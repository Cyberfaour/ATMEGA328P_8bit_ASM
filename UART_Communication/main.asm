

; Replace with your application code
.org 0x00
.equ baud=9600
.equ clock=16000000
.equ bps=(clock/(16*baud))-1


START:


	Trans_Init:				;initiate the connection between input and output.
	
		LDI R20,HIGH(bps)		;load high baud rate into the UBBR0H and low to UBBR0L recpectively
		STS UBRR0H,R20
		LDI R20,LOW(bps)
		STS UBRR0L,R20
		LDI R21,(1<<TXEN0)|(1<<RXEN0)	;set the transmittor on and reciver 
		STS UCSR0B,R21					;load value into the control/status registers

		LDS R21,UCSR0A					;check the value of the UDRE0 flag is set or not in the UCSR0A register
		SBRS R21,UDRE0
		JMP Trans_Init					;if not jump again until it's set
		ldi R18,'a'
		sts UDR0,R18					;load 'a' into the UDR0 register to transmit the data from D1

		CALL DELAY
	
		jmp Trans_Init

	DELAY:
			LDI R22,0X00			;Generic delays
			LDI R23,0X00
			LDI R24,0X0F

	AGAIN:
			DEC R22
			BRNE AGAIN
			dec r23
			BRNE AGAIN
			DEC R24
			BRNE AGAIN
			RET
			
			JMP START
			
