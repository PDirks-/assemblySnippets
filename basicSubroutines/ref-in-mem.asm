* ------------------------------------------------------------
*
* Adds contents of tables together, stores in RESULT variable
* 
* addition operation done in a sub-routine, data passed via a
* call by reference in program memory
*
* result should be 6
* ------------------------------------------------------------

	ORG	$B000
TABLE	FCB	1,2,3,$FF
RESULT	RMB	1

	ORG	$C000
	LDS	#$01FF	* set stack pointer to start at #$01FF
	JSR	SUB
	FDB	TABLE
	FDB	RESULT
DONE	BRA	DONE

* ------------------------------------------------------------
*	Addition subroutine start
* ------------------------------------------------------------
SUB	TSX		* get stack pointer
	LDY	0,X	* load the return address from SP
	LDX	0,Y	* get first entry in table
	LDY	2,Y	* get the result address
	CLR	0,Y	* set result to 0
	
			** start of while loop **
WHILE	LDAB	0,X	* get table item into A register
	CMPB	#$FF	* check if at the last element
	BEQ	ENDWHILE	* break loop

	ADDB	0,Y	* addition operation
	STAB	0,Y
	INX
	BRA	WHILE
			** end of while loop **

ENDWHILE	TSY		* need to increment return address
	LDX	0,Y	* load return address from SP
	LDAB	#4	
	ABX		* add 4 to return address
	STY	0,Y	* store new address in Y register
	RTS
* ------------------------------------------------------------
*	end of subroutine
* ------------------------------------------------------------
