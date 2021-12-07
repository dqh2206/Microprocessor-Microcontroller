; Button counter : When the button is pressed, the counter increases, 2 LEDs display the number of button press. When the value is 99, it will come back to 00.
; Microcontroller : AT89C52
; Simulation : Proteus 
; Programming language : Assembly
; Hardware connection : Port 1 is conneted to 2 IC 7447, which decode for 2 LEDs. Pin 3.4 (T0) of port 3 is connected to the button. 
; The button is grounded through a 10K resister. If the button is not pressed, pin 3.4 is HIGH. If the button is pressed, pin 3.4 is LOW.
; Counter 0 will increase when the button is pressed. (Counter 0 detects the negative transition from HIGH to LOW)
ORG 0000H
MAIN : 
		MOV R3,#0 ; R3 is a button counter
		MOV A, #0
		MOV P1, A ; display 00 on 2 LEDs when start
		MOV TMOD, #07H; Counter 0 is in mode 3. 
		MOV TL0, #0 ; Initialize counter 
		SETB TR0 ; Counter 0 is running
DISPLAY : 	MOV R3, TL0 ; TL0 is counter number
		CALL BCD_DECODE
		MOV A, R3
		MOV P1, A ; Display on 2 LEDs
		CALL DELAY_1S
		SJMP DISPLAY
; BCD Decoder
BCD_DECODE : 
		MOV A, R3
		ANL A, #0FH
		SUBB A, #9 ; check 4 low bits
		JC END_BCD 
		MOV A, R3 ; if 4 low bits larger than 9
		ADD A, #6 ; BCD conversion
		MOV R3, A 
		SUBB A, #154 ; check for value larger than 99
		JNC RESTART ; back to 00
END_BCD : 	RET
RESTART : 	MOV R3, #0
		MOV TL0,#0
		RET
; Delay function : 1 second	
DELAY_1S : 
	  MOV R0,#1    
LOOP3	: MOV R1,#200   
LOOP2 	: MOV R2,#200   
LOOP1	: NOP		
	  DJNZ R2, LOOP1  
	  DJNZ R1, LOOP2
	  DJNZ R0, LOOP3
	  RET
END