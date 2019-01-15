#
# This is a sample code using "twelite" module.
#

import twelite as tw
import time

### Serial port setting
PORT = "COM9"
BAUDRATE = 115200

### Destination addresses of TWELITE-DIP slave nodes
SLAVE_1 = 0x01
SLAVE_2 = 0x02
SLAVE_3 = 0x03
SLAVE_4 = 0x04

### Frequency of fetch operations
FREQ = 40.0  # Hz
LOOP_CNT = 100

### Main
if __name__ == '__main__':

    genSeq_1 = tw.GenSeq()

    info = lambda len_, seq, lqi: ' length: {}, seq number: {}, LQI: {} ({} dBm)'.format(len_, seq, lqi, tw.lqi2dbm(lqi))
    
    with tw.MasterNode(PORT, BAUDRATE) as mn:

        start_time = time.time()
        
        for _ in range(LOOP_CNT):
            try:
                #print('--- SLAVE {} ---'.format(SLAVE_1))

                ### Fetch temperature data from thermistor on AMG8833
                # Note: the sequence number is generated in MasterNode class
                #data, len_, seq, lqi = mn.fetch(dst=SLAVE_1, cmd=tw.THERMISTOR)
                #print(info(len_, seq, lqi))                 
                #print(' room temperature: {} degrees Celsius'.format(str(data[0])))
                #print('')
                ### Fetch 64 pixels data from AMG8833
                # Note: the sequence number for SLAVE_1 is generated by GenSeq generator
                data, len_, seq, lqi  = mn.fetch(dst=SLAVE_1, cmd=tw.PIXELS, seq=next(genSeq_1))
                #print(info(len_, seq, lqi))                 
                #print(' pixels: ', end='')
                #for d in data[:-1]:
                #    print('{},'.format(str(d)), end='')
                #print('{} degrees Celsius'.format(str(data[-1])))
                #print('')
            except Exception as e:
                #print(e)
                time.sleep(1)
            
            time.sleep(1/FREQ)

        stop_time = time.time()
        print('Elapsed time: {:.2f} sec'.format(stop_time - start_time))
        print('Average interval: {:.2f} msec'.format((stop_time - start_time)/LOOP_CNT))
