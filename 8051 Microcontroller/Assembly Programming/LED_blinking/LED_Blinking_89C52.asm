; LED Blinking : After 1 second, LED will blink.
; Microcontroller : AT89C52
; Simulation : Proteus 
; Programming language : Assembly 
; Hardware connection : Pin 1.2 is connected to LED. 
ORG 0000H
MAIN : 
	SETB P1.2
	ACALL DELAY_1S
	CLR P1.2
	ACALL DELAY_1S
	SJMP MAIN
; Delay function : 1 second	
DELAY_1S : 
	  MOV R0,#10    
LOOP3	: MOV R1,#200   
LOOP2 	: MOV R2,#200   
LOOP1	: NOP		
	  DJNZ R2, LOOP1  
	  DJNZ R1, LOOP2
	  DJNZ R0, LOOP3
	  RET
; LOOP1 : (1.2+2.4)x(R2-1)+1.2 = 717.6 us
; LOOP2 : (1.2+717.6)x(R1-1)+1.2 = 143043 us
; LOOP3 : (1.2+143043)x(R0-1)+1.2 = 1000000us -> 
END
