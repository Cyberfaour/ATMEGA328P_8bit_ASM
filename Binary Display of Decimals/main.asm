
     .ORG 0X00
start:
    LDI R16, 0xFF ;load zeros in the R16 register
	OUT DDRD, R16 ;set ports to zeros
	CALL delay2 ;call delay twice to give some time before the program start
	CALL delay2 
	LDI R18,0x00 ;load 255 into r18 before initiating decrements on it in the 1st delay
AGAIN: ;loop to inc r16 while loading it's values into PORTD to display results 
         ;while decrementing R18 till it reaches 0x00 therefore letting R16 to reach it's max of 0xFF
	DEC R16
	OUT PORTD,R16 
	CALL delay
	INC R18
	BRNE AGAIN
	CALL delay2
	rjmp AGAIN
delay: ;this delay will control the time elapsed between each LED blink to make it visible
       ; in this case the this delay will loop 30000 times
	LDI R30,200
loop1:
	LDI R24,150
loop2:
	DEC R24
	BRNE loop2
	DEC R30
	BRNE loop1
	RET
delay2: ;this delay doesnt affect the program it just gives a no operation time before the 
		; the program has been initiaited thus it'll loop 65,025 times before starting the program.
	LDI R25,255
loop3:
	LDI R26,255
loop4:
	DEC R26
	BRNE loop4
	DEC R25
	BRNE loop3
	RET