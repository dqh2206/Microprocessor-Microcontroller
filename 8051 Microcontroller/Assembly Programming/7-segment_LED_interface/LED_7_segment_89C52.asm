; 7-segment common-cathode LED interface: Display from 0 to 9 after each second. When the value is 9, it will come back to 0.
; Microcontroller : AT89C52
; Simulation : Proteus 
; Programming language : Assembly 
; Hardware connection : Port 1 is conneted to 7-segment LED. Pin 1.7 is not connected. 
; 7-segment LED decoder table
ORG 4000H
DB 3FH ; display 0 pattern
DB 06H ; display 1 pattern
DB 5BH ; display 2 pattern
DB 4FH ; display 3 pattern
DB 66H ; display 4 pattern
DB 6DH ; display 5 pattern
DB 7DH ; display 6 pattern
DB 07H ; display 7 pattern
DB 7FH ; display 8 pattern
DB 6FH ; display 9 pattern
DB 00H; end of the table
; Main program
ORG 0000H
MAIN : 
		MOV DPTR, #4000H ; DPTR point to the table
DISPLAY : 	MOV A,#0 
		MOVC A,@A+DPTR
		JZ MAIN
		MOV P1, A
		ACALL DELAY_1S
		INC DPTR
		SJMP DISPLAY
		SJMP MAIN
; Delay function : approximate 1 second	
DELAY_1S : 
	  MOV R0,#5    
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
