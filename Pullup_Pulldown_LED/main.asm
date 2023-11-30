

; Replace with your application code


LDI R16,0x00    ;set values to corresponding register that will be loaded into the needed ports respectively.
LDI R17,0X02
LDI R18,0X01

OUT DDRD,R16
OUT DDRB,R17
OUT DDRC,R18

out portB,r17
OUT PIND,R16
OUT PINC,R18
START:
	SBIC PIND,0				;skip the branching if the pinD,0 id clear.otherwise branch(pull down button)
	BRNE TURNONRED
	SBIS PINC,0				;skip the the branching if the pinC,0 is set.other wise branch.(pull up button)
	BRNE TURNOFFGREEN
	OUT PORTB,R17
	JMP START

TURNONRED:
	SBI PORTB,0			;set red led on
	NOP
	JMP START

TURNOFFGREEN:
	CBI PORTB,1			;set green light off.
	NOP
	JMP START

	



