;========================================================================================
;	VIC-20 KERNEL ROM Disassembly			
;	(c) 1995-1999 Richard A. Cini, Jr. All Rights Reserved.			
;				
;	To create compileable version: save as text, import into Excel and strip
;	column B, which is the address/op-code field. Re-open in Word
;	and fix-up double-quote problems from Ex-Im process.			
;				
;  Release History:				
;  ================				
;  1995/03/01	0.1		Originally scanned document to text	
;   {...many intervening steps...a slow, iterative process}
;  1997/03/21	0.99		First compiled completely with minor errors	
;  1997/03/24	1.01		Completed fix-up. Code now compiles with all things in the	
;				right places. Code still has fix-up tables. Still need to do
;				BASIC ROM. 
;  1997/06/12	1.1		Began code annotation process	
;  1997/07/25	1.12		cross-referenced locations and descriptions against table	
;				in "The Anatomy of the Commodore 64" book by Angerhausen
;				et. al.	Made minor changes.
;  1997/11/06	1.20		Changed RAM variable equates into DSEG
;  1998/03/13   1.21		Various comment changes
;========================================================================================

;========================================================================================
;  Boolean Logic Tutorial (because I always forget)				
;				
;  AND				
;				
;  A     MASK     Result         - Used to pass through bits (1=pass, 0=mask off)				
;  =     ====     ======         - Used to test to see if bits are set (using positive mask)				
;  0      0          0           - Used to "turn off" bits (0=force off)				
;  1      0          0
;  0      1          0
;  1      1          1
;
;  OR
;
;  A     MASK     Result         - Used to pass through bits (0=pass, 1=mask on)
;  =     ====     ======         - Used to test to see if bits are set (using inverted mask)
;  0      0          0           - Used to "turn on" bits (1=force on) 
;  1      0          1
;  0      1          1
;  1      1          1

#include "ramvars.inc"

;********************************************************************
;	Data Segment
;********************************************************************
.DSEG
.ORG 0h

USRPOK 	.db	0h			;00	USR jump (C64: DDR)
USRVEC 	.dw	0h			;01	USR vector (C64: processor reg)
ADRAY1 	.dw	0h			;03	float-fixed conversion vector
ADRAY2 	.dw	0h			;05	fixed-float conversion vector
CHARAC 	.db	0h			;07	search character
ENDCHR 	.db	0h			;08	scan-squtes flag (InQuote)
TABCOL 	.db	0h			;09	TAB column save
VERCK  	.db	0h			;0A	Load/verify flag (0=load, 1=verify)
COUNT  	.db	0h			;0B	input buffer pointer/#subscript
DIMFLG 	.db	0h			;0C	default DIM flag
VALTYP 	.db	0h			;0D	value type (ff=string, 0=numeric)
INTFLG 	.db	0h			;0E	integer flag (80=integer, 0=floating point)
DORES  	.db	0h			;0F	DATA scan, LIST quote, memory flag
SUBFLG 	.db	0h			;10	subscript, FNx flag
INPFLG 	.db	0h			;11	input flag (0=INPUT, 40=GET, 98=READ)
TANSGN 	.db	0h			;12	ATN sign, comparison evaluation flag
IOPMPT 	.db	0h			;13	current I/O prompt flag
INTRVL 	.dw	0h			;14	integer value
TEMPPT 	.db	0h			;16	POINTER: temporary string stack
LASTPT 	.dw	0h			;17	last temp string vector
TEMPST 	.db	0h,0h,0h,0h,0h,0h,0h,0h	;19	stack for temporary strings
	.db	0h			
UTLPTR 	.db	0h,0h,0h,0h		;22	utility pointer area
ADDEND 	.db	0h,0h,0h,0h,0h		;26	product area for multiplication
TXTTAB 	.dw	0h			;2B	POINTER: start of BASIC
VARTAB 	.dw	0h			;2D	POINTER: start of variables
ARYTAB 	.dw	0h			;2F	POINTER: start of arrays
STREND 	.dw	0h			;31	POINTER: end of arrays
FRETOP 	.dw	0h			;33	POINTER: string storage (moving down)
FRESPC 	.dw	0h			;35	utility string pointer
MEMSIZ 	.dw	0h			;37	POINTER: memory limit (memory size)
CURLIN 	.dw	0h			;39	current BASIC line number
OLDLIN 	.dw	0h			;3B	previous BASIC line number
OLDTXT 	.dw	0h			;3D	POINTER: BASIC statement for CONT
DATLIN 	.dw	0h			;3F	current DATA line number
DATPTR 	.dw	0h			;41	current DATA address
INPPTR 	.dw	0h			;43	input vector
VARNAM 	.dw	0h			;45	current variable name
VARPNT 	.dw	0h			;47	current variable address
FORPNT 	.dw	0h			;49	FOR/NEXT variable pointer
YSAVE  	.dw	0h			;4B	.Y save, op-save, BASIC pointer save
ACCSYM 	.db	0h			;4D	accumulator comparison symbol
WORK1  	.dw	0h,0h,0h		;4E	miscellaneous work area
JMPER  	.db	0h,0h,0h		;54	jump vector for functions
;WORKNV 	.db	0h		;57	miscellaneous work area - numeric
FC3M1  	.db	0h,0h,0h,0h,0h		;57	sometimes called FC #3
FC4M1  	.db	0h,0h,0h,0h,0h		;5C	sometimes called FC #4
FC1EXP 	.db	0h			;61	FAC1 exponent
FC1M1  	.db	0h			;62	FAC1 mantissa
FC1M2  	.db	0h			;63		
FC1M3  	.db	0h			;64		
FC1M4  	.db	0h			;65		
FC1SGN 	.db	0h			;66	FAC1 sign
SEVALP 	.db	0h			;67	series evaluation constant pointer
FC1OVF 	.db	0h			;68	FAC1 overflow
FC2EXP 	.db	0h			;69	FAC2 exponent
FC2M1  	.db	0h			;6A	FAC2 mantissa
FC2M2  	.db	0h			;6B
FC2M3  	.db	0h			;6C	
FC2M4  	.db	0h			;6D	
FC2SGN 	.db	0h			;6E	FAC2 sign
ARISGN 	.db	0h			;6F	FAC1:FAC2 sign comparison
FC1ROU 	.db	0h			;70	FAC1 rounding
CSBFLN 	.dw	0h			;71	cassette buffer length, series pointer
CHRGET 	.dw	0h,0h,0h		;73	CHGRET subroutine (next character)
CHRGOT 	.db	0h			;79	CHRGOT entry (current character)
TXTPTR 	.dw	0h,0h,0h,0h,0h,0h,0h	;7A	Pointer to current byte of BASIC text
FILLEN 	.db	0h,0h,0h		;88		
RNDX   	.db	0h,0h,0h,0h,0h		;8B	RND seed value
CSTAT  	.db	0h			;90	status word ST
STKEY  	.db	0h			;91	keyswitch PIA: STOP & RVS flags
SVXT   	.db	0h			;92	tape timing constant
IOFLG2 	.db	0h			;93	I/O flag #2 (0=load, 1=verify)
C3PO   	.db	0h			;94	serial deferred character flag
BSOUT  	.db	0h			;95	serial deferred character (buffered character)
EOTFLG 	.db	0h			;96	tape EOT received flag
REGSAV 	.db	0h			;97	register save
COPNFL 	.db	0h			;98	number of open files (max 10)
INDEV  	.db	0h			;99	input device (default 0=KEYBOARD)
OUTDEV 	.db	0h			;9A	output device (default 3=SCREEN)
TPRTY  	.db	0h			;9B	tape character parity flag
BYTINF 	.db	0h			;9C	byte received flag
CMDMOD 	.db	0h			;9D	command mode (80=direct, 0=run)
TPTR1  	.db	0h			;9E	tape pass 1 error log/character buffer
TPTR2  	.db	0h			;9F	tape pass 2 error log/corrected
CTIMR0 	.db	0h			;A0	jiffy clock (HML)
CTIMR1 	.db	0h			;A1	 
CTIMR2 	.db	0h			;A2	
SBITCF 	.db	0h			;A3	serial bit count/EOI flag
CYCLE  	.db	0h			;A4	cycle count
CNTDN  	.db	0h			;A5	countdown - tape write/bit count
BUFPNT 	.db	0h			;A6	POINTER: tape buffer
INBIT  	.db	0h			;A7	tape write leader count/read pass/inbit
BITCI  	.db	0h			;A8	tape write new byte/read error/inbit count
RINONE 	.db	0h			;A9	write start bit/read bit error/stbit
RIDATA 	.db	0h			;AA	tape scan, count, leader, end - byte assembly
RIPRTY 	.db	0h			;AB	write lead length/read CRC/parity
SAL    	.dw	0h			;AC	POINTER: tape buffer (scrolling)
EAL    	.dw	0h			;AE	POINTER: tape end address/end of program
TPCON1 	.db	0h			;B0	tape timing constant 1
TPCON2 	.db	0h			;B1	tape timing constant 2
TAPE1  	.dw	0h			;B2	POINTER: start of tape buffer
BITTS  	.db	0h			;B4	tape timer (1=enable); bit count
NXTBIT 	.db	0h			;B5	tape EOT;RS232 next bit to send
RODATA 	.db	0h			;B6	read character error/outbyte buffer
FNMLEN 	.db	0h			;B7	number of characters in filename
LOGFIL 	.db	0h			;B8	current logical file#
SECADR 	.db	0h			;B9	current secondary address
CHANNL 	.db	0h			;BA	current device number
FNPTR  	.dw	0h			;BB	POINTER: filename
ROPRTY 	.db	0h			;BD	write shift word/read input character
FSBLK  	.db	0h			;BE	tape pass counter
MYCH   	.db	0h			;BF	serial word buffer
CAS1   	.db	0h			;C0	tape motor interlock
STAL   	.dw	0h			;C1	I/O start address
MEMUSS 	.dw	0h			;C3	I/O end address (POINTER: KERNEL setup)
CURKEY 	.db	0h			;C5	current key pressed
KEYCNT 	.db	0h			;C6	number of characters in the keyboard buffer
RVS    	.db	0h			;C7	screen reverse flag
EOLPTR 	.db	0h			;C8	POINTER: end of line for INPUT
ICRROW 	.db	0h			;C9	INPUT cursor row
ICRCOL 	.db	0h			;CA	INPUT cursor column
KEYDN  	.db	0h			;CB	which key (64=none)
BLNSW  	.db	0h			;CC	cursor enable (0=flash)
BLNCT  	.db	0h			;CD	cursor timing countdown
GDBLN  	.db	0h			;CE	character under cursor
BLNON  	.db	0h			;CF	cursor in blink phase
INSRC  	.db	0h			;D0	input from SCREEN or KEYBOARD
LINPTR 	.dw	0h			;D1	POINTER: screen line
CSRIDX 	.db	0h			;D3	position of cursor on screen line
CSRMOD 	.db	0h			;D4	cursor mode (0=direct, non-zero=programmed)
LINLEN 	.db	0h			;D5	screen line length ($16=22d)
CURROW 	.db	0h			;D6	current row
LASTKY 	.db	0h			;D7	last INKEY, CRC, buffer
INSRTO 	.db	0h			;D8	number of INSERTs outstanding
SLLTBL 	.dw	0h,0h,0h,0h,0h,0h,0h,0h	;D9	screen line link table
	.dw	0h,0h,0h,0h
SLDMY  	.db	0h			;F1	dummy screen link
SCROWM 	.db	0h			;F2	screen row marker
COLRPT 	.dw	0h			;F3	POINTER: screen color
KEYTAB 	.dw	0h			;F5	POINTER: keyboard
RIBUF  	.dw	0h			;F7	POINTER: RS232 Rx
ROBUF  	.dw	0h			;F9	POINTER: RS232 Tx
OSFRE0 	.db	0h			;FB	free Z-page OS space
OSFRE1 	.db	0h			;FC		
OSFRE2 	.db	0h			;FD		
OSFRE3 	.db	0h			;FE		
BASSTO 	.db	0h			;FF	BASIC storage

;Page 1 Variables
FBUFFR 	.dw	0h,0h,0h,0h,0h,0h,0h,0h	;0100	floating ASCII work area; tape error log; processor
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h	;		  stack area

;Page 2 Variables
.ORG $0200
BUF    	.dw	0h,0h,0h,0h,0h,0h,0h,0h	;0200		BASIC input buffer
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h
	.db	0h
FILTBL 	.dw	0h,0h,0h,0h,0h		;0259	logical file table
DEVTBL 	.dw	0h,0h,0h,0h,0h		;0263	devce number table
SECATB 	.dw	0h,0h,0h,0h,0h		;026D	secondary address table
KBUFFR 	.dw	0h,0h,0h,0h,0h		;0277	keyboard buffer
OSSTAR 	.dw	0h			;0281	POINTER: start of memory for OS
OSTOP  	.dw	0h			;0283	POINTER: end of BASIC memory (top of mem for OS)
STIMOT 	.db	0h			;0285	serial bus timeout flag
CLCODE 	.db	0h			;0286	current color code
CSRCLR 	.db	0h			;0287	color under cursor
HIPAGE 	.db	0h			;0288	screen memory page
KBMAXL 	.db	0h			;0289	maximum size of keyboard buffer
KEYRPT 	.db	0h			;028A	key repeat (80=repeat all keys)
KRPTSP 	.db	0h			;028B	repeat speed
KRPTDL 	.db	0h			;028C	repeat delay
SHFTFL 	.db	0h			;028D	keyboard SHIFT/CTRL flag
LSSHFT 	.db	0h			;028E	last keyboard shift pattern
FCEVAL 	.dw	0h			;028F	POINTER: keyboard decode logic (FCEVAL)
SHMODE 	.db	0h			;0291	shift mode (0=enabled, 80=locked)
SCRLFL 	.db	0h			;0292	auto scroll down flag (0=on, non-zero=off)
M51CTR 	.db	0h			;0293	RS232 control register
M51CDR 	.db	0h			;0294	RS232 command register
M51AJB 	.dw	0h			;0295	RS232 baud rate (non-standard)
RSSTAT 	.db	0h			;0297	RS232 status register
BITNUM 	.db	0h			;0298	number of bits to send
BAUDOF 	.dw	0h			;0299	RS232 baud rate
RIDBE  	.db	0h			;029B	RS232 receive pointer
RIDBS  	.db	0h			;029C	RS232 input pointer
RODBS  	.db	0h			;029D	RS232 transmit pointer
RODBE  	.db	0h			;029E	RS232 output pointer
TAPIRQ 	.dw	0h			;029F	POINTER: saved IRQ address during tape operations
PGINDR 	.db	0h			;02A1	program indirects
;c64:	02a1	CIA2 NMI
;	02a2	CIA2 Timer A
;	02a3	CIA1 IRQ
;	02a4	CIAl Timer A
;	02a5	screen lines
;	02c0	sprite 11
;	02ff	undefined
		
;Page 3 Variables
.ORG $0300
ERRVPT 	.dw	0h			;0300	POINTER: ERROR message routine
MAINVP 	.dw	0h			;0302	POINTER: BASIC warm start
CRNCHV 	.dw	0h			;0304	POINTER: crunch BASIC tokens
LISTVP 	.dw	0h			;0306	POINTER: print BASIC tokens
BYEBVP 	.dw	0h			;0308	POINTER: start new BASIC code
EVALVP 	.dw	0h			;030A	POINTER: get arithmetic element
R6502A 	.db	0h			;030C	.A
R6502X 	.db	0h			;030D	.X
R6502Y 	.db	0h			;030E	.Y
R6502P 	.db	0h			;030F	.P
UNKNO1 	.dw	0h,0h			;0310	range $0310-$0313
;c64:	.db	$4c			; User JMP vector
;	.dw	USR vector

;========================================================================================
;  System Vectors
;
;  These are the indirected system vectors located in page 3 RAM. Calling these
;  functions requires an indirect JSR or JMP. These locations used primarily for
;  re-vectoring to user-created code that provides equivalent functionality.
IRQVP  	.dw	0h			;0314	IRQ		EABF
BRKVP  	.dw	0h			;0316	Break		FED2
NMIVP  	.dw	0h			;0318	NMI		FEAD
OPENVP 	.dw	0h			;031A	OPEN		F40A
CLOSVP 	.dw	0h			;031C	CLOSE		F34A
CKINVP 	.dw	0h			;031E	Set Input	F2C7
CKOTVP 	.dw	0h			;0320	Set Output	F309
CLCHVP 	.dw	0h			;0322	Restore I/O	F3F3
CHINVP 	.dw	0h			;0324	INPUT		F20E
CHOTVP 	.dw	0h			;0326	OUTPUT		F27A
STOPVP 	.dw	0h			;0328	STOP		F770
GTINVP 	.dw	0h			;032A	GET		F1F5
CLALVP 	.dw	0h			;032C	CLALL		F3EF
USERVP 	.dw	0h			;032E	Warm start	FED2
LLODVP 	.dw	0h			;0330	Link to Load	F549
LSAVVP 	.dw	0h			;0332	Link to Save	F685
UNKNO2 	.db	0h,0h,0h,0h,0h,0h,0h,0h	;0334	range $0334-$033B
CSBUF  	.dw	0h,0h,0h,0h,0h,0h,0h,0h	;033C	cassette buffer
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h,0h,0h,0h,0h,0h,0h
	.dw	0h,0h			; padding
;c64:	0340	sprite 13
;	0380	sprite 14
;	03c0	sprite 15
	

;********************************************************************
;	Code Segment
;********************************************************************
.CSEG
.ORG $E000			

	.db $0F			
	.db $DC				;From BASIC ROM @$C000 JSR $DC0F
	LDA FC1EXP			
	CMP #$88			
	BCC ELOOP2			;E00B

ELOOP1				
	JSR MLDVEX			

ELOOP2				
	JSR INT			
	LDA CHARAC			
	CLC			
	ADC #$81			
	BEQ ELOOP1			;E008
	SEC			
	SBC #$01			
	PHA			
	LDX #$05			

ELOOP3				
	LDA FC2EXP,X			
	LDY FC1EXP,X			
	STA FC1EXP,X			
	STY FC2EXP,X			
	DEX			
	BPL ELOOP3			;$E01B
	LDA JMPER+2			
	STA FC1ROU			
	JSR FSUB+3			;$D853
	JSR NEGOP			;flip sign
	LDA #$EA			;FIXUP1 ;#$C4
	LDY #$EA			;FIXUP1+1 ;#$DF table of some constants
	JSR POLYIN			;calc polynomial
	LDA #$00			
	STA ARISGN			
	PLA			
	JSR MULDIV+2			;$DAB9
	RTS			

;====================================================================				
; POLYX - Function Series Evaluation				
;				
POLYX				
	STA CSBFLN			
	STY CSBFLN+1			;ptr to poly degree
	JSR MOV2F+3			;$DBCA move factor to a3
	LDA #$57			;#$57 ptr to fc3m1
	JSR FMULT			;multiply fac*a3 (square)
	JSR POLYX1			;calc
	LDA #$57			;}#$57 ptr to fc3m1
	LDY #$00			;}
	JMP FMULT			;fac=fac*a3

POLYIN				
	STA CSBFLN			;ptr to degree
	STY CSBFLN+1			

POLYX1				
	JSR MOV2F			;fac to ac4
	LDA (CSBFLN),Y			;degree
	STA SEVALP			;counter
	LDY CSBFLN			
	INY				;point to first coef.
	TYA			
	BNE POLYSK1			
	INC CSBFLN+1			

POLYSK1				
	STA CSBFLN			
	LDY CSBFLN+1			

POLYLP				
	JSR FMULT			;fac=fac*const (in A/Y)
	LDA CSBFLN			
	LDY CSBFLN+1			
	CLC			
	ADC #$05			;point to next #
	BCC POLYSK2			
	INY			

POLYSK2				
	STA CSBFLN			
	STY CSBFLN+1			;ptr next constant
	JSR FADD			;fac=fac+const (in A/Y)
	LDA #$5C			;}#$5C
	LDY #$00			;} ptr to FC4M1
	DEC SEVALP			
	BNE POLYLP			
	RTS			

;====================================================================				
; RMULC - Constant Manipulation: RND Data				
;				
RMULC				
	.db $98, $35, $44, $7A, $00	;11.879546

RMULC1	.db $68, $28, $B1, $46, $00	;3.92767774e-4			

;====================================================================				
; RND - Perform RND function				
;				
;				
;				
RND				
	JSR SIGN			;get sign
	BMI RNDCAL			;neg? branch
	BNE RANDDT			
	JSR IOBASE			;get IO base and...

	STX UTLPTR			
	STY UTLPTR+1			;...save as pointer
	LDY #$04			;}
	LDA (UTLPTR),Y			;}Timer1 low
	STA FC1M1			;}
	INY				;]
	LDA (UTLPTR),Y			;]Timer1 high
	STA FC1M3			;]
	LDY #$08			;}
	LDA (UTLPTR),Y			;}Timer2 low
	STA FC1M2			;}
	INY				;]
	LDA (UTLPTR),Y			;]Timer2 high
	STA FC1M4			;]
	JMP RNDEXIT			

RANDDT					
	LDA #$8B			;ptr to last RND	
	LDY #$00				
	JSR MOVFM			;mmove it to the FAC	

	LDA #$EA			;FIXUP1+2 #$8A randomize data LSB	
	LDY #$EA 			;FIXUP1+3 #$E0 randomize data MSB
	JSR FMULT			;multiply FAC=FAC*const	

	LDA #$EA 			;FIXUP1+4 #$8F	
	LDY #$EA 			;FIXUP1+5 #$E0	
	JSR FADD			;ADD at E0BF FAC=FAC+const	

RNDCAL					
	LDX FC1M4			;swap digits in FAC	
	LDA FC1M1				
	STA FC1M4			
	STX FC1M1			
	LDX FC1M2			
	LDA FC1M3			
	STA FC1M2			
	STX FC1M3			

RNDEXIT				
	LDA #$00			
	STA FC1SGN			
	LDA FC1EXP			
	STA FC1ROU			
	LDA #$80			;exponent
	STA FC1EXP			
	JSR FADD+112			;$D8D7 left-justify FAC
	LDX #$8B			
	LDY #$00			

RNEXIT				
	JMP MOV2F+13			;$DBD4 round result


;====================================================================				
; BIOERR - Handle I/O Error in BASIC				
;				
BIOERR				
	CMP #$F0			;error F0

;			1    1	  1     1    0    0    0    0
;		    EOT-|    |    |     |    |    |    |    |-TMO write
;			 EOF-|    |	|    |    |    |TMO Read
;		   checksum error-|     |    |    |-short block
;			  unrecoverable-|    |-long block

	BNE BERSK			
	STY MEMSIZ+1			;set RAM end
	STX MEMSIZ			
	JMP CLEAR+5			;$C663 clear from bottom to top

BERSK				
	TAX			
	BNE BERREX			
	LDX #$1E			;BREAK key 

BERREX				
	JMP ERROR			;error

;====================================================================				
; BCHOUT - Output character/BASIC				
;				
BCHOUT				
	JSR CHROUT			;standard call
	BCS BIOERR			;error branch on CY=1
	RTS				;return to BASIC

;====================================================================				
; BCHIN - Input a character/BASIC				
;				
BCHIN				
	JSR CHRIN			;standard call
	BCS BIOERR			;error branch on CY=1
	RTS			

;====================================================================				
; BCKOUT - Setup for output/BASIC				
;				
BCKOUT				
	JSR CHKOUT			;standard call
	BCS BIOERR			;error branch on CY=1
	RTS			

;====================================================================				
; BCKIN - Setup for input/BASIC				
;				
BCKIN				
	JSR CHKIN			;standard call
	BCS BIOERR			;error branch on CY=1
	RTS			

;====================================================================				
; BGETIN - Get one character/BASIC				
;				
BGETIN				
	JSR GETIN			;standard call
	BCS BIOERR			;error branch on CY=1
	RTS			

;====================================================================				
; SYS - Perform SYS/BASIC				
;				
SYS				
	JSR FRMNUM			;get numeric term
	JSR GETADR			;convert FAC1 to integer number

	LDA #$EA 			;FIXUP1+7 #$E1
	PHA			
	LDA #$EA 			;FIXUP1+6 #$43
	PHA				;push address $E143 (breakpoint)
	LDA R6502P			
	PHA				;save processor flags
	LDA R6502A			;load registers with new values
	LDX R6502X			
	LDY R6502Y			
	PLP				;restore flags
	JMP (INTRVL)			;jump to routine

	PHP				;on return, restore regs
	STA R6502A			
	STX R6502X			
	STY R6502Y			
	PLA			
	STA R6502P			;restore old flags
	RTS				;return to caller

;====================================================================				
; SAVET - Perform SAVE/BASIC				
;				
SAVET				
	JSR SLPARA			;get SAVE parameters
	LDX VARTAB			;load start of vars ptr, which
	LDY VARTAB+1			;equals end-of-BASIC
	LDA #TXTTAB			;start address=start of BASIC
	JSR SAVE			;call SAVE
	BCS BIOERR			;branch on error

	RTS			

;====================================================================				
; VERFYT - Perform Verify or Load/BASIC				
;				
VERFYT				
	LDA #$01			;setup for verify 1=verify
	.db $2C				;results in BIT $00A9 skip

;				
;BASIC Load				
;				
VERFYL				
	LDA #$00			;else, 0=load
	STA VERCK			;save code
	JSR SLPARA			;get parameters

	LDA VERCK			;get IO flag
	LDX TXTTAB			;get load address=BASIC start
	LDY TXTTAB+1			
	JSR LOAD			;Load file
	BCS CLSEXT			;branch on error 

	LDA VERCK			;Verify?
	BEQ VERLD			;go do it

	LDX #$1C			;error message #1C (Verify Error)
	JSR READST			;get IO status
	AND #%00010000			;#$10 mismatch error
	BEQ SKPRDY			;no, continue

	JMP ERROR			;do error

SKPRDY				
	LDA TXTPTR			;get current char
	CMP #$02			;direct mode?
	BEQ VERIFX			;yes, return to ready

	LDA #$EA			;$64 FIXUP2+4 print "OK"
	LDY #$EA			;$C3 FIXUP2+5
	JMP STROUT			

VERIFX				
	RTS			

VERLD				
	JSR READST			;get ST again
	AND #%10111111			;$BF EOF?
	BEQ VERSK1			;no, continue

	LDX #$1D			;error #1D "Load error"
	JMP ERROR			;do it

VERSK1				
	LDA TXTPTR+1			 
	CMP #$02			;direct mode?
	BNE VERSK2			;no, continue

	STX VARTAB			;save address of program end
	STY VARTAB+1 			
	LDA #$EA			;$76 FIXUP2+6 print "READY"
	LDY #$EA			;$C3 FIXUP2+7
	JSR STROUT			
	JMP $C52A			;jump into BASIC

VERSK2				
	JSR STXPT			;CHRGET ptr to start
	JMP BASSLN			;find pgm lines again

;====================================================================				
; OPENT - Perform OPEN/BASIC				
;				
OPENT				
	JSR OCPARA			;get OPEN params
	JSR OPEN			;call OPEN
	BCS CLSEXT			;error branch on CY=1
	RTS				;return

;====================================================================				
; CLOSET - Perform CLOSE/BASIC				
;				
CLOSET				
	JSR OCPARA			;get original OPEN params
	LDA FORPNT			;file#
	JSR CLOSE			;call close
	BCC VERIFX			;return on carry clear

CLSEXT				
	JMP BIOERR			;IO Error

;====================================================================				
; SLPARA - Get LOAD/SAVE parameters				
;				
SLPARA				
	LDA #$00			;assume no filename...
	JSR SETNAM			;set it
	LDX #$01			;...device 1 (cass)
	LDY #$00			;...SA=0
	JSR SETLFS			;set params
	JSR DEFLT			;any more params?
	JSR OCPSK2			;yes, check for filename
	JSR DEFLT			;more?
	JSR COMBYT			;check for device#
	LDY #$00			;message 0
	STX FORPNT			;save device#
	JSR SETLFS			;set params again
	JSR DEFLT			;more params?
	JSR COMBYT			;yes, must be message#
	TXA			
	TAY			
	LDX FORPNT			;get device#
	JMP SETLFS			;set params for last time

;====================================================================				
; COMBYT - Get next one-byte parameter				
;				
COMBYT				
	JSR COMMA			;check for comma
	JMP GETBYT+3			;get byte param to .X

;====================================================================				
; DEFLT - Check default parameters				
;				
DEFLT				
	JSR CHRGOT			;get current char to .A
	BNE DEFLEX			;return if not EOL

	PLA				;pop last call from stack to return to
	PLA				;caller of caller 2 levels up.

DEFLEX				
	RTS			

;====================================================================				
; COMMA - Check for comma				
;				
COMMA				
	JSR CHKCOM			;BASIC comma check
	JSR CHRGOT			;get current char
	BNE DEFLEX			;not comma, return

	JMP SNERR			;error: comma w/o param

;====================================================================				
; OCPARA - Get OPEN/CLOSE parameters				
;				
OCPARA				
	LDA #$00			;assume no filename
	JSR SETNAM			;set it
	JSR COMMA+3			;more params?
	JSR GETBYT+3			;yes, get next to .X (file#)
	STX FORPNT			;save param value (file#)
	TXA				;copy param to .A
	LDX #$01			;device 1 (cass)
	LDY #$00			;SA= 0 (read)
	JSR SETLFS			;set params
	JSR DEFLT			;more params? (device#)
	JSR COMBYT			;yes, get value
	STX FORPNT+1			;save
	LDY #$00			;SA= 0(read)
	LDA FORPNT			;.A= file#
	CPX #$03			;device <=3
	BCC OCPSK1			;yes, go set params

	DEY				;msg =FF if not IEEE

OCPSK1				
	JSR SETLFS			;set params
	JSR DEFLT			;more? (msg#)
	JSR COMBYT			;yes, get value (SA)
	TXA			
	TAY				;set message#...
	LDX FORPNT+1			;...device#
	LDA FORPNT			;...file#
	JSR SETLFS			;set params
	JSR DEFLT			;more params?
	JSR COMMA			;yes, check for comma

OCPSK2				
	JSR FRMEVL			;evaluate expression
	JSR FRESTR			;contains string?
	LDX UTLPTR			;yes, save string address LSB...
	LDY UTLPTR+1			;...MSB
	JMP SETNAM			;set filename param

;====================================================================				
; COS - Perform COS function/BASIC				
;	On entry, FAC1 contains radians. On exit, FAC1 holds COS.			
;				
COS				
	LDA #$EA 			;FIXUP1+12;#$DD
	LDY #$EA 			;FIXUP1+13;#$E2 PI2 table
	JSR FADD			;add to FAC

;====================================================================				
; SIN - Perform SIN function/BASIC				
;	On entry, FAC1 contains radians. On exit, FAC1 holds SIN.			
;				
SIN				
	JSR MOVAF			;round FAC, put in arg
	LDA #$EA 			;FIXUP1+14 ;#$E2
	LDY #$EA 			;FIXUP1+15 ;#$E2 PI*2 table
	LDX FC2SGN			
	JSR FDIV			;divide by 2pi
	JSR MOVAF			;round it
	JSR INT				;get integer
	LDA #$00			
	STA ARISGN			
	JSR FSUB+3			;$D853 arg-FAC
	LDA #$EA 			;FIXUP1+16;#$E7
	LDY #$EA 			;FIXUP1+17;#$E2
	JSR FSUB			;const 0.25-FAC
	LDA FC1SGN			
	PHA				;save sign
	BPL SINCON1			;if positive, negate it

	JSR FADDH			;FAC+0.5
	LDA FC1SGN			;get sign
	BMI SINCON1A			;negative?

	LDA TANSGN			;flip flag
	EOR #$FF			
	STA TANSGN			

SINCON1				
	JSR NEGOP			;negate sign

SINCON1A				
	LDA #$EA 			;FIXUP1+16;#$E7
	LDY #$EA 			;FIXUP1+17;#$E2
	JSR FADD			;FAC+0.25
	PLA				;get sign
	BPL SINCON2			;positive, branch

	JSR NEGOP			;else negate

SINCON2				
	LDA #$EA 			;FIXUP1+18;#$EC ptr to poly coeff.
	LDY #$EA 			;FIXUP1+19;#$E2
	JMP POLYX			;calc. polynomial

;====================================================================				
; TAN - Perform TAN function/BASIC				
;	On entry, FAC1 contains radians. On exit, FAC1 holds TAN.			
;				
TAN				
	JSR MOV2F+3			;$DBCA FAC to ac3
	LDA #$00			
	STA TANSGN			;set flag
	JSR SIN				;calc sin
	LDX #WORK1			;}$4E helper accum
	LDY #$00			;}
	JSR RNEXIT			;FAC to helper
	LDA #$57			;}$57 FC3M1 to FC
	LDY #$00			;}
	JSR MOVFM			;move ac3
	LDA #$00			
	STA FC1SGN			;save sign
	LDA TANSGN			;and flag
	JSR TAN2			;cals cos
	LDA #WORK1			;}$004E
	LDY #$00			;}
	JMP FDIVT			;divide WORK1 by FAC

TAN2				
	PHA			
	JMP SINCON1			;calc cos

;				
;Data: Trigonometry Constants $E2DD-E30A				
PI2					;PI/2 1.57079633
	.db $81, $49, $0F, $DA, $A2 			

PI22					;PI*2 6.28318531			
	.db $83, $49, $0F, $DA, $A2			

PI14					;1/4			
	.db $7F, $00, $00, $00, $00 			

RNCTR					;polynomial degree			
	.db $05			

TRIG14					;-14.3813907
	.db $84, $E6, $1A, $2D, $1B 

TRIG42					;42.0077971
	.db $86, $28, $07, $FB, $F8

TRIG76					;-76.7041703
	.db $87, $99, $68, $89, $01

TRIG81					;81.6052237
	.db $87, $23, $35, $DF, $E1

TRIG41					;-41.3417021
	.db $86, $A5, $5D, $E7, $28

TRIG6					;6.28318531
	.db $83, $49, $0F, $DA, $A2			


;====================================================================				
; ATN - Perform ATN function/BASIC				
;	On entry, FAC1 contains radians. On exit, FAC1 holds TAN.			
;				
ATN				
	LDA FC1SGN			;sign
	PHA				;save it
	BPL ATNSK1			;positive? branch

	JSR NEGOP			;change sign

ATNSK1				
	LDA FC1EXP			
	PHA				;save exponent
	CMP #$81			; 1?
	BCC ATNSK2			;no

	LDA #$EA			;$BC FIXUP2+8
	LDY #$EA			;$D9 FIXUP2+9 table of flt pt constants
	JSR FDIVT			;reciprocal of FAC

ATNSK2				
	LDA #$EA 			;FIXUP1+22;#$3B
	LDY #$EA 			;FIXUP1+23;$$E3 ATNCON - table of ATN constants
	JSR POLYX			;calc poly

	PLA				;restore exponent
	CMP #$81			;less than 1
	BCC ATNSK3			

	LDA #$EA 			;FIXUP1+12;#$DD	
	LDY #$EA 			;FIXUP1+13;#$E2	;const PI/2
	JSR FSUB			;pi/2-FAC	

ATNSK3					
	PLA				;get sign	
	BPL ATNEXT			;positive?	

	JMP NEGOP			;change it	

ATNEXT					
	RTS				

;					
;  ATN Constants $E33B-E377					
;				
ATNCON
	.db $0B				;11 polynomial degrees
	.db $76, $B3, $83, $BD, $D3	;-6.84793912e-04
	.db $79, $1E, $F4, $A6, $F5	; 4.85094216e-03
	.db $7B, $83, $FC, $B0, $10	;-0.0161117015
	.db $7C, $0C, $1F, $67, $CA	; 0.034209638
	.db $7C, $DE, $53, $CB, $C1	;-0.054279133
	.db $7D, $14, $64, $70, $4C	; 0.0724571965
	.db $7D, $B7, $EA, $51, $7A	;-0.0898019185
	.db $7D, $63, $30, $88, $7E	; 0.110932413
	.db $7E, $92, $44, $99, $3A	;-0.142839808
	.db $7E, $4C, $CC, $91, $C7	; 0.19999912
	.db $7F, $AA, $AA, $AA, $13	;-0.333333316
	.db $81, $00, $00, $00, $00	; 1.000000000

;====================================================================				
; INIT - BASIC cold start				
;				
INIT				
	JSR INITV			;init BASIC vector table

INITNV				
	JSR INITCZ			;init OS RAM locs
	JSR INITMS			;print power-up message
	LDX #$FB			
	TXS				;setup stack ptr
	JMP READY			;jump to BASIC

;====================================================================				
; INITAT - CHRGET for zero-page (ROM version of CHRGET)				
;				
INITAT				
	INC TXTPTR			
	BNE ININCR			

	INC TXTPTR+1			

ININCR				
	LDA MOVLOOP-2			
	CMP #':'			;$3A
	BCS INIEXT			

	CMP #' '			;$20 {space}
	BEQ INITAT			

	SEC			
	SBC #$30			
	SEC			
	SBC #$D0			

INIEXT				
	RTS			

;====================================================================				
; RNDSED - RND seed value				
;				
RNDSED				
	.db $80, $4F, $C7, $52, $58	;0.811635157

;====================================================================				
; INITCZ - Initialize BASIC RAM				
;				
INITCZ				
	LDA #$4C			;save JMP op-code...
	STA JMPER			;...for functions
	STA USRPOK			;...usr functions
	LDA #$EA 			;FIXUP1+24;#$48
	LDY #$EA 			;FIXUP1+25;#$D2
	STA USRVEC			;USER vector at $D248
	STY USRVEC+1			

	LDA #$EA 			;FIXUP1+26;#$91
	LDY #$EA 			;FIXUP1+27;#$D3
	STA ADRAY2			
	STY ADRAY2+1			;fixed-float cvt code $D391

	LDA #$EA			;FIXUP1+28;#$AA
	LDY #$EA 			;FIXUP1+29;#$D1
	STA ADRAY1			
	STY ADRAY1+1			;float-fixed cvt code $D1AA

	LDX #$1C			;move 28 bytes of code

CHGLOP				
	LDA INITAT,X			;copy CHRGET to z-page location
	STA CHRGET,X			
	DEX			
	BPL CHGLOP			

	LDA #$03			;setup various locations
	STA JMPER-1			;$53 step-width for garbage collection
	LDA #$00			
	STA FC1OVF			
	STA IOPMPT			;input device=keyboard
	STA LASTPT+1			
	LDX #$01			
	STX BUF-3			;$01FD
	STX BUF-4			;$01FC
	LDX #$19			
	STX TEMPPT			;ptr for string stack
	SEC				;read bottom of RAM
	JSR MEMBOT			
	STX TXTTAB			;save membot.LSB as start of BASIC
	STY TXTTAB+1			;save membot.MSB
	SEC				;read top of RAM
	JSR MEMTOP	
	STX MEMSIZ			;set mem size...
	STY MEMSIZ+1			
	STX FRETOP			;...and top of BASIC
	STY FRETOP+1			
	LDY #$00			;set zero pointer for start
	TYA				;of BASIC (NEWed) sentinal
	STA (TXTTAB),Y			
	INC TXTTAB			
	BNE CZEXIT			

	INC TXTTAB+1			

CZEXIT				
	RTS			


;====================================================================				
; INITMS - Print power-up message				
;				
INITMS				
	LDA TXTTAB			;determine memory size
	LDY TXTTAB+1			;based on start of BASIC	
	JSR REASON			;check free memory	
	LDA #$EA 			;FIXUP1+30;#$36	WORDS text
	LDY #$EA 			;FIXUP1+31;#$E4	
	JSR STROUT			;print version string	

	LDA MEMSIZ			;calc mem size in bytes...	
	SEC				;BASIC end...	
	SBC TXTTAB			;minus start...	
	TAX				
	LDA MEMSIZ+1				
	SBC TXTTAB+1			;equals free	
	JSR INPRT1			;$DDCD print BASIC line number 	
	LDA #$EA 			;FIXUP1+32;#$29	FREMES text
	LDY #$EA 			;FIXUP1+33;#$E4	
	JSR STROUT			;print "xx bytes free"	
	JMP SCRTCH1			;$C644 external entry into SCRTCH (NEW)

FREMES				
	.db " BYTES FREE", $0D, $00			

WORDS				
	.db $93, "**** CBM BASIC V2 ****", $0D, $00			

;====================================================================				
; BVTRS - Basic vector table				
;				
BVTRS				
	.dw ERROR+3			;$C43A
	.dw MAIN+3			;$C483
	.dw CRNCH+3			;$C57C
	.dw QPLOP+3			;$C71A
	.dw GONE+3			;$C7E4
	.dw EVAL+3			;$CE86

;====================================================================				
; INITV - Initialize BASIC vectors				
;				
INITV				
	LDX #$0B			;move 12 bytes

TVLOOP				
	LDA BVTRS,X			;load from BASIC vector table
	STA ERRVPT,X			;copy to $0300
	DEX			
	BPL TVLOOP			

	RTS			

;====================================================================				
; BASSFT - BASIC warm start (NMI re-entrance)				
;				
BASSFT				
	JSR CLRCH			;reset I/O channels
	LDA #$00			
	STA IOPMPT			;set input device as keyboard
	JSR CLEAR2			;$c67a CLEAR
	CLI				;clear interrupts
	JMP READY			

;				
; unknown what this is for. Appears at the end of the C64 BASIC LOAD code.				
;				
	.db $41				;appears nowhere

BASSLN				
	JSR LNKPRG			;rechain BASIC lines
	JMP CLEAR1			;$c677 CLEAR

;====================================================================				
; FIXUP1 - Absolute location fixup area #1				
;				
FIXUP1	;$E47C			
	.dw $DFC4			;0 e47c
	.dw RMULC			;2 7e
	.dw RMULC1			;4 80
	.dw SYS+28			;6 82 ROM breakpoint
	.dw $C364			;8 84
	.dw $C316			;10 86
	.dw PI2				;12 88
	.dw PI22			;14 8a
	.dw PI14			;16 8c
	.dw RNCTR			;18 8e
	.dw $D9BC			;20 90
	.dw ATNCON			;22 92
	.dw $D248			;24 94
	.dw $D391			;26 96
	.dw $D1AA			;28 98
	.dw WORDS			;30 9a
	.dw FREMES			;32 9c
	.dw SHEVAL			;34 9e
					;ends at $ef9f


;====================================================================				
; SOUT1 - Serial output 1 (inverted logic)				
;				
SOUT1				
	LDA D2PCR			;load PCR
	AND #%11011111			;$DF turn off CB2
	STA D2PCR			;save change
	RTS			

;====================================================================				
; SOUT0- Serial output 0 (inverted logic)				
;				
SOUT0				
	LDA D2PCR			;load PCR
	ORA #%00100000			;$20 turn on CB2
	STA D2PCR			;save change
	RTS			

;====================================================================				
; SDCLK - Get SDCLK status				
;				
SDCLK				
	LDA D1ORAH			;load register
	CMP D1ORAH			;any change?
	BNE SDCLK			;yes (unstable), loop

	LSR A				;shift Bit0 to .A
	RTS			


;====================================================================				
; SSADR - Get SECADR patch for LOAD/VERIFY				
;				
SSADR				
	LDX SECADR			;get secondary address
	JMP SRCHMS			;print "Searching..."

;====================================================================				
; SLDPCH - Relocated patch for serial LOAD/VERIFY				
;				
SLDPCH				
	TXA			
	BNE SLDEXIT			;load location not set in LOAD call, so
					;continue with load

	LDA MEMUSS			;get specified load address from call...
	STA EAL				;and save as program start address
	LDA MEMUSS+1			
	STA EAL+1			

SLDEXIT				
	JMP LOADMS			;print "Loading"

;====================================================================				
; TPWPCH - Tape write patch for CLOSE				
;				
TPWPCH				
	JSR TPWRIT			;write to tape
	BCC TPWCHEX			;error? close

	PLA				;set exit code
	LDA #$00			

TPWCHEX				
	JMP ICLSE2			;External entry into ICLOSE

;====================================================================				
; FIXUP2 - Absolute location fixup area #2				
;				
FIXUP2	;$E4DA			
	.dw KNRLSV			;0 e4da FD6D
	.dw KDECD1			;2 dc
	.dw $c364			;4 de OK
	.dw $c376			;6 e0 ready
	.dw $d9bc			;8 e2 FONE
	.dw $FFFF			;10 e4
	.dw $FFFF			;12 e6
	.dw $FFFF			;14 e8
	.dw $FFFF			;16 ea
	.dw $FFFF			;18 ec
	.dw $FFFF			;20 ee
	.dw $FFFF			;22 f0
	.dw $FFFF			;24 f2
	.dw $FFFF			;26 f4
	.dw $FFFF			;28 f6
	.dw $FFFF			;30 f8
	.dw $FFFF			;32 fa
	.dw $FFFF			;34 fc
	.dw $FFFF			;36 fe
					;ends at $e4ff

;###################################################################				
;  Official start of the VIC KERNEL				
;###################################################################				

;====================================================================				
; IIOBASE - Return I/O base address				
;	Returns the IO Base address in .X(LSB) and .Y(MSB)			
IIOBASE				
	LDX #$10			;return $9110 as IO Base
	LDY #$91			
	RTS			

;====================================================================				
; ISCREN - Return screen organization				
;	Returns the screen organization is .X(columns) and .Y(rows)			
;				
ISCREN				
	LDX #$16        		;return 22 cols x 23 rows
	LDY #$17			
	RTS			

;====================================================================				
; IPLOT - Read/set cursor position				
;	On entry:  SEC to read cursor position to .X(row) and .Y(col)			
;	           CLC to save cursor position from .X(row) and .Y(col)			
; 				
IPLOT				
	BCS READPL			;carry set? yes, read position
	STX CURROW			;save row...
	STY CSRIDX			;...and column
	JSR SCNPTR			;update position

READPL				
	LDX CURROW			;return row...
	LDY CSRIDX			;...and column
	RTS			

;====================================================================				
; CINT1 - Initialize I/O				
;				

;				
;Screen reset				
;				
CINT1				
	JSR IODEF1			;set deflt I/O and init VIC chip
	LDA HIPAGE			;get screen memory page
	AND #%11111101			;$FD MS nibble is ChrROM and
	ASL A				;LS nibble is ChrRAM
	ASL A			
	ORA #%10000000			;$80
	STA VRSTRT			;set chargen ROM to $8000
	LDA HIPAGE			;get screen mem page
	AND #%00000010			;$02 check for screen RAM at 
	BEQ CINT1A			;$E536 $1E page

	LDA #%10000000			;$80 screen RAM is at $10 page
	ORA VRCOLS			;set Bit7
	STA VRCOLS			

CINT1A				
	LDA #$00			
	STA SHMODE			;enable shift-C=
	STA BLNON			;start at no blink

	LDA #$EA 			;FIXUP1+34;#$DC
	STA FCEVAL			
	LDA #$EA 			;FIXUP1+35;#$EB
	STA FCEVAL+1			;shift mode evaluation

	LDA #$0A			
	STA KBMAXL			;key buffer=16
	STA KRPTDL			;repeat delay=16ms
	LDA #$06			
	STA CLCODE			;color=6(blue)
	LDA #$04			
	STA KRPTSP			;repeat speed
	LDA #$0C			
	STA BLNCT			;blink timer=12ms
	STA BLNSW			;set for solid cursor
;				
; Clear screen				
;				
CLRSCN				
	LDA HIPAGE			;mem page for screen RAM
	ORA #%10000000			;$80
	TAY			
	LDA #$00			
	TAX			

CLRLP1				
	STY SLLTBL,X			;address of screen line
	CLC			
	ADC #$16			;add 22
	BCC CLRSC1			

	INY			

CLRSC1				
	INX			
	CPX #$18			;all rows done?
	BNE CLRLP1			

	LDA #$FF			
	STA SLLTBL,X			
	LDX #$16			

CLRLP2				
	JSR CLRLIN			;clear line
	DEX			
	BPL CLRLP2			
;				
; "Home" cursor				
;				
HOME				
	LDY #$00			
	STY CSRIDX			;set col to 0
	STY CURROW			;and row, too
;				
; Set screen pointers	
;	
SCNPTR	
	LDX CURROW
	LDA CSRIDX

SCNPLP	
	LDY SLLTBL,X
	BMI SCNPT1

	CLC
	ADC #$16
	STA CSRIDX
	DEX
	BPL SCNPLP

SCNPT1	
	LDA SLLTBL,X
	AND #$03
	ORA HIPAGE
	STA LINPTR+1
	LDA LBSCAD,X
	STA LINPTR
	LDA #$15
	INX

SCNLP1	
	LDY SLLTBL,X
	BMI SCNEXIT

	CLC
	ADC #$16
	INX			
	BPL SCNLP1			

SCNEXIT				
	STA LINLEN			
	RTS			

;====================================================================				
; PANIC - Set I/O defaults (unused entry point??)				
;				
PANIC				
	JSR IODEF1			;reset devices and VIC regs
	JMP HOME			;home cursor
;				
; Real PANIC entry; reset default devices				
;				
IODEF1					
	LDA #$03				
	STA OUTDEV			;reset output device to screen	
	LDA #$00				
	STA INDEV			;reset input device to keyboard	
;					
; Initialize 6561 VIC					
;					
	LDX #$10			;move 16 VIC registers	


V6561I					
	LDA VICSUP-1,X			;$ede3	register value table
	STA $8FFF,X			;save to VIC regs	
	DEX				
	BNE V6561I			;loop to next register	

	RTS			

;====================================================================				
; LP2 - Input from keyboard (prompt loop)				
;				
LP2				
	LDY KBUFFR			;get char at head of buffer
	LDX #$00			

LP2LOOP				
	LDA KBUFFR+1,X			;move next char "up" in list
	STA KBUFFR,X			
	INX				;loop until all remaining waiting keys
	CPX KEYCNT			;are copied
	BNE LP2LOOP			

	DEC KEYCNT			;one less key in buffer
	TYA				;return key in .A
	CLI				;
	CLC				;return no error
	RTS			

;====================================================================				
; INKEY - Input from keyboard (keyboard prompt loop)				
;				
INKEY				
	JSR OUTSCR			;output character

KEYLP1				
	LDA KEYCNT			;# of keys
	STA BLNSW			
	STA SCRLFL			
	BEQ KEYLP1			

	SEI			
	LDA BLNON			;in blink phase?
	BEQ INKEY1			

	LDA GDBLN			
	LDX CSRCLR			
	LDY #$00			
	STY BLNON			
	JSR PRNSCR			

INKEY1				
	JSR LP2			
	CMP #$83			;shift-run combo
	BNE INKEY2			;no, continue

	LDX #$09			;9 characters
	SEI			
	STX KEYCNT			;save # of chars

KEYLP2				
	LDA RUNSHF-1,X			;process run-shift meta key
	STA KBUFFR-1,X			;stuff into buffer
	DEX			
	BNE KEYLP2			
	BEQ KEYLP1			

INKEY2				
	CMP #$0D			;return yet?
	BNE INKEY			;no, loop

	LDY LINLEN			
	STY INSRC			;set cr-flag

KEYLP3				
	LDA (LINPTR),Y			;get char from screen
	CMP #$20			;space?
	BNE INKEY3			;no, continue

	DEY				;elim space at line end
	BNE KEYLP3			

INKEY3				
	INY			
	STY EOLPTR			;save position as index
	LDY #$00			
	STY SCRLFL			;reset modes
	STY CSRIDX			
	STY CSRMOD			
	LDA ICRROW			
	BMI INSCR1			

	LDX CURROW			
	JSR CSRMIN+4			;$E719
	CPX ICRROW			
	BNE INSCR1			;$E657
	BNE INSCR1			

	LDA ICRCOL			;last column
	STA CSRIDX			;save as column pointer
	CMP EOLPTR			;compare with index
	BCC INSCR1			
	BCS INSCR4A			

;====================================================================				
; INSCR - Input from screen/keyboard until <RET>				
;				
INSCR				
	TYA			
	PHA			
	TXA			
	PHA			
	LDA INSRC			;CR flag
	BEQ KEYLP1			;no, wait more

INSCR1				
	LDY CSRIDX			;get column
	LDA (LINPTR),Y			;get char from screen

	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea			
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea			
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea			

	STA LASTKY			
	AND #%00111111			;$3F
	ASL LASTKY			;change to ASCII
	BIT LASTKY			
	BPL INSCR2			

	ORA #%10000000			;$B0/80

INSCR2				
	BCC INSCR3			

	LDX CSRMOD			
	BNE INSCR4			

INSCR3				
	BVS INSCR4			

	ORA #%01000000			;$40

INSCR4				
	INC CSRIDX			;move cursor forward
	JSR QUOTET			;check on high-comma
	CPY EOLPTR			;cursor in last column?
	BNE INSCR7			

INSCR4A				
	LDA #$00			
	STA INSRC			;CR flag
	LDA #$0D			
	LDX INDEV			
	CPX #$03			;is input from screen?
	BEQ INSCR5			;yes, send it

	LDX OUTDEV			
	CPX #$03			;output to screen?
	BEQ INSCR6			;yes, continue

INSCR5				
	JSR OUTSCR			;write char to screen

INSCR6				
	LDA #$0D			

INSCR7				
	STA LASTKY			;save CR as last key
	PLA			
	TAX			
	PLA			
	TAY			
	LDA LASTKY			;screen code
	CMP #$DE			;is it pi??
	BNE INSCREX			;no, exit

	LDA #$FF			;yes, substitute BASIC token for pi

INSCREX				
	CLC			
	RTS			

;====================================================================				
; QUOTET - Quotes test				
;				
QUOTET				
	CMP #$22			;quote char?
	BNE QUOTEX			;no, exit

	LDA CSRMOD			;yes, set CursorMode to programmed
	EOR #%00000001			;$01
	STA CSRMOD			
	LDA #$22			;restore quote char

QUOTEX				
	RTS			

;====================================================================				
; CMD4 cmd- Setup screen print				
;				
CMD4				
	ORA #%01000000			;$40
	LDX RVS			
	BEQ CMD41			;$e6cd

	ORA #%10000000			;80

CMD41				
	LDX INSRTO			
	BEQ CMD42			;$e6d3

	DEC INSRTO			

CMD42				
	LDX CLCODE			;get color code
	JSR PRNSCR			;print it
	JSR CSRPLS			;update line-start table 

CMD42A				
	PLA			
	TAY			
	LDA INSRTO			;any INSERTs outstanding?
	BEQ CMD4SK			;$E6E4 no, exit

	LSR CSRMOD			

CMD4SK				
	PLA			
	TAX			
	PLA			
	CLC			
	CLI			
	RTS			

;====================================================================				
; CSLPLS - Advance cursor (calc MSB for line start)				
;				
CSRPLS				
	JSR CKLNPL			
	INC CSRIDX			
	LDA LINLEN			
	CMP CSRIDX			
	BCS CSREXIT			;$E72C

	CMP #$57			;#of chars (88 = 4 lines)
	BEQ CSRDEC			;$E723

	LDA SCRLFL			
	BEQ CSRPSK			;$E701
	JMP INSSLOP			;$E9F0

CSRPSK				
	LDX CURROW			
	CPX #$17			
	BCC CSRSK2			;$E70E

	JSR SCRLSC			
	DEC CURROW			
	LDX CURROW			

CSRSK2				
	ASL SLLTBL,X			
	LSR SLLTBL,X			
	JMP G4			

;====================================================================				
; CSRMIN - Move cursor back				
;				
CSRMIN				
	ADC #$16			;add 22d (screen line length)
	STA LINLEN			

CSRMLP				
	LDA SLLTBL,X			
	BMI CSRMIN1			;$E720

	DEX			
	BNE CSRMLP			;$E719

CSRMIN1	
	JMP LINSTR

CSRDEC	
	DEC CURROW
	JSR NEWLIN
	LDA #$00
	STA CSRIDX

CSREXIT	
	RTS

;====================================================================	
; CSRUP - Move cursor up	
;	
CSRUP				
	LDX CURROW			
	BNE CSRUP1			;$E737

	STX CSRIDX			
	PLA			
	PLA			
	BNE CMD42A			;$E6DC

CSRUP1				
	DEX			
	STX CURROW			
	JSR SCNPTR			
	LDY LINLEN			
	STY CSRIDX			
	RTS			

;====================================================================				
; OUTSCR - Output to screen				
;				
OUTSCR				
	PHA			
	STA LASTKY			
	TXA			
	PHA			
	TYA			
	PHA			
	LDA #$00			
	STA INSRC			
	LDY CSRIDX			
	LDA LASTKY			
	BPL NOSHCH			;$E756

	JMP SHCHRS			
;				
; Output unshifted characters				
;				
NOSHCH				
	CMP #$0D			
	BNE NOTCR			;$E75D

	JMP CR			

NOTCR				
	CMP #$20			;{space}
	BCC CTRLCODE			;$E771

	CMP #$60			;last standard ASCII
	BCC ALPHA			;$E769

	AND #%11011111			;$DF
	BNE ALPHA1			;$E76B

ALPHA				
	AND #%00111111			;$3F

ALPHA1				
	JSR QUOTET			
	JMP CMD4+2			;$E6C7

CTRLCODE				
	LDX INSRTO			
	BEQ NOINSERT			;$E778
	JMP CMD41-2			;$E6CB

NOINSERT				
	CMP #$14			;{delete}
	BNE NOTDEL			;$E7AA

	TYA			
	BNE DEL				;$E785

	JSR CSRUP			;$E72D
	JMP NOSHCH1			;$E79F

DEL				
	JSR CKLNMI			;$E8E8
	DEY			
	STY CSRIDX			
	JSR CCOLRAM			

NOSHLP1				
	INY			
	LDA (LINPTR),Y			
	DEY			
	STA (LINPTR),Y			
	INY			
	LDA (COLRPT),Y			
	DEY			
	STA (COLRPT),Y			
	INY			
	CPY LINLEN			
	BNE NOSHLP1			;$E78E

NOSHCH1				
	LDA #$20			
	STA (LINPTR),Y			
	LDA CLCODE			
	STA (COLRPT),Y			
	BPL NOTRT1A			;$E7F7

NOTDEL				
	LDX CSRMOD			
	BEQ NOTDEL1			;$E7B1
	JMP CMD41-2			;$E6CB

NOTDEL1				
	CMP #$12			;{RVS}
	BNE NOTRVS			;$E7B7

	STA RVS			

NOTRVS				
	CMP #$13			;{HOME}
	BNE NOTHOME			;$E7BE

	JSR HOME			

NOTHOME				
	CMP #$1D			;{RIGHT}
	BNE NOTRT			;$E7D9

	INY				;right
	JSR CKLNPL			
	STY CSRIDX			
	DEY			
	CPY LINLEN			
	BCC CSRRTEX			;$E7D6

	DEC CURROW			
	JSR NEWLIN			
	LDY #$00			
	STY CSRIDX			

CSRRTEX				
	JMP CMD42A			;$E6DC

NOTRT				
	CMP #$11			;{DOWN}
	BNE NOTDOWN			;$E7FA

	CLC				;down
	TYA			
	ADC #$16			
	TAY			
	INC CURROW			
	CMP LINLEN			
	BCC CSRRTEX-2			;$E7D4
	BEQ CSRRTEX-2			;$E7D4

	DEC CURROW			

NOTRTLP				
	SBC #$16			
	BCC NOTRT1			;$E7F4

	STA CSRIDX			
	BNE NOTRTLP			;$E7EC

NOTRT1				
	JSR NEWLIN			

NOTRT1A				
	JMP CMD42A			

NOTDOWN				
	JSR STCLRC			;$E912
	JMP GRTXTF			;$ED21
;				
; Output shifted characters				
;				
SHCHRS				
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea			
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea			
	.db $ea, $ea, $ea, $ea, $ea			

	AND #%01111111			;$7F
	CMP #%01111111			;$7F
	BNE SRCH_S1			;$E81D

	LDA #$5E			

SRCH_S1				
	.db $ea, $ea, $ea, $ea, $ea, $ea			

	CMP #$20			;{space}
	BCC SRCH_S2			;$E82A
	JMP CMD4			;$E6C5

SRCH_S2				
	CMP #$0D			;{return}
	BNE SRCH_S3			;$E831
	JMP CR			

SRCH_S3				
	LDX CSRMOD			
	BNE SCHR2			;$E874

	CMP #$14			;{text}
	BNE SCHR1			;$E870

	LDY LINLEN			
	LDA (LINPTR),Y			
	CMP #$20			
	BNE SRCH_S4			;$E845

	CPY CSRIDX			
	BNE SRCH_S5			;$E84C

SRCH_S4				
	CPY #$57			
	BEQ SCHR1-3			;$E86D

	JSR INSSPC			;$E9EE

SRCH_S5				
	LDY LINLEN			
	JSR CCOLRAM			

SHCHLOOP				
	DEY			
	LDA (LINPTR),Y			
	INY			
	STA (LINPTR),Y			
	DEY			
	LDA (COLRPT),Y			
	INY			
	STA (COLRPT),Y			
	DEY			
	CPY CSRIDX			
	BNE SHCHLOOP			;$E851

	LDA #$20			
	STA (LINPTR),Y			
	LDA CLCODE			
	STA (COLRPT),Y			
	INC INSRTO			
	JMP CMD42A			

SCHR1				
	LDX INSRTO			
	BEQ SRCH_S6			;$E879

SCHR2				
	ORA #%01000000			;$40
	JMP CMD4+6			;$E6CB

SRCH_S6				
	CMP #$11			;{down}
	BNE SCHR3			;$E893

	LDX CURROW			
	BEQ SHCHEXIT-3			;$E8B8

	DEC CURROW			
	LDA CSRIDX			
	SEC			
	SBC #$16			
	BCC SRCH_S7			;$E88E

	STA CSRIDX			
	BPL SHCHEXIT-3			;$E8B8

SRCH_S7				
	JSR SCNPTR			
	BNE SHCHEXIT-3			;$E8B8

SCHR3				
	CMP #$12			;{RVS}
	BNE SRCH_S8			;$E89B

	LDA #$00			
	STA RVS			

SRCH_S8				
	CMP #$1D			;{right}
	BNE SHCH4			;$E8B1

	TYA			
	BEQ SRCH_S9			;$E8AB
	JSR CKLNMI			;$E8E8
	DEY			
	STY CSRIDX			
	JMP CMD42A			

SRCH_S9				
	JSR CSRUP			;$E72D
	JMP CMD42A			

SHCH4				
	CMP #$13			;{home}
	BNE SHCHEXIT			;$E8BB

	JSR CLRSCN			;$E55F
	JMP CMD42A			

SHCHEXIT				
	ORA #%10000000			;$80
	JSR STCLRC			;$E912
	JMP G1				;$ED30

;====================================================================				
; NEWLIN - Goto next line				
;				
NEWLIN				
	LSR ICRROW			;move to next row
	LDX CURROW			;get row#

NWLNLP				
	INX				;increment row
	CPX #$17			;screen bottom?
	BNE NEWLIN1			;$E8CF no, increment row
	JSR SCRLSC			;yes, scroll screen

NEWLIN1				
	LDA SLLTBL,X			;get link pointer
	BPL NWLNLP			;$E8C7
	STX CURROW			;save new row
	JMP SCNPTR			;update screen

;====================================================================				
; CR - Output <RET>				
;				
CR				
	LDX #$00			;clear...
	STX INSRTO			;  inserts outstanding
	STX RVS				;  reverse mode
	STX CSRMOD			;  programmed cursor (make direct)
	STX CSRIDX			;column 0 (line home)
	JSR NEWLIN			;create a new line
	JMP CMD42A			;$E6DC exit

;====================================================================				
; CKLNMI - Check line decrement				
;				
CKLNMI				
	LDX #$04			;loop counter (pause before scroll??)
	LDA #$00			

CKLNLP				
	CMP CSRIDX			;beginning of line?
	BEQ CKLND1			;$E8F7 yes, go to previous row

	CLC				;no, go to next row
	ADC #$16			
	DEX			
	BNE CKLNLP			;$E8EC loop 4x

	RTS			

CKLND1				
	DEC CURROW			;previous row
	RTS			

;====================================================================				
; CKLNPL - Check for line increment				
;				
CKLNPL				
	LDX #$04			;loop counter
	LDA #$15			;column 15

CKLNINL				
	CMP CSRIDX			;at EOL?
	BEQ CKLNIN			;$E909 yes, go to next line

	CLC				;no, check again
	ADC #$16			
	DEX			
	BNE CKLNINL			;$E8FE loop

	RTS			

CKLNIN				
	LDX CURROW			;get row
	CPX #$17			;end of screen?
	BEQ CKLNEX			;$E911 yes, return (and scroll later)

	INC CURROW			;no, go to next row

CKLNEX				
	RTS			

;====================================================================				
; STCLRC - Set color code				
;				
STCLRC				
	LDX #$07			;8 color codes to check

STCLRL				
	CMP COLRTB,X			;compare color code
	BEQ SETCLR			;$E91D found it? Set new color

	DEX				;not found, go to next color
	BPL STCLRL			;$E914 loop

	RTS				;color code not found, exit

SETCLR				
	STX CLCODE			;set new color code
	RTS				;exit

;  Table: Color code	
COLRTB	
	.db $90, $05, $1C, $9F, $9C, $1E, $1F, $9E


;  Table: ScreenCode <==> ASCII	
XLATB1	
	.db $EF, $A1, $DF, $A6, $E1, $B1, $E2, $B2
	.db $E3, $B3, $E4, $B4, $E5, $B5, $E6, $B6
	.db $E7, $B7, $E8, $B8, $E9, $B9, $FA, $BA
	.db $FB, $BB, $FC, $BC, $EC, $BD, $FE, $BE
	.db $84, $BF, $F7, $C0, $F8, $DB, $F9, $DD
	.db $EA, $DE, $5E, $E0, $5B, $E1, $5D, $E2
	.db $40, $B0, $61, $B1, $78, $DB, $79, $DD
	.db $66, $B6, $77, $C0, $70, $F0, $71, $F1
	.db $72, $F2, $73, $F3, $74, $F4, $75, $F5
	.db $76, $F6, $7D, $FD

;====================================================================	
; SCRLSC - Scroll screen evaluation	
;	
SCRLSC	
	LDA SAL
	PHA
	LDA SAL+1
	PHA
	LDA EAL
	PHA
	LDA EAL+1
	PHA

SCLPUSH				
	LDX #$FF			
	DEC CURROW			
	DEC ICRROW			
	DEC SCROWM			

SCRLP1				
	INX			
	JSR LINSTR			
	CPX #$16			
	BCS SCRL_S1			;$E99D

	LDA LBSCAD+1,X			;$EDFE,X
	STA SAL			
	LDA SLLTBL+1,X			
	JSR MOVELN			;shift screen line up
	BMI SCRLP1			;$E989

SCRL_S1				
	JSR CLRLIN			;clear line
	LDX #$00			

SCRLP2				
	LDA SLLTBL,X			
	AND #%01111111			;$7F
	LDY SLLTBL+1,X			
	BPL SCRL_S2			;E9AC

	ORA #%10000000			;$B0 or 80

SCRL_S2				
	STA SLLTBL,X			
	INX			
	CPX #$16			
	BNE SCRLP2			;$E9A2

	LDA SLLTBL+22			;$EF
	ORA #%10000000			;$B0 or 80
	STA SLLTBL+22			;$EF
	LDA SLLTBL			
	BPL SCLPUSH			;$E981

	INC CURROW			
	INC SCROWM			
	LDA #$FB			
	STA D2ORB			
	LDA D2ORA			
	CMP #$FE			;CTRL key pressed?
	PHP			
	LDA #$F7			
	STA  D2ORB			
	PLP			
	BNE SCRL_S3			;$E9DF

	LDY #$00			

SCRL_S2A				
	NOP				;scroll pause
	DEX			
	BNE SCRL_S2A			;E9D6

	DEY			
	BNE SCRL_S2A			;E9D6 

	STY KEYCNT			;#keys pressed =2

SCRL_S3				
	LDX CURROW 			
	PLA			
	STA EAL+1			
	PLA			
	STA EAL			
	PLA			
	STA SAL+1			
	PLA			
	STA SAL			
	RTS			


;====================================================================				
; INSSPC - Open a space on the screen (insert a second line)				
;				
INSSPC				
	LDX CURROW			

INSSLOP				
	INX			
	LDA SLLTBL,X			
	BPL INSSLOP			; $E9F0

	STX SCROWM			
	CPX #$16			
	BEQ INSSPC1			;$EA08
	BCC INSSPC1			

	JSR SCRLSC			
	LDX SCROWM			
	DEX			
	DEC CURROW			
	JMP CSRSK2			;$E70E

INSSPC1				
	LDA SAL			
	PHA			
	LDA SAL+1			
	PHA			
	LDA EAL			
	PHA			
	LDA EAL+1			
	PHA			
	LDX #$17			

INSSLP2				
	DEX			
	JSR LINSTR			
	CPX SCROWM			
	BCC INSSPC2			;$EA2C
	BEQ INSSPC2			;$EA2C

	LDA LBSCAD-1,X			;$EDFC
	STA SAL			
	LDA INSRTO,X			
	JSR MOVELN			
	BMI INSSLP2			;$EA16

INSSPC2				
	JSR CLRLIN			
	LDX #$15			

INSSLP3				
	CPX SCROWM			
	BCC INSEXIT			;$EA44

	LDA SLLTBL+1,X 			
	AND #%01111111			;$7F
	LDY SLLTBL,X			
	BPL INSSPC3			;$EA3F

	ORA #%10000000			;$80

INSSPC3				
	STA SLLTBL+1,X			
	DEX			
	BNE INSSLP3			;$EA31

INSEXIT	
	LDX SCROWM
	JSR CSRSK2
	PLA
	STA EAL+1
	PLA
	STA EAL
	PLA
	STA SAL+1
	PLA
	STA SAL
	RTS

;====================================================================	
; MOVELN - Move a screen line up	
;				
MOVELN				
	AND #%00000011			;$03
	ORA HIPAGE			
	STA SAL+1			
	JSR COPYCL			
	LDY #$15			

MOVLOOP				
	LDA (SAL),Y			
	STA (LINPTR),Y			
	LDA (EAL),Y			
	STA (COLRPT),Y			
	DEY			
	BPL MOVLOOP			;$EA62
	RTS			

;====================================================================				
; COPYCL - Synchronize color transfer				
;				
COPYCL				
	JSR CCOLRAM			;get loc of color RAM
	LDA SAL				;twiddle tape buffer addresses
	STA EAL			
	LDA SAL+1			
	AND #%00000011			;$03
	ORA #%10010100			;$94
	STA EAL+1			
	RTS			

;====================================================================				
; LINSTR - Set start of line				
;				
LINSTR				
	LDA LBSCAD,X			;$EDFD
	STA LINPTR			
	LDA SLLTBL,X			
	AND #%00000011			;$03
	ORA HIPAGE			
	STA LINPTR+1			
	RTS			

;====================================================================				
; CLRLIN - Clear screen line				
;				
CLRLIN				
	LDY #$15			;counter (#of cols)
	JSR LINSTR			;set start of line
	JSR CCOLRAM			;get loc of color RAM

CLEARLP				
	LDA #$20			;{space}
	STA (LINPTR),Y			;write {space}
	LDA #$01			
	STA (COLRPT),Y			;write color 1 (white?)
	DEY				;next column
	BPL CLEARLP			;$EA95 done? No, loop.
	RTS				;exit

;====================================================================				
; PRNSCR - Print to screen				
;	.A=char, .X=color			
PRNSCR				
	TAY				;save character
	LDA #$02			;blink cursor
	STA BLNCT			;set blink counter at repeat
	JSR CCOLRAM			
	TYA				;restore character

PRNSCR1	;get character & color on screen			
	LDY CSRIDX			;get column
	STA (LINPTR),Y			;write caracter...
	TXA			
	STA (COLRPT),Y			;...then color
	RTS				;return

;====================================================================				
; CCOLRAM - Calculate pointer to color RAM				
;				
CCOLRAM				
	LDA LINPTR			;get ptr to screen RAM LSB	
	STA COLRPT			;save it as color LSB	
	LDA LINPTR+1			;get screen RAM MSB	
	AND #%00000011			;$03	twiddle
	ORA #%10010100			;$94	
	STA COLRPT+1			;save as color ptr MSB	
	RTS				;exit	

;====================================================================					
; IRQVEC - IRQ Vector					
;					
IRQVEC					
	JSR UDTIM			;update clock F734	
	LDA BLNSW			;in blink phase?	
	BNE IRQVEC2			;$EAEF no, skip blink	

	DEC BLNCT			;decrement blink count
	BNE IRQVEC2			;$EAEF not reached 0, so do cass stuff

	LDA #$14			;reset blink timer to 20ms
	STA BLNCT			
	LDY CSRIDX			;cursor column
	LSR BLNON			;blink switch
	LDX CSRCLR			;color under cursor
	LDA (LINPTR),Y			;set character code
	BCS IRQVEC1			;$EAEA blink already on, so continue

	INC BLNON			;switch on
	STA GDBLN			;save char under cursor
	JSR CCOLRAM			;get ptr to color RAM
	LDA (COLRPT),Y			;get color code
	STA CSRCLR			;save it
	LDX CLCODE			;get color under cursor
	LDA GDBLN			;get char again

IRQVEC1				
	EOR #%10000000			;update cursor
	JSR PRNSCR1			;set char and color

IRQVEC2				
	LDA D1ORAH			;get I/O bitmap
	AND #%01000000			;$40 is cass switch pressed?
	BEQ IRQVEC3			;$EB01 no, turn drive off

	LDY #$00			
	STY CAS1			;zero motor interlock flag
	LDA D1PCR			;cass motor control
	ORA #%00000010			;$02 set motor on
	BNE IRQVEC4			;$EB0A save motor status

IRQVEC3				
	LDA CAS1			;get interlock flag
	BNE IRQVEC5			;$EB12 yes, skip update

	LDA D1PCR			;cass motor control
	AND #%11111101			;$FD set motor off

IRQVEC4				
	BIT D1IER			;IER
	BVS IRQVEC5			;$EB12 timer 1 enabled? Yes, branch

	STA D1PCR			;set motor status

IRQVEC5				
	JSR ISCNKY			;Eb1E scan keyboard
	BIT D2TM1L			;9124 D2T1 latch lsb 
	PLA			
	TAY			
	PLA			
	TAX			
	PLA			
	RTI			

;====================================================================				
; ISCNKY - Scan keyboard				
;	Scans keyboard for character. Called by IRQ routine. Key placed			
;	in keyboard buffer.			
ISCNKY				
	LDA #$00			
	STA SHFTFL			
	LDY #$40			
	STY KEYDN			
	STA D2ORB			
	LDX D2ORA			
	CPX #$FF			
	BEQ PROCK1A			;$EB8F

	LDA #$FE			
	STA D2ORB			
	LDY #$00			
	LDA #$EA 			;FIXUP2+2;#$5E
	STA KEYTAB			
	LDA #$EA 			;FIXUP2+3;#$EC
	STA KEYTAB+1			

ISCKLP1				
	LDX #$08			
	LDA D2ORA			
	CMP D2ORA			
	BNE ISCKLP1			;$EB40

ISCKLP2				
	LSR A			
	BCS ISCNK1+3			;$EB63

	PHA			
	LDA (KEYTAB),Y			
	CMP #$05			
	BCS ISCNK1			;$EB60

	CMP #$03			
	BEQ ISCNK1			;$EB60

	ORA SHFTFL			
	STA SHFTFL			
	BPL ISCNK1+2			;$EB62

ISCNK1				
	STY KEYDN			
	PLA			
	INY			
	CPY #$41			
	BCS ISCNEXIT			;$EB71

	DEX			
	BNE ISCKLP2			;$EB4A

	SEC			
	ROL D2ORB			
	BNE ISCKLP1			;$EB40

ISCNEXIT				
	JMP (FCEVAL)			
;				
; Process key image 				
;				
PROCKY				
	LDY KEYDN			
	LDA (KEYTAB),Y			
	TAX			
	CPY CURKEY			
	BEQ PROCK1			;$EB84

	LDY #$10			
	STY KRPTDL			
	BNE PROCK4			;$EBBA

PROCK1				
	AND #%01111111			;$7F
	BIT KEYRPT			
	BMI PROCK2			;$EBA1
	BVS PROCK5			;$EBD6

	CMP #$7F			

PROCK1A				
	BEQ PROCK4			;$EBBA

	CMP #$14			
	BEQ PROCK2			;$EBA1

	CMP #$20			
	BEQ PROCK2			;$EBA1

	CMP #$1D			
	BEQ PROCK2			;$EBA1

	CMP #$11			
	BNE PROCK5			;$EBD6

PROCK2				
	LDY KRPTDL			
	BEQ PROCK3			;$EBAB

	DEC KRPTDL			
	BNE PROCK5			;$EBD6

PROCK3				
	DEC KRPTSP			
	BNE PROCK5			;$EBD6

	LDY #$04			
	STY KRPTSP			
	LDY KEYCNT			
	DEY			
	BPL PROCK5			;$EBD6

PROCK4				
	LDY KEYDN			
	STY CURKEY			
	LDY SHFTFL			
	STY LSSHFT			
	CPX #$FF			
	BEQ PROCK5			;$EBD6

	TXA			
	LDX KEYCNT			
	CPX KBMAXL			
	BCS PROCK5			;$EBD6

	STA KBUFFR,X			
	INX			
	STX KEYCNT			

PROCK5				
	LDA #$F7			
	STA D2ORB			
	RTS			

;				
; Evaluate for shift/CTRL/Commodore keys				
;				
SHEVAL				
	LDA SHFTFL			
	CMP #$03			
	BNE PROCK6A			;$EC0F

	CMP LSSHFT			
	BEQ PROCK5			;$EBD6

	LDA SHMODE			
	BMI PROCKEX			;$EC43

	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea			
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea			
	.db $ea, $ea, $ea			

	LDA VRSTRT			
	EOR #%00000010			;$02
	STA VRSTRT			

	.db $ea, $ea, $ea, $ea			

PROCK6				
	JMP PROCKEX			;$EC43

PROCK6A				
	ASL A			
	CMP #$08			
	BCC $+6				;$EC1B

	LDA #$06

	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea
	.db $ea, $ea, $ea, $ea, $ea, $ea, $ea, $ea
	.db $ea, $ea

	TAX
	LDA KDECOD,X
	STA KEYTAB
	LDA KDECOD+1,X
	STA KEYTAB+1

PROCKEX	
	JMP PROCKY			

;====================================================================				
; KDECOD - Pointers to keyboard decode tables				
;				
KDECOD				
	.dw KDECD1			;$EC5E Unshifted
	.dw KDECD2			;$EC9F Shifted
	.dw KDECD3			;$ECE0 Commodore
	.dw KDECD5			;$EDA3 Control
	.dw KDECD1			;$EC5E Unshifted
	.dw KDECD2			;$EC9F Shifted
	.dw KDECD4			;$ED69 Shfited
	.dw KDECD5			;$EDA3 Control
	.dw GRTXTF			;$ED21 Graphics/text control
	.dw KDECD4			;$ED69 Shifted
	.dw KDECD4			;$ED69 Shifted
	.dw KDECD5			;$EDA3 Control
;				
;Unshifted				
;				
KDECD1     ;pa0  pa1  pa2  pa3  pa4  pa5  pa6  pa7
	.db $31, $33, $35, $37, $39, $2B, $5C, $14	;col 0
	.db $5F, $57, $52, $59, $49, $50, $2A, $0D	;col 1			
	.db $04, $41, $44, $47, $4A, $4C, $3B, $1D	;col 2			
	.db $03, $01, $58, $56, $4E, $2C, $2F, $11	;col 3		
	.db $20, $5A, $43, $42, $4D, $2E, $01, $85 	;col 4		
	.db $02, $53, $46, $48, $4B, $3A, $3D, $86	;col 5		
	.db $51, $45, $54, $55, $4F, $40, $5E, $87	;col 6		
	.db $32, $34, $36, $38, $30, $2D, $13, $88	;col 7		
	.db $FF						; EOT
;				
;shifted	
;	
KDECD2	
	.db $21, $23, $25, $27, $29
	.db $DB, $A9, $94, $5F, $D7, $D2, $D9, $C9
	.db $D0, $C0, $8D, $04, $C1, $C4, $C7, $CA
	.db $CC, $5D, $9D, $83, $01, $D8, $D6, $CE
	.db $3C, $3F, $91, $A0, $DA, $C3, $C2, $CD
	.db $3E, $01, $89, $02, $D3, $C6, $C8, $CB
	.db $5B, $3D, $8A, $D1, $C5, $D4, $D5, $CF
	.db $BA, $DE, $8B, $22, $24, $26, $28, $30
	.db $DD, $93, $8C, $FF 
;	
;Commodore	
;	
KDECD3	
	.db $21, $23, $25, $27			
	.db $29, $A6, $A8, $94, $5F, $B3, $B2, $B7			
	.db $A2, $AF, $DF, $8D, $04, $B0, $AC, $A5			
	.db $B5, $B6, $5D, $9D, $83, $01, $BD, $BE			
	.db $AA, $3C, $3F, $91, $A0, $AD, $BC, $BF			
	.db $A7, $3E, $01, $89, $02, $AE, $BB, $B4			
	.db $A1, $5B, $3D, $8A, $AB, $B1, $A3, $B8			
	.db $B9, $A4, $DE, $8B, $22, $24, $26, $28			
	.db $30, $DC, $93, $8C, $FF			
;				
;Control character management				
;@$ed21				
GRTXTF				
	cmp #$0e			
	bne G1				; +09

	lda #$02			
	ora VRSTRT			
	sta VRSTRT			
	jmp CMD42A			

G1					;$ED30
	cmp #$8E	
	bne G2			

G1A				
	lda #$fd			
	and VRSTRT			
	sta VRSTRT			

G1A1				
	jmp CMD42A			

G2					;$ED3F
	cmp #$08			
	bne G3			
	lda #$80			
	ora SHMODE			
	sta SHMODE			
	bmi G1A1			;$-ef

G3					;$ED4D
	cmp #$09			
	bne G1A1			;$-eb
	lda #%01111111			;$7f
	and SHMODE			
	sta SHMODE			
	bpl G1A1			;$-e1

G4				
	inx			

GRTX2				
	lda SLLTBL,x			
	ora #%10000000			;$80
	sta SLLTBL,x			
	dex			
	lda LINLEN			
	clc			
	jmp CSRMIN			;$e715

;ED21 				
;ED24 				
;ED2C 				
;ED34 	
;ED3C 	
;ED44 	
;ED4C 	
;ED54 	
;ED5C 	
;ED64 	
;	
;Keyboard decoding table - Shifted	
;	
KDECD4	
	.db $FF, $FF, $FF
	.db $FF, $FF, $FF, $FF, $FF, $FF, $04, $FF
	.db $FF, $FF, $FF, $FF, $E2, $9D, $83, $01
	.db $FF, $FF, $FF, $FF, $FF, $91, $A0, $FF
	.db $FF, $FF, $FF, $EE, $01, $89, $02, $FF
	.db $FF, $FF, $FF, $E1, $FD, $8A, $FF, $FF
	.db $FF, $FF, $FF, $B0, $E0, $8B, $F2, $F4
	.db $F6, $FF, $F0, $ED, $93, $8C, $FF 
;	
;Keyboard decoding table - control	
;	
KDECD5	
	.db $90
	.db $1C, $9C, $1F, $12, $FF, $FF, $FF, $06
	.db $FF, $12, $FF, $FF, $FF, $FF, $FF, $FF
	.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $05
	.db $9F, $1E, $9E, $92, $FF, $FF, $FF, $FF
;	
;VIC chip video control constants	
;	ede4

VICSUP	
;	.db $05, $19, $16, $2E, $00, $C0, $00, $00
;	.db $00, $00, $00, $00, $00, $00, $00, $1B

	.db $05	;bit7 interlace, 6-0 HCenter
	.db $19	;VCenter
	.db $16	;bit7=video address, 6-0 #rcols
	.db $2E	;bit6-1=#rows, bit0=8x8 or 16x8 chars
	.db $00	;current TV raster beam line
	.db $C0	;bit0-3 start of char memory
		;bit4-7 is rest of video address
		;BITS 3,2,1,0 CM starting address
		;             HEX   DEC
		;0000   ROM  8000  32768 *default
		;0001        8400  33792
		;0010        8800  34816
		;0011        8C00  35840
		;1000   RAM  0000  0000
		;1001        xxxx  }
		;1010        xxxx  }unavail.
		;1011        xxxx  }
		;1100        1000  4096
		;1101        1400  5120
		;1110        1800  6144
		;1111        1C00  7168
	.db $00	;Hpos of light pen
	.db $00	;Vpos of light pen

	.db $00 ;Digitized value of paddle X /EDEC
	.db $00 ;Digitized value of paddle Y
	.db $00 ;Frequency for oscillator 1 (low)
	.db $00 ;Frequency for oscillator 2 (medium)
	.db $00 ;Frequency for oscillator 3 (high)
	.db $00 ;Frequency of noise source
	.db $00 ; bit0-3 sets volume of all sound
		; bit4-7 are auxiliary color information
	.db $1B	;Screen and border color register
		; bits 4-7 select background color
		; bits 0-2 select border color
		; bit 3 selects inverted or normal mode

;	
;Shift-run equivalent	
;	
RUNSHF	
	.db "LOAD", $0D, "RUN", $0D
;	
;Low-byte screen address	
;	
LBSCAD	
	.db $00, $16, $2C, $42, $58, $6E, $84, $9A
	.db $B0, $C6, $DC, $F2, $08, $1E, $34, $4A			
	.db $60, $76, $8C, $A2, $B8, $CE, $E4			

;====================================================================				
; ITALK - Send TALK command on serial bus (internal)				
;	On entry, .A is a device number from 0 to 30			
;				
ITALK				
	ORA #%01000000			;$40 Bit6 = Talk address
	.db $2C				;BIT $2009

;====================================================================				
; ILISTN - Send LISTEN command on serial bus (internal)				
;	On entry, .A is a device number from 0 to 30			
; 				
ILISTN				
	ORA #%00100000			;$20 BIT5 = Listen address
	JSR SBIDLE			;IEEE time-out

LSNOIDLE				
	PHA				;save device address
	BIT C3PO			;char waiting?
	BPL LISN1			;no, branch $EE2B

	SEC				;yes, output bit
	ROR SBITCF			;bit count
	JSR OTDSBU			;output
	LSR C3PO			;go to next
	LSR SBITCF			

LISN1				
	PLA				;restore device address
	STA BSOUT			;save to xmit buffer
	JSR SOUT1			;send DATA=1
	CMP #%00111111			;$3F Data=0? 7-5=DATA 4=SRQ 3-1=CLK
	BNE LISN2			;$EE38 no answer yet, send ATN

	JSR SCLK1			;send SCLK=1 answer

LISN2				
	LDA D1ORAH			
	ORA #%10000000			;$80 set BIT7 = ATN
	STA D1ORAH			

ILISTEX				
	JSR SCLK0			;send SCLK=0
	JSR SOUT1			;send DATA=1
	JSR DELAY			;wait


;====================================================================				
; OTDSBU- Send one byte on serial bus				
;				
OTDSBU				
	SEI				;kill interrupts
	JSR SOUT1			;send DATA=1
	JSR SDCLK			;wait for DATA to go low
	LSR A				;still high?
	BCS FLGERR			;yes, device not present

	JSR SCLK1			;got device ack, ack with CLK=1
	BIT SBITCF			;more bits?
	BPL OTDLP3			;$EE66 yes, skip EOI handler

OTDLP1				
	JSR SDCLK			;wait for DIn=H
	LSR A				;roll data into carry
	BCC OTDLP1			;$EE5A

OTDLP2				
	JSR SDCLK			;wait for DIn=L
	LSR A				;roll data into carry
	BCS OTDLP2			;$EE60

OTDLP3				
	JSR SDCLK			;wait again for DIn=H
	LSR A				;roll data into carry
	BCC OTDLP3			;$EE66

	JSR SCLK0			;send CLK=0
	LDA #$08			;bit counter
	STA CNTDN			;save as bit count-down

OTDLP4				
	LDA D1ORAH			;wait for idle
	CMP D1ORAH			
	BNE OTDLP4			;$EE73

	LSR A			
	LSR A				;not idle for 2 tests, 
	BCC FLGER03			;$EEB7 time-out error

	ROR BSOUT			;get bit
	BCS OTDSB1			;$EE8B if 1, send DATA=1

	JSR SOUT0			;not 1, must be 0; DATA=0
	BNE OTDSB2			;$EE8B

OTDSB1				
	JSR SOUT1			;send DATA=1

OTDSB2				
	JSR SCLK1			;clock it out

	.db $EA, $EA, $EA, $EA			

	LDA D2PCR			;get PCR
	AND #%11011111			;$DF DATA=1
	ORA #%00000010			;$02 CLK=0
	STA D2PCR			;output it
	DEC CNTDN			;process next bit
	BNE OTDLP4			;$EE73 loop

	LDA #$04			;set time-out
	STA D2TM2H			

OTDLP5				
	LDA D2IFR			;test timer
	AND #%00100000			;$20
	BNE FLGER03			;$EEB7 timed-out, buss timeout

	JSR SDCLK			;wait for DIn=L
	LSR A			
	BCS OTDLP5			;$EEA5
	CLI			
	RTS			

;====================================================================				
; FLGERR - Flag errors				
;				
FLGERR				
	LDA #$80			; Error $80 - device not present
	.db $2C			

FLGER03				
	LDA #$03			; Error $03 - write timeout
	JSR ISETMS1			;$FE6A set status
	CLI			
	CLC			
	BCC IUNLSN+5			;$EF09


;====================================================================				
; ISECND - Send LISTEN secondary address (internal)				
;	On entry, .A is secondary address from 0 to 31.			
;	Required prior calls:  FFB1/LISTEN			
;				
ISECND				
	STA BSOUT			;save secondary address
	JSR ILISTEX			;$EE40 output with ATN
					;CLK=0, DATA=1, pause
;				
; CLRATN - Clear the ATN line				
;				
CLRATN				
	LDA D1ORAH			;release ATN
	AND #%01111111			;$7F
	STA D1ORAH			
	RTS			

;====================================================================				
; ITKSA - Sent TALK secondary address (internal)				
;	On entry, .A is secondary address from 0 to 31.			
;	Required prior calls:  FFB4/TALK			
;				
ITKSA				
	STA BSOUT     			;save secondary address to xmit
	JSR ILISTEX			;$EE40 output with ATN
					;CLK=0, DATA=1, pause
;				
; Wait for CLK				
;				
CLKWAIT				
	SEI				;kill interrupts
	JSR SOUT0			;DATA=0
	JSR CLRATN			;clear ATN
	JSR SCLK1			;CLK=1

CLKWAIT1				
	JSR SDCLK			;wait for CLK=0
	BCS CLKWAIT1			;$EEDD
	CLI			
	RTS			


;====================================================================				
; ICIOUT - Send serial deferred (internal)				
;	On entry, .A is byte to send			
;	Required prior calls:  FFB1/LISTEN			
;				
ICIOUT				
	BIT C3PO       			;deferred character?
	BMI ICIOUT1			;$EEED no, send it now	
	SEC				
	ROR C3PO				
	BNE ICIOUT2			;$EEF2	send it later

ICIOUT1					
	PHA				;save byte	
	JSR OTDSBU			;send it immediately	
	PLA				;restore it	

ICIOUT2					
	STA BSOUT			;deferred character	
	CLC				
	RTS				



;====================================================================				
; IUNTLK - Send UNTALK on serial bus (internal)				
;	On entry, UNKNOWN			
;	Required prior calls:  FFB4/TALK			
;				
IUNTLK				
	JSR SCLK0			;CLK=0
	LDA D1ORAH			
	ORA #%10000000			;$80 send ATN
	STA D1ORAH			

	LDA #$5F			;entry 1
	.db $2C				;really BIT $3FA9 to skip EF04

;====================================================================				
; IUNLSN - Send UNLISTEN on serial bus (internal)				
;	On entry, UNKNOWN			
;	Required prior calls:  FFB1/LISTEN			
;				
IUNLSN				
	LDA #$3F			;entry 2
	JSR LSNOIDLE			;$EE1C send UNLSTN; skip idle test
	JSR CLRATN			;clear ATN
	TXA			
	LDX #$0B			;pause loop (40ms)

IUNLP1				
	DEX			
	BNE IUNLP1			;$EF0F pause
	TAX			
	JSR SCLK1			;CLK=1
	JMP SOUT1			;DATA=1

;====================================================================				
; IACPTR - Receive from serial bus (internal)				
;	On entry, UNKNOWN			
;	On exit, .A is the character returned from the serial bus			
;	Required prior calls:  FFB4/TALK; FF96/TKSA (optional)			
;				
IACPTR				
	SEI           			;kill interrupts
	LDA #$00			
	STA CNTDN			;zero-out bit count
	JSR SCLK1			;assert CLK

IACPLP1				
	JSR SDCLK			
	BCC IACPLP1			;$EF21

	JSR SOUT1			

IACPTR1				
	LDA #$01			
	STA D2TM2H			

IACPLP2				
	LDA D2IFR			
	AND #%00100000			;$20
	BNE IACPTR2			;$EF3C

	JSR SDCLK			
	BCS IACPLP2			;$EF2E
	BCC IACPTR3A			;$EF54

IACPTR2				
	LDA CNTDN			
	BEQ IACPTR3			;$EF45

	LDA #$02			;set eerror code to 2
	JMP FLGER03+2			;$EEB9 

IACPTR3				
	JSR SOUT0			
	JSR IUNLSN+8			;$EF0C
	LDA #$40			;EOF error
	JSR ISETMS+4			;$FE6A
	INC CNTDN			
	BNE IACPTR1			;$EF29

IACPTR3A				
	LDA #$08			

IACPLP3				
	STA CNTDN			;set bit count

IACPLP4				
	LDA D1ORAH			
	CMP D1ORAH			
	BNE IACPLP4			;$EF56

	LSR A			
	BCC IACPLP4			;$EF58

	LSR A			
	ROR CYCLE			

IACPLP5				
	LDA D1ORAH			
	CMP D1ORAH			
	BNE IACPLP5			;$EF66

	LSR A			
	BCS IACPLP5			;$EF66

	DEC CNTDN			
	BNE IACPLP4			;$EF58

	JSR SOUT0			
	LDA CSTAT			
	BEQ IACPEX			;$EF7F

	JSR IUNLSN+8			

IACPEX				
	LDA CYCLE			
	CLI			
	CLC			
	RTS			

;====================================================================				
; SCLK1 - Set Serial CLK "1" (inverted logic)				
;				
SCLK1				
	LDA D2PCR			;PCR
	AND #%11111101			;$FD kill CA2
	STA D2PCR			;save it
	RTS			

;====================================================================				
; SCLK0 - Set Serial CLK "0" (inverted)				
;				
SCLK0				
	LDA D2PCR			;PCR
	ORA #%00000010			;$02 assert CA2
	STA D2PCR			;save it
	RTS			

;====================================================================				
; DELAY - Delay 1ms				
;				
DELAY				
	LDA #$04			;set time-out counter
	STA D2TM2H			

DLYLOOP				
	LDA D2IFR			;IFR 
	AND #%00100000			;$20 time-out flagged?
	BEQ DLYLOOP			;$EF9B no, loop
	RTS			

;====================================================================				
; SSEND - RS-232 Send				
;				
SSEND				
	LDA BITTS			
	BEQ SSNDN			
	BMI SSEND1			;$EFE8

	LSR RODATA			
	LDX #$00			
	BCC SSEND2			;$EFB0

	DEX			

SSEND2				
	TXA			
	EOR ROPRTY			
	STA ROPRTY			
	DEC BITTS			
	BEQ SSEND3			;$EFBF

SSEND2A				
	TXA			
	AND #%00100000			;$20
	STA NXTBIT			
	RTS			

SSEND3				
	LDA #$20			
	BIT M51CDR			
	BEQ SSEND5			;$EFDA
	BMI SSEND7			;$EFE4
	BVS SSEND6			;$EFDE

	LDA ROPRTY			
	BNE SSEND4A			;$EFCF

SSEND4				
	DEX			

SSEND4A				
	DEC BITTS			
	LDA M51CTR			
	BPL SSEND2A			;$EFB9

	DEC BITTS			
	BNE SSEND2A			;$EFB9

SSEND5				
	INC BITTS			
	BNE SSEND4			;$EFCE

SSEND6				
	LDA ROPRTY			
	BEQ SSEND4A			;$EFCF
	BNE SSEND4			;$EFCE

SSEND7				
	BVS SSEND4A			;$EFCF
	BVC SSEND4			;$EFCE

SSEND1				
	INC BITTS			
	LDX #$FF			
	BNE SSEND2A			;$EFB9

;====================================================================				
; SSNDN - Send new RS-232 byte				
;				
SSNDN				
	LDA M51CDR			
	LSR A			
	BCC SSNDN1			;$EFFB

	BIT D2ORB			
	BPL DSRERR			
	BVC CTSERR			

SSNDN1				
	LDA #$00			
	STA ROPRTY			
	STA NXTBIT			
	LDX BITNUM			
	STX BITTS			
	LDY RODBS			
	CPY RODBE			
	BEQ DISTIM			

	LDA (ROBUF),Y			
	STA RODATA			
	INC RODBS			
	RTS			

;====================================================================				
; DSRERR - "No DSR/CTS" errors
;				
DSRERR				
	LDA #%01000000			;$40 no DSR
	.db $2C				;bit $10a9
;				
; CTSERR - CTS Error				
;				
CTSERR				
	LDA #%00010000			;$10 no CTS
	ORA RSSTAT			;set DSR/CTS status
	STA RSSTAT			;save it
;				
; DISTIM - Disable timer				
;				
DISTIM				
	LDA #%01000000			;$40 disable timer
	STA D1IER			
	RTS			


;====================================================================				
; BITCNT - Compute RS-232 bit count				
;				
BITCNT				
	LDX #$09			;8+1 bits
	LDA #$20			
	BIT M51CTR			;control word
	BEQ BITCNT1			;$F031

	DEX				;.X= number of bits

BITCNT1				
	BVC BITEXIT			;$F035
	DEX			
	DEX			

BITEXIT				
	RTS			

;====================================================================				
; SERRX - RS-232 Receive				
;				
SERRX				
	LDX RINONE			
	BNE PROCSB			

	DEC BITCI			
	BEQ PROCSB1			;$F06F
	BMI SERRX1			;$F04D

	LDA INBIT			
	EOR RIPRTY			
	STA RIPRTY			
	LSR INBIT			
	ROR RIDATA			

SERRXEX				
	RTS			

	DEC BITCI			

SERRX1				
	LDA INBIT			
	BEQ PRSBEX			;$F0B3
	LDA M51CTR			
	ASL A			
	LDA #$01			
	ADC BITCI			
	BNE SERRXEX			;$F04A
;	
; RXSET - Setup to receive	
;	
RXSET	
	LDA #$90
	STA D1IER
	STA RINONE
	LDA #$20
	STA D1IER
	RTS

;====================================================================	
; PROCSB - Process RS-232 byte	
;	
PROCSB	
	LDA INBIT			
	BNE RXSET			
	STA RINONE			
	RTS			

PROCSB1				
	LDY RIDBE			
	INY			
	CPY RIDBS			
	BEQ SBE04			;$F0A2

	STY RIDBE			
	DEY			
	LDA RIDATA			
	LDX BITNUM			

PRSBLP1				
	CPX #$09			
	BEQ PROCSB2			;$F089

	LSR A			
	INX			
	BNE PRSBLP1			;$F081

PROCSB2				
	STA (RIBUF),Y			
	LDA #$20			
	BIT M51CDR			
	BEQ SERRX1-2			;$F04B
	BMI SERRXEX			;$F04A RTS

	LDA INBIT			
	EOR RIPRTY			
	BEQ PROC_S1			;$F09D
	BVS SERRXEX			;$F04A

	.db $2C			

PROC_S1				
	BVC SERRXEX			;BIT $A850 = BVC+A8 f14b

SBE01				
	LDA #$01			;Parity error
	.db $2C			

SBE04				
	LDA #$04			;Receive buffer overrun
	.db $2C			

SBE80				
	LDA #$80			;Receiver BREAK received
	.db $2C			

SBE02				
	LDA #$02			;Framing error 
	ORA RSSTAT			
	STA RSSTAT			
	JMP RXSET			;set RS232 error code

PRSBEX				
	LDA RIDATA			
	BNE SBE02			;$F0A8
	BEQ SBE80			;$F0A5
	JMP IOERMS9			;$F796 "ILLEGAL DEVICE" error


;====================================================================				
; SSUBBT - Submit to RS-232				
;				
SSUBBT				
	STA OUTDEV			
	LDA M51CDR			
	LSR A			
	BCC SSRETC			;$F0EB return OK

	LDA #$02			
	BIT D1ORB			
	BPL SSRETE			;$F0E8 return DSR error
	BNE SSRETC			;$F0EB

SSLOOP1				
	LDA D1IER			
	AND #%00110000			;$30
	BNE SSLOOP1			;$F0CD

SSLOOP2				
	BIT D1ORB			
	BVS SSLOOP2			;$F0D4

	LDA D1ORB			
	ORA #$02			
	STA D1ORB			

SSLOOP3				
	BIT D1ORB			
	BVS SSRETC			;$F0EB
	BMI SSLOOP3			;$F0E1

SSRETE				
	JSR DSRERR			;set DSR error

SSRETC				
	CLC			
	RTS			

;====================================================================				
; SSENDB - Output to RS-232 buffer				
;				
SSENDB				
	LDY RODBE			
	INY			
	CPY RODBS			
	BEQ SSENDB			

	STY RODBE			
	DEY			
	STA (ROBUF),Y			
	BIT D1IER			
	BVC SNDB1			;$F102

	RTS			

SNDB1				
	LDA BAUDOF			
	STA D1TM1L			
	LDA BAUDOF+1			
	STA D1TM1L+1			
	LDA #%11000000			;$C0
	STA D1IER			
	JMP SSNDN			


;====================================================================				
; SERINP - Input from RS-232				
;				
SERINP				
	STA INDEV			
	LDA M51CDR			
	LSR A			
	BCC SINPEX2			;$F146

	AND #%00001000			;$08
	BEQ SINPEX2			;$F146

	LDA #$02			
	BIT D1ORB			
	BPL SSRETE			;$F0E8 DSR error
	BEQ SINRETC			;$F144

SINPLP1				
	BIT D1IER			
	BVS SINPLP1			;$F12B

	LDA D1ORB			
	AND #%11111101			;$FD
	STA D1ORB			

SINLP2				
	LDA D1ORB			
	AND #%00000100			;$04
	BEQ SINLP2			;$F138

SINPEX1				
	LDA #%10010000			;$90
	STA D1IER			

SINRETC				
	CLC			
	RTS			

SINPEX2				
	LDA D1IER			
	AND #%00110000			;$30
	BEQ SINPEX1			;$F13F
	CLC			
	RTS			

;====================================================================				
; SERGET - Get from RS-232				
;				
SERGET				
	LDY RIDBS			;buffer pointer
	CPY RIDBE			
	BEQ SERGET1			;$F15D empty? Yes, exit

	LDA (RIBUF),Y			;get byte from buffer
	INC RIDBS			;increment pointer
	RTS			

SERGET1				
	LDA #$00			;transfer 0 chars
	RTS			

;====================================================================				
; SBIDLE - Set timer for serial bus timeout				
;				
SBIDLE				
	PHA				;save .A
	LDA D1IER			;get IER
	BEQ SBIDLEX			;$F172 no interrupts pending, exit

SBIDLLP				
	LDA D1IER			;get IER
	AND #%01100000			;$60 T1 & T2
	BNE SBIDLLP			;$F166

	LDA #%00010000			;$10 kill CB1 RS232	
	STA D1IER				

SBIDLEX					
	PLA				
	RTS				

;====================================================================					
; KIOMSG - KERNEL I/O messages					
;					
KIOMSG					
	.db $0D, "I/O ERROR ", $A3			;00h

	.db $0D, "SEARCHING", $A0, "FOR", $A0		;0Ch

	.db $0D, "PRESS PLAY ON TAP", $C5		;1Bh	

	.db "PRESS RECORD & PLAY ON TAP", $C5		;2Eh	

	.db $0D, "LOADIN", $C7				;49h

	.db $0D, "SAVING", $A0				;51h

	.db $0D, "VERIFYIN", $C7			;59h

	.db $0D, "FOUND", $A0				;63h

	.db $0D, "OK", $8D				;6Ah


;====================================================================				
; DIRMSG - Print message to screen if direct mode				
;  On entry, .A is the I/O Error number.				
;				
DIRMSG				
	BIT CMDMOD			;programmed/direct?
	BPL MSGEXIT			;$F1F3 exit if programmed
;				
; MSG - Print message				
;				
MSG				
	LDA KIOMSG,Y			;
	PHP				;save character
	AND #%01111111			;$7F clear character shift
	JSR CHROUT			;output character
	INY				;increment
	PLP			
	BPL MSG				;loop

MSGEXIT				
	CLC			
	RTS				;exit clear


;====================================================================				
; IGETIN - Get a byte (internal)				
;	On exit, .A is the character pulled from the keyboard queue.			
;	Required prior calls:  NONE			
;				
IGETIN				
	LDA INDEV      			;input device
	BNE IGET232			;$F201 not keyboard, check RS232
	LDA KEYCNT			;yes keyboard, get # of keys
	BEQ GTSCEXC			;$F26A none, skip to tape & IEEE
	SEI				;get chars from buffer
	JMP LP2			

IGET232				
	CMP #$02			;input from RS-232?
	BNE CHINSCRN			;$F21D no, maybe screen

IGETIN1				
	STY REGSAV			;get from RS232
	JSR SERGET			
	LDY REGSAV			;restore registers
	CLC			
	RTS				;exit

;====================================================================				
; ICHRIN - Input a byte (internal)				
;	On entry, UNKNOWN			
;	On exit, .A is the received character			
;	Required prior calls:  FFC6/CHKIN			
;				
ICHRIN				
	LDA INDEV			;get input device
	BNE CHINSCRN			;$F21D not 0, must not be keyboard

	LDA CSRIDX			;keyboard input. Set input row/col
	STA ICRCOL			;to current position
	LDA CURROW			
	STA ICRROW			
	JMP INSCR			;$E64F input from screen until <RET>

CHINSCRN				
	CMP #$03			;input from screen?
	BNE ICHRIN1			;$F22A no, check next device range

	STA INSRC			;set screen as source
	LDA LINLEN			
	STA EOLPTR			
	JMP INSCR			;$E64F input until <RET>

ICHRIN1				
	BCS GTTSCH1			;$F264 device >3, must be IEEE

	CMP #$02			;RS-232?
	BEQ GTSCHLP			;$F26F yes, process

	STX REGSAV			;only device left is the tape drive
	JSR GTTSCH			;get character
	BCS ICHREXIT			;$F24D

	PHA			
	JSR GTTSCH			;get char from tape
	BCS ICHRIN3			;$F24A
	BNE ICHRIN2			;$F244 last one? No, branch
	LDA #%01000000			;$40 stat bit: EOF tape, EOI line IEEE
	JSR ISETMS+4			;$FE6A OR with CSTAT

ICHRIN2				
	DEC BUFPNT			;decrement tape buffer pointer
	LDX REGSAV			;restore .X
	PLA			
	RTS			

ICHRIN3				
	TAX				;clean-up stack
	PLA			
	TXA				;character inputted

ICHREXIT				
	LDX REGSAV			;restore .X
	RTS			

;====================================================================				
; GTTSCH - Get input from tape/serial/RS-232 (main device input)				
;				
GTTSCH				
	JSR INCTPT			;increment pointer in tape buffer
	BNE GTTSCEX			;$F260 ptr <> #$C0 (not top of buffr?)
	JSR TPREAD			;read block from tape
	BCS GTSCEXC+1			;$F26B error, just return
	LDA #$00			
	STA BUFPNT			;reset pointer to 0
	BEQ GTTSCH			;$F250 loop

GTTSCEX				
	LDA (TAPE1),Y			;return character from buffer at
	CLC				;pointer location
	RTS			

GTTSCH1				
	LDA CSTAT			;any IEEE errors? 
	BEQ GTTSCH2			;$F26C no, get next char from device
	LDA #$0D			;yes, return <CR>

GTSCEXC				
	CLC			
	RTS			;exit

GTTSCH2				
	JMP IACPTR			;get next char from IEEE

GTSCHLP				
	JSR IGETIN1			;get from RS-232
	BCS GTSCEX2			;$F279 error? Yes, exit
	CMP #$00			;any chars to process?
	BEQ GTSCHLP			;$F26F no, loop

	CLC			

GTSCEX2				
	RTS				;exit

;====================================================================				
; ICHROT - Output one character (internal)				
;	On entry, .A is the character to send.			
;	Required prior calls:  FFC9/CHKOUT			
;				
ICHROT				
	PHA				;save character
	LDA OUTDEV			;get output device
	CMP #$03			;is it screen?
	BNE ONOTSCR			;$F285 no, skip

	PLA				;yes, restore character and...
	JMP OUTSCR			;send it to the screen


ONOTSCR				
	BCC OTIEEE			;$F28B <3, must be serial RS232

	PLA				;restore character and...
	JMP ICIOUT			;send to IEEE


OTIEEE				
	CMP #$02			;RS-232?
	BEQ OTRS232			;$F2B9 yes, send to RS232

;output to tape				
	PLA				;must be tape. Restore character

OTIEEE1				
	STA TPTR1			;process character to tape buffer
	PHA				;save registers
	TXA			
	PHA			
	TYA			
	PHA			
	JSR INCTPT			;increment tape pointer
	BNE CHROT1			;$F2AA buffer full? No, buffer char

	JSR TPWRIT			;buffer full, so write bufr to device
	BCS CHROT1A			;$F2AF error, restore regs and exit

	LDA #$02			;control byte for data block
	LDY #$00			;TAPE1 defaults to $0360
	STA (TAPE1),Y			;save $02 in first buffer location
	INY				;increment buffer pointer
	STY BUFPNT			;save pointer location

CHROT1				
	LDA TPTR1			;move character to buffer
	STA (TAPE1),Y			
	CLC			

CHROT1A				
	PLA				;restore registers

CHROT2				
	TAY			
	PLA			
	TAX			
	PLA			
	BCC CHRRET			;$F2B8
	LDA #$00			

CHRRET				
	RTS				;exit

OTRS232				
;output by RS-232				
	PLA				;RS232; restore character
	STX REGSAV			;save regs
	STY TPTR1			
	JSR SSENDB			;send to RS232 buffer
	LDX REGSAV			;restore regs
	LDY TPTR1			
	CLC			
	RTS				;return clear

;====================================================================				
; ICHKIN - Set input device (internal)				
;	On entry, .X is file number			
;	Required prior calls:  FFC0/OPEN. Must be called before FFCF/CHRIN and			
;	  FFE4/GETIN			
;				
ICHKIN				
	JSR FIND			;find file# in tables
	BEQ ICHKI1			;$F2CF found, continue
	JMP IOERMS3			;$F784 'FILE NOT OPEN' error

ICHKI1				
	JSR FLATRB			;set file# params
	LDA CHANNL			;get device 
	BEQ ICHKI2			;$F2EC keyboard? Set INDEV and exit

	CMP #$03			;SCREEN?
	BEQ ICHKI2			;$F2EC yes, set INDEV
	BCS ICHKI3			;$F2F0 IEEE? yes, handle IEEE

	CMP #$02			;RS232?
	BNE ICHK_S1			;$F2E3 no, must be tape; handle it
	JMP SERINP			;go to serial input

ICHK_S1				
	LDX SECADR			;handle tape
	CPX #$60			;is SA=0 (read)?
	BEQ ICHKI2			;$F2EC yes, set INDEV and exit
	JMP IOERMS6			;$F78D 'NOT INPUT FILE' error

ICHKI2				
	STA INDEV			;save input device...
	CLC			
	RTS				;...and exit

ICHKI3	;handle IEEE			
	TAX				;copy device
	JSR ITALK			;command device to talk 
	LDA SECADR			;is there a secondary address?
	BPL ICHKI4			;$F2FE yes, send it
	JSR CLKWAIT			;no, sent regular talk command
	JMP ICHKI4+3			;$F301

ICHKI4				
	JSR ITKSA			;send secondary address talk
	TXA				;restore device#
	BIT CSTAT			;BIT7= EOT or Dev not present
	BPL ICHKI2			;$F2EC all clear, exit
	JMP IOERMS5			;$F78A "DEVICE NOT PRESENT" error

;====================================================================				
; ICHKOT - Set output device (internal)				
;	On entry, .X is file number			
;	Required prior calls:  FFC0/OPEN. Must be called before FFD2/OUTCH			
;				
ICHKOT				
	JSR FIND			;locate file# in tables
	BEQ ICHKO_S1			;$F311 found, continue
	JMP IOERMS3			;$F784 "FILE NOT OPEN" error

ICHKO_S1				
	JSR FLATRB			;set file attributes
	LDA CHANNL			;get device
	BNE ICHKO_S2			;$F31B not keyboard, branch

ICHKER7				
	JMP IOERMS7			;$F790 "NOT OUTPUT FILE" error

ICHKO_S2				
	CMP #$03			;screen?
	BEQ ICHKO1			;$F32E yes, set OUTDEV
	BCS ICHKO2			;$F332 IEEE no, process IEEE

	CMP #$02			;RS232?
	BNE ICHKO_S3			;$F328 no, must be tape; process
	JMP SSUBBT			;process RS232

;Set tape as output				
ICHKO_S3				
	LDX SECADR			;devs 1 tape
	CPX #$60			;SA set for read
	BEQ ICHKER7			;$F318 yes, perform tape verify

ICHKO1				
	STA OUTDEV			;set OUTDEV and exit
	CLC			
	RTS			

;Set IEEE as output				
ICHKO2					;IEEE
	TAX				;save device#
	JSR ILISTN+1			;command device to listen
	LDA SECADR			;is there an SA?
	BPL ICHKO_S4			;$F33F yes, send SA

	JSR CLRATN			;no, send listen
	BNE ICHKO_S5			;$F342

ICHKO_S4				
	JSR ISECND			;send SA

ICHKO_S5				
	TXA				;restore device#
	BIT CSTAT			;BIT7=EOT or Dev not present
	BPL ICHKO1			;$F32E

	JMP IOERMS5			;$F78A "DEVICE NOT PRESENT" error

;====================================================================				
; ICLOSE - Close file (internal)				
;	On entry, .A is the file number			
;	Required prior calls:  FFC0/OPEN			
;				
ICLOSE				
	JSR FIND1			;$F3D4 locate file#
	BEQ ICLSE			;$F351 found it, go to closer
	CLC			
	RTS				;not found, return clear

ICLSE				
	JSR FLATRB			;get file attributes
	TXA				;save table offset
	PHA				;push it
	LDA CHANNL			;get device
	BEQ ICLSE4			;$F3B1 keyboard? Yes, go to closer

	CMP #$03			;screen?
	BEQ ICLSE4			;$F3B1 yes, close it
	BCS ICLSE3			;$F3AE device#>3, close IEEE 

	CMP #$02			;RS232?
	BNE ICLSE1			;$F38D no, must be tape; close it

;Close RS232 device				
	PLA			
	JSR ICLSE4+1			;$F3B2 clear file entry in table
	LDA #%01111101			;$7D
	STA D1IER			
	LDA #%00000110			;$06 restore VIAs	
	STA D1ORB				
	LDA #%11101110			;$EE	
	STA D1PCR				
	JSR IMEMTP+2			;$FE75	
	LDA RIBUF+1			;input buffer	
	BEQ ICLSE_S1			;$F37F	

	INY				

ICLSE_S1					
	LDA ROBUF+1				
	BEQ ICLSE_S2			;$F384	output buffer

	INY				

ICLSE_S2				
	LDA #$00			;mark buffers as "free"
	STA RIBUF+1			
	STA ROBUF+1			
	JMP SEROPN4			;$F53C

;Close tape				
ICLSE1				
	LDA SECADR			;secondary address
	AND #%00001111			;$0F file open for reading?
	BEQ ICLSE4			;$F3B1 yes, go to closer

	JSR GETBFA			;$F84D purge tape buffer to tape
	LDA #$00			
	JSR OTIEEE1			;$F290 skips channel check
	JMP TPWPCH			;$E4CF

ICLSE2				
	BCS ICLSEEX			;$F3CE
	LDA SECADR			;get SA
	CMP #$62			;SA=2 write EOT?
	BNE ICLSE4			;$F3B1 no, continue
	LDA #$05			;control byte for EOT marker
	JSR WRTPHD			;write block to tape
	JMP ICLSE4			;$F3B1

ICLSE3				
	JSR SERSAV1A			;close IEEE

ICLSE4				
	PLA				;closer
	TAX			
	DEC COPNFL			;decrement # of open files
	CPX COPNFL			;no more files open, go to ready
	BEQ ICLSEEX-1			;$F3CD return CY=0
	LDY COPNFL			;delete device by moving last entry
 	LDA FILTBL,Y			;in table into deleted position
	STA FILTBL,X			
	LDA DEVTBL,Y			
	STA DEVTBL,X			
	LDA SECATB,Y			
	STA SECATB,X			
	CLC			

ICLSEEX				
	RTS				;exit clear

;====================================================================				
; FIND - Look for logical file number in open-file table				
;	On entry to FIND1, .A=file#			
;	On exit, .X=offset in file table			
;				
FIND				
	LDA #$00			
	STA CSTAT			;clear status
	TXA			

FIND1				
	LDX COPNFL			;get #of open files

FINDLOOP				
	DEX			
	BMI FLATRBX			;$F3EE reached 0, then exit

	CMP FILTBL,X			;is this the one?
	BNE FINDLOOP			;$F3D6 no, try again

	RTS				;return

;====================================================================				
; FLATRB - Set file values				
;	On entry, .X = offset in the file tables			
;				
FLATRB				
	LDA FILTBL,X			
	STA LOGFIL			;get file#
	LDA DEVTBL,X			
	STA CHANNL			;get device
	LDA SECATB,X			
	STA SECADR			;get SA

FLATRBX				
	RTS			

;====================================================================				
; ICLALL - Abort all files (internal)				
;	On entry, NONE			
;				
ICLALL				
	LDA #$00			
	STA COPNFL			;zero-out count of open files

;====================================================================				
; ICLRCH - Restore default I/O (internal)				
;	On entry, NONE			
;				
ICLRCH				
	LDX #$03			
	CPX OUTDEV			;is output device <=3?
	BCS ICLRCH_S1			;$F3FC yes, continue 
 				
	JSR IUNLSN			;no, send unlisten command to IEEE

ICLRCH_S1				
	CPX INDEV			;is input device <=3?
	BCS ICLRCH_S2			;$F403 yes, continue

	JSR IUNTLK			;send untalk

ICLRCH_S2				
	STX OUTDEV			;restore default I/O devices
	LDA #$00			
	STA INDEV			
	RTS			

;====================================================================				
; IOPEN - Open file (internal)				
;	Required prior calls:  FFBA/SETLFS and FFBD/SETNAM			
;				
IOPEN				
	LDX LOGFIL			;get file number
	BNE IOPEN_S1			;F411 <>0 not "save"
	JMP IOERMS6			;$F78D "NOT INPUT FILE" error

IOPEN_S1				
	JSR FIND			;locate file# in table
	BNE IOPEN_S2			;F419 not found; any more free spots
	JMP IOERMS2			;$F781 "FILE OPEN" error

IOPEN_S2				
	LDX COPNFL			;get # of open files
	CPX #$0A			;10 files open?
	BCC IOPEN_S3			;F422 no, OK to open it
	JMP IOERMS1			;"TOO MANY FILES" error

IOPEN_S3				
	INC COPNFL			;bump count
	LDA LOGFIL			
	STA FILTBL,X			;save file# in table
	LDA SECADR			;flag and save SA
	ORA #%01100000			;$60
	STA SECADR			
	STA SECATB,X			
	LDA CHANNL			;save device
	STA DEVTBL,X			
	BEQ IOPENRC			;$F493 if keyboard, return clear

	CMP #$03			;screen?
	BEQ IOPENRC			;$F493 yes, exit
	BCC IOPEN_S4			;F444 branch for tape or RS232

	JSR SENDSA			;send secondary to IEEE
	BCC IOPENRC			;$F493 return clear

IOPEN_S4				
	CMP #$02			;RS232?
	BNE IOPEN_S5			;F44B not RS232, process tape
	JMP SEROPN			;open RS232 device

IOPEN_S5				
	JSR GETBFA			;must be tape. Get buffer address
	BCS IOPEN_S6			;F453 MSB>2? No, continue with open
	JMP IOERMS9			;$F796 "ILLEGAL DEVICE NUMBER" error

IOPEN_S6				
	LDA SECADR			;get SA
	AND #%00001111			;$0F
	BNE IOPEN2			;$F478

	JSR PLAYMS			;wait for "PLAY" key
	BCS IOPENRC+1			;$F494 return CY=1

	JSR SRCHMS			;print "Searching for [name]" message
	LDA FNMLEN			;length of filename
	BEQ IOPEN1			;F46F no name, continue

	JSR LOCSPH			;search for desired tape header
	BCC IOPEN3			;$F482
	BEQ IOPENRC+1			;$F494 return CY=1

IOPENA				
	JMP IOERMS4			;F787 "FILE NOT FOUND"

;--Search for next header				
IOPEN1				
	JSR LOCTPH			;search for next header
	BEQ IOPENRC+1			;$F494
	BCC IOPEN3			;$F482
	BCS IOPENA			;$F46C

IOPEN2				
	JSR RECDMS			;wait for REC & PLAY
	BCS IOPENRC+1			;$F494 return CY=1

	LDA #$04			;control byte for data header
	JSR WRTPHD			;write header

IOPEN3				
	LDA #$BF			;pointer to tape buffer head
	LDY SECADR			
	CPY #$60			;SA=0 (read), continue
	BEQ IOPENRC-2			;$F491

	LDY #$00			
	LDA #$02			;control block for data block
	STA (TAPE1),Y			;write it to buffer
	TYA			
	STA BUFPNT			;save pointer

IOPENRC				
	CLC			
	RTS			

;====================================================================				
; SENDSA - Send secondary address				
;				
SENDSA				
	LDA SECADR			;get SA
	BMI SNDSARC			;$F4C5 neg, exit

	LDY FNMLEN			;get filename length
	BEQ SNDSARC			;$F4C5 0, error	

	LDA CHANNL			;get device	
	JSR ILISTN+1			;command it to listen	
	LDA SECADR			;get SA	
	ORA #%11110000			;$F0	
	JSR ISECND			;$EEC0	sent it
	LDA CSTAT			;status	
	BPL SENDSA1			;$F4B2 OK, continue	

	PLA				;error, set RTS for caller's caller	
	PLA				
	JMP IOERMS5			;$F78A "DEVICE NOT PRESENT" error	

SENDSA1					
	LDA FNMLEN			;get filename length	
	BEQ SNDSARU			;$F4C2 0, send unlisten

	LDY #$00			

SENDSALP				
	LDA (FNPTR),Y			;output filename to IEEE
	JSR ICIOUT			;send it
	INY			
	CPY FNMLEN			
	BNE SENDSALP			;$F4B8 loop

SNDSARU				
	JSR IUNLSN			;done, send unlisten command

SNDSARC				
	CLC			
	RTS			

;====================================================================				
; SEROPN - Open RS-232				
;				
SEROPN				
	LDA #%00000110			;$06 set VIAs
	STA D1DDRB			
	STA D1ORB			
	LDA #%11101110			;$EE
	STA D1PCR			
	LDY #$00			;zero-out status byte
	STY RSSTAT			

SEROPLP				
	CPY FNMLEN			;get filename length
	BEQ SEROPN1			;$F4E7 none, go to open

	LDA (FNPTR),Y			;copy first 4 chars of filename
	STA M51CTR,Y			;to buffer
	INY			
	CPY #$04			
	BNE SEROPLP			;$F4D9

SEROPN1				
	JSR BITCNT			;get number of data bits
	STX BITNUM			;save count
	LDA M51CTR			;control register
	AND #%00001111			;$0F isolate baud rate bits
	BNE $+2				;F4F4

	ASL A				;*2
	TAX			
	LDA R232TB-2,X			;$FF5A,X baud rate H
	ASL A			
	TAY			
	LDA R232TB-1,X			;$FF5B,X baud rate L
	ROL A			
	PHA			
	TYA			
	ADC #$C8			
	STA BAUDOF			;save baud rate codes
	PLA			
	ADC #$00			
	STA BAUDOF+1			
	LDA M51CDR			
	LSR A			
	BCC SEROPN2			;$F51B

	LDA D2ORB			;check DSR
	ASL A			
	BCS SEROPN2			;$F51B ready, continue
	JMP DSRERR			;not ready, DRS error

SEROPN2				
	LDA RIDBE			;set buffer pointer to RS232
	STA RIDBS			
	LDA RODBE			
	STA RODBS			
	JSR IMEMTP+2			;$FE75 get MEMTOP

	LDA RIBUF+1			;has input buffer already been created?
	BNE SEROPN3			;$F533 yes, skip create

	DEY			
	STY RIBUF+1			;create input buffer
	STX RIBUF			

SEROPN3				
	LDA ROBUF+1			;output buffer created?
	BNE SEROPN4			;$F53C yes, skip create
	DEY			
	STY ROBUF+1			;create output buffer
	STX ROBUF			

SEROPN4				
	SEC			
	LDA #$F0			
	JMP STOTOP			;$FE7B set new MEMTOP

;====================================================================				
; ILOAD - Load RAM from device (internal)				
;	On entry, .A is 0 (load) or 1 (verify)			
;	          .X/.Y is LSB/MSB load address for SECADR=3; for SECADR=0-2,			
;	          load address is set from file header.			
;	On exit,  .X/.Y is LSB/MSB RAM load address			
;	Required prior calls:  FFBA/SETLFS and FFBD/SETNAM			
;				
ILOAD				
	STX MEMUSS			;save load location from call
	STY MEMUSS+1			
	JMP (LLODVP)			;jump to Load routine

;====================================================================				
; LNKLOD - Load RAM (indirect from $0330)				
;				
LNKLOD				
	STA IOFLG2			;load/verify flag
	LDA #$00			
	STA CSTAT			;clear ST 
	LDA CHANNL			;get device
	BNE LINK_S1			;$F556 not 0 (keyboard), continue

LNKLDEX				
	JMP IOERMS9			;$F796 "ILLEGAL DEVICE" error

LINK_S1				
	CMP #$03			;screen?
	BEQ LNKLDEX			;$F553 yes, error
	BCC TAPLOA			;F5CA <3, must be tape
;				
; SERLOA - Load file from serial bus				
;				
SERLOA				
	LDY FNMLEN			;get filename length
	BNE SERLO_S1			;F563 filename required on IEEE
	JMP IOERMS8			;$F793 "FILENAME MISSING" error

SERLO_S1				
	JSR SSADR			;$E4BC print "Searching"
	LDA #$60			
	STA SECADR			;set default SA to 0
	JSR SENDSA			;send it
	LDA CHANNL			;get device
	JSR ITALK			;command it to talk
	LDA SECADR			;get SA
	JSR ITKSA			;send SA for talk
	JSR IACPTR			;get char
	STA EAL				;save it as start address L
	LDA CSTAT			;status
	LSR A			
	LSR A			
	BCS SERLDEX			;$F5C7 timeout? Yes, error

	JSR IACPTR			;get next char
	STA EAL+1			;save as start address H
	JSR SLDPCH			;$E4C1 print "Loading" msg and set load
					;address based on file type

SERLDLP				
	LDA #%11111101			;$FD timeout bit
	AND CSTAT			;clear it
	STA CSTAT			;save ST
	JSR STOP			;check for STOP key
	BNE SERLO_S2			;F598 not pressed, continue
	JMP SAVEXIT1			;$F6CE close file

SERLO_S2				
	JSR IACPTR			;get next char - program byte
	TAX				;save it
	LDA CSTAT			;chect status
	LSR A			
	LSR A			
	BCS SERLDLP			;$F58A error, interrupt process

	TXA				;restore char
	LDY IOFLG2			;check load/verify flag
	BEQ SERLD1			;$F5B3 =0, load

	LDY #$00			;verify comparison
	CMP (EAL),Y			
	BEQ SERLD2			;$F5B5 match, continue

	LDA #$10			;not a match, error
	JSR ISETMS1			;$FE6A set status
	.db $2C				;bit $ae91

SERLD1				
	STA (EAL),Y			;save byte

SERLD2				
	INC EAL				;increment address
	BNE SERLO_S3			;$F5BB

	INC EAL+1			

SERLO_S3				
	BIT CSTAT			;test for EOF
	BVC SERLDLP			;$F58A not EOF, loop

	JSR IUNTLK			;EOF, send untalk
	JSR SERSAV1A			;close file
	BCC TPLOAEX			;$F641 exit no error

SERLDEX				
	JMP IOERMS4			;$F787 "FILE NOT FOUND" error

;====================================================================				
; TAPLOA - Load file from tape				
;				
TAPLOA				
	CMP #$02			;RS232?
	BNE TPLOA_S1			;F5D1 no, load from tape
	JMP SSUBBT-3			;IOERMS9 "ILLEGAL DEVICE" error

TPLOA_S1				
	JSR GETBFA			;get buffer start
	BCS TPLOA_S2			;F5D9
	JMP IOERMS9			;$F796 "ILLEGAL DEVICE NUMBER" error

TPLOA_S2				
	JSR PLAYMS			;wait for PLAY key
	BCS TPLORTS			

	JSR SRCHMS			;print "Searching for [name]"

TAPLOALP				
	LDA FNMLEN			;get filename length
	BEQ TAPLOA1			;$F5EE no filename, search for next 
					;header

	JSR LOCSPH			;locate specified header 
	BCC TAPLOA2			;$F5F5 found, continue
	BEQ TPLORTS			;return clear
	BCS SERLDEX			;$F5C7 error, file not found

TAPLOA1				
	JSR LOCTPH			;search for next header
	BEQ TPLORTS			;return clear
	BCS SERLDEX			;$F5C7 none found, error

TAPLOA2				
	LDA CSTAT			;get status
	AND #%00010000			;$10 unrecoverable error?
	SEC				;return error
	BNE TPLORTS			;exit with error

	CPX #$01			;header type 1= BASIC pgm (relocatable)
	BEQ TAPLOA3			;$F611

	CPX #$03			;3=machine program (nonrelocatable)

TAPLOA2A				
	BNE TAPLOALP			;$F5E1 not ML, next file
 				
TAPLOALP2				
	LDY #$01			;ML program, get load address from
	LDA (TAPE1),Y			;header stored in tape buffer.
	STA MEMUSS			
	INY			
	LDA (TAPE1),Y			
	STA MEMUSS+1			
	BCS TAPLOA4			;$F615

TAPLOA3				
	LDA SECADR			;SA
	BNE TAPLOALP2			;F604 not 0, absolute load

TAPLOA4				
	LDY #$03			;calc program length. Start with low
	LDA (TAPE1),Y			;bytes...
	LDY #$01			
	SBC (TAPE1),Y			
	TAX			
	LDY #$04			;...then high bytes
	LDA (TAPE1),Y			
	LDY #$02			
	SBC (TAPE1),Y			
	TAY				;save length
	CLC			
	TXA			
	ADC MEMUSS			;pgm length + start address
	STA EAL				;equals end address
	TYA			
	ADC MEMUSS+1			
	STA EAL+1			
	LDA MEMUSS			
	STA STAL			
	LDA MEMUSS+1			
	STA STAL+1			
	JSR LOADMS			;output "Loading/Verifying" message
	JSR TPREAD2			;$F8C9 load file from tape
	.db $24				;BIT LASTPT+1

TPLOAEX				
	CLC			
	LDX EAL				;return program end address 
	LDY EAL+1			

TPLORTS				
	RTS			

;====================================================================				
; SRCHMS - Print "Searching for [filename]"				
;				
SRCHMS				
	LDA CMDMOD			;direct mode?
	BPL SRCHEX			;$F669 no, exit


	LDY #KIM_SRCH			;"Searching for"
	JSR MSG				;output message
	LDA FNMLEN			;filename length
	BEQ SRCHEX			;$F669 no filename, skip "for"
	LDY #$17			;point to "FOR" in "Searching For"
	JSR MSG				;print it
;				
; FLNMMS - Print filename				
;				
FLNMMS				
	LDY FNMLEN			;get filename length
	BEQ SRCHEX			;$F669 no filename, exit
	LDY #$00			

FLNMLP				
	LDA (FNPTR),Y			;print filename
	JSR CHROUT			
	INY			
	CPY FNMLEN			
	BNE FLNMLP			;$F65F

SRCHEX				
	RTS				;exit

;====================================================================				
; LOADMS - Print "Loading" or "Verifying"				
;				
LOADMS				
	LDY #KIM_LOAD			;"Loading" assumed
	LDA IOFLG2			;check load/verify flag-0=load
	BEQ DOMESG			;$F672 load, print message

	LDY #KIM_VERF			;flag=1, "Verifying"

DOMESG				
	JMP DIRMSG			;print message

;====================================================================				
; ISAVE - Save RAM to device				
;	On entry, .X/.Y is the LSB/MSB top save address ("to"). Bottom 			
;	          save address ("from") set by FF9C/MEMBOT. No filename			
;	          is required for the cassette. Devices 0/3 are illegal.			
;	Required prior calls:  FFBA/SETLFS, FFBD/SETNAM, FF9C/MEMBOT			
;				
ISAVE				
	STX EAL				;copy "save to" address
	STY EAL+1			
	TAX			
	LDA USRPOK,X			
	STA STAL			;save start address L
	LDA USRVEC,X			
	STA STAL+1			;save start address H
	JMP (LSAVVP)			;save it

;====================================================================				
; LNKSAV - Link to SAVE (indirect from $0302)				
;				
LNKSAV				
	LDA CHANNL			;Get current device
	BNE LNKSV_S2			;F68C Not keyboard, continue

LNKSV_S1				
	JMP IOERMS9			;$F796 "ILLEGAL DEVICE NUMBER" errro 

LNKSV_S2				
	CMP #$03			;screen?
	BEQ LNKSV_S1			;$F689 yes, error
	BCC TAPESV			;no, continue
;				
; SERSAV - Save to serial bus				
;				
SERSAV				
	LDA #$61			;SA=1
	STA SECADR			;set it
	LDY FNMLEN			;get filename length
	BNE SERSAV_S1			;$F69D not 0, continue
	JMP IOERMS8			;$F793 "FILENAME MISSING" error

;IEEE save				
SERSAV_S1				
	JSR SENDSA			;send filename
	JSR SAVEMS			;print "Saving" message
	LDA CHANNL			;get device
	JSR ILISTN			;command it to listen EE17
	LDA SECADR			;get SA
	JSR ISECND			;send it
	LDY #$00			
	JSR RSTTPP			;save start address to SAL
	LDA SAL			
	JSR ICIOUT			;send start address L...
	LDA SAL+1			
	JSR ICIOUT			;...and start address H

SERSAVLP				
	JSR CKWRPT			;reached end yet?
	BCS SERSAV1			;$F6D7 yes, go to ready

	LDA (SAL),Y			;get program byte
	JSR ICIOUT			;send it
	JSR STOP			;check for STOP key
	BNE SAVEXIT2			;not pressed, continue

SAVEXIT1				
	JSR SERSAV1A			;$F6DA close channel

SAVEXIT				
	LDA #$00			;set flag for "BREAK"
	SEC			
	RTS				;exit

SAVEXIT2				
	JSR INCRDP			;$FD1B bump current address
	BNE SERSAVLP			;$F6BC continue saving

SERSAV1				
	JSR IUNLSN			;send unlisten

SERSAV1A				
	BIT SECADR			
	BMI SERSAVRC			;$F6EF

	LDA CHANNL			;get device
	JSR ILISTN			;command it to listen
	LDA SECADR			;get SA
	AND #%11101111			;$EF twiddle some bits
	ORA #%11100000			;$E0
	JSR ISECND			;send SA
	JSR IUNLSN			;send unlisten 

SERSAVRC				
	CLC			
	RTS				;return clear

;====================================================================				
; TAPESV - Save to tape				
;				
TAPESV				
	CMP #$02			;RS232?
	BNE TPSAV_S1			;$F6F8 no, continue with tape
	JMP IOERMS9			;IOERMS9 "ILLEGAL DEVICE NUMBER" error

TPSAV_S1				
	JSR GETBFA			;get buffer start
	BCC LNKSAV+4			;$F689 JMP IOERMS9 "ILLEGAL DEVICE"

	JSR RECDMS			;wait for play and rec
	BCS TPSVRET			;$F727 error, exit

	JSR SAVEMS			;print "saving" message
	LDX #$03			;header type 3-ML program
	LDA SECADR			;ger SA
	AND #%00000001			;$01 BIT0 set (SA=1 or 3)
	BNE TPSAV_S2			;$F70F yes, save ML program

	LDX #$01			;no, must be BASIC program

;--Save file to tape				
TPSAV_S2				
	TXA			
	JSR WRTPHD			;write header
	BCS TPSVRET			;$F727 exit at STOP key

	JSR TPWRIT+3			;$F8E6 save program
	BCS TPSVRET			;$F727 exit at STOP key

	LDA SECADR			;get SA
	AND #%00000010			;$02 BIT1 set (SA=2 or 3)
	BEQ TPSVRET-1			;$F726 no, exit with CLC

	LDA #$05			;yes, write EOT control byte
	JSR WRTPHD			;write block
	.db $24				; BIT $18
	CLC			

TPSVRET				
	RTS			

;====================================================================				
; SAVEMS - Print "Saving [filename]"				
;				
SAVEMS				
	LDA CMDMOD			;direct mode?
	BPL TPSVRET			;$F727 no, exit

	LDY #KIM_SAVE			;yes, print 'Saving
	JSR MSG				;print message
	JMP FLNMMS			;print filename

;====================================================================				
; IUDTIM - Update RTC (internal)				
;	Called by IRQ			
;				
IUDTIM				
	LDX #$00			
	INC CTIMR2			;increase time tick
	BNE UDTIM1			;$F740

	INC CTIMR1			
	BNE UDTIM1			;$F740

	INC CTIMR0			

UDTIM1				
	SEC			
	LDA CTIMR2			
	SBC #$01			
	LDA CTIMR1			;check for 24hr
	SBC #$1A			
	LDA CTIMR0			
	SBC #$4F			
	BCC UDTIM2			;$F755 smaller, ok

	STX CTIMR0			;roll-over, reset timer to 0
	STX CTIMR1			
	STX CTIMR2			

UDTIM2				
	LDA D2ORAH			;check for STOP key
	CMP D2ORAH			
	BNE UDTIM2			;$F755

	STA STKEY			;got STOP, set flag
	RTS
	
;====================================================================				
; IRDTIM - Read RTC (internal)				
;	Returns .A=Jiffy MSB, .X Jiffy mid, .Y Jiffy LSB
;	
IRDTIM	
	SEI
	LDA CTIMR2
	LDX CTIMR1
	LDY CTIMR0

;====================================================================	
; ISETTM - Set RTC (internal)	
;	On entry, .A=Jiffy MSB, .X Jiffy mid, .Y Jiffy LSB
;	
ISETTM	
	SEI 
	STA CTIMR2
	STX CTIMR1			
	STY CTIMR0			
	CLI			
	RTS			

;====================================================================				
; ISTOP - Check STOP key				
;	On exit, Z-flag=1 of Stop key is pressed during call. .A= key scan			
;	    row if Stop is not pressed.			
;				
ISTOP				
	LDA STKEY			;check for STOP flag
	CMP #%11111110			;$FE set?
	BNE ISTOPEX			;$F77D no, exit

	PHP				;got STOP...
	JSR CLRCH			;clear I/O channels
	STA KEYCNT			;clear keybuff
	PLP			

ISTOPEX				
	RTS				;exit


;====================================================================				
;IOERMS - I/O Error Message Table register load				
;         All use the BIT $xxA9 trick to skip unused entries				
;         If on entry LDA=0, error message is "Break Error"				
;				
IOERMS1				
	LDA #$01			;Too Many Files
	.db $2C			

IOERMS2				
	LDA #$02			;File Already Open 
	.db $2C 			

IOERMS3				
	LDA #$03			;File Not Open
	.db $2C 			

IOERMS4				
	LDA #$04			;File Not Found
	.db $2C 			

IOERMS5				
	LDA #$05			;Device Not Present
	.db $2C 			

IOERMS6				
	LDA #$06			;Not Input File
	.db $2C 			

IOERMS7				
	LDA #$07			;Not Output File
	.db $2C 			

IOERMS8				
	LDA #$08			;Missing File Name
	.db $2C 			

IOERMS9				
	LDA #$09			;Illegal Device Number

	PHA				;save error#
	JSR CLRCH			;clear I/O channel
	LDY #$00			
	BIT CMDMOD			;BIT7=1 for direct
	BVC IOERMSEX			;$F7AC must be RUN mode, exit

	JSR MSG				;print "I/O ERROR #" message
	PLA				;get error#
	PHA			
	ORA #%00110000			;$30 convert to ASCII
	JSR CHROUT			;output error#

IOERMSEX				
	PLA			
	SEC			
	RTS			

;====================================================================
; LOCTPH - Read any tape header
;	Header type: 1=BASIC program, 2=data block, 3=machine program,
;			4=data header, 5=end-of-tape marker
;
LOCTPH				
	LDA IOFLG2			
	PHA				;save load/verif flag
	JSR TPREAD			;read block
	PLA			
	STA IOFLG2			;restore flag
	BCS LOCTPEX			;F7E6 error, end

	LDY #$00			;index reg
	LDA (TAPE1),Y			;get header type
	CMP #$05			;EOT? 
	BEQ LOCTPEX			;$F7E6 yes, exit

	CMP #$01			;BASIC program?
	BEQ LOCTP1			;$F7CE yes, branch

	CMP #$03			;ML program?
	BEQ LOCTP1			;$F7CE yes, branch

	CMP #$04			;data block header?
	BNE LOCTPH			;data block, so read next header

LOCTP1				
	TAX			
	BIT CMDMOD			;direct mode?
	BPL LOCTPEX-2			;$F7E4 no, continue

	LDY #KIM_FOUN			;setup for "Found" msg
	JSR MSG				;print it
	LDY #$05			;offset to file name

LOCLOOP				
	LDA (TAPE1),Y			;print loop
	JSR CHROUT			
	INY			
	CPY #$15			;16 characters
	BNE LOCLOOP			;$F7DA loop
	CLC			
	DEY			

LOCTPEX				
	RTS			

;====================================================================				
; WRTPHD - Write tape header				
;  On entry, .A is the header type				
;				
WRTPHD				
	STA TPTR1			;save header type
	JSR GETBFA			;get buffer address
	BCC WRTPEX			;$F84C

	LDA STAL+1			
	PHA				;save...start H
	LDA STAL			
	PHA				;...start L
	LDA EAL+1			
	PHA				;...end H
	LDA EAL			
	PHA				;...end L
	LDY #$BF			;buffer length
	LDA #$20			

WRTPLP1				
	STA (TAPE1),Y			;clear buffer
	DEY			
	BNE WRTPLP1			;$F7FE

	LDA TPTR1			;get header type
	STA (TAPE1),Y			;write it
	INY			
	LDA STAL			;get start L
	STA (TAPE1),Y			;write it
	INY			
	LDA STAL+1			;get start H
	STA (TAPE1),Y			;write it
	INY			
	LDA EAL				;get end L
	STA (TAPE1),Y			;write it
	INY			
	LDA EAL+1			;get end H
	STA (TAPE1),Y			;write it
	INY			
	STY TPTR2			;save buffer offset
	LDY #$00			;filename loop counter
	STY TPTR1			;save loop counter

WRTPLP2				
	LDY TPTR1			;get loop counter
	CPY FNMLEN			;compare filename length
	BEQ WRTPH1			;$F834 done

	LDA (FNPTR),Y			;get filename char
	LDY TPTR2			;get tape buffer pointer
	STA (TAPE1),Y			;write char to buffer
	INC TPTR1			;increment loop counters
	INC TPTR2			
	BNE WRTPLP2			;$F822 loop

WRTPH1				
	JSR SETBST			;set start and end address pointers
	LDA #$69			;chacksum block ID
	STA RIPRTY			;save parity character
	JSR TPWRIT1			;$F8EA write block
	TAY				;restore start and end addresses
	PLA			
	STA EAL			
	PLA			
	STA EAL+1			
	PLA			
	STA STAL			
	PLA			
	STA STAL+1			
	TYA			

WRTPEX				
	RTS				;exit

;====================================================================				
; GETBFA - Get start of tape buffer				
;    Returns buffer address in .X (LSB) and .Y (MSB)				
;				
GETBFA				
	LDX TAPE1			
	LDY TAPE1+1			
	CPY #$02			;is buffer at $02xx?
	RTS			


;====================================================================				
; SETBST - Set buffer start/end pointers				
;				
SETBST				
	JSR GETBFA			;get buffer address
	TXA			
	STA STAL			;start=start of buffer
	CLC			
	ADC #$C0			;end=start+192
	STA EAL			
	TYA			
	STA STAL+1			
	ADC #$00			
	STA EAL+1			
	RTS			

;====================================================================				
; LOCSPH- Find specific tape header				
;				
LOCSPH				
	JSR LOCTPH			;search for next header
	BCS LCSPEXC+1			;$F889 return EOT? Go to ready

	LDY #$05			;filename offset
	STY TPTR2			;save offset 
	LDY #$00			;loop counter
	STY TPTR1			;save it

LCSPHLP				
	CPY FNMLEN			;compare filename length
	BEQ LCSPEXC			;$F888 conter 0, done

	LDA (FNPTR),Y			;get filename letter
	LDY TPTR2			
	CMP (TAPE1),Y			;compare to tape header
	BNE LOCSPH			;f867 different, get next header

	INC TPTR1			;increment counters
	INC TPTR2			
	LDY TPTR1			
	BNE LCSPHLP			;$F874 loop

LCSPEXC				
	CLC			
	RTS			


;====================================================================				
; INCTPT - Bump tape pointer				
;				
INCTPT				
	JSR GETBFA			;get buffer to .X/.Y
	INC BUFPNT			;increment pointer in buffer
	LDY BUFPNT			;get pointer
	CPY #$C0			;at top of buffer?
	RTS				;return


;====================================================================				
; PLAYMS - Wait for tape key on read				
;				
PLAYMS				
	JSR TPSTAT			;get key status
	BEQ TPSTEX			;$F8B5 pressed, exit

	LDY #KIM_PLAY			;offset for "Press Play..." message

PLAYMS1				
	JSR MSG				;print it

WTPLAY				
	JSR TPSTOP			
	JSR TPSTAT			;get key status
	BNE WTPLAY			;$F89E wait for PLAY switch

	LDY #KIM_OK			;offset for "OK"
	JMP MSG				;print it


;====================================================================				
; TPSTAT - Check tape key status				
;				
TPSTAT				
	LDA #%01000000			;$40
	BIT D1ORAH			;switch sense
	BNE TPSTEX			;$F8B5 not pressed, exit
	BIT D1ORAH			;button pressed. Setup for another
					;compare later. Z=1 if pressed
TPSTEX				
	CLC			
	RTS				;return clear

;====================================================================				
; RECDMS - Wait for tape key on write				
;				
RECDMS				
	JSR TPSTAT			;get button status
	BEQ TPSTEX			;$F8B5 pressed? Yes, continue

	LDY #KIM_RECP			;no, remind to "Press Play & Record"
	BNE PLAYMS1			;$F89B JSR MSG

;====================================================================				
; TPREAD - Read tape block				
;				
TPREAD				
	LDA #$00			
	STA CSTAT			;clear status variable...
	STA IOFLG2			;and read/verif flag

TPREAD1				
	JSR SETBST			;set tape buffer pointers

;				
; load program				
;				
TPREAD2				
	JSR PLAYMS			;wait for Play key
	BCS TPCODE-2			;$F8ED

	SEI				;disable interrupts
	LDA #$00			;clear work memory for IRQ routines
	STA RIDATA			
	STA BITTS			
	STA TPCON1			
	STA TPTR1			
	STA TPTR2			
	STA BYTINF			
	LDA #$82			;Timer H constant
	LDX #$0E			;number for IRQ vector
	BNE TPCODE1			;$F8F4

;====================================================================				
; TPWRIT - Initiate tape write				
;				
TPWRIT				
	JSR SETBST			;get buffer pointers
	LDA #$14			;checksum
	STA RIPRTY			;save it

;				
; write buffer to tape				
;				
TPWRIT1				
	JSR RECDMS			;wait for Record+Play keys
	BCS TPSTPX1			;$F957 exit
;				
; TPCODE - Common tape code				
;				
TPCODE				
	SEI				;disable interrupts
	LDA #%10100000			;$A0 Timer H constant
	LDX #%00001000			;$08 number for IRQ vector

TPCODE1				
	LDY #%01111111			;$7F disable interrupts
	STY D2IER			
	STA D2IER			;enable timer 2
	JSR SBIDLE			;wait for timeout
	LDA IRQVP			;save current IRQ Vector
	STA TAPIRQ			
	LDA IRQVP+1			
	STA TAPIRQ+1			
	JSR STOIRQ1			;$FCFB .X=8 set tape IRQ vectors
	LDA #$02			;read # of blocks
	STA FSBLK			
	JSR NCHAR			;set bit counter for serial output
	LDA D1PCR			
	AND #%11111101			;$FD CA2 manual low
	ORA #%00001100			;$0C force bits 2,3 high
	STA D1PCR			;switch on tape drive
	STA CAS1			;flag as on
	LDX #$FF			;delay loop for high (outter)
	LDY #$FF			;inner loop

TPCDLP1				
	DEY			
	BNE TPCDLP1			;$F925

	DEX			
	BNE TPCDLP1-2			;$F923 outside loop
	STA D2TM2H			
	CLI			;allow tape interrupts

;				
; wait for I/O-end				
;				
TPCDLP2				
	LDA TAPIRQ+1			;check IRQ direction
	CMP IRQVP+1			;standard vector?
	CLC			
	BEQ TPSTPX1			;$F957 yes, ready

	JSR TPSTOP			;no, check STOP key
	LDA D2IFR			;timer 1 IF clear?
	AND #%01000000			;$40
	BEQ TPCDLP2			;$F92F continue

	LDA D1TM1L			
	JSR IUDTIM			;update RTC
	JMP TPCDLP2			;$F92F loop

;====================================================================				
; TPSTOP - Check for tape stop				
;				
TPSTOP				
	JSR STOP			;scan STOP key
	CLC			
	BNE TPSTPX			;$F95C not pressed, return

	JSR RESIRQ			;pressed, turn drive off and restore IRQ
	SEC				;set error flag 
	PLA				;pop return address
	PLA			

TPSTPX1				
	LDA #$00			;flag normal IRQ vector
	STA TAPIRQ+1			

TPSTPX				
	RTS			

;====================================================================				
; SETRDT - Set read timing				
;				
SETRDT				
	STX TPCON2			
	LDA TPCON1			
	ASL A			
	ASL A			
	CLC			
	ADC TPCON1			
	CLC			
	ADC TPCON2			
	STA TPCON2			
	LDA #$00			
	BIT TPCON1			
	BMI SETRD_S1			;$F972

	ROL A			

SETRD_S1				
	ASL TPCON2			
	ROL A			
	ASL TPCON2			
	ROL A			
	TAX			

RDTLP1				
	LDA D2TM2L			
	CMP #$15			
	BCC RDTLP1			;$F979

	ADC TPCON2			
	STA D2TM1L			
	TXA			
	ADC D2TM2H			
	STA D2TM1L+1			
	CLI
	RTS

;====================================================================	
; RDTPBT - Read tape bits IRQ routine	
;	
RDTPBT	
	LDX D2TM2H
	LDY #$FF
	TYA
	SBC D2TM2L
	CPX D2TM2H
	BNE RDTPBT

	STX TPCON2
	TAX			
	STY D2TM2L			
	STY D2TM2H			
	TYA			
	SBC TPCON2			
	STX TPCON2			
	LSR A			
	ROR TPCON2			
	LSR A			
	ROR TPCON2			
	LDA TPCON1			
	CLC			
	ADC #$3C			
	BIT D2ORA			
	CMP TPCON2			
	BCS RDTP4			;$FA06

	LDX BYTINF			
	BEQ RDTPB_S1			;F9C3
	JMP STORTC			;save tape IRQs

RDTPB_S1				
	LDX SBITCF			
	BMI RDTP1			;$F9E2

	LDX #$00			
	ADC #$30			
	ADC TPCON1			
	CMP TPCON2			
	BCS RDTP2			;$F9ED

	INX			
	ADC #$26			
	ADC TPCON1			
	CMP TPCON2			
	BCS RDTP3			;$F9F1

	ADC #$2C			
	ADC TPCON1			
	CMP TPCON2			
	BCC RDTPLP1			;$F9E5

RDTP1				
	JMP RDTP6A			;$FA60

RDTPLP1				
	LDA BITTS			
	BEQ RDTP4			;$FA06

	STA BITCI			
	BNE RDTP4			;$FA06

RDTP2				
	INC RINONE			
	BCS RDTP3A			;$F9F3

RDTP3				
	DEC RINONE			

RDTP3A				
	SEC			
	SBC #$13			
	SBC TPCON2			
	ADC SVXT			
	STA SVXT			
	LDA CYCLE			
	EOR #$01			
	STA CYCLE			
	BEQ RDTP3C			;$FA25

	STX LASTKY			

RDTP4				
	LDA BITTS			
	BEQ RDTPEX1			;$FA22

	BIT D2IFR			
	BVC RDTPEX1			;$FA22

	LDA #$00			
	STA CYCLE			
	LDA SBITCF			
	BPL RDTP6			;$FA47
	BMI RDTP1			;$F9E2

RDTP3B				
	LDX #$A6			
	JSR SETRDT			
	LDA TPRTY			
	BNE RDTPLP1			;$F9E5

RDTPEX1				
	JMP EOI				;return from interrupt

RDTP3C				
	LDA SVXT			
	BEQ RDTP5A			;$FA30
	BMI RDTP5			;$FA2E

	DEC TPCON1			
	.db $2C				;bit $b0e6

RDTP5				
	INC TPCON1			

RDTP5A				
	LDA #$00			
	STA SVXT			
	CPX LASTKY			
	BNE RDTP6			;$FA47

	TXA			
	BNE RDTPLP1			;$F9E5

	LDA RINONE			
	BMI RDTP4			;$FA06

	CMP #$10			
	BCC RDTP4			;$FA06

	STA EOTFLG			
	BCS RDTP4			;$FA06

RDTP6				
	TXA			
	EOR TPRTY			
	STA TPRTY			
	LDA BITTS			
	BEQ RDTPEX1			;$FA22

	DEC SBITCF			
	BMI RDTP3B			;$FA19

	LSR LASTKY			
	ROR MYCH			
	LDX #$DA			
	JSR SETRDT			
	JMP EOI				;return from interrupt

RDTP6A				
	LDA EOTFLG			
	BEQ RDTP7			;$FA68

	LDA BITTS			
	BEQ RDTP8			;$FA6C

RDTP7				
	LDA SBITCF			
	BPL RDTP3			;$F9F1

RDTP8				
	LSR TPCON2			
	LDA #$93			
	SEC			
	SBC TPCON2			
	ADC TPCON1			
	ASL A			
	TAX			
	JSR SETRDT			
	INC BYTINF			
	LDA BITTS			
	BNE RDTP9			;$FA91

	LDA EOTFLG			
	BEQ RDTPEX2			;$FAAA

	STA BITCI			
	LDA #$00			
	STA EOTFLG			
	LDA #%11000000			;$C0
	STA D2IER			
	STA BITTS			

RDTP9				
	LDA EOTFLG			
	STA NXTBIT			
	BEQ RDTP10			;$FAA0

	LDA #$00			
	STA BITTS			
	LDA #%01000000			;$40
	STA D2IER			

RDTP10				
	LDA MYCH			
	STA ROPRTY			
	LDA BITCI			
	ORA RINONE			
	STA RODATA			

RDTPEX2				
	JMP EOI				;return from interrupt

;====================================================================				
; STORTC - Store tape characters				
;				
STORTC				
	JSR NCHAR			
	STA BYTINF			
	LDX #%11011010			;$DA
	JSR SETRDT			
	LDA FSBLK			
	BEQ STOTC_S1			;FABD

	STA INBIT			

STOTC_S1				
	LDA #$0F			
	BIT RIDATA			
	BPL STOTC1			;FADA

	LDA NXTBIT			
	BNE STOTCEX1			;$FAD3

	LDX FSBLK			
	DEX			
	BNE STOTCEX1A			;$FAD7

	LDA #$08			;I/O error 8
	JSR ISETMS1			;"LONG BLOCK" error
	BNE STOTCEX1A			

STOTCEX1				
	LDA #$00			
	STA RIDATA			

STOTCEX1A				
	JMP EOI				;return from interrupt

STOTC1				
	BVS STOTC4A			;$FB0D
	BNE STOTC3			;$FAF6

	LDA NXTBIT			
	BNE STOTCEX1A			

	LDA RODATA			
	BNE STOTCEX1A			

	LDA INBIT			
	LSR A			
	LDA ROPRTY			
	BMI STOTC2			;$FAF0
	BCC STOTC4			;$FB07

	CLC			

STOTC2				
	BCS STOTC4			;$FB07
	AND #%00001111			;$0F
	STA RIDATA			

STOTC3				
	DEC RIDATA			
	BNE STOTCEX1A			

	LDA #$40			
	STA RIDATA			
	JSR RSTTPP			
	LDA #$00			
	STA RIPRTY			
	BEQ STOTCEX1A			

STOTC4				
	LDA #$80			
	STA RIDATA			
	BNE STOTCEX1A			

STOTC4A				
	LDA NXTBIT			
	BEQ STOTC5			;$FB1B

	LDA #$04			;I/O error 4
	JSR ISETMS1			;$FE6A "SHORT BLOCK" error
	LDA #$00			
	JMP STOTC11A			;$FB97

STOTC5				
	JSR CKWRPT			
	BCC STOTC_S2			;$FB23
	JMP STOTC11			;$FB95

STOTC_S2				
	LDX INBIT			
	DEX			
	BEQ STOTC7			;$FB55

	LDA IOFLG2			
	BEQ STOTC6			;$FB38

	LDY #$00			
	LDA ROPRTY			
	CMP (SAL),Y			
	BEQ STOTC6			;$FB38

	LDA #$01			
	STA RODATA			

STOTC6				
	LDA RODATA			
	BEQ STOTC10			;$FB87

	LDX #$3D			
	CPX TPTR1			
	BCC STOTC9			;$FB80

	LDX TPTR1			
	LDA SAL+1			
	STA FBUFFR+1,X			
	LDA SAL			
	STA FBUFFR,X			
	INX			
	INX			
	STX TPTR1			
	JMP STOTC10			;$FB87

STOTC7				
	LDX TPTR2			
	CPX TPTR1			
	BEQ STOTC10A			;$FB90

	LDA SAL				;error correction pass #2
	CMP FBUFFR,X			
	BNE STOTC10A			;$FB90

	LDA SAL+1			
	CMP FBUFFR+1,X			
	BNE STOTC10A			;$FB90

	INC TPTR2			
	INC TPTR2			
	LDA IOFLG2			
	BEQ STOTC8			;$FB7C

	LDA ROPRTY			;read byte
	LDY #$00			
	CMP (SAL),Y			;compare to memory
	BEQ STOTC10A			;$FB90

	INY			
	STY RODATA			

STOTC8				
	LDA RODATA			
	BEQ STOTC10			;$FB87

STOTC9				
	LDA #$10			;I/O error #16
	JSR ISETMS1			;$FE6A "SECOND PASS" error
	BNE STOTC10A			;$FB90

STOTC10				
	LDA IOFLG2			;verify?
	BNE STOTC10A			;$FB90 yes, branch

	TAY			
	LDA ROPRTY			;read byte
	STA (SAL),Y			;save it

STOTC10A				
	JSR INCRDP			;increment address pointer
	BNE STOEX			;$FBCF

STOTC11				
	LDA #$80			

STOTC11A				
	STA RIDATA			
	LDX FSBLK			
	DEX			;decrement pass counter
	BMI STOTC_S3			;$FBA0

	STX FSBLK			

STOTC_S3				
	DEC INBIT			
	BEQ STOTC12			;$FBAC

	LDA TPTR1			
	BNE STOEX			;$FBCF

	STA FSBLK			
	BEQ STOEX			;$FBCF

STOTC12				
	JSR RESIRQ			;one pass done
	JSR RSTTPP			;reset address to program start
	LDY #$00			
	STY RIPRTY			

STORTLP1				
	LDA (SAL),Y			;calc program checksum
	EOR RIPRTY			
	STA RIPRTY			
	JSR INCRDP			;increment address pointer
	JSR CKWRPT			;reached end?
	BCC STORTLP1			;$FBB6 no, continue

	LDA RIPRTY			;calculate checksum
	EOR ROPRTY			;compare with tape's checksum
	BEQ STOEX			;ok

	LDA #$20			;I/O error 32
	JSR ISETMS1			;$FE6A "CHECKSUM" error

STOEX				
	JMP EOI			;return from interrupt

;====================================================================				
; RSTTPP - Reset tape pointer				
;				
RSTTPP				
	LDA STAL+1			
	STA SAL+1			
	LDA STAL
	STA SAL
	RTS

;====================================================================	
; NCHAR - Set bit counter for new character (serial output)	
;	
NCHAR	
	LDA #$08
	STA SBITCF
	LDA #$00
	STA CYCLE
	STA BITCI
	STA TPRTY
	STA RINONE
	RTS			


;====================================================================				
; TONE - Write one bit to tape (send tone to tape)				
;				
TONE				
	LDA ROPRTY			;get bit
	LSR A				;determine tone length
	LDA #$60			;set short tone timing (1 bit)
	BCC TONE1			;$FBF3 C=clear

TONEA				
	LDA #$B0			;set long tone time (0 bit)

TONE1				
	LDX #$00				
	STA D2TM2L				
	STX D2TM2H			;setup timer	
	LDA D2ORB				
	EOR #%00001000			;$08	invert output bit for tape
	STA D2ORB				
	AND #%00001000				
	RTS				

;====================================================================					
; TWRDTA - Write data to tape					
;					
TWRDTA					
	SEC				
	ROR SAL+1				
	BMI TWRDEX1			;fc47

;				
; tape write IRQ routine				
;				
TWRD7				
	LDA BITCI			
	BNE TWRD1			;$FC21

	LDA #$10			
	LDX #$01			
	JSR TONE1+2			;$FBF5 send frequency
	BNE TWRDEX1			;fc47

	INC BITCI			
	LDA SAL+1			
	BPL TWRDEX1			;fc47
	JMP WRLEDR			;write second block

TWRD1				
	LDA RINONE			
	BNE TWRD2A			;$FC2B

	JSR TONEA			;$FBF1 write 0 bit
	BNE TWRDEX1			;fc47

TWRD2				
	INC RINONE			;LDA #$D0
	BNE TWRDEX1			;ORA Y

TWRD2A				
	JSR TONE			;write bit
	BNE TWRDEX1			;fc47

	LDA CYCLE			
	EOR #$01			;invert bit for output
	STA CYCLE			
	BEQ TWRD3			;$FC4A

	LDA ROPRTY			
	EOR #$01			
	STA ROPRTY			
	AND #$01			
	EOR TPRTY			
	STA TPRTY			

TWRDEX1				
	JMP EOI				;return from interrupt

TWRD3				
	LSR ROPRTY			;next bit
	DEC SBITCF			;decrement counter
	LDA SBITCF			
	BEQ TWRD6			;$FC8C output it
	BPL TWRDEX1			;fc47

TWRD3A				
	JSR NCHAR			;reset bit counter
	CLI			
	LDA CNTDN			
	BEQ TWRD4			;$FC6E

	LDX #$00			
	STX LASTKY			
	DEC CNTDN			
	LDX FSBLK			
	CPX #$02			
	BNE TWRD_S1			;FC6A

	ORA #%10000000			;$80

TWRD_S1				
	STA ROPRTY			;$BD
	BNE TWRDEX1			;fc47

TWRD4				
	JSR CKWRPT			;end address reached?
	BCC TWRD5			;$FC7D
	BNE TWRDTA			

	INC SAL+1			
	LDA LASTKY			
	STA ROPRTY			
	BCS TWRDEX1			;fc47

TWRD5				
	LDY #$00			;loop counter
	LDA (SAL),Y			;byte to be written
	STA ROPRTY			
	EOR LASTKY			
	STA LASTKY			
	JSR INCRDP			;increment address pointer
	BNE TWRDEX1			;fc47

TWRD6				
	LDA TPRTY			
	EOR #$01			
	STA ROPRTY			

TPEOI				
	JMP EOI				;return from interrupt


;====================================================================				
; WRLEDR - Write tape leader				
;				
WRLEDR				
	DEC FSBLK			;decrement block counter
	BNE WRLDR1			;$FC9C more to go

	JSR NOMOTR			;none left, kill motor

WRLDR1				
	LDA #$50			
	STA INBIT			
	LDX #$08			
	SEI			
	JSR STOIRQ1			;$FCFB tape IRQs
	BNE TPEOI			;$FC92

;				
; write leader tape IRQ routine				
;				
WRLDR2				
	LDA #$78			;tone length??
	JSR TONE1			;$FBF3 write bit on tape
	BNE TPEOI			;$FC92

	DEC INBIT			
	BNE TPEOI			;$FC92

	JSR NCHAR			;set bit counter
	DEC RIPRTY			
	BPL TPEOI			;$FC92

	LDX #$0A			;IRQ number
	JSR STOIRQ1			;$FCFB set tape IRQ routine
	CLI				;allow interrupts
	INC RIPRTY			
	LDA FSBLK			
	BEQ STOIRQ			;$FCF6

	JSR RSTTPP			;set address to start
	LDX #$09			
	STX CNTDN			
	BNE TWRD3A			;$FC54
;				
; RESIRQ - Restore normal IRQ				
;				
RESIRQ				
	PHP			
	SEI				;kill interrupts
	JSR NOMOTR			;kill motor
	LDA #%01111111			;$7F
	STA D2IER			;restore screen
	LDA #%11110111			;$F7
	STA D2ORB 			
	LDA #%01000000			;$40
	STA D2ACR			
	JSR ENABTM			;enable timers
	LDA TAPIRQ+1			
	BEQ RSIRQEX			;$FCF4

	STA IRQVP+1			;restore IRQs
	LDA TAPIRQ			
	STA IRQVP			

RSIRQEX				
	PLP			
	RTS			

;====================================================================				
; STOIRQ - Set IRQ vector				
;				
STOIRQ				
	JSR RESIRQ			;restore std IRQs
	BEQ TPEOI			;$FC92

STOIRQ1				
	LDA RATS3,X			;$FDE9,X set vectors from table
	STA IRQVP			
	LDA RATS3+1,X			;$FDEA,X
	STA IRQVP+1			
	RTS			

;====================================================================				
; NOMOTR - Kill tape motor				
;				
NOMOTR				
	LDA D1PCR			
	ORA #%00001110			;$0E
	STA D1PCR			
	RTS			

;====================================================================				
; CKWRPT - Check read/write pointer for end address				
;				
CKWRPT				
	SEC			
	LDA SAL				;SAL is current address
	SBC EAL				;EAL is end address
	LDA SAL+1			
	SBC EAL+1			
	RTS			


;====================================================================				
; INCRDP - Bump read/write pointer				
;				
INCRDP				
	INC SAL			
	BNE INCRSK			;$FD21

	INC SAL+1			

INCRSK				
	RTS			


;####################################################################				
; Power-on RESET entry				
;####################################################################				
RESET				
	LDX #$FF			
	SEI				;kill interrupts
	TXS				;set stack top
	CLD			
	JSR SCNROM			;check for autostart ROM
	BNE SKIPA0			;$FD2F not there, skip init

	JMP (A0BASE)			;jump to ROM

SKIPA0				
	JSR RAMTAS			;test RAM
	JSR IRESTR			;init work memory
	JSR IOINIT			;setup hardware
	JSR CINT1			;init video
	CLI			
	JMP (BENTER)			;enter BASIC

;====================================================================				
; SCNROM - Scan ROM areas for Autostart ROM signature				
;				
SCNROM				
	LDX #$05			;5 chars to compare

SCNLOOP				
	LDA SCANEX,X			;$FD4C,X
	CMP A0BASE+3,X			;$A003,X
	BNE SCANEX			;$FD4C

	DEX			
	BNE SCNLOOP			;$FD41

SCANEX				
	RTS			
;				
; ROMSIG - Autostart ROM signature				
;				
ROMSIG				
	.db "A0", $C3, $C2, $CD		;A0CBM

;====================================================================				
; IRESTR - Restore KERNEL hardware vectors (internal)				
;	On entry, NONE			
;				
IRESTR				
	LDX #$EA 			;FIXUP2;#$6D
	LDY #$EA 			;FIXUP2+1;#$FD $FD6D KERNEL vecs
	CLC			
;				
; IVECTR - Change vectors for user				
;	On entry, SEC=read vector to .X/.Y LSB/MSB			
;	          CLC=set vector from .X/.Y LSB/MSB			
;				
IVECTR				
	STX MEMUSS			;save vector to temp
	STY MEMUSS+1			
	LDY #$1F			;# of bytes to move

VECLOOP				
	LDA IRQVP,Y			
	BCS VECSK			;$FD64 branch on CY=1

	LDA (MEMUSS),Y			

VECSK				
	STA (MEMUSS),Y			
	STA IRQVP,Y			
	DEY			
	BPL VECLOOP			;$FD5D loop
	RTS			

;				
;KERNEL Vectors				
;				
KNRLSV				
;FD6D 				
;FD75 				
;FD7D 				
;FD85 				
	.dw IRQVEC, WARMST, LNKNMI, IOPEN			
	.dw ICLOSE, ICHKIN, ICHKOT, ICLRCH			
	.dw ICHRIN, ICHROT, ISTOP,  IGETIN			
	.dw ICLALL, WARMST, LNKLOD, LNKSAV			

;====================================================================				
; RAMTAS - Initialize system contents				
;				
RAMTAS				
	LDA #$00			
	TAX			

RAMTSLP1				
	STA USRPOK,X			;zero page
	STA BUF,X			;clear page 2
	STA ERRVPT,X			;clear page 3
	INX			
	BNE RAMTSLP1			;$FD90

	LDX #$3C			;setup cassette buffer
	LDY #$03			
	STX TAPE1			
	STY TAPE1+1			
	STA STAL			
	STA REGSAV			
	STA OSSTAR			
	TAY			
	LDA #$04			;check RAM from $0500
	STA STAL+1			

RAMTASLP2				
	INC STAL			
	BNE RAMTAS1			;$FDB5

	INC STAL+1			

RAMTAS1				
	JSR MEMTST			;test RAM
	LDA REGSAV			
	BEQ RAMTAS3			;$FDDE
	BCS RAMTASLP2			;$FDAF

	LDY STAL+1			;RAM top
	LDX STAL			
	CPY #$20			
	BCC I6561LP			;$FDEB

	CPY #$21			
	BCS RAMTAS2			;$FDD2

	LDY #$1E			
	STY HIPAGE			

RAMTAS1A				
	JMP STOTOP			;$FE7B set RAM top

RAMTAS2				
	LDA #$12			
	STA OSSTAR+1			;set BASIC bottom
	LDA #$10			
	STA HIPAGE			
	BNE RAMTAS1A			;$FDCF

RAMTAS3				
	BCC RAMTASLP2			;$FDAF

	LDA STAL+1			
	STA OSSTAR+1			
	STA REGSAV			
	CMP #$11			

RATS3				
	BCC RAMTASLP2			;$FDAF

I6561LP				
	JSR V6561I-2			;$E5C3 init VIC regs
	JMP I6561LP			;$FDEB

;====================================================================				
; TAPEVC - Tape IRQ vectors				
;				
TAPEVC				
;	.dw $FCA8, $FC0B, $EABF, $F98E			
	.dw WRLDR2, TWRD7, IRQVEC, RDTPBT			

;====================================================================				
; IOINIT - Initialize I/O registers				
;				
IOINIT				
	LDA #%01111111			;$7F
	STA D1IER			
	STA D2IER			
	LDA #%01000000			;$40
	STA D2ACR			
	LDA #%01000000			;$40
	STA D1ACR			
	LDA #%11111110			;$FE
	STA D1PCR			
	LDA #%11011110			;$DE
	STA D2PCR			
	LDX #$00			
	STX D1DDRB			
	LDX #%11111111			;$FF
	STX D2DDRB			
	LDX #$00			
	STX D2DDRA			
	LDX #%10000000			;$80
	STX D1DDRA			
	LDX #$00			
	STX D1ORAH			
	JSR SCLK1			
	LDA #%10000010			;$82
	STA D1IER			
	JSR SCLK0			
;				
; ENABTM - Enable timer				
;				
ENABTM				
	LDA #%11000000			;$C0
	STA D2IER			
	LDA #%10001001			;$89
	STA D2TM1L			
	LDA #%01000010			;$42
	STA D2TM1L+1			
	RTS			


;====================================================================				
; ISETNM - Set filename (internal)				
;	On entry, .A is filename length, .X is LSB of filename string, .Y is MSB			
;				
ISETNM				
	STA FNMLEN			;set length
	STX FNPTR			;ptr L
	STY FNPTR+1			;ptr H
	RTS			

;====================================================================				
; ISETLF - Set logical file parameters (internal)				
;	On entry, .A is file number, .X is device# (0-30), .Y is command			
;				
ISETLF				
	STA LOGFIL			;file#
	STX CHANNL			;device
	STY SECADR			;secondary address
	RTS			

;====================================================================				
; IRDST - Get I/O status word (internal)				
;				
IRDST				
	LDA CHANNL			;get device
	CMP #$02			;RS232?
	BNE ISETMS+2			;$FE68 no, branch to OS messages

	LDA RSSTAT			;get RS232 status
	LDA #$00			
	STA RSSTAT			
	RTS			

;====================================================================				
; ISETMS - Control OS messages (internal)				
;	On entry, .A is message number. Bit7=1 for KERNEL messages, and 			
;	    Bit6=1 for control messages. Bit0-Bit5 is message number.			
;				
; set flag for OS messages				
;				
ISETMS				
	STA CMDMOD			;save message #
	LDA CSTAT			;get status

;				
; set ST bits				
;				
ISETMS1				
	ORA CSTAT			;twiddle bits
	STA CSTAT			;save status
	RTS			

;====================================================================				
; ISETTO - Set IEEE timeout (internal)				
;	On entry, Bit7=1 for time-outs disabled (device must respond to			
;	    DAV within 64ms).			
;				
ISETTO				
	STA STIMOT			
	RTS			

;====================================================================				
; IMEMTP - Set/read top of memory (internal)				
;	On entry, SEC to read, .X/.Y is LSB/MSB			
;	          CLC to set, .X/.Y is LSB/MSB			
;				
IMEMTP				
	BCC STOTOP			;$FE7B
	LDX OSTOP			
	LDY OSTOP+1			

STOTOP				
	STX OSTOP			
	STY OSTOP+1			
	RTS			

;====================================================================				
; IMEMBT - Set/read bottom of memory  (internal)				
;	On entry, SEC to read, .X/.Y is LSB/MSB			
;	          CLC to set, .X/.Y is LSB/MSB			
;				
IMEMBT				
	BCC STOBOT			;$FE8A
	LDX OSSTAR			
	LDY OSSTAR+1			

STOBOT				
	STX OSSTAR			
	STY OSSTAR+1			
	RTS			

;====================================================================				
; MEMTST - Test memory				
;				
MEMTST				
	LDA (STAL),Y			
	TAX			
	LDA #%01010101			;$55
	STA (STAL),Y			
	CMP (STAL),Y			
	BNE MEMTS1			;$FEA4

	ROR A				;%10101010
	STA (STAL),Y			
	CMP (STAL),Y			
	BNE MEMTS1			;$FEA4
	.db $A9				;LDA #$18

MEMTS1				
	CLC			
	TXA			
	STA (STAL), Y			
	RTS			

;====================================================================
; NMI - NMI transfer entry
;====================================================================
NMI				
	SEI			
	JMP (NMIVP)			;$FEAD

;====================================================================
; LNKNMI - Link to NMI code				
;				
LNKNMI				
	PHA				;save regs
	TXA			
	PHA			
	TYA			
	PHA			
	LDA D1IFR			;check VIA interrupt flag
	BPL WARMEOI			;no flag, then issue EOI

	AND D1IER			; see if interrupt is allowed
	TAX				; based on IER mask
	AND #%00000010			;CA1 - RESTOR key?
	BEQ WARM1			;no? Process RS232

					; NMI by RESTOR
	JSR SCNROM			;scan for A000
	BNE LNKNMI1			;not present, don't call A0 entry

	JMP (A0BASE+2)			;jump to ROM NMI routine

LNKNMI1					;continue NMI - no expansion ROM
	BIT D1ORA			;test ATN IN (7)/cass sw(6)
	JSR IUDTIM			;update TOD clock
	JSR STOP			;check STOP key - Z=1 for press
	BNE WARMEOI			;no stop key, so skip warm start calls

;====================================================================
; WARMST - Default USER vector
;	   Also get here from BRK instruction or RUN/STOP-RESTOR
;				
WARMST				
	JSR IRESTR			;restore default vectors
	JSR IOINIT			;init I/O
	JSR CINT1			;init screen editor
	JMP (BENTER+2)			;jump to BASIC NMI entry

WARM1					; RS232 NMI routines.
	LDA D1IER			;get IER bitmap
	ORA #%10000000			;$80 set mask for enabling interrupts
	PHA				; according to existing bitmap
	LDA #%01111111			;$7F mask - disable all VIA1 interrupts
	STA D1IER			
	TXA				;restore mask for active interrupts
	AND #%01000000			;$40 IFR bit6=TIMER1 time-out (RS232 clock)
	BEQ WARM2			;$FF02 T1 done, go to RS232 RX

	LDA #%11001110			;$CE set/reset bit5 xmit char
	ORA NXTBIT			;RS232 transmit - next bit to send
	STA D1PCR			;CB2 manual L/H; CB1 neg trans for
					; IRQ; CA2 manual H; CA1 neg trans
					; for IRQ; CB2=TX, CA2=cass motor
					; control
	LDA D1TM1L			;get VIA1/T1 count byte low
	PLA				;restore IER bitmap
	STA D1IER			; and save it
	JSR SSEND			;send RS232 char

WARMEOI				
	JMP EOI				;end of interrupt

WARM2					;RS232 receive NMI routine
	TXA				;restore IFR mask from above
	AND #%00100000			;$20 VIA1/T2 time-out (done receiving
					; character from RS232)?
	BEQ WARM3			;$FF2C yes, move byte to buffer

					; collect bits...
	LDA D1ORB			;get user port bitmap
	AND #%00000001			;$01 bit0=RS232/RX
	STA INBIT			;save received bit
	LDA D1TM2L			;get VIA1/T2L count
	SBC #$16			; subtract 22d
	ADC BAUDOF			; add low word of bit transmit time
	STA D1TM2L			; save it
	LDA D1TM2L+1			;get VIA1/T2H count
	ADC BAUDOF+1			; add high word of bit xmit time
	STA D1TM2L+1			; save it
	PLA				;restore old IFR bitmap
	STA D1IER			; and save it
	JSR SERRX			;signal RS232 receive routine
	JMP EOI				;end of interrupt

WARM3					; received new character, so buffer it
	TXA
	AND #%00010000			;$10 CB1 interrupt (RX data bit transition)
	BEQ EOI				;no bit, exit

	LDA M51CTR			;RS232 control register
	AND #%00001111			;$0F pass the baud rate param only
	BNE $+2				;$FF38 I/O delay

	ASL A				;shift left
	TAX				;save shifted baud rate bitmask and
					; use as an index into a data table
					; with the receive timer values
	LDA R232TB-2,X			;$FF5A,X index into divisor data table
	STA D1TM2L			; save divisor into the VIA
	LDA R232TB-1,X			;$FF5B,X
	STA D1TM2L+1			

	LDA D1ORB			;read RS232 output register
	PLA				;restore IFR bitmap
	ORA #%00100000			;$20 T2 interrupt flag
	AND #%11101111			;$EF pass only T2 flag and not T1
	STA D1IER			;save new interrupt bitmap
	LDX BITNUM			;get total number of bits to TX/RX
	STX BITCI			;save as receiver bit count
;				
; EOI - End of Interrupt external entry point				
;				
EOI				
	PLA				;restore registers
	TAY			
	PLA			
	TAX			
	PLA			
	RTI				;return from interrupt


;====================================================================				
; 232TBL - Baud rate tables				
;				
R232TB				
	.db $92, $27			;50 baud
	.db $40, $1A			;75 baud
	.db $C6, $11			;110 baud
	.db $74, $0E			;134.5 baud
	.db $EE, $0C 			;150 baud
	.db $45, $06			;300 baud
	.db $F1, $02			;600 baud
	.db $46, $01			;1200 baud
	.db $B8, $00			;1800 baud
	.db $71, $00			;2400 baud
	.db $2A, $00			;4800 baud (??)

;====================================================================				
; IRQ - IRQ transfer point				
;====================================================================				
IRQ				
	PHA				;save registers
	TXA			
	PHA			
	TYA			
	PHA			
	TSX				
	LDA FBUFFR+4,X			;$0104,X look in status
					; register to see if BRK
					; flag is set.	
	AND #%00010000			;$10	breakpoint or IRQ
	BEQ BRKSKIP			;$FF82 IRQ, branch	

	JMP (BRKVP)			;jump to breakpoint $FED2
					; which is WARMST

BRKSKIP					
	JMP (IRQVP)			;jump to IRQ $EABF

;====================================================================					
; - Vector table					
;					
 					
					;$ff85	
	.dw $FFFF			;sentinal (KERNAL version??)
	.db $FF				;unused JMP
	.dw $FFFF			;unused vector
	JMP IRESTR			;$FD52 RESTOR
	JMP IVECTR			;$FD57 VECTOR
	JMP ISETMS			;$FE66 SETMSG
	JMP ISECND			;$EEC0 SECND
	JMP ITKSA			;$EECE
	JMP IMEMTP			;$FE73
	JMP IMEMBT			;$FE82
	JMP ISCNKY			;$EB1E
	JMP ISETTO			;$FE6F SETTMO
	JMP IACPTR			;$EF19 ACPTR
	JMP ICIOUT			;$EEE4
	JMP IUNTLK			;$EEF6
	JMP IUNLSN			;$EF04
	JMP ILISTN			;$EE17
	JMP ITALK			;$EE14
	JMP IRDST			;$FE57 READST
	JMP ISETLF			;$FE50 SETLFS
	JMP ISETNM			;$FE49
	JMP (OPENVP)			;$F40A OPEN
	JMP (CLOSVP)			;$F34A CLOSE
	JMP (CKINVP)			;$F2C7 CHKIN
	JMP (CKOTVP)			;$F309 CHKOUT
	JMP (CLCHVP)			;$F3F3 CLRCH
	JMP (CHINVP)			;$F20E CHRIN
	JMP (CHOTVP)			;$F27A CHROUT
	JMP ILOAD			;$F542
	JMP ISAVE			;$F675
	JMP ISETTM			;$F767 SETTIM
	JMP IRDTIM			;$F760
	JMP (STOPVP)			;$F770 STOP
	JMP (GTINVP)			;$F1F5 GETIN
	JMP (CLALVP)			;$F3EF CLALL
	JMP IUDTIM			;$F734
	JMP ISCREN			;$E505
	JMP IPLOT			;$E50A
	JMP IIOBASE			;$E500
	.db $FF				;unused JMP
	.dw $FFFF			;unused vector
	.db $FF				;sentinal (kernal version number??)

;====================================================================				
; - Power-on Vectors				
;				
	.dw NMI				;$FEA9
	.dw RESET			;$FD22
	.dw IRQ				;$FF72

.end				

				
