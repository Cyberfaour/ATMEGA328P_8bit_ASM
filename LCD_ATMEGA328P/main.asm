

; Replace with your application code

.org 0x00

LDI R16,0X00 ;FOR DATA
LDI R17,0XFF ;FOR DDRD
LDI R18,0X03 ; FOR DDRB RS=1 AND E=1
LDI R19,0XFF;DDRC
LDI R20,0X00 ;FOR COMMANDS
LDI R21,0X00 
LDI R22,0X00 ;CGRAM
OUT DDRD,R17 
OUT DDRB,R18
OUT DDRC,R19

.EQU LCD_CLEAR=0X01 ;FOR CLEARING THE LCD
.EQU LCD_FUNCTIONSETLINE1=0X30 ;SET WRITING ON LINES1 AND 2
.EQU LCD_FUNCTIONSETLINE2=0X38
.EQU LCD_CURSOR_R1=0X80
.EQU LCD_CURSOR_R2=0XC0
.EQU LCD_DISPLAYOFF=0X08 ;SETTING LCD OFF
.EQU LCD_DISPLAYON=0X0E ;SETTING LCD ON
.EQU LCD_SHIFT_CURSOR_R=0X14
.EQU LCD_SET_CGRAM=0X40 ;CGRAM
DATA2:
	.DB "THNX 4 WATCHNG",0X00,0
DATA:
	.DB "4 watching",0X00,0

DATA3:
	.DB "LIU CENG DEPT ",0X00,0
/*CGRAM:
	.DB "  ",0X00*/

CALL LCD_INIT	;initialize lcd

START:
	IN R21,PINC
	SBRC R21,0
	CALL CLEAR_LCD   
	SBRC R21,1
	CALL SET_CURSOR_R1
	SBRC R21,2
	
	SBRC R21,3
	CALL LOADDATA1
	SBRC R21,4
	CALL LOADDATA3
	SBRC R21,5
	//CALL LCD_CGRAM
	JMP START
HERE:
	RJMP HERE
;FUNCTIONS

/*LOADDATA2:
	LDI ZH,HIGH(2*DATA2)
	LDI ZL,LOW(2*DATA2)
	CALL SET_CURSOR_R1
	CALL SET_COMMAND
	CALL WRITE_CHAR*/
LOADDATA1:
	CALL SET_CURSOR_R2
	LDI ZH,HIGH(2*DATA)
	LDI ZL,LOW(2*DATA)
	CALL WRITE_CHAR
LOADDATA3:
	LDI ZH,HIGH(2*DATA3)
	LDI ZL,LOW(2*DATA3)
	CALL WRITE_CHAR
/*LOAD_CGRAM:
	LDI ZH,HIGH(2*CGRAM)
	LDI ZL,LOW(2*CGRAM)
	CALL WRITE_CHAR*/

LCD_INIT:    ;LCD INITIATION
	CALL DELAY_100US
	CALL CLEAR_LCD
	CALL DELAY_2MS
	CALL SET_LINE1
	CALL SET_COMMAND
	CALL DELAY_100US
	CALL SET_LINE2
	CALL SET_COMMAND
	CALL DELAY_100US
	CALL SET_DISPLAYON
	CALL DELAY_100US
	/*CALL LOADDATA2*/
	
	

SET_CLEAR_COMMAND:   ;USE FOR CLEAR COMMAND
	SBIC PORTB,0
	CBI PORTB,0
	SBIS PORTB,1
	SBI PORTB,1
	CALL DELAY_2MS
	CBI PORTB,1 
	RET

SET_COMMAND:      ;USE FOR COMMANDS
	SBIC PORTB,0
	CBI PORTB,0
	SBIS PORTB,1
	SBI PORTB,1
	CALL DELAY_100US
	CBI PORTB,1
	RET
SET_CHAR:        ;USE FOR WRITNG
	SBIS PORTB,0
	SBI PORTB,0
	SBIS PORTB,1
	SBI PORTB,1
	CALL DELAY_100US
	CBI PORTB,1
	RET
WRITE_CHAR:	;WRITING CHARS FUNCTION
	
		LPM R16,Z+
		OUT PORTD,R16
		CALL SET_CHAR
		CPI R16,0
		BREQ EXIT
		JMP WRITE_CHAR

;SUBROUTINES

CLEAR_LCD:
	LDI R20,LCD_CLEAR
	OUT PORTD,R20
	CALL SET_CLEAR_COMMAND
	RET
 SET_LINE1:
	LDI R20,LCD_FUNCTIONSETLINE1
	OUT PORTD,R20
	RET
SET_LINE2:
	LDI R20,LCD_FUNCTIONSETLINE2
	OUT PORTD,R20
	RET
SET_DISPLAYON:
	LDI R20,LCD_DISPLAYON
	OUT PORTD,R20
	CALL SET_COMMAND
	RET
SET_DISPLAYOFF:
	LDI R20,LCD_DISPLAYOFF
	OUT PORTD,R20
	CALL SET_COMMAND
	RET
SET_CURSOR_R1:
	LDI R20,LCD_CURSOR_R1
	OUT PORTD,R20
	CALL SET_COMMAND
	RET
SET_CURSOR_R2:
	LDI R20,LCD_CURSOR_R2
	OUT PORTD,R20
	CALL SET_COMMAND
	RET
SHIFT_CURSOR_R:
	LDI R20,LCD_SHIFT_CURSOR_R
	OUT PORTD,R20
	CALL SET_COMMAND
	RET

; Delay 1 600 cycles
; 100us at 16 MHz
DELAY_100US:
	 ldi  r27, 3
     ldi  r28, 19
    LOOP: dec  r28
        brne L1
        dec  r27
        brne LOOP
		RET


; Delay 32 000 cycles
; 2ms at 16 MHz
DELAY_2MS:          
	LDI  r25, 42
    LDI  r26, 142
    L1: 
	DEC  r26
    BRNE L1
    DEC  r25
    BRNE L1
    nop
    RET


EXIT:
	
	 JMP START

//LCD_CGRAM:;CGRAM FOR SMILEY
			
		//	LDI R23,3
		
		// POSITIVE:	
		//	 LDI   R22,0X40        ;Load the location where we want to store
		//	 OUT PORTD,R22
			// call SET_COMMAND   ;Send the command*/
		 
			// LDI  R22,0X00       ;Load row 1 data
			// OUT PORTD,R22
			// call SET_CHAR   ;Send the data


			// LDI   R22,0X00         ;Load row 2 data
			 //OUT PORTD,R22
			 //call SET_CHAR   ;Send the data*/
		
			// LDI   R22,0X05
			          ;Load row 3 data
			// OUT PORTD,R22
			// call SET_CHAR   ;Send the data*/

			//LDI   R22,0X00        ;Load row 4 data
		   // OUT PORTD,R22
           // Call SET_CHAR   ;Send the data*/
		 
           // LDI   R22,0X09        ;Load row 5 data
		   // OUT PORTD,R22
           // call SET_CHAR   ;Send the data*/
		
           // LDI   R22,0X09         ;Load row 6 data
		  //  OUT PORTD,R22
          //  call SET_CHAR   ;Send the data*/
		
           // LDI   R22,0X06         ;Load row 7 data
			//OUT PORTD,R22
			//call SET_CHAR   ;Send the data*/
		 
			// LDI   R22,0X00         ;Load row 8 data
			// OUT PORTD,R22
			// call SET_CHAR   ;Send the data*/
			// CALL DELAY_2MS

		   //  RJMP NEGATIVE
		 ;*********** CGRAM FOR XMAS TREE
	// NEGATIVE:										
			//CALL DELAY_2MS
		

			// LDI   R22,0X40       ;Load the location where we want to store
			// OUT PORTD,R22
			// call SET_COMMAND   ;Send the command*/
		 
		 
///LDI  R22,0X1F       ;Load row 1 data
		//	 OUT PORTD,R22
		//	 call SET_CHAR   ;Send the data


		//	 LDI   R22,0X1B         ;Load row 2 data
		//	 OUT PORTD,R22
		//	 call SET_CHAR   ;Send the data*/
		
		//	 LDI   R22,0X11         ;Load row 3 data
		//	 OUT PORTD,R22
		//	 call SET_CHAR   ;Send the data*/

		//	 LDI   R22,0X1B         ;Load row 4 data
			// OUT PORTD,R22
		//	 Call SET_CHAR   ;Send the data*/
		 
		//	 LDI   R22,0X11       ;Load row 5 data
		//	 OUT PORTD,R22
		//	 call SET_CHAR   ;Send the data*/
		
		///	LDI   R22,0X00         ;Load row 6 data
		//	 OUT PORTD,R22
		//	call SET_CHAR   ;Send the data*/
		
		//	 LDI   R22,0X1B         ;Load row 7 data
		//	 OUT PORTD,R22
		//	 call SET_CHAR   ;Send the data*/
		 
		//	 LDI   R22,0X1B         ;Load row 8 data
		//	 OUT PORTD,R22
		//	 call SET_CHAR   ;Send the data*/
		//	 DEC R23
		//	 CPI R23,0
			// brne BRNE_POSITIVE 
		 
		 JMP START
		 
                      
