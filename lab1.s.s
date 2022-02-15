.section .text
.global main


//Set up constants for port. Don't Change!
.equ 	PCRD5, 		0x4004C014 //PORTD_PCR5   (GREEN), the manual has these backward
.equ 	SCGC5, 		0x40048038 //SIM_SCGC5    address
.equ 	PDDRD,  	0x400FF0D4 //GPIOB_PDDR   address
.equ 	PCORD,  	0x400FF0C8 //GPIOB_PCOR   address
.equ 	PSORD,  	0x400FF0C4 //GPIOB_PSOR   address


.equ 	twelve, 	0x00001000  // 1 << 12, for turning on port clock
.equ 	eight, 		0x00000100  // 1 << 8,  for setting MUX to GPIO
.equ	five, 		0x00000020  // 1 << 5,  for manipulating PIN


/*
---  Write your code below this line ---
Feel free to include additional label as needed.
*/


main:

       //Feel free to remove any unnecesary commands
	MOV   R0, #7
	BL    LEDSETUP
	BL    LEDON

	B     forever // after you program runs, it should enter this infinite loop

fib:
 	// Your code goes here!


/*
---  And above this one ---
*/

// Call this function first to set up the LED
// You only need to call this once
LEDSETUP:
	PUSH  {R4, R5}    //To preserve R4 and R5
	LDR   R4, =twelve // Load the value 1 << 12
	LDR   R5, =SCGC5
	STR   R4, [R5]

	LDR   R4, =eight  //MUX Port to be GPIO
	LDR   R5, =PCRD5
	STR   R4, [R5]

	LDR   R4, =five
	LDR   R5, =PDDRD
	STR   R4, [R5]
	POP   {R4, R5}
	BX    LR

// The functions below are for you to use freely
LEDON:
	PUSH  {R4, R5}
	LDR   R4, =five
	LDR   R5, =PCORD
	STR   R4, [R5]
	POP   {R4, R5}
	BX    LR

LEDOFF:
	PUSH  {R4, R5}
	LDR   R4, =five
	LDR   R5, =PSORD
	STR   R4, [R5]
	POP   {R4, R5}
	BX    LR

//wait forever
forever:
	B		forever
	.end

