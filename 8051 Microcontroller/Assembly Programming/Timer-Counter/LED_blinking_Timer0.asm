; LED Blinking : After 100 mili-second, LED will blink.
; Microcontroller : AT89C52
; Simulation : Proteus 
; Programming language : Assembly 
; Hardware connection : Pin 1.2 is connected to LED. Timer 0 working in mode 1 (16-bit timer) will determine the exact delay time. 
; System clock : fclk = 12 MHz -> f(timer) = 2/6 = 1/3 MHz -> clock cycle = 3 us 
; 100ms = 10^5 us = 33333.33 clock cycle 
; Timer register (TH0-TL0) : maximum value (FFFF) = 2^16-1 = 65535
; Initial value : 65535 - 33333 = 32202 -> 7DCA
ORG 0000H
MAIN : 
	MOV TMOD, #01H ; Timer 0 in mode 1
LOOP : 	SETB P1.2 ; LED is on
	CALL DELAY_100MS 
	CLR P1.2
	CALL DELAY_100MS
	SJMP LOOP 
; Delay function 
DELAY_100MS : 
	MOV TH0, #7DH
	MOV TL0, #0CAH
	SETB TR0
WAIT :  JNB TF0, WAIT ; waiting for Timer 0 overflow
	CLR TR0  ; stop Timer 0
	CLR TF0  ; clear overflow bit
	RET
END