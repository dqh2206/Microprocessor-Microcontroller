; Button counter : When the button is pressed, the counter increases, 2 LEDs display the number of button press. When the value is 99, it will come back to 00.
; Microcontroller : AT89C52
; Simulation : Proteus 
; Programming language : Assembly 
; Hardware connection : Port 1 is conneted to 2 IC 7447, which decode for 2 LEDs. Pin 0 of port 0 is connected to the button. 
; The button is grounded through a 10K resister. If the button is not pressed, pin 0.0 is LOW. If the button is pressed, pin 0.0 is HIGH.  
ORG 0000H
MAIN : 
		MOV R3,#0 ; initialize 2 LEDs displaying 00, R3 is a button counter
START :		MOV A, R3 ; A is check register
		ANL A, #0FH
		CJNE A,#10, DISPLAY
		CALL BCD_DECODE
DISPLAY : 	MOV A, R3
		MOV P1,A
		CALL DELAY_1S
		CJNE R3,#154,START; 
		SJMP MAIN
; BCD decoder 
BCD_DECODE : 
		MOV A, R3
		ADD A, #6
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