; Button counter : When the button is pressed, the counter increases, 2 LEDs display the number of button press. When the value is 99, it will come back to 00.
; Microcontroller : AT89C52
; Simulation : Proteus 
; Programming language : Assembly
; Hardware connection : Port 1 is conneted to 2 IC 7447, which decode for 2 LEDs. Pin 3.2 (INT0) of port 3 is connected to the button. The interrupt service will be activated when the button is pressed. 
; The button is grounded through a 10K resister. If the button is not pressed, pin 0.0 is LOW. If the button is pressed, pin 0.0 is HIGH.   
ORG 0000H
LJMP MAIN
ORG 0003H ; INT0 interrupt service routine (ISR)
		INC R3
		CALL BCD_DECODE
		MOV A, R3
		MOV P1,A
		CALL DELAY_1S
		RETI
ORG 0030H 
MAIN : 
		MOV R3,#0 ; R3 is a button counter
		MOV IE,#81H; enable global interrupt and INT0 ISR
		MOV A, #0
		MOV P1, A ; display 00 on 2 LEDs when start
DISPLAY : 	SJMP DISPLAY ; forever loop here
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
RESTART : 	MOV A, #0
		MOV R3, A
		RET
; Delay function : 1 second	
DELAY_1S : 
	  MOV R0,#5    
LOOP3	: MOV R1,#200   
LOOP2 	: MOV R2,#200   
LOOP1	: NOP		
	  DJNZ R2, LOOP1  
	  DJNZ R1, LOOP2
	  DJNZ R0, LOOP3
	  RET
END