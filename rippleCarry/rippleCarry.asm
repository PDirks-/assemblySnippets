* ------------------------------------------------ *
* 4-bit Ripple Carry adder
*
* Simple program that preforms addition on 2
* 4-byte numbers.
*
* Result is in big-endian format, and the sum 
* address is stored in the x-register.
*
* 123456 + 1356 = 124812 (expected $1E78C)
*
* ------------------------------------------------ *

	ORG 	$B000
Num1	FCB	$00,$01,$E2,$40 * two numebers to add together...
Num2	FCB	0,0,$5,$4C	
N	EQU	4	* used to count bytes in ripple carry
SUM	RMB	4

* start of program
 
	ORG  	$C000
	LDAB	#N

	LDX	#Num1+N-1	* load both num pointers into x and y registers
	LDY	#Num2+N-1	* need to start at right-most byte to have big-endian result

	CLC		* clear carry flag

do	LDAA	0,X	* load x-address in a-register
	ADCA	0,Y	* add x with y, and carry flag
	
	STAA	0,X

	DEX		* decrement x,y; moving operations to left
	DEY	
	
UNTIL	DECB
	BNE	do

	LDX	#Num1	* reset X-pointer

	LDD	0,X	* load contents of X-register, store in SUM
	STD	SUM
	LDD	2,X
	STD	SUM+2
	

DONE	BRA	DONE