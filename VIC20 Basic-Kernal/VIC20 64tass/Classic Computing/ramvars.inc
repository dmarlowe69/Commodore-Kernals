;========================================================================================
;	VIC-20 System Variable Equates no KERNEL definitions
;	(c) 1996-1997 Richard A. Cini, Jr. All Rights Reserved.
;
;	Portions of this have been derived from a file in comp.sys.cbm dated 9/1/94.
;	File was restructured to be used as part of an <#INCLUDE> assembler directive.
;	Undefined symbols from the comp.sys.cbm doc were created; others cleaned-up.
;	Variable locations were cross-referenced against other sources and a
;	disassembly of the KERNEL ROM for correctness.
;
;	Zero-page and Page 1 variable names partially derived from various PET books,
;	specifically for those locations that have similar functionality in both the
;	VIC and the PET. Other variable names are self-derived.
;
;
;  Release History:
;  ================
;  1996/12/13	0.10	First release to CBMAPPS (sort of public beta)
;  1996/12/19	0.12	Corrected calling tree notes on transfer vectors. Also began
;				work on system variables, and reworked KERNEL API.
;  1996/12/23	0.20	Began work on page 0 and 1 variables.
;  1996/12/31	0.99	Completed initial work. Still need to insert descriptions.
;  1997/02/14	1.01	Inserted descriptions; changed some variable names
;  1997/03/19	1.03	Added informational message equates
;  1997/11/06	1.20	Converted RAM locations to .DSEG
;
;========================================================================================

A0BASE =$A000		;Autostart ROM base

;========================================================================================
;  Kernel Informational Messages Equates
;
KIM_IOER =$00
KIM_SRCH =$0C
KIM_PLAY =$1B
KIM_RECP =$2E
KIM_LOAD =$49
KIM_SAVE =$51
KIM_VERF =$59
KIM_FOUN =$63
KIM_OK   =$6A

;========================================================================================
;  Commodore Public Kernel API
;
ACPTR  =$FFA5		;Receive From Serial Bus
BREAK  =$FED2		;Break vector handler
CHKIN  =$FFC6		;Set Input Device
CHKOUT =$FFC9		;Set Output Device
CHRIN  =$FFCF		;Input a byte
CHROUT =$FFD2		;Output One Character
CIOUT  =$FFA8		;Send Serial Deferred
CLALL  =$FFE7		;Abort All Files
CLOSE  =$FFC3		;Close File
CLRCH  =$FFCC		;Restore Default I/O
GETIN  =$FFE4		;Get a byte
IOBASE =$FFF3		;Return I/O Base Address
LISTN  =$FFB1		;Send LISTEN Command on Serial Bus	
LOAD   =$FFD5		;Load RAM From Device (flows to ILINKL)
MEMBOT =$FF9C		;Set / Read Bottom of Memory
MEMTOP =$FF99		;Set / Read Top of Memory
OPEN   =$FFC0		;Open File
PLOT   =$FFF0
RDTIM  =$FFDE		;Read Real-Time Clock
READST =$FFB7		;Get I/O Status Word
RESTOR =$FF8A		;Restore Kernel Vectors (at $0314)
SAVE   =$FFD8		;Save RAM To Device (flows to ILINKS)
SCNKEY =$FF9F		;Scan keyboard
SCREEN =$FFED
SECND  =$FF93		;Send LISTEN Secondary Address
SETLFS =$FFBA		;Set Logical File Parameters
SETMSG =$FF90		;Control OS Messages
SETNAM =$FFBD		;Set Filename
SETTIM =$FFDB		;Set Real-Time Clock
SETTMO =$FFA2		;Set IEEE Timeout
STOP   =$FFE1		;Check STOP Key
TALK   =$FFB4		;Send TALK Command on Serial Bus	
TKSA   =$FF96		;Send TALK Secondary Address
UDTIM  =$FFEA		;Increment Real-Time Clock
UNLSN  =$FFAE		;Send UNLISTEN on Serial Bus
UNTLK  =$FFAB		;Send UNTALK on Serial Bus
USER   =$FED2		;User vector
VECTOR =$FF8D		;Change Vectors For User


;########################################################################################
;  Commodore Internal BASIC and KERNEL ROM Equates
;     DO NOT include the below lines if actually recompiling the BASIC/KERNEL ROMS
;     otherwise the compiler will choke on duplicate labels!!
;########################################################################################

;========================================================================================
;  Commodore BASIC ROM API
;
;
BENTER =$c000		;Basic Restart Vectors
BPANIC =$c002		;Basic PANIC entry
BASSIG =$c004		;'cbmbasic'
STMDSP =$c00c		;BASIC Command Vectors
FUNDSP =$c052		;BASIC Function Vectors
OPTAB  =$c080		;BASIC Operator Vectors
RESLST =$c09e		;BASIC Command Keyword Table
MSCLST =$c129		;BASIC Misc. Keyword Table
OPLIST =$c140		;BASIC Operator Keyword Table
FUNLST =$c14d		;BASIC Function Keyword Table
ERRTAB =$c19e		;Error Message Table
ERRPTR =$c328		;Error Message Pointers
OKK    =$c364		;Misc. Messages
			;c364	;'<cr>ok<cr>'
			;c369	;'error'
UNUSE1 =$c389		;Unused byte
FNDFOR =$c38a		;Find FOR/GOSUB Entry on Stack
BLTU   =$c3b8		;Open Space in Memory
GETSTK =$c3fb		;Check Stack Depth
REASON =$c408		;Check Memory Overlap
OMERR  =$c435		;Output "?OUT OF MEMORY Error"
ERROR  =$c437		;Error Routine
ERRFIN =$c469		;Break Entry
READY  =$c474		;BASIC ready entry
MAIN   =$c480		;Input & Identify BASIC Line
MAIN1  =$c49c		;Get Line Number & Tokenise Text
INSLIN =$c4a2		;Insert BASIC Text
LNKPRG =$c533		;Rechain Lines
INLIN  =$c560		;Input Line Into Buffer
CRNCH  =$c579		;Tokenize Input Buffer
FNDLIN =$c613		;Search for Line Number
SCRTCH =$c642		;Perform [new]
SCRTCH1 =$c644		;
CLEAR  =$c65e		;Perform [clr]
CLEAR1 =$c677		;
CLEAR2 =$c67a		;
STXPT  =$c68e		;Reset TXTPTR
LIST   =$c69c		;Perform [list]
QPLOP  =$c717		;Handle LIST 
FOR    =$c742		;Perform [for]
NEWSTT =$c7ae		;BASIC Warm Start
CKEOL  =$c7c4		;Check End of Program
GONE   =$c7e1		;Prepare to execute statement
GONE3  =$c7ed		;Perform BASIC Keyword
RESTR  =$c81d		;Perform [restore]
BSTOP  =$c82c		;Perform [stop], [end], break
CONT   =$c857		;Perform [cont]
RUN    =$c871		;Perform [run]
GOSUB  =$c883		;Perform [gosub]
GOTO   =$c8a0		;Perform [goto]
RETURN =$c8d2		;Perform [return]
DATA   =$c8f8		;Perform [data]
DATAN  =$c906		;Search for Next Statement / Line
IF     =$c928		;Perform [if]
REM    =$c93b		;Perform [rem]
ONGOTO =$c94b		;Perform [on]
LINGET =$c96b		;Fetch linnum From BASIC
LET    =$c9a5		;Perform [let]
PUTINT =$c9c4		;Assign Integer
PTFLPT =$c9d6		;Assign Floating Point
PUTSTR =$c9d9		;Assign String
PUTTIM =$c9e3		;Assign TI$
GETSPT =$ca2c		;Add Digit to FAC#1
PRINTN =$ca80		;Perform [print#]
CMD    =$ca86		;Perform [cmd]
STRDON =$ca9a		;Print String From Memory
PRINT  =$caa0		;Perform [print]
VAROP  =$cab8		;Output Variable	
CRDO   =$cad7		;Output CR/LF	
COMPRT =$cae8		;Handle comma, TAB(, SPC(
STROUT =$cb1e		;Output String	
OUTSPC =$cb3b		;Output Format Character	
DOAGIN =$cb4d		;Handle Bad Data	
GET    =$cb7b		;Perform [get]	
INPUTN =$cba5		;Perform [input#]	
INPUT  =$cbbf		;Perform [input]	
BUFFUL =$cbea		;Read Input Buffer	
QINLIN =$cbf9		;Do Input Prompt	
READ   =$cc06		;Perform [read]	
RDGET  =$cc35		;General Purpose Read Routine	
EXINT  =$ccfc		;Input Error Messages
			;ccfc	'?EXTRA IGNORED<CR>'	
			;cd0c	'?REDO FROM START<CR>'	
NEXT   =$cd1e		;Perform [next]
DONEXT =$cd61		;Check Valid Loop
FRMNUM =$cd8a		;Confirm Result
FRMEVL =$cd9e		;Evaluate Expression in Text
EVAL   =$ce83		;Evaluate Single Term
PIVAL  =$cea8		;Constant - pi
QDOT   =$cead		;Continue Expression
PARCHK =$cef1		;Expression in Brackets
CHKCLS =$cef7		;Confirm Character
CHKPNC =$cef7		;test ')'
CHKPNO =$cefa		;test '('
CHKCOM =$cefd		;test comma
SNERR  =$cf08		;Output "?SYNTAX Error"
DOMIN  =$cf0d		;Set up NOT Function
RSVVAR =$cf14		;Identify Reserved Variable
ISVAR  =$cf28		;Search for Variable	
TISASC =$cf48		;Convert TI to ASCII String	
ISFUN  =$cfa7		;Identify Function Type	
STRFUN =$cfb1		;Evaluate String Function	
NUMFUN =$cfd1		;Evaluate Numeric Function	
OROP   =$cfe6		;Perform [or], [and]"	
DOREL  =$d016		;Perform <, =, >	
NUMREL =$d01b		;Numeric Comparison	
STRREL =$d02e		;String Comparison	
DIM    =$d07e		;Perform [dim]	
PTRGET =$d08b		;Identify Variable	
ORDVAR =$d0e7		;Locate Ordinary Variable	
NOTFNS =$d11d		;Create New Variable	
NOTEVL =$d128		;Create Variable	
ARYGET =$d194		;Allocate Array Pointer Space	
N32768 =$d1a5		;Constant 32768 in Flpt	DATA
FACINX =$d1aa		;FAC#1 to Integer in (AC/YR)
INTIDX =$d1b2		;Evaluate Text for Integer
AYINT  =$d1bf		;FAC#1 to Positive Integer
ISARY  =$d1d1		;Get Array Parameters
FNDARY =$d218		;Find Array
BSERR  =$d245		;"?Bad subscript error"
FCERR  =$d248		;"?Illegal quantity error"
NOTFDD =$d261		;Create Array
INLPN2 =$d30e		;Locate Element in Array
UMULT  =$d34c		;Number of Bytes in Subscript
FRE    =$d37d		;Perform [fre]
GIVAYF =$d391		;Convert Integer in (AC/YR) to Flpt
POS    =$d39e		;Perform [pos]
ERRDIR =$d3a6		;Confirm Program Mode
GETFNM =$d3e1		;Check Syntax of FN
FNDOER =$d3f4		;Perform [fn]
STRD   =$d465		;Perform [str$]
STRLIT =$d487		;Setup String
PUTNW1 =$d4d5		;Save String Descriptor
GETSPA =$d4f4		;Allocate Space for String
GARBAG =$d526		;Garbage Collection
DVARS  =$d5bd		;Search for Next String
GRBPAS =$d606		;Collect a String
CAT    =$d63d		;Concatenate Two Strings
MOVINS =$d67a		;Store String in High RAM
FRESTR =$d6a3		;Perform String Housekeeping
FREFAC =$d6db		;Clean Descriptor Stack
CHRD   =$d6ec		;Perform [chr$]
LEFTD  =$d700		;Perform [left$]
RIGHTD =$d72c		;Perform [right$]
MIDD   =$d737		;Perform [mid$]
PREAM  =$d761		;Pull sTring Parameters
LEN    =$d77c		;Perform [len]
LEN1   =$d782		;Exit String Mode
ASC    =$d78b		;Perform [asc]
GETBYT =$d79b		;Evaluate Text to 1 Byte in XR
VAL    =$d7ad		;Perform [val]
STRVAL =$d7b5		;Convert ASCII String to Flpt
GETNUM =$d7eb		;Get parameters for POKE/WAIT
GETADR =$d7f7		;Convert FAC#1 to Integer in LINNUM
PEEK   =$d80d		;Perform [peek]
POKE   =$d824		;Perform [poke]
WAIT   =$d82d		;Perform [wait]
FADDH  =$d849		;Add 0.5 to FAC#1
FSUB   =$d850		;Perform Subtraction
FADD5  =$d862		;Normalize Addition
FADD   =$d867		;Perform Addition
NEGFAC =$d947		;2's Complement FAC#1
OVERR  =$d97e		;"?OVERFLOW Error"
MULSHF =$d983		;Multiply by Zero Byte
FONE   =$d9bc		;Table of Flpt Constants
LOG    =$d9ea		;Perform [log]
FMULT  =$da28		;Perform Multiply
MULPLY =$da59		;Multiply by a Byte
CONUPK =$da8c		;Load FAC#2 From Memory
MULDIV =$dab7		;Test Both Accumulators
MLDVEX =$dad4		;Overflow / Underflow
MUL10  =$dae2		;Multiply FAC#1 by 10
TENC   =$daf9		;Constant 10 in Flpt
DIV10  =$dafe		;Divide FAC#1 by 10
FDIV   =$db07		;Divide FAC#2 by Flpt at (AC/YR)
FDIVT  =$db0f		;Divide FAC#2 by FAC#1
MOVFM  =$dba2		;Load FAC#1 From Memory
MOV2F  =$dbc7		;Store FAC#1 in Memory
MOVFA  =$dbfc		;Copy FAC#2 into FAC#1	
MOVAF  =$dc0c		;Copy FAC#1 into FAC#2	
ROUND  =$dc1b		;Round FAC#1	
SIGN   =$dc2b		;Check Sign of FAC#1	
SGN    =$dc39		;Perform [sgn]	
ABS    =$dc58		;Perform [abs]	
FCOMP  =$dc5b		;Compare FAC#1 With Memory	
QINT   =$dc9b		;Convert FAC#1 to Integer	
INT    =$dccc		;Perform [int]	
FIN    =$dcf3		;Convert ASCII String to a Number in FAC#1	
N0999  =$ddb3		;String Conversion Constants
INPRT  =$ddc2		;Output 'IN ' + Line Number
INPRT1 =$ddcd		;print BASIC line number	
FOUT   =$dddd		;Convert FAC#1 to ASCII String	
FOUTIM =$de68		;Convert TI to String	
FHALF  =$df11		;Table of Constants	
SQR    =$df71		;Perform [sqr]	
FPWRT  =$df7b		;Perform power ($)
NEGOP  =$dfb4		;Negate FAC#1
LOGEB2 =$dfbf		;Table of Constants
EXP    =$dfed		;Perform [exp]

VV9002 = $9002
VV9005 = $9005
VV9110 = $9110
VV9111 = $9111
VV9112 = $9112
VV9113 = $9113
VV9114 = $9114
VV9118 = $9118
VV9119 = $9119
VV911B = $911B
VV911C = $911C
VV911D = $911D
VV911E = $911E
VV911F = $911F
VV9120 = $9120
VV9121 = $9121

VV9122	= $9122		; VIA 2 DDRB
VV9123	= $9123		; VIA 2 DDRA
VV9124	= $9124		; VIA 2 T1C_l
VV9125	= $9125		; VIA 2 T1C_h
VV9128	= $9128		; VIA 2 T2C_l
VV9129	= $9129		; VIA 2 T2C_h
VV912B	= $912B		; VIA 2 ACR
VV912C	= $912C		; VIA 2 PCR

VV912D = $912D
VV912E = $912E
VV912F = $912F
