; Pulse width control : The pulse width is controlled by Timer 0 in mode 2. 
; Microcontroller : AT89C52
; Simulation : Proteus 
; Programming language : Assembly 
; Hardware connection : Pin 1.2 is connected to LED. Timer 0 working in mode 2 (16-bit timer) will determine the pulse width.  
; System clock : fclk = 2 MHz -> f(timer) = 2/6 = 1/3 MHz -> clock cycle = 3 us 
; TL0 is counting register, maximum value = 2^8-1 = 127
; TH0 = N -> pulse width = (127-N)* 3us =
ORG 0000H
MAIN : 
	MOV TMOD, #02H ; Timer 0 is working in mode 2
	MOV TH0, #107
	SETB TR0 ; Timer 0 starts to run
	SETB P1.2
WAIT :  JNB TF0, WAIT ; waiting for Timer 0 overflow
	CLR TF0 ; restart Timer 0
	CPL P1.2
	SJMP WAIT 
END