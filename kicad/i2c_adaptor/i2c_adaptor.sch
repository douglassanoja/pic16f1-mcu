EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:pic16f1-mcu
LIBS:i2c_adaptor-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "I2C adaptor for TWELITE-DIP"
Date "2019-01-11"
Rev ""
Comp "https://github.com/araobp"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Conn_01x14 J4
U 1 1 5C385BC5
P 7150 5150
F 0 "J4" H 7150 5850 50  0000 C CNN
F 1 "Conn_01x14" H 7150 4350 50  0000 C CNN
F 2 "mcu:Pin_Socket_14P" H 7150 5150 50  0001 C CNN
F 3 "" H 7150 5150 50  0001 C CNN
	1    7150 5150
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x14 J6
U 1 1 5C385C26
P 8200 5250
F 0 "J6" H 8200 5950 50  0000 C CNN
F 1 "Conn_01x14" H 8200 4450 50  0000 C CNN
F 2 "mcu:Pin_Socket_14P" H 8200 5250 50  0001 C CNN
F 3 "" H 8200 5250 50  0001 C CNN
	1    8200 5250
	-1   0    0    1   
$EndComp
Text Notes 7250 4600 0    60   ~ 0
GND
Text Notes 7250 4800 0    60   ~ 0
RX
Text Notes 7250 5500 0    60   ~ 0
TX
Text Notes 7950 4600 0    60   ~ 0
VCC
$Comp
L +3.3V #PWR01
U 1 1 5C385E37
P 2750 4100
F 0 "#PWR01" H 2750 3950 50  0001 C CNN
F 1 "+3.3V" H 2750 4240 50  0000 C CNN
F 2 "" H 2750 4100 50  0001 C CNN
F 3 "" H 2750 4100 50  0001 C CNN
	1    2750 4100
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR02
U 1 1 5C385E6A
P 8700 4000
F 0 "#PWR02" H 8700 3850 50  0001 C CNN
F 1 "+3.3V" H 8700 4140 50  0000 C CNN
F 2 "" H 8700 4000 50  0001 C CNN
F 3 "" H 8700 4000 50  0001 C CNN
	1    8700 4000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 5C385E9F
P 6400 5050
F 0 "#PWR03" H 6400 4800 50  0001 C CNN
F 1 "GND" H 6400 4900 50  0000 C CNN
F 2 "" H 6400 5050 50  0001 C CNN
F 3 "" H 6400 5050 50  0001 C CNN
	1    6400 5050
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5C385F63
P 2500 4850
F 0 "R1" V 2580 4850 50  0000 C CNN
F 1 "51k" V 2500 4850 50  0000 C CNN
F 2 "mcu:Register" V 2430 4850 50  0001 C CNN
F 3 "" H 2500 4850 50  0001 C CNN
	1    2500 4850
	0    1    1    0   
$EndComp
$Comp
L Conn_01x05 J2
U 1 1 5C3861E2
P 4250 2400
F 0 "J2" H 4250 2700 50  0000 C CNN
F 1 "Conn_01x05" H 4250 2100 50  0000 C CNN
F 2 "" H 4250 2400 50  0001 C CNN
F 3 "" H 4250 2400 50  0001 C CNN
	1    4250 2400
	-1   0    0    1   
$EndComp
Text Notes 3950 2250 0    60   ~ 0
SCL
Text Notes 3950 2350 0    60   ~ 0
SDA
Text Notes 3950 2550 0    60   ~ 0
GND
Text Notes 3950 2650 0    60   ~ 0
3.3V
NoConn ~ 4450 2400
$Comp
L +3.3V #PWR04
U 1 1 5C386313
P 5600 2000
F 0 "#PWR04" H 5600 1850 50  0001 C CNN
F 1 "+3.3V" H 5600 2140 50  0000 C CNN
F 2 "" H 5600 2000 50  0001 C CNN
F 3 "" H 5600 2000 50  0001 C CNN
	1    5600 2000
	1    0    0    -1  
$EndComp
NoConn ~ 6950 4650
NoConn ~ 8400 5450
NoConn ~ 3050 4650
NoConn ~ 3050 5150
NoConn ~ 8400 4650
NoConn ~ 8400 4750
NoConn ~ 8400 4850
NoConn ~ 8400 4950
NoConn ~ 8400 5050
NoConn ~ 8400 5150
NoConn ~ 8400 5250
NoConn ~ 8400 5350
NoConn ~ 8400 5550
NoConn ~ 8400 5650
NoConn ~ 8400 5750
NoConn ~ 8400 5850
NoConn ~ 6950 5850
NoConn ~ 6950 5750
NoConn ~ 6950 5650
NoConn ~ 6950 5550
NoConn ~ 6950 5350
NoConn ~ 6950 5250
NoConn ~ 6950 5150
NoConn ~ 6950 5050
NoConn ~ 6950 4950
NoConn ~ 6950 4850
$Comp
L Polyfuse F1
U 1 1 5C3866BB
P 7300 2700
F 0 "F1" V 7200 2700 50  0000 C CNN
F 1 "Polyfuse (100mA)" V 7400 2700 50  0000 C CNN
F 2 "" H 7350 2500 50  0001 L CNN
F 3 "" H 7300 2700 50  0001 C CNN
	1    7300 2700
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR05
U 1 1 5C386728
P 7950 2900
F 0 "#PWR05" H 7950 2750 50  0001 C CNN
F 1 "+3.3V" H 7950 3040 50  0000 C CNN
F 2 "" H 7950 2900 50  0001 C CNN
F 3 "" H 7950 2900 50  0001 C CNN
	1    7950 2900
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x02 J5
U 1 1 5C38677C
P 7300 1800
F 0 "J5" H 7300 1900 50  0000 C CNN
F 1 "Conn_01x02" H 7300 1600 50  0000 C CNN
F 2 "" H 7300 1800 50  0001 C CNN
F 3 "" H 7300 1800 50  0001 C CNN
	1    7300 1800
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR06
U 1 1 5C3867EC
P 8550 2400
F 0 "#PWR06" H 8550 2150 50  0001 C CNN
F 1 "GND" H 8550 2250 50  0000 C CNN
F 2 "" H 8550 2400 50  0001 C CNN
F 3 "" H 8550 2400 50  0001 C CNN
	1    8550 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5C386C5F
P 4850 2950
F 0 "#PWR07" H 4850 2700 50  0001 C CNN
F 1 "GND" H 4850 2800 50  0000 C CNN
F 2 "" H 4850 2950 50  0001 C CNN
F 3 "" H 4850 2950 50  0001 C CNN
	1    4850 2950
	1    0    0    -1  
$EndComp
Text Notes 7200 4350 0    60   ~ 0
MONOWIRELESS-DIP
Text Notes 3300 2450 0    60   ~ 0
I2C module
Text Notes 6800 1450 0    60   ~ 0
CR2032 battery case (3.0V)
Text Notes 7350 1700 1    60   ~ 0
3.0V
Text Notes 7450 1700 1    60   ~ 0
GND
$Comp
L SW_SPDT SW1
U 1 1 5C38651E
P 7500 3250
F 0 "SW1" H 7500 3420 50  0000 C CNN
F 1 "SW_SPDT" H 7500 3050 50  0000 C CNN
F 2 "mcu:Slide_switch" H 7500 3250 50  0001 C CNN
F 3 "" H 7500 3250 50  0001 C CNN
	1    7500 3250
	1    0    0    -1  
$EndComp
NoConn ~ 7700 3150
$Comp
L GND #PWR08
U 1 1 5C38791B
P 6000 5050
F 0 "#PWR08" H 6000 4800 50  0001 C CNN
F 1 "GND" H 6000 4900 50  0000 C CNN
F 2 "" H 6000 5050 50  0001 C CNN
F 3 "" H 6000 5050 50  0001 C CNN
	1    6000 5050
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG09
U 1 1 5C387C86
P 5850 2250
F 0 "#FLG09" H 5850 2325 50  0001 C CNN
F 1 "PWR_FLAG" H 5850 2400 50  0000 C CNN
F 2 "" H 5850 2250 50  0001 C CNN
F 3 "" H 5850 2250 50  0001 C CNN
	1    5850 2250
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG010
U 1 1 5C387ECD
P 6200 4500
F 0 "#FLG010" H 6200 4575 50  0001 C CNN
F 1 "PWR_FLAG" H 6200 4650 50  0000 C CNN
F 2 "" H 6200 4500 50  0001 C CNN
F 3 "" H 6200 4500 50  0001 C CNN
	1    6200 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 4550 6400 5050
Wire Wire Line
	8700 4550 8700 4000
Wire Wire Line
	8400 4550 8700 4550
Wire Wire Line
	2150 4550 3050 4550
Wire Wire Line
	2750 4100 2750 4550
Wire Wire Line
	6400 4550 6950 4550
Wire Wire Line
	2650 4850 3050 4850
Wire Wire Line
	2350 4850 2150 4850
Wire Wire Line
	2150 4850 2150 4550
Connection ~ 2750 4550
Wire Wire Line
	5600 2600 4450 2600
Wire Wire Line
	5600 2000 5600 2600
Wire Wire Line
	4450 2300 5200 2300
Wire Wire Line
	5200 2300 5200 5050
Wire Wire Line
	5350 4950 5350 2200
Wire Wire Line
	5350 2200 4450 2200
Wire Wire Line
	7950 2900 7950 3350
Wire Wire Line
	7300 2000 7300 2550
Wire Wire Line
	7400 2000 7400 2200
Wire Wire Line
	7400 2200 8550 2200
Wire Wire Line
	8550 2200 8550 2400
Wire Wire Line
	4450 2500 4850 2500
Wire Wire Line
	4850 2500 4850 2950
Wire Wire Line
	7300 2850 7300 3250
Wire Wire Line
	7950 3350 7700 3350
Wire Wire Line
	6000 4550 6000 5050
Wire Wire Line
	5850 2250 5850 2400
Wire Wire Line
	5850 2400 5600 2400
Connection ~ 5600 2400
Wire Wire Line
	6200 4500 6200 4900
Wire Wire Line
	6200 4900 6000 4900
Connection ~ 6000 4900
Wire Wire Line
	2700 5050 2700 5800
Wire Wire Line
	2700 5800 6750 5800
Wire Wire Line
	6750 5800 6750 4750
Wire Wire Line
	6750 4750 6950 4750
Wire Wire Line
	2850 4950 2850 5450
Wire Wire Line
	2850 5450 6950 5450
NoConn ~ 3050 4750
Wire Wire Line
	2850 4950 3050 4950
Wire Wire Line
	2700 5050 3050 5050
Text Notes 3900 1950 0    60   ~ 0
Conta connector
$Comp
L pic16f1825 U1
U 1 1 5C3905D1
P 3850 4850
F 0 "U1" H 3300 5300 60  0000 C CNN
F 1 "pic16f1825" H 3850 4850 60  0000 C CNN
F 2 "pic16f1:ic-pinsocket-14pins" H 3450 4900 60  0001 C CNN
F 3 "" H 3450 4900 60  0001 C CNN
	1    3850 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 5050 4650 5050
Wire Wire Line
	4650 4950 5350 4950
NoConn ~ 4650 4550
NoConn ~ 4650 4650
NoConn ~ 4650 4750
NoConn ~ 4650 4850
NoConn ~ 4650 5150
$EndSCHEMATC
