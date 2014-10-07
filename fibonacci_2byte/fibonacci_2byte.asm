* Program description: generate the Nth number in the
* 	fibonacci sequence in 2-bits
*
* Pseudocode:
*
*	int main(void){
*		int RESULT;		
*		int ADATA;		// two variables to count up fibonacci sequence
*		int BDATA;
*		int NEXT;		// fibonacci sequence to return
*		int COUNT;
*		
*		NEXT = 0;		// assign 0 to all variables
*		ADATA = 0;
*		BDATA = 0;
*		NEXT = 0;
*		COUNT = 0;		// counter variable, want to use in while loop
*		RESULT = 0;
*
*		ADATA++;		// increment ADATA to first starting position
*
*		while( count != N){
*			a = a + b;
*			next = a;
*			a = b;
*			b = next;
*
*			count++;
*		}// end while
*		RESULT = next;
*	}// end main
*
*
**************************************

* start of data section

	ORG $B000
N	FCB	10 	* variable to return the fib number to

	ORG $B010
RESULT	RMB	2
* define any other variables that you might need here
ADATA	RMB	2
BDATA	RMB	2
NEXT	RMB	2	* make NEXT 2 bytes
COUNT	RMB	1

	ORG $C000
* start of program
	CLR	NEXT	* clear out all variables...
	CLR	NEXT+1	* clear second byte of varaibles
	CLR	ADATA
	CLR	ADATA+1
	CLR	BDATA
	CLR	BDATA+1
	CLR	COUNT	
	CLR	RESULT
	CLRA		* clear out registers A and B
	CLRB

	INC	ADATA+1	* set ADATA to a starting value of 1 at LSB

WHILE	LDAA	COUNT	* start of while loop
	CMPA	N	* make comparison
	BEQ	ENDWHILE
			* --- block --- *

	LDD	ADATA	* load up ADATA
	ADDD	BDATA	* add BDATA to ADATA
	STD	NEXT	

	LDD	BDATA	* load, then save ADATA into BDATA
	STD	ADATA	

	LDD	NEXT	* load, then save NEXT into BDATA
	STD	BDATA
			
	INC	COUNT	* increment counter
	BRA	WHILE	* branch back up to while
			* ------------- *

ENDWHILE	LDD	NEXT	* load NEXT
	STD	RESULT	* store a into the result
DONE	BRA	DONE	* end program
	END


