#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include "i2c_util.h"
#include "amg8833.h"
#include "twelite.h"

//#define DEBUG

/* Macro for 2D matrix elemenet positions
 *     -- i -->
 *    +-------------------------
 *  | |
 *  j | 2D matrix of pixel data
 *  | |
 *  V |
 */
#define IDX(i, j) (j * 8 + i)
#define SCAN_ROW_IDX(i) (SCAN_ROW * 8 + i)

float peak_count_threshold = PEAK_COUNT_THRESHOLD;

/**
 * Enable/disable moving average
 */
void set_moving_average(amg8833_instance *A, bool enable) {
    uint8_t reg_addr_sequence[5] = {AMG8833_1F_ADDR, AMG8833_1F_ADDR, AMG8833_1F_ADDR,
        AMG8833_AVE_ADDR, AMG8833_1F_ADDR};

    uint8_t enable_sequence[5][2] = {
        {AMG8833_1F_ADDR, 0x50},
        {AMG8833_1F_ADDR, 0x45},
        {AMG8833_1F_ADDR, 0x57},
        {AMG8833_AVE_ADDR, 0x20},
        {AMG8833_1F_ADDR, 0x00}
    };

    uint8_t disable_sequence[5][2] = {
        {AMG8833_1F_ADDR, 0x50},
        {AMG8833_1F_ADDR, 0x45},
        {AMG8833_1F_ADDR, 0x57},
        {AMG8833_AVE_ADDR, 0x00},
        {AMG8833_1F_ADDR, 0x00}
    };

    if (enable) {
        for (int i = 0; i < 5; i++) {
            i2c_write(AMG8833_DEV_ADDR, enable_sequence[i], 2);
        }
    } else {
        for (int i = 0; i < 5; i++) {
            i2c_write(AMG8833_DEV_ADDR, disable_sequence[i], 2);
        }
    }
}

/**
 * Transmit data to UART
 */
void uart_transmit(uint8_t *pbuf, uint8_t len) {
    for (int i = 0; i < len; i++) {
        printf("%d,", pbuf[i]);
    }
    printf("%d\n", 0xff);
}

/**
 * Read the thermistor register on AMG8833
 */
void update_thermistor(amg8833_instance *A) {
    uint8_t err;
    float temp;
    err = i2c_read(AMG8833_DEV_ADDR, AMG8833_TTHL_ADDR, A->thermistor, AMG8833_THERMISTOR_LENGTH);
}

/**
 *  Read pixel registers on AMG8833
 */
void update_pixels(amg8833_instance *A) {
    uint8_t err;
    float temp;
    err = i2c_read(AMG8833_DEV_ADDR, AMG8833_T01L_ADDR, A->pixels, AMG8833_PIXELS_LENGTH);
    for (int i = 0; i < AMG8833_PIXELS_LENGTH_HALF; i++) {
        A->pixels[i] = A->pixels[i * 2]; // Ignore MSB of a pair of [LSB, MSB]
    }
}

/**
 * Read pixel registers and calculate diff between the current and the previous data 
 * @return true if at least one diff data is over the threshold
 */
bool update_diff(amg8833_instance *A, bool flag) {
    uint8_t err;
    float temp;
    bool detected = false;
    
    err = i2c_read(AMG8833_DEV_ADDR, AMG8833_T01L_ADDR, A->pixels, AMG8833_PIXELS_LENGTH);
    for (int i = 0; i < AMG8833_PIXELS_LENGTH_HALF; i++) {
        A->pixels[i] = A->pixels[i * 2]; // Ignore MSB of a pair of [LSB, MSB]
        A->diff[i] = (int8_t) A->pixels[i] - (int8_t) A->pixels_prev[i];
        if (abs(A->diff[i]) > peak_count_threshold) {
            detected = true;
        } else if (flag) {
            A->diff[i] = 0;
        }
        A->pixels_prev[i] = A->pixels[i];
    }
    return detected;
}

/**
 * Colmun-wise motion detection filter
 */
void filter(int i, int8_t *pdiff, int8_t *pcolumn, bool downward) {
    bool filter_on, filter_detecting;
    int idx, start, end;
    int j;
    filter_on = false;
    filter_detecting = false;
    j = (downward) ? 0 : 7;
    while (true) {
        idx = IDX(i, j);
        // Column-wise scan downward
        if (!filter_on && pdiff[idx] > peak_count_threshold) {
            filter_on = true;
        } else if (filter_on && pdiff[idx] < -peak_count_threshold) {
            filter_detecting = true;
            pcolumn[j] = (downward) ? 1 : -1;
        } else if (filter_on && filter_detecting && pdiff[idx] >= -peak_count_threshold) {
            filter_on = false;
            filter_detecting = false;
        }
        if (downward) {
            if (j++ >= 7) break;
        } else {
            if (j-- <= 0) break;
        }
    }
}

/**
 * Column-wise motion detection.
 * 0: still, 1: forward, -1: backward
 */
void update_diff_motion(amg8833_instance *A) {
    int8_t column[8] = {0};
    bool filter_on, filter_flip, filter_detecting;
    int idx;
    update_diff(A, false);
    for (int i = 0; i < 8; i++) {
        filter(i, A->diff, column, true); // column-wise scan downward
        filter(i, A->diff, column, false); // column-wise scan upward
        for (int j = 0; j < 8; j++) { // Copy motion data
            A->diff[IDX(i, j)] = column[j];
            column[j] = 0;
        }
    }
}

/**
 * Motion count on a specific row after column-wise motion detection
 * 0: still, 1: forward, -1: backward
 * @return true if motion count is not all-zero
 */
bool update_line(amg8833_instance *A) {
    static int8_t prev_row[8][8] = {
        { 0 }
    };
    int8_t temp_row[8] = {0};
    int idx;
    bool peak_on;
    int peak_on_idx, peak_idx;
    bool detected = false;
    int8_t *pdiff;

    update_diff_motion(A);

    // Find peaks
    peak_on = false;
    for (int i = 0; i < 8; i++) {
        idx = SCAN_ROW_IDX(i);
        if (!peak_on && A->diff[idx] != 0) {
            peak_on = true;
            peak_on_idx = i;
        } else if (peak_on && (A->diff[idx] == 0 || i == 7)) {
            if ((i - peak_on_idx) >= OBJECT_RESOLUTION) {
                peak_idx = (peak_on_idx + i) / 2;
                temp_row[peak_idx] = A->diff[SCAN_ROW_IDX(peak_idx)];
                detected = true;
            }
            peak_on = false;
        }
    }

    /*   Check if the peaks were already counted in the previous read.
     *
     *   prev_row[1][ ]: 0  0  0  0  0  0  0  0
     *   prev_row[0][ ]: 0  0  0  0  0  1  0  0
     *   current row   : 0  0  0  0  1  0  0  0  => This "1" is removed.
     * 
     *   prev_row[1][ ]: 0  0  0  0  1  0  0  0
     *   prev_row[0][ ]: 0  0  0  0  0  0  0  0
     *   current row   : 0  0  0  0  0  1  0  0  => This "1" is removed.
     */
    for (int i = 0; i < 8; i++) {
        A->line[i] = temp_row[i];
    }
    for (int i = 0; i < 8; i++) {
        if (A->line[i] != 0) {
            switch (i) {
                case 0:
                    for (int j = 0; j < OBJECT_RESOLUTION; j++) {
                        if (prev_row[j][0] != 0 || prev_row[j][1] != 0) {
                            A->line[0] = 0;
                            detected = false;
                        }
                    }
                    break;
                case 7:
                    for (int j = 0; j < OBJECT_RESOLUTION; j++) {
                        if (prev_row[j][6] != 0 || prev_row[j][7] != 0) {
                            A->line[7] = 0;
                            detected = false;
                        }
                    }
                    break;
                default:
                    for (int j = 0; j < OBJECT_RESOLUTION; j++) {
                        if (prev_row[j][i - 1] != 0 || prev_row[j][i] != 0 || prev_row[j][i + 1] != 0) {
                            A->line[i] = 0;
                            detected = false;
                        }
                    }
                    break;
            }
        }
    }

    // Save the current row
    for (int i = 0; i < 8; i++) {
        for (int j = 1; j < OBJECT_RESOLUTION; j++) {
            prev_row[j][i] = prev_row[j-1][i];
        }
        prev_row[0][i] = temp_row[i];
    }
        
    return detected;

}

/**
 * Calibrate motion detection threshold
 */
void calibrate_threshold(int v) {
    switch (v) {
        case 0:
            peak_count_threshold = PEAK_COUNT_THRESHOLD;
            break;
        default:
            peak_count_threshold = v;
            break;
    }
}
