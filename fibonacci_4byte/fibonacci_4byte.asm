* Program description: generate fibonacci sequence with 4 bytes
*
* Pseudocode:
*
*	unsigned int N = 40; 	// 1 byte variable
*	unsigned int result[] = {0,0,0,0}
*	unsigned int countF;	// 1 byte counter
*	
*	unsigned int numA[] = {0,0,0,0};
*	unsigned int numB[] = {0,0,0,0};
*
*	ptA = &numA[0];
*	ptB = &numB[0];
*
*	*(ptA) = 0;
*	*(ptA+1) = 0;
*	*(ptA+2) = 0;
*	*(ptA+3) = 0;
*
*	*(ptB) = 0;
*	*(ptB+1) = 0;
*	*(ptB+2) = 0;
*	*(ptB+3) = 0;
*
*	result[0] = 0;
*	result[1] = 0;
*	result[2] = 0;
*	result[3] = 0;
*
*	int CF;
*	*(ptA+3)+=1;
*
*	while( countF != N){
*		count = 0;
*		int tempcount = 4;
*		ptA+3
*		ptB+3;
*		CF = 0;
*		do{
*			*ptA = *ptA + *ptB + CF;
*			ptA--;
*			ptB--;
*			count--;
*		}while( tempcount != 0)
*
*		ptA = &numA[0];
*		ptB = &numB[0];
*		
*		result[0] = *(ptA);
*		result[1] = *(ptA+1);
*		result[2] = *(ptA+2);
*		result[3] = *(ptA+3);
*		
*		*ptB = *ptA;
*		*(ptB+1) = *(ptA+1);
*		*(ptB+2) = *(ptA+2);
*		*(ptB+3) = *(ptA+3);
*
*		*ptA = result[0];
*		*(ptA+1) = result[1];
*		*(ptA+2) = result[2];
*		*(ptA+3) = result[3];
*
*		countF++;
*	}
*
**************************************

* start of data section


	ORG 	$B000
N       FCB    	40

	ORG 	$B010
RESULT  RMB     4
* define any other variables that you might need here

countF	RMB	1	* counter variable for fib sequence
Adata	RMB	4
Bdata	RMB	4


* start of your program
 
	ORG  	$C000

	LDX	#Adata
	LDY	#Bdata

	CLR	countF	* set count to zero
	CLR	0,X		* clear out x, and y - useful when running multiple times
	CLR	1,X
	CLR	2,X
	CLR	3,X	

	CLR	0,Y
	CLR	1,Y
	CLR	2,Y
	CLR	3,Y

	CLR	RESULT
	CLR	RESULT+3

	INC 	3,X	* debug, checking if add works	

WHILE	LDAA	countF	* -- fibonacci loop -- *
	CMPA	N
	BEQ	ENDWHILE	* break when n is equal to countF

	LDAB	#4	* load 4 into B, as counter

	LDX	#Adata+$3	* set pointer to left most
	LDY	#Bdata+$3

	CLC
DO	LDAA	0,X	* - ripple carry loop - *
	ADCA	0,Y	* add c, y to a
	STAA	0,X	* store result in x

	DEX		*decrement pointers
	DEY	

UNTIL	DECB		*- end ripple carry loop - *
	BNE	DO
ENDDO	

	CLRA		

	LDX	#Adata
	LDY	#Bdata

	LDD	0,X	* store first 2 bytes
	STD	RESULT
	LDD	2,X	* load last 2 bytes, store them
	STD	RESULT+2
	
	LDD	Bdata	* store B in A
	STD	Adata
	LDD	Bdata+2
	STD	Adata+2
	
	LDD	RESULT	* store result in B
	STD	Bdata
	LDD	RESULT+2
	STD	Bdata+2
	
	
	INC	countF	* increment count
	BRA	WHILE
ENDWHILE			* -- end fibonacci loop -- *

DONE	BRA	DONE
	END
