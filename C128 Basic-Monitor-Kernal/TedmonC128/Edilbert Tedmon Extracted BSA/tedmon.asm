; **********************************
; The Commodore 128 operating system
; **********************************

; ASCII/PETSCII control codes

C_ULINE = $02  ; Underline On
LF      = $0a  ; Line Feed
CR      = $0d  ; Carriage Return
BLINK   = $0f  ; Blinking On
DOWN    = $11  ; Cursor Down
REVERSE = $12  ; Reverse Printing
HOME    = $13  ; Cursor Home
DEL     = $14  ; Delete
ESC     = $1b  ; Escape
RIGHT   = $1d  ; Cursor Right
QUOTE   = $22  ; String Delimiter
APOSTR  = $27  ; Apostroph
UP      = $91  ; Cursor Up
PICHAR  = $ff  ; BASIC Real_PI character

; The address range $000 - $03ff is common RAM by default
; These locations are accessible from all banks

; CPU register

D8502   = $00  ; CPU 8502 register
R8502   = $01  ; CPU 8502 register

; Zero page variables and pointers

BANK    = $02  ; Bank configuration

; save CPU registers for monitor and sys calls

PC_HI   = $03
PC_LO   = $04
S_REG   = $05
A_REG   = $06
X_REG   = $07
Y_REG   = $08
CHARAC  = $09

; The cursor column position prior to the TAB or SPC is moved here from
; $XX, and is used to calculate where the cursor ends up after one of
; these functions is invoked. Note that the value contained here shows
; the position of the cursor on a logical line. Since one logical line
; can be two physical lines long, the value stored here can range from
; 0 to 79.

ENDCHR  = $0a       ; scan quotes flag
TRMPOS  = $0b       ; TAB column save
B_VERCK = $0c       ; BASIC load/verify flag, 0 = load, 1 = verify

; The routine that converts the text in the input buffer into lines of
; executable program tokens, and the routines that link these program
; lines together, use this location as an index into the input buffer
; area. After the job of converting text to tokens is done, the value
; in this location is equal to the length of the tokenized line.
; The routines which build an array or locate an element in an array use
; this location to calculate the number of DIMensions called for and the
;  amount of storage required for a newly created array, or the number
; of subscripts when referencing an array element.

B_COUNT = $0d       ; BASIC line crunch/array access/logic operators

; This is used as a flag by the routines that build an array or
; reference an existing array. It is used to determine whether a
; variable is in an array, whether the array has already been
; DIMensioned, and whether a new array should assume default size 10.

DIMFLG  = $0e       ; DIM flag

; This flag is used to indicate whether data being operated upon is
; string or numeric. A value of $FF in this location indicates string
; data while a $00 indicates numeric data.

VALTYP  = $0f       ; data type flag, $FF = string, $00 = numeric

; If the above flag indicates numeric then a $80 in this location
; identifies the number as an integer, and a $00 indicates a floating
; point number.

INTFLG  = $10

; The garbage collection routine uses this location as a flag to
; indicate that garbage collection has already been tried before adding
; a new string. If there is still not enough memory, an OUT OF MEMORY
; error message will result.

; LIST uses this byte as a flag to let it know when it has come to a
; character string in quotes. It will then print the string,rather than
; search it for BASIC keyword tokens.

; This location is also used during the process of converting a line of
; text in the BASIC input buffer into a linked program line of BASIC
; keyword tokens to flag a DATA line is being processed.

GARBFL  = $11

; This flag is set from the routines handling FOR, DEF and FN
; statements. Names for loop indices and function names must not be
; integer. Only identifiers of type real are allowed.

SUBFLG  = $12

 ; input mode, $00 = INPUT, $40 = GET, $98 = READ

INPFLG  = $13

; This location is used to determine whether the sign of the value
; returned by the functions SIN, COS, ATN or TAN is positive or negative
; Also the comparison routines use this location to indicate the outcome
; of the compare. For A <=> B the value here will be $01 if A > B,
; $02 if A = B, and $04 if A < B. If more than one comparison operator
; was used to compare the two variables then the value here will be a
; combination of the above values.

TANSGN  = $14       ; ATN sign/comparison evaluation flag

; When the default input or output device is used the value here will
; be a zero, and the format of prompting and output will be the standard
; screen output format. The location $$$ is used to decide what device
; actually to put input from or output to.

CHANNL  = $15

; Used whenever a 16 bit unsigned integer is used e.g. the target line
; number for GOTO, LIST, ON, and GOSUB also the number of a BASIC line
; that is to be added or replaced. additionally PEEK, POKE, WAIT, and
; SYS use this location as a pointer to the address which is the subject
; of the command.

LINNUM  = $16       ; WORD: line number

; This location points to the next available slot in the temporary
; string descriptor stack located at TEMPST ($16-$1e).

TEMPPT  = $18       ; descriptor stack pointer, next free

; This contains information about temporary strings which have not yet
; been assigned to a string variable.

LASTPT  = $19       ; current descriptor stack item pointer

; Stack for temporary string descriptors
; String 1: $1b-$1d
; String 2: $1e-$20
; String 3: $21-$1e

TEMPST  = $1b       ; (9 bytes): temporary descriptor stack

; miscellaneous pointer / word used in many BASIC routines
; the subroutine Get_INDEXA_1 is used to read bank 1 values
; pointed to by INDEXA

INDEXA  = $24       ; WORD: miscellaneous pointer

; miscellaneous pointer / word used in many BASIC routines
; the subroutine Get_INDEXB_0 is used to read bank 0 values
; pointed to by INDEXB

INDEXB  = $26       ; WORD: miscellaneous pointer

; Floating point accumulator #3 (mantissa only)

FAC3_M1 = $28
FAC3_M2 = $29
FAC3_M3 = $2a
FAC3_M4 = $2b

;       = $2c       ; FREE

; Start of BASIC program in bank 0 : initialized to $1c01

TXTTAB  = $2d       ; WORD: Text Table

; Start of variable storage in bank 1 : initialized tp $0400

VARTAB  = $2f       ; WORD: Variable Table

; Start of array storage in bank 1 (and top of variable storage)

ARYTAB  = $31       ; WORD: Array Table

; Top of arrays and lower boundary of free RAM in bank 1

STREND  = $33       ; WORD: String End

; top of free memory in bank 1, initilaized to MEMSIZ

FRETOP  = $35       ; WORD: Free Top of memory

; bottom of string space in bank 1

FRESPC  = $37       ; WORD: Free Space

; top of BASIC memory in bank 1, initialized to $ff00

MEMSIZ  = $39       ; WORD: Memory Size

; These locations contain the line number of the BASIC statement which
; is currently being executed. A value of $FF in location CURLIN+1
; means that BASIC is in immediate mode.

CURLIN  = $3b       ; WORD: Current Line

; TXTPTR is used from the CHRGET (with increment) and CHRGOT
; (no increment) routine, to read the next byte and test it
; for being numeric, colon (:) or zero.

TXTPTR  = $3d       ; WORD: Text Pointer

; FNDPNT is used mainly by subroutines, that use the BASIC stack
; e.g. FOR, NEXT, DO, LOOP, GOSUB and RETURN routines.

FNDPNT  = $3f       ; WORD: Find Pointer

; These locations hold the line number of the current DATA statement
; being READ. These values are defined but never used

DATLIN  = $41       ; WORD: Data Line

; These locations point to the address where the next DATA will be READ
; from. RESTORE sets this pointer back to the line indicated.

DATPTR  = $43       ; WORD: Data Pointer

; READ, INPUT and GET all use this as a pointer to the address of the
; source of incoming data, such as DATA statements, or the text input
; buffer.

INPPTR  = $45       ; WORD: Input Pointer

; Two bytes storing the name of a BASIC variable as ASCII values
; The combination of the two bits 7 determines the type
; ---------------------------------------------
; Real    : AB      = $41 $42 = 'A'     'B'
; Function: FNAB()  = $c1 $42 = 'A'+$80 'B'
; String  : AB$     = $41 $c2 = 'A'     'B'+$80
; Integer : AB%     = $c1 $c2 = 'A'+$80 'B'+$80

VARNAM  = $47       ; WORD: Variable Name

; These locations point to the value of the current BASIC variable.
; Specifically they point to the byte just after the two-character
; variable name.

VARPNT  = $49       ; WORD: Variable Pointer

; The address of the BASIC variable which is the subject of a FOR/NEXT
; loop is first stored here before being pushed onto the stack.
; It is also used in many other routines as temporary pointer.

FORPNT  = $4b       ; WORD: FOR Pointer

; VARTXT is used as temporary storage of the TXTPTR nad also for other
; temporary values.

VARTXT  = $4d       ; WORD: Variable Text Pointer

; Used as temporary storage from operator routines

OP_TMP  = $4f       ; Operator Temporary storage

; Named for its use in the garbage collection routine, which reorders
; string space. Despite its name this pointer is also used in many
; other routines as auxiliary pointer.

GRBPNT  = $50       ; WORD: Garbage collection Pointer

; A multi purpose pointer mainly used as descriptor pointer

DSCPNT  = $52       ; WORD: Descriptor Pointer

;         $54       ; FREE

; This flag helps the LIST routines to know wether they are called
; by the LIST command or by the HELP command

HELPER  = $55

; The first byte contains permanent the code $4c for the JMP instruction.
; The two byte after it are modified by the function handling routine.
; After writing a target address to JUMPER+1 and JUMPER+2 a
; JSR JUMPER is used to call the function.

JUMPER  = $56       ; 3 BYTES: JMP nnnn

; Temporary storage for math routines.
; This address overlaps with JUMPER+2 !

OLDOV   = $58       ; Old Operator Value

; The address range $59 - $62 is saved and restored en block
; in the subroutine Check_Mem_Avail !

; Temporary storage for floating point values (5 bytes)
; and temporary pointer (block pointer, array pointer)

FACTPA  = $59       ; 5 BYTES: Temporary Floating Point Accumulator A

; multi purpose pointer, named after its use in array handling routines
; The address overlaps with FACTPA+1 and FACTPA+2

ARYPNT  = $5a       ; WORD: Array Pointer

; Frequently used multi purpose pointer.
; It has its own fetch routines for access to bank 0 and bank1
; named Get_HIGHTR_0 and Get_HIGHTR_1.
; The address overlaps with FACTPA+3 and FACTPA+4

HIGHTR  = $5c       ; WORD:

DESCA   = $5d       ; 3 bytes for temporary descriptor

; Occasionally the address range $5e - $68 (FACTPB and FAC1)
; is used for copy operations in one loop !

; Temporary storage for floating point values (5 bytes)
; and temporary pointer (block pointer, array pointer)

FACTPB   = $5e      ; 5 BYTES: Temporary Floating Point Accumulator B
TMPVAR   = $5f      ; temporary variable
TENEXP   = $60      ; 10th's exponent
LOWTR    = $61      ; temporaray pointer

M_Aval = $60      ; 3 BYTES (address + bank) used in monitor
M_Bval = $63      ; 3 BYTES (address + bank) used in monitor
M_Cval = $66      ; 3 BYTES (address + bank) used in monitor

; Floating point accumulator 1

FAC1_EX  = $63      ; FAC1 exponent
FAC1_M1  = $64      ; FAC1 mantissa 1
FAC1_M2  = $65      ; FAC1 mantissa 2
FAC1_M3  = $66      ; FAC1 mantissa 3
FAC1_M4  = $67      ; FAC1 mantissa 4
FAC1_SI  = $68      ; FAC1 sign

DEGREE   = $69

; Floating point accumulator 2

FAC2_EX  = $6a
FAC2_M1  = $6b
FAC2_M2  = $6c
FAC2_M3  = $6d
FAC2_M4  = $6e
FAC2_SI  = $6f

; String pointer and FAC sign comparison and FAC rounding

STRPTR  = $70       ; string pointer & FAC variables

; this address is sometimes used as high btye for the STRPTR
; and as rounding byte (5th. byte of mantissa) for FAC1

FROUND  = $71       ; FAC1 mantissa 5 = rounding byte

; Temporary pointers and indices used in many BASIC routines

STRNG2  = $72       ; temp BASIC execute/array pointer low byte/index
AUTINC  = $74       ; WORD: auto increment value (0 = OFF)
MVDFLG  = $76       ; (graphics) memory reserved flag
TEMP_A  = $77       ; temporary byte value
KEYSIZ  = $78       ; string length and counter
SYNTMP  = $79       ; short term temporary value
DS_LEN  = $7a       ; length  of DS$ (disk status)
DS_ADR  = $7b       ; address of DS$ (disk status)

TOS     = $7d       ; Top Of Basic Stack
RUNMOD  = $7f       ; $80 = RUN [line], $40 = RUN <filename>, $00 = direct

; DOSFLA flags for parsing BASIC 4 DOS commands

; bit 0: $01 = source Filename given
; bit 1: $02 = target Filename given       : start address
; bit 2: $04 = logical address set in LA   : end   address
; bit 3: $08 = primary address set in FA
; bit 4: $10 = source drive set
; bit 5: $20 = target drive set
; bit 6: $40 = W (Write) or L (record)     : bank
; bit 7: $80 = Save and replace flag '@'

DOSFLA  = $80       ; DOS flags A

; DOSFLB flags for parsing BLOAD/BSAVE arguments

; bit 0: $01 = bank given
; bit 1: $02 = BLOAD/BSAVE start address
; bit 2: $04 = BSAVE end address

DOSFLB  = $81       ; DOS flags B

OLDSTK  = $82       ; save stack pointer

; color modes

COLSEL  = $83       ; color selected
MULCO1  = $84       ; multi color 1
MULCO2  = $85       ; multi color 2
FG_COL  = $86       ; foreground color
SCALE_X = $87       ; graphics scale X
SCALE_Y = $89       ; graphics scale Y
STOPNB  = $8b       ; PAINT comparison byte

GRAPNT  = $8c       ; Graphics Pointer
VTEMPA  = $8e       ; Temporaray pointer

; The STATUS byte is used to flag I/O errors or End-Of-Information
; A bit set to 1 indicates foloowing conditions:

; bit 0 : time out write
; bit 1 : time out read
; bit 2 : short block (tape)
; bit 3 : long  block (tape)
; bit 4 : verify error
; bit 5 : checksum error (tape)
; bit 6 : EOI (End Of Information)
; bit 7 : device not present

STATUS  = $90

STKEY   = $91       ; STOP key flag
SVXT    = $92       ; tape timer
K_VERCK = $93       ; verify flag and monitor variable

C3PO    = $94       ; serial buffer flag
BSOUR   = $95       ; serial output buffer

SYNO    = $96       ; tape sync
XSAV    = $97       ; save X register

; The number of currently open I/O files is stored here. The maximum
; number that can be open at one time is ten. The number stored here is
; used as the index to the end of the tables that hold the file numbers,
; device numbers, and secondary addresses.

LDTND   = $98       ; open file count

; The default value of this location is 0.

DFLTN   = $99       ; input device number

; number   device
; ------   ------
;  0      keyboard
;  1      cassette 1
;  2      serial RS232
;  3      screen (default)
;  4-31   serial IEC bus

DFLTO   = $9a       ; output device number


PRTY    = $9b       ; tape parity byte
DPSW    = $9c       ; tape dipole switch

MSGFLG  = $9d       ; kernal message flag
PTR_LO  = $9e       ; pointer 1
PTR_HI  = $9f       ; pointer 2

; These three locations form a counter which is updated 50 times a
; second on PAL computers and 60 times a second on NTSC computers.
; It serves as a software clock which counts the number of
; jiffies that have elapsed since the computer was turned on.
; After 24 * 60 * 60 * 60 jiffies, which is one day,
; the jiffy clock is reset to zero.
; On PAL systems an adjustment term is applied every 5th. jiffy.

JIFFY_CLOCK = $a0   ; 3 bytes jiffy clock at 50Hz (PAL) or 60Hz (NTSC)

R2D2    = $a3       ; serial bus
BSOUR1  = $a4       ; serial output buffer
CNTDN   = $a5       ; count down
BUFPT   = $a6       ; tape buffer pointer

RSI_In_Bit = $a7    ; RS232 Input bit
RSI_Count  = $a8    ; RS232 Input bit counter
RSI_Start  = $a9    ; RS232 Input start bit
RSI_Data   = $aa    ; RS232 Input data byte
RSI_Parity = $ab    ; RS232 Input parity

SAL     = $ac       ; Start Address Low
SAH     = $ad       ; Start Address High
EAL     = $ae       ; End   Address Low
EAH     = $af       ; End   Address Hig


CMP0    = $b0       ; tape timer
CMP1    = $b1       ; tape timer

; These two locations point to the address of the tape buffer. This
; pointer is initialized to T_Buffer ($0b00).

TAPE1    = $b2      ; tape buffer pointer
RS_Count = $b4      ; RS232 output character bit counter
RS_Next  = $b5      ; RS232 next bit to transfer
RS_Out   = $b6      ; current RS232 output byte

; primary file descriptor

FNLEN     = $b7     ; filename length
LA        = $b8     ; Local     Address
SA        = $b9     ; Secondary Address
FA        = $ba     ; First     Address (unit)
FNADR     = $bb     ; file name Address
:w
RS_Parity = $bd     ; RS232 Output Parity
FSBLK     = $be     ; tape block counter
DRIVE     = $bf
CAS1      = $c0     ; tape drive motor flag

STAL    = $c1       ; start address low
STAH    = $c2       ; start address high
MEMUSS  = $c3       ; temporary pointer

DATA    = $c5       ; tape data byte
BA      = $c6       ; bank for load/save/verify
FNBANK  = $c7       ; bank for filename

RIBUF   = $c8       ; pointer to RS232 input  buffer
ROBUF   = $ca       ; pointer to ES232 output buffer

KEYTAB  = $cc       ; pointer to keyboard decode table

IMPARM  = $ce       ; used by PRIMM (print immediate) subroutine

NDX     = $d0       ; number of keys buffered
KYNDX   = $d1       ; function key text counter
KEYIDX  = $d2       ; function key text index
SHFLAG  = $d3       ; flag for SHIFT, CONTROL, C=
SFDX    = $d4       ; index of key pressed
LSTX    = $d5       ; index of last key (for repeat)
CRSW    = $d6       ; CRT switch 0 = keyboard input, all else screen
MODE_80 = $d7       ; screen mode $00 = 40 col, $80 = 80 col

GRAPHM  = $d8       ; graphics mode
CHAREN  = $d9       ; character RAM/ROM flag
E_Beg   = $da       ; Screen Editor Start Address
E_End   = $dc       ; Screen Editor End   Address
E_Col   = $de       ; Screen Editor Temporary Variable
E_Row   = $df       ; Screen Editor Temporary Variable

PNT     = $e0       ; Pointer to current text row
USER    = $e2       ; Pointer to text attribute

; window row/column counts start at 0

Margin_Bottom = $e4 ; SCBOT  default = 24
Margin_Top    = $e5 ; SCTOP  default =  0
Margin_Left   = $e6 ; SCLF   default =  0
Margin_Right  = $e7 ; SCRT   default = 39 or 79

CurLst_Row    = $e8 ; LSXP   last cursor row (bit 7 = continuation row)
CurLst_Col    = $e9 ; LSTP   last cursor column
Cursor_End    = $ea ; INDX   Input end column (default = last non blank)

Cursor_Row    = $eb ; TBLX   current cursor row
Cursor_Col    = $ec ; PNTR   current cursor column

LINES   = $ed       ; Screen lines
COLUMNS = $ee       ; Screen columns
DATAX   = $ef       ; Output character
LSTCHR  = $f0       ; Last character
E_Attribute   = $f1 ; Color/Attribute
TCOLOR  = $f2       ; Color/Attribute for Insert
E_Reverse     = $f3 ; Reverse flag
QTSW    = $f4       ; Quote switch
INSRT   = $f5       ; Insert mode
INSFLG  = $f6       ; Automatic insert
LOCKS   = $f7       ; Commodore/Shift lock
Scroll_Locked = $f8 ; Scroll lock
BEEPER  = $f9       ; Beeper mode

STACK   = $0100     ; CPU runtime stack

; The lower part of the stack page is used as temporary storage
; and is therefore unusable for normal stack operations
; The upper four bytes $1fc - $1ff are used by the CRUNCH routine.
; This limits the runtime stack pointer to the range $fb - $37

; DOS Parameter block

; This parameter block is filled in by the DOS_Parser routine
; and used by all disk commands, like COPY, DLOAD, DIRECTORY, etc.

DOS_COUNT   = $0110 ; length of format string
DOS_FNLEN_1 = $0111 ; length of 1st. filename
DOS_DRIVE_1 = $0112 ; drive # 1 (0 for single drive units)
DOS_FNLEN_2 = $0113 ; length of 2nd. filename
DOS_DRIVE_2 = $0114 ; drive # 2 (0 for single drive units)
DOS_FNADR_2 = $0115 ; address of 2nd. filename
DOS_BEG     = $0117 ; start address for BSAVE, BLOAD
DOS_END     = $0119 ; end   address for BSAVE
DOS_LA      = $011b ; Logical   Address for file operations
DOS_FA      = $011c ; First     Address (unit)
DOS_SA      = $011d ; Secondary Address (0 = relocatble LOAD)
DOS_RL      = $011e ; Record Length for REL files
DOS_BANK    = $011f ; Bank for LOAD/SAVE
DOS_ID      = $0120 ; ID (two characters) for HEADER
DOS_UNIT    = $0122 ; 2nd. unit for unit to unit COPY

; Formatted printing

; This parameter block is used by the PRINT USING command

BNR         = $0123 ; begin pointer
ENR         = $0124 ; end   pointer
DOLR        = $0125 ; dollar flag
FLAG        = $0126 ; comma  flag
SWE         = $0127 ; counter
USGN        = $0128 ; exponent sign
UEXP        = $0129 ; exponent pointer
VN          = $012a ; digits before decimal point
CHSN        = $012b ; adjust flag
VF          = $012c ; chars  before decimal point
NF          = $012d ; chars  after  decimal point
POSP        = $012e ; +/- flag position
FESP        = $012f ; exponent flag
ETOF        = $0130 ; switch
CFORM       = $0131 ; counter
SNO         = $0132 ; sign number
BLFD        = $0133 ; space star flag
BEGFD       = $0134 ; begin pointer
LFOR        = $0135 ; length of format string
ENDFD       = $0136 ; end pointer

; Input buffer

; The input buffer is capable to store the contents of two full lines
; in 80 column mode and a terminating zero byte and is therefore 161
; bytes long ($200 - $2a1). The four bytes before the input buffer
; ($1fc - $1ff) are used by the CRUNCH routine to store link address
; and line number just before the line itself. So after crunching the
; area starting at BUF-4 contains the full tokenized BASIC line.
; This is why the stack pointer is initialized with $fb.

BUF         = $0200 ; 161 bytes

; a collection of utilities that are used to access RAM
; from bank 0 or bank 1 by modifying  the address byte of
; the LDA (ADR),Y   STA (ADR),Y   or   CMP (ADR),Y instruction.
; These routines are copied from ROM during startup

; *************
  FETCH = $02a2
; *************
; 02a2 ad 00 ff  LDA MMU_CR ; save old bank value
; 02a5 8e 00 ff  STX MMU_CR ; set new bank from X
; 02a8 aa        TAX        ; copy old value to X
; 02a9 b1 ff     LDA (**),Y ; load A from chosen bank
; 02ab 8e 00 ff  STX MMU_CR ; restore bank value
; 02ae 60        RTS        ; return

; *************
  STASH = $02af
; *************
; 02af 48        PHA        ; save A
; 02b0 ad 00 ff  LDA MMU_CR ; save old bank value
; 02b3 8e 00 ff  STX MMU_CR ; set new bank from X
; 02b6 aa        TAX        ; copy old value to X
; 02b7 68        PLA        ; restore A
; 02b8 91 ff     STA (**),Y ; store A to chosen bank
; 02ba 8e 00 ff  STX MMU_CR ; restore bank value
; 02bd 60        RTS        ; return

; **************
  CMPARE = $02be
; **************
; 02be 48        PHA        ; save A
; 02bf ad 00 ff  LDA MMU_CR ; save old bank value
; 02c2 8e 00 ff  STX MMU_CR ; set new bank from X
; 02c5 aa        TAX        ; copy old value to X
; 02c6 68        PLA        ; restore A
; 02c7 d1 ff     CMP (**),Y ; compare A
; 02ca 8e 00 ff  STX MMU_CR ; restore bank value
; 02cd 60        RTS        ; return

; **************
  JSRFAR = $02cd
; **************
; 02cd 20 e3 02  JSR JMPFAR ; jump to BANK,PC
; 02d0 85 06     STA A_REG  ; save A
; 02d2 86 07     STX X_REG  ; save X
; 02d4 84 08     STY Y_REG  ; save Y
; 02d6 08        PHP
; 02d7 68        PLA
; 02d8 85 05     STA S_REG  ; save SR
; 02da ba        TSX
; 02db 86 09     STX CHARAC ; save SP
; 02dd a9 00     LDA #0
; 02df 8d 00 ff  STA MMU_CR ; default bank
; 02e2 60        RTS        ; return

; **************
  JMPFAR = $02e3
; **************
; 02e3 a2 00     LDX #0       ; for x=0 to 2
; 02e5 b5 03     LDA PC_HI,X  ; push PC and SR
; 02e7 48        PHA
; 02e8 e8        INX
; 02e9 e0 03     CPX #3
; 02eb 90 f8     BCC $02e5    ; -> loop
; 02ed a6 02     LDX BANK     ; # of bank configuration
; 02ef 20 6b ff  JSR K_GETCFG ; get  bank configuration
; 02f2 8d 00 ff  STA MMU_CR   ; set  bank configuration
; 02f5 a5 06     LDA A_REG    ; restore A
; 02f7 a6 07     LDX X_REG    ; restore X
; 02f9 a4 08     LDY Y_REG    ; restore Y
; 02fb 40        RTI          ; restore SR and JUMP to PC

; This vector is used when a BASIC prgram uses the USR() function.
; The vector should point to user defined code.
; It is initialised so that if you try to execute a USR call
; without changing them you will receive an ILLEGAL QUANTITY error.

USRVEC  = $02fc     ; pointer to user defined machine code

; A table of vectors for the most important BASIC routines
; These may be used for interception in order to add new functionality

IERROR  = $0300     ; DEF_ERROR   BASIC error handler
IMAIN   = $0302     ; DEF_MAIN    BASIC main loop
ICRNCH  = $0304     ; DEF_CRUNCH  BASIC tokenizer
IQPLOP  = $0306     ; DEF_QPLOP   BASIC statement lister
IGONE   = $0308     ; DEF_GONE    BASIC interpret statement
IEVAL   = $030a     ; DEF_EVAL    BASIC evaluate expressiom
IESCLK  = $030c     ; DEF_ESCLK
IESCPR  = $030e     ; DEF_ESCPR
IESCEX  = $0310     ; DEF_ESCEX

; A table of vectors for kernal and ML monitor subroutines
; These may be used for interception in order to add new functionality
; Default values are copied from the ROM table vectss at $e073

IIRQ    = $0314     ; IRQ_Normal
IBRK    = $0316     ; Mon_Break
INMI    = $0318     ; NMI_Normal
IOPEN   = $031a     ; OPEN
ICLOSE  = $031c     ; CLOSE
ICHKIN  = $031e     ; CHKIN
ICKOUT  = $0320     ; CKOUT
ICLRCH  = $0322     ; CLRCH
IBASIN  = $0324     ; BASIN
IBSOUT  = $0326     ; BSOUT
ISTOP   = $0328     ; STOP
IGETIN  = $032a     ; GEIIN
ICLALL  = $032c     ; CLALL
EXMON   = $032e     ; Mon_Command
ILOAD   = $0330     ; D_LOADSP
ISAVE   = $0332     ; D_SAVE

; A table of vectors for editor subroutines
; These may be used for interception in order to add new functionality
; Default values are copied from the ROM table Edit_Vectors at $c065

CTLVEC  = $0334     ; Edit_Use_Ctrl
SHFVEC  = $0336     ; Edit_Print_Shifted
ESCVEC  = $0338     ; Edit_Escape_Switch
KEYVEC  = $033a     ; Edit_Use_Scancode
KEYCHK  = $033c     ; Edit_Use_Function_Key

DECODE  = $033e

KEYD    = $034a     ; keyboard buffer 10 bytes
TABMAP  = $0354     ; bitmap for 80 TAB positions (10 bytes)
BITABL  = $035e     ; bitmap for line concatenation flag (4 bytes)

; These three tables hold the address parameters for all open files
; they are 10 bytes long, which is the limit for the number of open files

LAT     = $0362     ; table of logical   addresses
FAT     = $036c     ; table of first     addresses
SAT     = $0376     ; table of secondary addresses

; Basic CHRGET (pre increment) and CHRGOT (no increment) routine
; This routine is copied from ROM ($4279) in Init_BASIC
; It is the main routine to get new bytes from the current program.
; The routine fetches the byte from (TXTPTR) in bank 0 and switches
; back to bank configuration 15 after reading.
; This routine runs in common RAM and is therefore interceptable for
; BASIC interpreter extensions.
; Besides returning the byte value or character in A the flags are set:
; Zero-flag if the value was zero (0) or colon (:) both indicating an
; end of statement condition.
; Carry-flag if char is NOT numeric ('0'..'9')

; **************
  CHRGET = $0380
; **************
; 0380 e6 3d     INC TXTPTR      [5]
; 0382 d0 02     BNE CHRGOT      [2]
; 0384 e6 3e     INC TXTPTR+1    [5]
; **************
  CHRGOT = $0386
; **************
; 0386 8d 01 ff  STA MMU_LCRA    [4] ; bank 0
; 0389 a0 00     LDY #0          [2]
; 038b b1 3d     LDA (TXTPTR),Y  [5] ; load byte
; 038d 8d 03 ff  STA MMU_LCRC    [4] ; bank 15
; **************
  ISNUM = $0390
; **************
; 0390 c9 3a     CMP #':'        [2] ; end-of-statement
; 0392 b0 0a     BCS RET         [2] ; return for chars > '9' with C=1
; 0394 c9 20     CMP #' '        [2]
; 0396 f0 e8     BEQ CHRGET      [2] ; skip blanks
; 0398 38        SEC             [2]
; 0399 e9 30     SBC #'0'        [2] ; test for numeric digits
; 039b 38        SEC             [2]
; 039c e9 d0     SBC #$d0        [2] ; clear carry for chars < '0'
; 039e 60    RET RTS             [6] ; size = 31 [CHRGET]
                                     ; time = 33 - 49

; ***************
  Fetch_0 = $039f
; ***************
; Input : A = address of ZP pointer
;         Y = index to be used
; Output: A = value read from (A),Y in bank 0

; 039f 8d a6 03  STA Fetch_0+7   [4] ; modify ZP address
; 03a2 8d 01 ff  STA MMU_LCRA    [4]
; 03a5 b1 00     LDA (0),Y       [5] ; <-- ZP address modified
; 03a7 8d 03 ff  STA MMU_LCRC    [4] ; back to ROM / RAM bank 0
; 03aa 60        RTS             [6] ; size = 12 [Fetch_0]
                                     ; time = 23

; ***************
  Fetch_1 = $03ab
; ***************
; Input : A = address of ZP pointer
;         Y = index to be used
; Output: A = value read from (A),Y in bank 1

; 03ab 8d a6 03  STA Fetch_1+7       ; modify ZP address
; 03ae 8d 01 ff  STA MMU_LCRB
; 03b1 b1 00     LDA (0),Y           ; <-- ZP address modified
; 03b3 8d 03 ff  STA MMU_LCRD        ; back to ROM / RAM bank 1
; 03b6 60        RTS

; ********************
  Get_INDEXA_1 = $03b7
; ********************
; 03b7 8d 02 ff  STA MMU_LCRB
; 03ba b1 24     LDA (INDEXA),Y
; 03bc 8d 04 ff  STA MMU_LCRD
; 03bf 60        RTS

; ********************
  Get_INDEXB_0 = $03c0
; ********************
; 03c0 8d 01 ff  STA MMU_LCRA
; 03c3 b1 26     LDA (INDEXB),Y
; 03c5 8d 03 ff  STA MMU_LCRC
; 03c8 60        RTS

; **************
  INDTXT = $03c9
; **************
; 03c9 8d 01 ff  STA MMU_LCRA
; 03cc b1 3d     LDA (TXTPTR),Y
; 03ce 8d 03 ff  STA MMU_LCRC
; 03d1 60        RTS

; Whenever a NULL string descriptor is needed this address, pointing
; to three zero bytes, is used. E.g. if a string variable
; without value is created. Also comparisons, wether a descriptor is
; allocated or not is done via comparisons of the descriptor address
; with the address of the NULL descriptor.

NULL_DESC = $03d2   ; These 3 bytes must contain zeroes permanently

; The BASIC command BANK sets this location to the user defined value
; It is used in subsequent calls to LOAD, SAVE, FETCH, STASH, SYS,
; PEEK, POKE  etc.

USER_BANK = $03d5   ; User defined bank configuration

TMPDES    = $03d6   ; space for two temporary address pointer
STR_BANK  = $03da   ; bank for string to be parsed
SAVSIZ    = $03db   ; string descriptor for sprite storage
BITS      = $03df   ; FAC1 overflow
SPRTMP    = $03e0   ; temporary storage for TXTPTR

FG_BG     = $03e2   ; foreground background nibbles combined
FG_MC1    = $03e3   ; foreground multicolor 1

; This routine is copied from ROM_DMA = $f85a

; ***************
  RAM_DMA = $03f0
; ***************
; 03f0 ae 00 ff  LDX MMU_CR
; 03f3 8c 01 df  STY DMA_CMD
; 03f6 8d 00 ff  STA MMU_CR
; 03f9 8e 00 ff  STX MMU_CR
; 03fc 60        RTS


; The default position of the VIC screen RAM used in text mode

VIC_TEXT      = $0400 ; bank 0 : 40 x 25 charcters ($400 - $7e7)
VAR_START     = $0400 ; bank 1 : start of BASIC variable storage

BASIC_STACK   = $0800 ; 512 byte stack for loops and GOSUB calls

RESET_VECTOR  = $0a00 ; used for cold start and monitor exit
DEJAVU        = $0a02 ; a value of $a5 indicates, that the routine had been run
PALNTS        = $0a03 ; $ff = PAL (50 hz),  $00 = NTSC (60 Hz)
INIT_STATUS   = $0a04 ; RESET and NMI status
MEM_BOT       = $0a05 ; bottom of banked RAM, default = $1c00
MEM_TOP       = $0a07 ; top    of banked RAM, default = $ff00
IRQTMP        = $0a09 ; save value of (IIRQ) here

; variables used in tape I/O

CASTON        = $0a0b ; timing value for tape operations
KIKA26        = $0a0c ; temporary storage for tape operations
STUPID        = $0a0d
TIMOUT        = $0a0e

; variables used for the serial RS232 interface

RS_Enable     = $0a0f ; Enable RS232 interface
RS_Control    = $0a10 ; Control register
RS_Command    = $0a11 ; Command register
RS_Baudrate   = $0a12 ; Baudrate
RS_Status     = $0a14 ; Status
                      ; 7... .... BREAK  detected
                      ; .6.. .... DSR    missing
                      ; ...4 .... CTS    missing
                      ; .... 3... input  buffer empty
                      ; .... .2.. input  buffer overflow
                      ; .... ..1. FRAME  error
                      ; .... ...0 PARITY error

RS_Bits       = $0a15 ; Length of character
RS_Timer_Lo   = $0a16 ; Baudrate corrected for TIMER low
RS_Timer_Hi   = $0a17 ; Baudrate corrected for TIMER high
RS_IBP_End    = $0a18 ; Input  Buffer Pointer End
RS_IBP_Beg    = $0a19 ; Input  Buffer Pointer Begin
RS_OBP_Beg    = $0a1a ; Output Buffer Pointer Begin
RS_OBP_End    = $0a1b ; Output Buffer Pointer End

Fast_IEC      = $0a1c ; Flag for fast IEC I/O
                      ; 7... .... fast IEC
                      ; .6.. .... burst mode
                      ; .... ...0 fast

; These three locations form a counter which is updated 50 times a
; second, and serves as a software clock which counts the number of
; jiffies that have elapsed since the computer was turned on.
; European computers running at 50 Hz add an additional count every
; 5th. jiffy in order to compensate the lower interrupt frequency.
; After 24 hours and one jiffy these locations are set back to $000000.

JIFFY_COUNTDOWN         = $0a1d ; 3 byte jiffy clock
XMAX          = $0a20 ; max. length of keyboard queue (10)
PAUSE         = $0a21 ; Ctrl-S flag
RPTFLG        = $0a22 ; repeat flag: $80 = all, $40 = no, $00 = cursor
KOUNT         = $0a23 ; repeat speed delay (default = 4)
DELAY         = $0a24 ; initial repeat delay (default = 10)
LSTHF         = $0a25 ; Commodore-Shift dleay (default = 8)

BLNON         = $0a26 ; $40 = non blinking cursor
BLNSW         = $0a27 ; $00 = blinking on
BLNCT         = $0a28 ; blink count
GDBLN         = $0a29 ; save charcter under cursor
GDCOL         = $0a2a ; save color    under cursor

; cursor mode in 80 column screen

; $80 = constant
; $60 = normal blinking
; $40 = fast blinking
; $20 = off

CURMOD        = $0a2b ; Cursor Mode
VSH_TEXT      = $0a2c ; VIC text      page
VSH_BITMAP    = $0a2d ; VIC bitmap    page
VDC_RAM_PAGE  = $0a2e ; VDC text      page
VDC_ATT_PAGE  = $0a2f ; VDC attribute page
LINTMP        = $0a30 ; temporary variable
VDC_ROW       = $0a31 ; temporary row
VDC_COL       = $0a32 ; temporary column
VDC_ATT       = $0a33 ; temporary attribute
VSH_SPLIT     = $0a34 ; VIC split shadow register
FN_SAVE_X     = $0a35 ; Save X register while accessing filename
PAL_ADJ       = $0a36 ; adjust jiffy clock running at 50 Hz
VSH_SPEED     = $0a37 ; VIC system speed
VSH_SPR_ENA   = $0a38 ; VIC sprites enabled
VSH_Ctrl_1    = $0a39 ; VIC control register 1
SPRITES       = $0a3a ; sprite enable flag
VIC_RAM_PAGE  = $0a3b ; start of VIC text RAM
VDC_UPDATE_LO = $0a3c ; pointer to VDC RAM
VDC_UPDATE_HI = $0a3d ; pointer to VDC RAM

; This area is used to swap the contents of the zero page addresses
; $e0 - $fa in the case of screen swapping

ZP_SW_COL     = $0a40 ; swap area for alternate screen

; This area is used to swap the contents of the tabulator settings
; at TABMAP in the case of screen swapping

SWPMAP        = $0a60 ; swap area for tab positions

; storage area for the machine language monitor

M_Data        = $0a80  ; 32 bytes for hunt string
M_Operand     = $0aa0  ; 10 bytes for operand
M_Format      = $0aaa  ; bit pattern describing operand syntax
M_Op_Size     = $0aab  ; length of operand (0,1 or 2)
M_Mne         = $0aac  ; 3 bytes for assembler mnemonic
M_Save_XR     = $0aaf  ; save X register
M_Opcode      = $0ab1  ; opcode for assembler/disassembler
M_Save_X      = $0ab2  ; save X register during banked RAM access
M_Dir         = $0ab3  ; direction of memory block transfer
M_Count       = $0ab4  ; unread bytes in input
M_Number      = $0ab5  ; temporary variable
M_Shift       = $0ab6  ; shifts for number conversion
M_Temp        = $0ab7  ; temporary 20 bit value

Module_Bank   = $0ac0  ; current bank for ROM module
Module_Flags  = $0ac1  ; ROM module initialization flags
DINFLAG       = $0ac5  ; ASCII/DIN mode and accent flag

; UNUSED      = $0ac6 - $0aff

; buffer areas

T_Buffer      = $0b00  ; 256 bytes tape buffer
R_Rece_Buffer = $0c00  ; 256 bytes RS232 serial receive buffer
R_Send_Buffer = $0d00  ; 256 bytes RS232 serial send    buffer
PKYBUF        = $1000  ;  10 bytes for programmable function keys
PKYDEF        = $100a  ; 246 bytes for function key assignment
DOSSTR        = $1100  ;  49 bytes for DOS command/open string

; variables for BASIC graphics commands

XPOS          = $1131  ; position
YPOS          = $1133
XDEST         = $1135  ; destination
YDEST         = $1137
XABS          = $1139  ; absolute value
YABS          = $113b
XSGN          = $113d  ; sign
YSGN          = $113f
FCT           = $1141
ERRVAL        = $1145
LESSER        = $1147
GREATR        = $1148
ANGSGN        = $1149  ; quadrant
SINVAL        = $114a  ;   sine value in 16 bit floating point
COSVAL        = $114c  ; cosine value in 16 bit floating point
ANGCNT        = $114e
XCIRCL        = $1150
YCIRCL        = $1152
XRADIUS       = $1154
YRADIUS       = $1156
ROTANG        = $1158
YDIST2        = $115a
ANGBEG        = $115c
ANGEND        = $115e
XRCOS         = $1160
YRSIN         = $1162
XRSIN         = $1164
YRCOS         = $1166
CHRPAG        = $1168
BITCNT        = $1169
SCALEM        = $116a
WIDTH         = $116b
FILFLG        = $116c
BITMSK        = $116d
NUMCNT        = $116e
TRCFLG        = $116f

; RENUMBER variables

Ren_Line_Lo   = $1170
Ren_Line_Hi   = $1171
Ren_Step_Lo   = $1172
Ren_Step_Hi   = $1173

T3            = $1174  ; used in MOVSPR and DIRECTORY
T4            = $1175
T5            = $1176

VTEMP3        = $1177  ; used in LAY_MUL_X
VTEMP4        = $1178  ; used in Get_Coordinates
Rel_Abs_Flag  = $1179  ; realtive or absolut plot mode
ADRAY1        = $117a  ; pointer to FAC1_To_Int_AY
ADRAY2        = $117c  ; pointer to Integer_To_Real

SPRITE_DATA   = $117e

; VIC shadow registers are used as working copies
; The contents are then copied to the VIC hardware registers
; while executing the BASIC_IRQ routine.

VSH           = $11d6    ; shadow of VIC = $d000
VSH_SS_COLL   = VSH + 17 ; sprite/sprite collision
VSH_LPX       = VSH + 19 ; light pen x
VSH_LPY       = VSH + 20 ; light pen y

CHARGEN_TEXT  = $11eb    ; character generator page for text     = $d8
CHARGEN_GRAF  = $11ec    ; character generator page for graphics = $d0

REC_SA        = $11ed    ; secondary address for RECORD command
OLDLIN        = $1200    ; old line number
OLDTXT        = $1202    ; old interpreter ointer

PU_FILL       = $1204    ; default ' ' : print using fill character
PU_COMMA      = $1205    ; default ',' : print using separator
PU_DOT        = $1206    ; default '.' : print using decimal dot
PU_MONEY      = $1207    ; default '$' : print using currency symbol

ERRNUM        = $1208    ; error number ($ff = no error)
ERRLIN        = $1209    ; linenumber of error
TRAPNO        = $120b    ; linenumber for error trap ($ffxx = no trap)
TMPTRP        = $120d    ; obsolete
ERRTXT        = $120e    ; pointer to error position in BASIC source

TEXT_TOP      = $1210    ; top of current   BASIC program text
TEXT_MAX      = $1212    ; top of available BASIC program text
TEXT_TMP      = $1214    ; temporary TEXT pointer
TEXT_LIN      = $1216    ; temporary LINE number storage
FUNC_USR      = $1218    ; JMP ($4c) and address for USR function

RNDX          = $121b    ; last used random number as 5 byte float

ARC_SEG       = $1220    ; plot intervall for plotting arcs or circles

; variables used for sound control in BASIC

Snd_Tempo     = $1222    ; duration = 19.22 / Snd_Tempo [sec]
Snd_Duration  = $1223    ; 16 bit duration for 3 voices
Snd_Dur_Tmp   = $1229    ; 16 bit duration
Snd_Octave    = $122b
Snd_Sharp     = $122c
Snd_Pitch     = $122d    ; 16 bit pitch

VOICE = $122f
WAVE0 = $1230
DNOTE = $1233
FLTSAV = $1234
FLTFLG = $1238

NIBBLE = $1239
TONNUM = $123a
TONVAL = $123b

PARCNT = $123e
ATKTAB = $123f
SUSTAB = $1249
WAVTAB = $1253
PULSLO = $125d
PULSHI = $1267
FILTERS = $1271
Old_Filter = $1274
Old_Volume = $1275
INT_TRIP_FLAG = $1276
Light_Pen_Flag = $1278
INT_ADR_LO = $1279
INT_ADR_HI = $127c
INT_VAL = $127f
Collision_Type      = $1280
Voice_Number        = $1281
Sound_Duration_1_Lo = $1282
Sound_Duration_2_Lo = $1283
Sound_Duration_3_Lo = $1284
Sound_Duration_1_Hi = $1285
Sound_Duration_2_Hi = $1286
Sound_Duration_3_Hi = $1287
SOUND_MAX_LO        = $1288
SOUND_MAX_HI        = $128b
SOUND_MIN_LO        = $128e
SOUND_MIN_HI        = $1291
SOUND_DIR           = $1294
SOUND_STEP_LO       = $1297
SOUND_STEP_HI       = $129a
SOUND_FREQ_LO       = $129d
SOUND_FREQ_HI       = $12a0
TEMP_TIME_LO        = $12a3
TEMP_TIME_HI        = $12a4
TEMP_MAX_LO         = $12a5
TEMP_MAX_HI         = $12a6
TEMP_MIN_LO         = $12a7
TEMP_MIN_HI         = $12a8
TEMP_DIRECTION      = $12a9
TEMP_STEP_LO        = $12aa
TEMP_STEP_HI        = $12ab
TEMP_FREQ_LO        = $12ac
TEMP_FREQ_HI        = $12ad
TEMP_PULSE_LO       = $12ae
TEMP_PULSE_HI       = $12af
TEMP_WAVEFORM       = $12b0

POT_IEMP_1          = $12b1
POT_IEMP_2          = $12b2

Win_XL              = $12b3
Win_YL              = $12b4
Win_XH              = $12b5
Win_YH              = $12b6

SAVRAM              = $12b7

DEFMOD = $12fa
LINCNT = $12fb
SPRNUM = $12fc
IRQ_ACTIVE_FLAG = $12fd
RAMBOT = $1c00
PROGRAM_START = $1c01

COLOR_RAM = $1c00
GRAFX_RAM = $2000

V3e00 = $3e00

; *************************************
; C-128 VIC (MOS 8564) Video Controller
; *************************************

;  #| Adr.  |Bit7|Bit6|Bit5|Bit4|Bit3|Bit2|Bit1|Bit0| Function
; --+-------+----+----+----+----+----+----+----+----+------------------------
;  0| $d000 |                  M0X                  | X coordinate sprite 0
; --+-------+---------------------------------------+------------------------
;  1| $d001 |                  M0Y                  | Y coordinate sprite 0
; --+-------+---------------------------------------+------------------------
;  2| $d002 |                  M1X                  | X coordinate sprite 1
; --+-------+---------------------------------------+------------------------
;  3| $d003 |                  M1Y                  | Y coordinate sprite 1
; --+-------+---------------------------------------+------------------------
;  4| $d004 |                  M2X                  | X coordinate sprite 2
; --+-------+---------------------------------------+------------------------
;  5| $d005 |                  M2Y                  | Y coordinate sprite 2
; --+-------+---------------------------------------+------------------------
;  6| $d006 |                  M3X                  | X coordinate sprite 3
; --+-------+---------------------------------------+------------------------
;  7| $d007 |                  M3Y                  | Y coordinate sprite 3
; --+-------+---------------------------------------+------------------------
;  8| $d008 |                  M4X                  | X coordinate sprite 4
; --+-------+---------------------------------------+------------------------
;  9| $d009 |                  M4Y                  | Y coordinate sprite 4
; --+-------+---------------------------------------+------------------------
; 10| $d00a |                  M5X                  | X coordinate sprite 5
; --+-------+---------------------------------------+------------------------
; 11| $d00b |                  M5Y                  | Y coordinate sprite 5
; --+-------+---------------------------------------+------------------------
; 12| $d00c |                  M6X                  | X coordinate sprite 6
; --+-------+---------------------------------------+------------------------
; 13| $d00d |                  M6Y                  | Y coordinate sprite 6
; --+-------+---------------------------------------+------------------------
; 14| $d00e |                  M7X                  | X coordinate sprite 7
; --+-------+---------------------------------------+------------------------
; 15| $d00f |                  M7Y                  | Y coordinate sprite 7
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 16| $d010 |M7X8|M6X8|M5X8|M4X8|M3X8|M2X8|M1X8|M0X8| MSBs of X coordinates
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 17| $d011 |RST8| ECM| BMM| DEN|RSEL|    YSCROLL   | Control register 1
; --+-------+----+----+----+----+----+--------------+------------------------
; 18| $d012 |                 RASTER                | VIC_RASTER counter
; --+-------+---------------------------------------+------------------------
; 19| $d013 |                  LPX                  | Light pen X
; --+-------+---------------------------------------+------------------------
; 20| $d014 |                  LPY                  | Light pen Y
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 21| $d015 | M7E| M6E| M5E| M4E| M3E| M2E| M1E| M0E| Sprite enabled
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 22| $d016 |  - |  - | RES| MCM|CSEL|    XSCROLL   | Control register 2
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 23| $d017 |M7YE|M6YE|M5YE|M4YE|M3YE|M2YE|M1YE|M0YE| Sprite Y expansion
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 24| $d018 |VM13|VM12|VM11|VM10|CB13|CB12|CB11|  - | Memory pointers
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 25| $d019 | IRQ|  - |  - |  - | ILP|IMMC|IMBC|IRST| Interrupt register
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 26| $d01a |  - |  - |  - |  - | ELP|EMMC|EMBC|ERST| Interrupt enabled
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 27| $d01b |M7DP|M6DP|M5DP|M4DP|M3DP|M2DP|M1DP|M0DP| Sprite data priority
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 28| $d01c |M7MC|M6MC|M5MC|M4MC|M3MC|M2MC|M1MC|M0MC| Sprite multicolor
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 29| $d01d |M7XE|M6XE|M5XE|M4XE|M3XE|M2XE|M1XE|M0XE| Sprite X expansion
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 30| $d01e | M7M| M6M| M5M| M4M| M3M| M2M| M1M| M0M| Sprite-sprite collision
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 31| $d01f | M7D| M6D| M5D| M4D| M3D| M2D| M1D| M0D| Sprite-data collision
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 32| $d020 |  - |  - |  - |  - |         EC        | Border color
; --+-------+----+----+----+----+-------------------+------------------------
; 33| $d021 |  - |  - |  - |  - |        B0C        | Background color 0
; --+-------+----+----+----+----+-------------------+------------------------
; 34| $d022 |  - |  - |  - |  - |        B1C        | Background color 1
; --+-------+----+----+----+----+-------------------+------------------------
; 35| $d023 |  - |  - |  - |  - |        B2C        | Background color 2
; --+-------+----+----+----+----+-------------------+------------------------
; 36| $d024 |  - |  - |  - |  - |        B3C        | Background color 3
; --+-------+----+----+----+----+-------------------+------------------------
; 37| $d025 |  - |  - |  - |  - |        MM0        | Sprite multicolor 0
; --+-------+----+----+----+----+-------------------+------------------------
; 38| $d026 |  - |  - |  - |  - |        MM1        | Sprite multicolor 1
; --+-------+----+----+----+----+-------------------+------------------------
; 39| $d027 |  - |  - |  - |  - |        M0C        | Color sprite 0
; --+-------+----+----+----+----+-------------------+------------------------
; 40| $d028 |  - |  - |  - |  - |        M1C        | Color sprite 1
; --+-------+----+----+----+----+-------------------+------------------------
; 41| $d029 |  - |  - |  - |  - |        M2C        | Color sprite 2
; --+-------+----+----+----+----+-------------------+------------------------
; 42| $d02a |  - |  - |  - |  - |        M3C        | Color sprite 3
; --+-------+----+----+----+----+-------------------+------------------------
; 43| $d02b |  - |  - |  - |  - |        M4C        | Color sprite 4
; --+-------+----+----+----+----+-------------------+------------------------
; 44| $d02c |  - |  - |  - |  - |        M5C        | Color sprite 5
; --+-------+----+----+----+----+-------------------+------------------------
; 45| $d02d |  - |  - |  - |  - |        M6C        | Color sprite 6
; --+-------+----+----+----+----+-------------------+------------------------
; 46| $d02e |  - |  - |  - |  - |        M7C        | Color sprite 7
; --+-------+----+----+----+----+-------------------+------------------------
; 47| $d02f |  - |  - |  - |  - |  - | K2 | K1 | K0 | Keyboard control
; --+-------+----+----+----+----+-------------------+------------------------
; 48| $d030 |  - |  - |  - |  - |  - |  - |  - | MHz| Fast / Slow
; --+-------+----+----+----+----+-------------------+------------------------

VIC = $d000

; **********************************************
; C-64 CIA1 (MOS 6526) Complex Interface Adapter
; **********************************************

;  #| Adr.  |Bit7|Bit6|Bit5|Bit4|Bit3|Bit2|Bit1|Bit0| Function
; --+-------+----+----+----+----+----+----+----+----+------------------------
;  0| $dc00 |                  PRA                  | Data port A
; --+-------+---------------------------------------+------------------------
;  1| $dc01 |                  PRB                  | Data port B
; --+-------+---------------------------------------+------------------------
;  2| $dc02 |                 DDRA                  | Data direction A
; --+-------+---------------------------------------+------------------------
;  3| $dc03 |                 DDRB                  | Data direction B
; --+-------+---------------------------------------+------------------------
;  4| $dc04 |                 TALO                  | Timer A low
; --+-------+---------------------------------------+------------------------
;  5| $dc05 |                 TAHI                  | Timer A high
; --+-------+---------------------------------------+------------------------
;  6| $dc06 |                 TBLO                  | Timer B low
; --+-------+---------------------------------------+------------------------
;  7| $dc07 |                 TBHI                  | Timer B high
; --+-------+----+----+----+----+----+----+----+----+------------------------
;  8| $dc08 | S/A|  0 |  0 |  0 |       TODS        | Time Of Day [1/10 sec]
; --+-------+----+----+----+----+----+----+----+----+------------------------
;  9| $dc09 |  0 |  TODS [10s]  |     TODS [1s]     | Time Of Day [sec]
; --+-------+----+--------------+-------------------+------------------------
; 10| $dc0a |  0 |  TODM [10m]  |     TODM [1m]     | Time Of Day [min]
; --+-------+----+--------------+-------------------+------------------------
; 11| $dc0b |AMPM|  TODH [10h]  |     TODH [1h]     | Time Of Day [hour]
; --+-------+----+--------------+-------------------+------------------------
; 12| $dc0c |                  SDR                  | Serial Data Register
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 13| $dc0d |MODE|  0 |  0 |IFLG|ISDR|IARM|ITBU|ITBA| Interrupt Control Reg.
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 14| $dc0e | Hz |DSDR|CNTP| ONE|CONT|TBUN|TBUN|STOP| Control Timer A
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 15| $dc0f |MODE|   TACT  | ONE|CONT|TAUN|TAUN|STOP| Control Timer B
; --+-------+----+----+----+----+----+----+----+----+------------------------

CIA1         = $DC00 ; base address
CIA1_KBD_COL = $DC00 ; CIA1 Peripheral data Register A : keyboard column
CIA1_KBD_ROW = $DC01 ; CIA1 Peripheral data Register B : keyboard row

                     ; C64  keyboard matrix layout
                     ;       c7   c6   c5   c4   c3   c2   c1   c0
                     ;   +------------------------------------------------
                     ; r7|  RUN    /    ,    N    V    X  LSH   DN
                     ; r6|    Q   UP    @    O    U    T    E   F5
                     ; r5|  CBM    =    :    K    H    F    S   F3
                     ; r4|   SP  RSH    .    M    B    C    Z   F1
                     ; r3|    2  HOM    -    0    8    6    4   F7
                     ; r2|  CTL    ;    L    J    G    D    A  RGT
                     ; r1|  LFT    *    P    I    Y    R    W  RET
                     ; r0|    1    £    +    9    7    5    3  DEL

CIA1_DDRA  = $DC02   ; CIA1 Data Direction  Register A
CIA1_DDRB  = $DC03   ; CIA1 Data Direction  Register B
CIA1_TALO  = $DC04   ; CIA1 Timer A Low  register
CIA1_TAHI  = $DC05   ; CIA1 Timer A High register
CIA1_TBLO  = $DC06   ; CIA1 Timer B Low  register
CIA1_TBHI  = $DC07   ; CIA1 Timer B High register
CIA1_TODT  = $DC08   ; CIA1 Time Of Day 1/10 seconds
CIA1_TODS  = $DC09   ; CIA1 Time Of Day seconds
CIA1_TODM  = $DC0A   ; CIA1 Time Of Day minutes
CIA1_TODH  = $DC0B   ; CIA1 Time Of Day hours
CIA1_SDR   = $DC0C   ; CIA1 Serial Data Register
CIA1_ICR   = $DC0D   ; CIA1 Interrupt Control Register
CIA1_CRA   = $DC0E   ; CIA1 Control Register A
CIA1_CRB   = $DC0F   ; CIA1 Control Register B

; **********************************************
; C-64 CIA2 (MOS 6526) Complex Interface Adapter
; **********************************************

;  #| Adr.  |Bit7|Bit6|Bit5|Bit4|Bit3|Bit2|Bit1|Bit0| Function
; --+-------+----+----+----+----+----+----+----+----+------------------------
;  0| $dd00 |                  PRA                  | Data port A
; --+-------+---------------------------------------+------------------------
;  1| $dd01 |                  PRB                  | Data port B
; --+-------+---------------------------------------+------------------------
;  2| $dd02 |                 DDRA                  | Data direction A
; --+-------+---------------------------------------+------------------------
;  3| $dd03 |                 DDRB                  | Data direction B
; --+-------+---------------------------------------+------------------------
;  4| $dd04 |                 TALO                  | Timer A low
; --+-------+---------------------------------------+------------------------
;  5| $dd05 |                 TAHI                  | Timer A high
; --+-------+---------------------------------------+------------------------
;  6| $dd06 |                 TBLO                  | Timer B low
; --+-------+---------------------------------------+------------------------
;  7| $dd07 |                 TBHI                  | Timer B high
; --+-------+----+----+----+----+----+----+----+----+------------------------
;  8| $dd08 | S/A|  0 |  0 |  0 |       TODS        | Time Of Day [1/10 sec]
; --+-------+----+----+----+----+----+----+----+----+------------------------
;  9| $dd09 |  0 |  TODS [10s]  |     TODS [1s]     | Time Of Day [sec]
; --+-------+----+--------------+-------------------+------------------------
; 10| $dd0a |  0 |  TODM [10m]  |     TODM [1m]     | Time Of Day [min]
; --+-------+----+--------------+-------------------+------------------------
; 11| $dd0b |AMPM|  TODH [10h]  |     TODH [1h]     | Time Of Day [hour]
; --+-------+----+--------------+-------------------+------------------------
; 12| $dd0c |                  SDR                  | Serial Data Register
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 13| $dd0d |MODE|  0 |  0 |IFLG|ISDR|IARM|ITBU|ITBA| Interrupt Control Reg.
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 14| $dd0e | Hz |DSDR|CNTP| ONE|CONT|TBUN|TBUN|STOP| Control Timer A
; --+-------+----+----+----+----+----+----+----+----+------------------------
; 15| $dd0f |MODE|   TACT  | ONE|CONT|TAUN|TAUN|STOP| Control Timer B
; --+-------+----+----+----+----+----+----+----+----+------------------------

; **********************************************
; C-64 CIA2 (MOS 6526) Complex Interface Adapter
; **********************************************

CIA2       = $DD00 ; base address

CIA2_PRA   = $DD00   ; CIA2 Peripheral data Register A

; bit 7:   IEC DATA  IN
; bit 6:   IEC CLOCK IN
; bit 5:   IEC DATA  OUT
; bit 4:   IEC CLOCK OUT
; bit 3:   IEC ATN   OUT
; bit 2:   RS232     OUT
; bit 1:   VA15
; bit 0:   VA14

CIA2_PRB   = $DD01   ; CIA2 Peripheral data Register B

; bit 7:   DSR Data Set Ready
; bit 6:   CTS Clear To Send
; bit 5:   DCD Data Carrier Detect
; bit 4:
; bit 3:   RI  Ring Indicator
; bit 2:   DTR Data Terminal Ready
; bit 1:   RTS Request To Send
; bit 0:   RXD Received Data

CIA2_DDRA  = $DD02   ; CIA2 Data Direction  Register A
CIA2_DDRB  = $DD03   ; CIA2 Data Direction  Register B
CIA2_TALO  = $DD04   ; CIA2 Timer A Low  register
CIA2_TAHI  = $DD05   ; CIA2 Timer A High register
CIA2_TBLO  = $DD06   ; CIA2 Timer B Low  register
CIA2_TBHI  = $DD07   ; CIA2 Timer B High register
CIA2_TODT  = $DD08   ; CIA2 Time Of Day 1/10 seconds
CIA2_TODS  = $DD09   ; CIA2 Time Of Day seconds
CIA2_TODM  = $DD0A   ; CIA2 Time Of Day minutes
CIA2_TODH  = $DD0B   ; CIA2 Time Of Day hours
CIA2_SDR   = $DD0C   ; CIA2 Serial Data Register
CIA2_ICR   = $DD0D   ; CIA2 Interrupt Control Register

; bit 7:   IRQ enable
; bit 6:
; bit 5:
; bit 4:   IRQ flag
; bit 3:   serial port full/empty
; bit 2:   ALARM
; bit 1:   TIMER B
; bit 0:   TIMER A

CIA2_CRA   = $DD0E   ; CIA2 Control Register A
CIA2_CRB   = $DD0F   ; CIA2 Control Register B

; key coordinates

CTRL_COL = %01111111 ; $7f = col 7
CTRL_ROW = %11111011 ; $fb = row 2

STND_COL = %01111111 ; $7f = col 7

VIA2_IER = CIA1_ICR    ; CIA1 Interrupt Control Register
VIA2_T2CH= $DC07
VIA2_T2CL= $DC06
VIA2_T1CL= $DC04
VIA2_T1CH= $DC05

COLS          =  40
ROWS          =  25
COLINK        =   2
COLMAX        =  80
COLRAM_PAGE   = $D8
Default_Color = 14   ; Light blue

MEM_CONTROL   = $D018
IEC_TIM_H     = $DC07; CIA 1 TIH, timer high
IEC_IFR       = CIA1_ICR    ; CIA 1 CRB, interrupt flag register
IEC_PCR       = $DD00; VIA 2 peripheral control register (PCR)
IEC_DRAN      = $DD00; CIA 2 DRA, IEC bus

; bit 7	IEC Bus Data  Input
;     6	IEC Bus Clock Input
;     5	IEC Bus Data  Output
;     4	IEC Bus Clock Output
;     3	IEC Bus ATN Signal Output
;     2 User port PA2
;   0-1 VIC memory address

RS2_DSR_CTS   = $DD01
RS2_IRQ_REG   = CIA2_ICR
RS2_TIM_LOW   = $DD04
RS2_TIM_HIG   = $DD05
IEC_ATN_BIT   = $08
IEC_IFR_BIT   = $02
IEC_CLK_BIT   = %00010000; $10
IEC_DAT_BIT   = %00100000; $20
RS232_C_BIT   = %00000100; $04


VIC_Ctrl_1  = $d011    ; VIC control register 1
VIC_RASTER  = $d012
VIC_LPX     = $d013
VIC_LPY     = $d014
VIC_SPR_ENA = $d015
VIC_Ctrl_2  = $d016
VIC_Memory  = $d018
VIC_IRQ_REG = $d019
VIC_IRQ_ENA = $d01a
Vd01c = $d01c
VIC_SS_COLL = $d01e
Vd020 = $d020
VIC_BG_COL = $d021
Vd025 = $d025
Vd026 = $d026
Vd027 = $d027
VIC_KBD = $d02f
VIC_SPEED = $d030

SID_Freq_1 = $d400
SID_Pulse_1 = $d402
SID_Control_1 = $d404
SID_Attack_1 = $d405
SID_Sustain_1 = $d406
SID_Freq_2 = $d407
SID_Pulse_2 = $d409
SID_Control_2 = $d40b
SID_Attack_2 = $d40c
SID_Sustain_2 = $d40d
SID_Freq_3 = $d40e
SID_Pulse_3 = $d410
SID_Control_3 = $d412
SID_Attack_3 = $d413
SID_Sustain_3 = $d414
SID_Cutoff = $d415
SID_Resonance = $d417
SID_Volume = $d418
SID_POT_X = $d419

; MMU

MMU_CONT = $d500
MMU_PCRA = $d501
MMU_MODE = $d505
MMU_RAMC = $d506

; VDC

VDC_Register = $d600
VDC_Data = $d601

VIC_COLOR_RAM = $d800

; DMA controller as used by the Commodore REU

DMA_BASE   = $df00

; 7....... interrupt pending
; .6...... end of block
; ..5..... fault
; ...4.... size of RAM chips
; ....3210 version

DMA_CMD    = $df01
DMA_CBM_LO = $df02
DMA_CBM_HI = $df03
DMA_REU_LO = $df04
DMA_REU_HI = $df05
DMA_REU_BA = $df06
DMA_CNT_LO = $df07
DMA_CNT_HI = $df08

K_SPINIO  = $ff47
K_CLOALL  = $ff4a
K_C64     = $ff4d
K_DMA     = $ff50
K_BOOT    = $ff53
K_PHOENIX = $ff56
K_LKUPLA  = $ff59
K_LKUPSA  = $ff5c
K_SWAPPER = $ff5f
K_DLCHR   = $ff62
K_PFKEY   = $ff65
K_SETBNK  = $ff68
K_GETCFG  = $ff6b
K_JSRFAR  = $ff6e
K_JMPFAR  = $ff71
K_INDFET  = $ff74
K_INDSTA  = $ff77
K_INDCMP  = $ff7a
K_PRIMM   = $ff7d
K_VERSION = $ff80
K_CINT    = $ff81
K_IOINIT  = $ff84
K_RAMTAS  = $ff87
K_RESTOR  = $ff8a
K_VECTOR  = $ff8d
K_SETMSG  = $ff90
K_SECND   = $ff93
K_TKSA    = $ff96
K_MEMTOP  = $ff99
K_MEMBOT  = $ff9c
K_KEY     = $ff9f
K_SETTMO  = $ffa2
K_ACPTR   = $ffa5
K_CIOUT   = $ffa8
K_UNTLK   = $ffab
K_UNLSN   = $ffae
K_LISTN   = $ffb1
K_TALK    = $ffb4
K_READST  = $ffb7
K_SETLFS  = $ffba
K_SETNAM  = $ffbd
K_OPEN    = $ffc0
K_CLOSE   = $ffc3
K_CHKIN   = $ffc6
K_CKOUT   = $ffc9
K_CLRCH   = $ffcc
K_BASIN   = $ffcf
K_BSOUT   = $ffd2
K_LOADSP  = $ffd5
K_SAVESP  = $ffd8
K_SETTIM  = $ffdb
K_RDTIM   = $ffde
K_STOP    = $ffe1
K_GETIN   = $ffe4
K_CLALL   = $ffe7
K_UDTIM   = $ffea
K_SCRORG  = $ffed
K_PLOT    = $fff0
K_IOBASE  = $fff3

MMU_CR   = $ff00
MMU_LCRA = $ff01
MMU_LCRB = $ff02
MMU_LCRC = $ff03
MMU_LCRD = $ff04

.STORE $B000, $1000, "b000.tedmon"

* = $b000   ; *** 128.rom ***  Commodore 128

; *********************
  BASIC_MONITOR ; $b000
; *********************

          JMP Mon_Entry_By_Call

; *****************
  Mon_Break ; $b003
; *****************

          JMP Mon_Entry_By_Break

; *******************
  Mon_Command ; $b006
; *******************

          JMP Mon_Command_Switch

; ******************
  Mon_Entry_By_Break
; ******************

          JSR K_PRIMM
          .BYTE "\rBREAK",7,0
          PLA                 ; bank of interrupted program
          STA BANK
          LDX #5
MEBB_10   PLA
          STA PC_HI,X         ; save CPU registers and flags
          DEX
          BPL MEBB_10
          BMI Mon_Start       ; always

; *************************
  Mon_Entry_By_Call ; $b021
; *************************

          LDA #0
          STA MMU_CR          ; system bank
          STA A_REG           ; clear register saves
          STA X_REG
          STA Y_REG
          STA S_REG
          LDA #<BASIC_MONITOR ; default for PC save
          LDY #>BASIC_MONITOR
          STA PC_LO
          STY PC_HI
          LDA #15
          STA BANK            ; bank configuration for monitor
          JSR K_PRIMM
          .BYTE "\rMONITOR",0

; *****************
  Mon_Start ; $b046
; *****************

          CLD                 ; clear decimal mode
          TSX
          STX CHARAC          ; save stack pointer
          LDA #$c0            ; activate kernal and I/O messages
          JSR K_SETMSG        ; set message flag
          CLI                 ; enable interrupts

; ****************
  Mon_Print_Header
; ****************

          JSR K_PRIMM         ; print register header
          .BYTE "\r    PC  SR AC XR YR SP\r; "
          .BYTE $1b,$51,$00
          LDA BANK
          JSR Mon_Bin_To_Hex
          TXA                 ; hex value of lower nibble
          JSR K_BSOUT         ; prinz bank as single hex
          LDA PC_HI
          JSR Mon_Hex
          LDY #2
MPH_10    LDA BANK,Y          ; print all register values
          JSR Mon_Hex_Blank
          INY
          CPY #8
          BCC MPH_10

; ****************
  Mon_Main ; $b08b
; ****************

          JSR Mon_CR
          LDX #0
          STX DS_LEN
MoMa_10   JSR K_BASIN
          STA BUF,X
          INX
          CPX #161            ; max. buffer size
          BCS Mon_Error
          CMP #CR             ; end of input
          BNE MoMa_10
          LDA #0
          STA BUF-1,X         ; zero terminate buffer
MoMa_20   JSR Mon_Get_Char
          BEQ Mon_Main
          CMP #' '
          BEQ MoMa_20
          JMP (EXMON)         ; JMP Mon_Command -> Switch

; **************************
  Mon_Command_Switch ; $b0b2
; **************************

          LDX #21             ; # of commands
MoCS_10   CMP cmdchr,X
          BEQ MoMa_30
          DEX
          BPL MoCS_10

; *****************
  Mon_Error ; $b0bc
; *****************

          JSR K_PRIMM
          .BYTE $1d,$3f,$00   ; cursor right, ?, 0
          JMP Mon_Main

; ***************
  MoMa_30 ; $b0c5
; ***************

          CPX #19
          BCS MoMa_40         ; -> Load, Save or Verify
          CPX #15
          BCS MoMa_50         ; -> numeric conversion
          TXA
          ASL A
          TAX
          LDA cmdtbl+1,X
          PHA
          LDA cmdtbl,X
          PHA
          JMP Mon_Got_Aval    ; parse arguments, then execute function
MoMa_40   STA K_VERCK         ; store 'L', or 'S' or 'V'
          JMP Mon_Load_Save   ; load, save or verify
MoMa_50   JMP Mon_Convert

; ****************
  Mon_Exit ; $b0e3
; ****************

          JMP (RESET_VECTOR)

cmdchr    .BYTE "ACDFGHJMRTX@.>;"
cmdnum    .BYTE "$+&%"
          .BYTE "LSV"
cmdtbl    .WORD Mon_Assemble     - 1  ; A
          .WORD Mon_Compare -      1  ; C
          .WORD Mon_Disassemble  - 1  ; D
          .WORD Mon_Fill         - 1  ; F
          .WORD Mon_Go           - 1  ; G
          .WORD Mon_Hunt         - 1  ; H
          .WORD Mon_Gosub        - 1  ; J
          .WORD Mon_Memory       - 1  ; M
          .WORD Mon_Print_Header - 1  ; R
          .WORD Mon_Transfer     - 1  ; T
          .WORD Mon_Exit         - 1  ; X
          .WORD Mon_Disk         - 1  ; @
          .WORD Mon_Assemble     - 1  ; .
          .WORD Mon_Set_Memory   - 1  ; >
          .WORD Mon_Set_Register - 1  ; ;

; *****************
  Mon_Fetch ; $b11a
; *****************

          STX M_Save_X
          LDX M_Cval+2
          LDA #M_Cval
          SEI
          JSR K_INDFET
          CLI
          LDX M_Save_X
          RTS

; *****************
  Mon_Stash ; $b12a
; *****************

          STX M_Save_X
          LDX #M_Cval
          STX STASH+10
          LDX M_Cval+2
          SEI
          JSR K_INDSTA
          CLI
          LDX M_Save_X
          RTS

; *****************
  Mon_Compa ; $b13d
; *****************

          STX M_Save_X
          LDX #M_Cval
          STX CMPARE+10
          LDX M_Cval+2
          SEI
          JSR K_INDCMP
          CLI
          PHP
          LDX M_Save_X
          PLP
          RTS

; ******************
  Mon_Memory ; $b152
; ******************

          BCS MoMe_10         ; -> no end address
          JSR Mon_Aval_To_Cval
          JSR Mon_Got_Aval
          BCC MoMe_20
MoMe_10   LDA #11             ; display 12 lines
          STA M_Aval
          BNE MoMe_40
MoMe_20   JSR Mon_Aval_Minus_Cval
          BCC MoMe_Err
          LDX #3              ; X = 3
          BIT MODE_80
          BPL MoMe_30         ; -> 40 column screen
          INX                 ; X = 4
MoMe_30   LSR M_Aval+2      ; Aval /= (bytes per line)
          ROR M_Aval+1
          ROR M_Aval
          DEX
          BNE MoMe_30
MoMe_40   JSR K_STOP          ; test for STOP key
          BEQ MoMe_60         ; -> STOP
          JSR Mon_Dump_Row
          LDA #8              ; display  8 bytes on 40 column screen
          BIT MODE_80
          BPL MoMe_50
          ASL A               ; display 16 bytes on 80 column screen
MoMe_50   JSR Mon_Add_Cval
          JSR Mon_Dec_Aval
          BCS MoMe_40
MoMe_60   JMP Mon_Main
MoMe_Err  JMP Mon_Error

; ************************
  Mon_Set_Register ; $b194
; ************************

          JSR Mon_Aval_To_PCB          ; set PC
          LDY #0
MoSr_10   JSR Mon_Got_Aval
          BCS MoSr_20
          LDA M_Aval
          STA S_REG,Y         ; SR AC XR YR SP
          INY
          CPY #5
          BCC MoSr_10
MoSr_20   JMP Mon_Main

; **********************
  Mon_Set_Memory ; $b1ab
; **********************

          BCS MoSM_30
          JSR Mon_Aval_To_Cval
          LDY #0
MoSM_10   JSR Mon_Got_Aval
          BCS MoSM_30
          LDA M_Aval
          JSR Mon_Stash
          INY
          BIT MODE_80
          BPL MoSM_20         ; -> 40 columns
          CPY #16
          BCC MoSM_10
MoSM_20   CPY #8
          BCC MoSM_10
MoSM_30   JSR K_PRIMM
          .BYTE ESC,'O',$91,0 ; clear attributes
          JSR Mon_Dump_Row
          JMP Mon_Main

; **************
  Mon_Go ; $b1d6
; **************

          JSR Mon_Aval_To_PCB
          LDX CHARAC
          TXS
          JMP K_JMPFAR

; *****************
  Mon_Gosub ; $b1df
; *****************

          JSR Mon_Aval_To_PCB
          JSR K_JSRFAR
          JMP Mon_Main

; ********************
  Mon_Dump_Row ; $b1e8
; ********************

          JSR Mon_CR
          LDA #'>'
          JSR K_BSOUT
          JSR Mon_Hex_Cval        ; address
          LDY #0
          BEQ MoDR_20         ; always

MoDR_10   JSR Mon_Blank
MoDR_20   JSR Mon_Fetch
          JSR Mon_Hex          ; memory byte
          INY
          CPY #8              ; 40 columns
          BIT MODE_80
          BPL MoDR_30         ; -> 40 column screen
          CPY #16             ; 80 columns
MoDR_30   BCC MoDR_10         ; -> loop
          JSR K_PRIMM
          .BYTE ':',$12,0     ; separator to text dump

          LDY #0              ; fall through to text dump
MoDR_40   JSR Mon_Fetch
          PHA
          AND #$7f            ; remove reverse bit
          CMP #' '            ; printable ?
          PLA
          BCS MoDR_50
          LDA #'.'            ; use dot for unprintable chars
MoDR_50   JSR K_BSOUT
          INY
          BIT MODE_80
          BPL MoDR_60
          CPY #16             ; 80 columns
          BCC MoDR_40
MoDR_60   CPY #8              ; 40 columns
          BCC MoDR_40
          RTS

; *******************
  Mon_Compare ; $b231
; *******************

          LDA #0
          BIT

; ********************
  Mon_Transfer ; $b234
; ********************

          LDA #$80
          STA K_VERCK         ; $80 = Transfer, $00 = Compare
          LDA #0
          STA M_Dir
          JSR Mon_Range       ; Cval, TEMPS (Bval = range)
          BCS MoTr_10
          JSR Mon_Got_Aval    ; Aval = target address
          BCC MoTr_15
MoTr_10   JMP Mon_Error

MoTr_15   BIT K_VERCK
          BPL MoTr_25         ; -> Compare is indepent of direction
          SEC
          LDA M_Cval
          SBC M_Aval
          LDA M_Cval+1
          SBC M_Aval+1      ; source (Cval) >= target (Aval) ?
          BCS MoTr_25         ; -> yes, do a forward copy
          LDA M_Bval        ; otherwise we need a backward copy
          ADC M_Aval
          STA M_Aval
          LDA M_Bval+1
          ADC M_Aval+1
          STA M_Aval+1
          LDA M_Bval+2
          ADC M_Aval+2
          STA M_Aval+2
          LDX #2
MoTr_20   LDA M_Temp,X         ; Cval = TEMPS
          STA M_Cval,X
          DEX
          BPL MoTr_20
          LDA #$80
          STA M_Dir       ; do a backward transfer

MoTr_25   JSR Mon_CR
          LDY #0
MoTr_30   JSR K_STOP
          BEQ MoTr_65
          JSR Mon_Fetch       ; load byte (Cval)
          LDX #M_Aval
          STX STASH+10
          STX CMPARE+10
MoTr_35   LDX M_Aval+2      ; bank config
          SEI
          BIT K_VERCK
          BPL MoTr_40         ; -> compare
          JSR K_INDSTA        ; transfer
MoTr_40   LDX M_Aval+2      ; bank config
          JSR K_INDCMP        ; compare
          CLI
          BEQ MoTr_45         ; -> equal
          JSR Mon_Hex_Cval
          JSR Mon_Blank
          JSR Mon_Blank
MoTr_45   BIT M_Dir
          BMI MoTr_50         ; -> backward: count down
          INC M_Aval        ; count up
          BNE MoTr_55
          INC M_Aval+1
          BNE MoTr_55
          JMP Mon_Error
MoTr_50   JSR Mon_Dec_Aval
          JSR Mon_Dec_Cval
          JMP MoTr_60
MoTr_55   JSR Mon_Inc_Cval
MoTr_60   JSR Mon_Dec_Bval
          BCS MoTr_30         ; loop
MoTr_65   JMP Mon_Main

; ****************
  Mon_Hunt ; $b2ce
; ****************

          JSR Mon_Range
          BCS MoHu_Err
          LDY #0
          JSR Mon_Get_Char
          CMP #APOSTR
          BNE MoHu_20         ; -> read numeric value
          JSR Mon_Get_Char    ; read search string
          CMP #0
          BEQ MoHu_Err
MoHu_10   STA M_Data,Y
          INY
          JSR Mon_Get_Char
          BEQ MoHu_40
          CPY #32             ; maximum length of search pattern
          BNE MoHu_10
          BEQ MoHu_40         ; always

MoHu_20   STY STACK
          JSR Mon_Get_Aval    ; get numeric value
MoHu_30   LDA M_Aval
          STA M_Data,Y
          INY
          JSR Mon_Got_Aval
          BCS MoHu_40         ; -> end of arguments
          CPY #32             ; maximum length of search pattern
          BNE MoHu_30

MoHu_40   STY K_VERCK         ; length of hunt string
          JSR Mon_CR
MoHu_50   LDY #0              ; start comparison
MoHu_60   JSR Mon_Fetch
          CMP M_Data,Y
          BNE MoHu_70         ; -> no match
          INY
          CPY K_VERCK
          BNE MoHu_60         ; -> more to compare
          JSR Mon_Hex_Cval        ; print matching address
          JSR Mon_Blank
          JSR Mon_Blank
MoHu_70   JSR K_STOP          ; check for stop key
          BEQ MoHu_80         ; -> user stop
          JSR Mon_Inc_Cval    ; increment comparison address
          JSR Mon_Dec_Bval    ; decrement comparison counter
          BCS MoHu_50         ; -> loop
MoHu_80   JMP Mon_Main
MoHu_Err  JMP Mon_Error

; *********************
  Mon_Load_Save ; $b337
; *********************

          LDY #1              ; Y = 1
          STY FA              ; default device = 1 (tape)
          STY SA              ; default secondary address = 1
          DEY                 ; Y = 0
          STY BA              ; default bank = 0
          STY FNLEN           ; no filename
          STY FNBANK          ; default filename bank = 0
          STY STATUS          ; Clear STATUS
          LDA #>M_Data          ; put filename into M_Data
          STA FNADR+1
          LDA #<M_Data
          STA FNADR
MLS_10    JSR Mon_Get_Char
          BEQ MLS_60          ; -> finished
          CMP #' '
          BEQ MLS_10          ; -> skip blanks
          CMP #QUOTE
          BNE MLS_30          ; -> error: no quote
          LDX DS_LEN          ; X = buffer pointer
MLS_20    LDA BUF,X
          BEQ MLS_60          ; -> end of buffer
          INX
          CMP #QUOTE
          BEQ MLS_40          ; -> end of string
          STA (FNADR),Y       ; store filename character
          INC FNLEN           ; update length
          INY                 ; increase length
          CPY #17             ; length < 17 ?
          BCC MLS_20          ; -> OK loop

MLS_30    JMP Mon_Error
MLS_40    STX DS_LEN          ; save buffer pointer
          JSR Mon_Get_Char    ; more parameter ?
          BEQ MLS_60          ; -> no
          JSR Mon_Got_Aval    ; read numeric value
          BCS MLS_60          ; -> none
          LDA M_Aval
          STA FA              ; store value as device address
          JSR Mon_Got_Aval    ; read next value
          BCS MLS_60          ; -> none
          JSR Mon_Aval_To_Cval    ; Cval = start address and bank
          STA BA              ; store bank from Aval+2
          JSR Mon_Got_Aval    ; read next value
          BCS MLS_80          ; -> none
          JSR Mon_CR
          LDX M_Aval          ; (X/Y) = end address
          LDY M_Aval+1
          LDA K_VERCK         ; 'L', 'S' or 'V'
          CMP #'S'            ; SAVE ?
          BNE MLS_30          ; -> error: end address only with SAVE
          LDA #0
          STA SA
          LDA #M_Cval         ; address of start address
          JSR K_SAVESP        ; perform SAVE
MLS_50    JMP Mon_Main

; LOAD or VERIFY

MLS_60    LDA K_VERCK         ; mode
          CMP #'V'            ; VERIFY ?
          BEQ MLS_70
          CMP #'L'            ; LOAD ?
          BNE MLS_30          ; -> error: neither VERIFY nor LOAD
          LDA #0              ; 0 = LOAD
MLS_70    JSR K_LOADSP        ; perform LOAD or VERIFY
          LDA STATUS
          AND #%0001 0000     ; $10 check verify error flag
          BEQ MLS_50          ; -> OK
          LDA K_VERCK
          BEQ MLS_30          ; was loading -> OK
          JSR K_PRIMM         ; start verify error message
          .BYTE " ERROR",0
          JMP Mon_Main

; only start address was given

MLS_80    LDX M_Cval
          LDY M_Cval+1
          LDA #0
          STA SA
          BEQ MLS_60

; ****************
  Mon_Fill ; $b3db
; ****************

          JSR Mon_Range       ; get fill range
          BCS MoFi_Err        ; -> error
          LDA M_Cval+2
          CMP M_Temp+2        ; compare bank in range
          BNE MoFi_Err
          JSR Mon_Got_Aval    ; iAval = fill byte
          BCS MoFi_Err
          LDY #0
MoFi_10   LDA M_Aval          ; fill byte
          JSR Mon_Stash       ; store it
          JSR K_STOP
          BEQ MoFi_20
          JSR Mon_Inc_Cval    ; increment fill address
          JSR Mon_Dec_Bval    ; decrement fill count
          BCS MoFi_10         ; -> loop
MoFi_20   JMP Mon_Main
MoFi_Err  JMP Mon_Error

; ********************
  Mon_Assemble ; $b406
; ********************

; Strategy: convert operand to disassembler format
; Loop opcode from 0 to 255 and call disassembler
; until mnemonic and operand match.

          BCS MoAs_20         ; -> error: missing PC address
          JSR Mon_Aval_To_Cval    ; Cval := PC
MoAs_10   LDX #0
          STX M_Operand+1
          STX M_Count
MoAs_12   JSR Mon_Get_Char
          BNE MoAs_14         ; -> continue
          CPX #0
          BNE MoAs_14
          JMP Mon_Main        ; -> no input after address
MoAs_14   CMP #' '
          BEQ MoAs_10         ; -> skip blank
          STA M_Mne,X         ; store mnemonic character
          INX
          CPX #3              ; length of a mnemonic
          BNE MoAs_12         ; -> loop for more
MoAs_16   DEX                 ; x = mnemonix index
          BMI MoAs_22         ; -> loop finished
          LDA M_Mne,X         ; A = mnemonic charcater
          SEC
          SBC #$3f            ; convert to 5-bit value
          LDY #5
MoAs_18   LSR A               ; rotate 5-bit value into (M_Operand)
          ROR M_Operand+1
          ROR M_Operand
          DEY
          BNE MoAs_18         ; -> loop bits of 5-bit character
          BEQ MoAs_16         ; -> loop mnemonic charcters

MoAs_20   JMP Mon_Error       ; -> error exit

MoAs_22   LDX #2              ; store operand after compressed mnemonic
MoAs_24   LDA M_Count         ; unread bytes in buffer
          BNE MoAs_34         ; -> more to read
          JSR Mon_Eval        ; evaluate operand
          BEQ MoAs_32         ; -> no characters evaluated
          BCS MoAs_20         ; -> error during evaluation
          LDA #'$'
          STA M_Operand,X     ; start operand with '$'
          INX
          LDA M_Aval+2        ; check bank byte of operand
          BNE MoAs_20         ; -> error: not allowed
          LDY #4              ; default length of address
          LDA M_Shift         ; base (16,10,8,2)
          CMP #8
          BCC MoAs_26         ; -> base = 2
          CPY M_Count
          BEQ MoAs_28         ; -> no fillup necessary
MoAs_26   LDA M_Aval+1        ; high byte
          BNE MoAs_28         ; -> not zero
          LDY #2              ; insert '00' for high byte
MoAs_28   LDA #'0'            ; insert leading zero
MoAs_30   STA M_Operand,X
          INX
          DEY
          BNE MoAs_30         ; loop for leading 0
MoAs_32   DEC DS_LEN
MoAs_34   JSR Mon_Get_Char
          BEQ MoAs_36         ; -> end of operand
          CMP #' '
          BEQ MoAs_24         ; skip blank
          STA M_Operand,X          ; store operand byte
          INX
          CPX #10             ; maximum operand length
          BCC MoAs_24         ; loop
          BCS MoAs_20         ; -> error: operand too long

MoAs_36   STX M_Bval          ; save X
          LDX #0
          STX M_Opcode

MoAs_38   LDX #0              ; loop body for next opcode
          STX PTR_HI            ; reset operand index
          LDA M_Opcode
          JSR Mon_Analyze_Opcode
          LDX M_Format
          STX M_Bval+1        ; save operand format
          TAX
          LDA Mon_Mne_Right,X     ; compressed left  half of mnemonic
          JSR Mon_Match_Operand
          LDA Mon_Mne_Left,X      ; compressed right half of mnemonic
          JSR Mon_Match_Operand   ;  6  5  4  3  2  1
          LDX #6              ;  $  (  #  ,  )  ,
                              ;     $  $  X     Y

MoAs_40   CPX #3              ; ",X" mode
          BNE MoAs_44
          LDY M_Op_Size
          BEQ MoAs_44         ; -> no operand
MoAs_42   LDA M_Format
          CMP #$e8            ; 11101 << 3 (2 byte instructions)
          LDA #'0'            ; high byte
          BCS MoAs_48         ; -> not a ZP mode
          JSR Mon_Match_Double    ; match "00"
          DEY
          BNE MoAs_42
MoAs_44   ASL M_Format        ; next address mode bit
          BCC MoAs_46         ; -> not set
          LDA Mon_Char1-1,X
          JSR Mon_Match_Operand   ; match 1st. character
          LDA Mon_Char2-1,X
          BEQ MoAs_46
          JSR Mon_Match_Operand   ; match 2nd. character
MoAs_46   DEX
          BNE MoAs_40         ; -> loop next M_Format bit
          BEQ MoAs_50         ; -> always

MoAs_48   JSR Mon_Match_Double    ; match "00"
          JSR Mon_Match_Double    ; match "00"
MoAs_50   LDA M_Bval
          CMP PTR_HI            ; operand index
          BEQ MoAs_52
          JMP MaOp_10
MoAs_52   LDY M_Op_Size
          BEQ MoAs_62         ; -> implicit mode
          LDA M_Bval+1        ; copy of M_Format
          CMP #$9d            ; relative (branches)
          BNE MoAs_58         ; -> no
          LDA M_Aval          ; handle branch instruction
          SBC M_Cval
          TAX                 ; X = low byte of distance
          LDA M_Aval+1
          SBC M_Cval+1
          BCC MoAs_54
          BNE MoAs_Err        ; error: branch out of range
          CPX #$82
          BCS MoAs_Err        ; error: branch out of range
          BCC MoAs_56         ; always

MoAs_54   TAY
          INY
          BNE MoAs_Err
          CPX #$82
          BCC MoAs_Err
MoAs_56   DEX                 ; adjust distance by subtracting 2
          DEX
          TXA
          LDY M_Op_Size
          BNE MoAs_60         ; -> implicit mode

MoAs_58   LDA FACTPB+1,Y      ; store operand bytes
MoAs_60   JSR Mon_Stash
          DEY
          BNE MoAs_58
MoAs_62   LDA M_Opcode
          JSR Mon_Stash       ; store opcode
          JSR Mon_BOL         ; Beginnig Of Line
          JSR K_PRIMM
          .BYTE "A ",ESC,"Q",0
          JSR Mon_Print_Code  ; print disassembled instruction
          INC M_Op_Size
          LDA M_Op_Size
          JSR Mon_Add_Cval
          LDA #'A'            ; A bxxxx " into keyboard buffer
          STA KEYD
          LDA #' '
          STA KEYD+1
          STA KEYD+7
          LDA M_Cval+2
          JSR Mon_Bin_To_Hex
          STX KEYD+2          ; bank
          LDA M_Cval+1
          JSR Mon_Bin_To_Hex
          STA KEYD+3          ; high byte
          STX KEYD+4
          LDA M_Cval
          JSR Mon_Bin_To_Hex
          STA KEYD+5          ; low byte
          STX KEYD+6
          LDA #8              ; force length of keyboard buffer
          STA NDX
          JMP Mon_Main
MoAs_Err  JMP Mon_Error

; ************************
  Mon_Match_Double ; $b57c
; ************************

          JSR Mon_Match_Operand

; *************************
  Mon_Match_Operand ; $b57f
; *************************

          STX M_Save_XR       ; save X
          LDX PTR_HI            ; operand index
          CMP M_Operand,X          ; compare A with operand byte
          BEQ MaOp_20         ; -> match
          PLA
          PLA                 ; remove return address
MaOp_10   INC M_Opcode          ; next opcode
          BEQ MoAs_Err        ; -> error: no matching code found
          JMP MoAs_38         ; -> try next opcode
MaOp_20   INC PTR_HI            ; increase operand index
          LDX M_Save_XR       ; restore X
          RTS

; ***********************
  Mon_Disassemble ; $b599
; ***********************

          BCS MoDi_10         ; -> no range: disassemble 20 lines
          JSR Mon_Aval_To_Cval    ; Cval := start of disassembly
          JSR Mon_Got_Aval    ; Aval := end   of disassembly
          BCC MoDi_12
MoDi_10   LDA #20
          STA M_Aval
          BNE MoDi_14         ; always

MoDi_12   JSR Mon_Aval_Minus_Cval ; Aval := range
          BCC MoDi_Err
MoDi_14   JSR K_PRIMM
          .BYTE CR,ESC,"Q",0  ; CR, delete to end of line
          JSR K_STOP
          BEQ MoDi_End
          JSR Mon_Dis_Code    ; Disassembler instruction
          INC M_Op_Size      ; add opcode to operand length
          LDA M_Op_Size      ; total length of instruction
          JSR Mon_Add_Cval    ; advance Cval
          LDA M_Op_Size
          JSR Mon_Sub_Aval    ; subtract length from range
          BCS MoDi_14         ; -> loop
MoDi_End  JMP Mon_Main
MoDi_Err  JMP Mon_Error

; ********************
  Mon_Dis_Code ; $b5d4
; ********************

          LDA #'.'
          JSR K_BSOUT
          JSR Mon_Blank

; **********************
  Mon_Print_Code ; $b5dc
; **********************

          JSR Mon_Hex_Cval        ; format address
          JSR Mon_Blank
          LDY #0
          JSR Mon_Fetch
          JSR Mon_Analyze_Opcode
          PHA                 ; push opcode
          LDX M_Op_Size      ; operand length
          INX                 ; plus opcode
MoPC_10   DEX
          BPL MoPC_15         ; -> opcode present
          JSR K_PRIMM
          .BYTE "   ",0       ; no opcode, print blanks
          JMP MoPC_20
MoPC_15   JSR Mon_Fetch       ; get instruction byte
          JSR Mon_Hex_Blank   ; print it
MoPC_20   INY
          CPY #3              ; up to three bytes
          BCC MoPC_10         ; -> loop
          PLA                 ; pull opcode
          LDX #3              ; print 3 character
          JSR Mon_Mnemonic
          LDX #6              ; process 6 format bits
MoPC_25   CPX #3              ; ,X mode
          BNE MoPC_35
          LDY M_Op_Size      ; operand length
          BEQ MoPC_35         ; -> no operand
MoPC_30   LDA M_Format
          CMP #$e8            ; 11101 << 3 (2 byte instructions)
          PHP
          JSR Mon_Fetch       ; get operand byte
          PLP
          BCS MoPC_50         ; -> not a ZP mode
          JSR Mon_Hex
          DEY
          BNE MoPC_30
MoPC_35   ASL M_Format
          BCC MoPC_40
          LDA Mon_Char1-1,X   ; 1st. char of address mode
          JSR K_BSOUT
          LDA Mon_Char2-1,X   ; 2nd. char of address mode
          BEQ MoPC_40
          JSR K_BSOUT
MoPC_40   DEX
          BNE MoPC_25         ; loop operand format
          RTS
MoPC_50   JSR MoPC_60
          CLC
          ADC #1
          BNE MoPC_55
          INX
MoPC_55   JMP Mon_Hex_Word    ; print word operand
MoPC_60   LDX M_Cval+1      ; add signed (A) to Cval
          TAY
          BPL MoPC_65
          DEX
MoPC_65   ADC M_Cval
          BCC MoPC_Ret
          INX
MoPC_Ret  RTS

; **************************
  Mon_Analyze_Opcode ; $b659
; **************************

; instruction pattern: aaa bbb cc
; aaa = instruction
; bbb = addressing mode
; cc  = group

; 1. analyze group cc
; ------------------------------------------
; cc = 00  one byte instructions, branches
; cc = 01  ORA,AND,EOR,ADC,STA,LDA,CMP,SBC
; cc = 10  ASL,ROL,LSR,ROR,STX,LDX,DEC,INC
; cc = 11  illegal opcodes

          TAY                 ; save opcode
          LSR A               ; bit 0 -> carry
          BCC AnOp_10
          LSR A               ; bit 1 -> carry
          BCS AnOp_30         ; 11 -> no valid opcode
          CMP #$22            ; invalid opcode $89 ?
          BEQ AnOp_30
          AND #7              ; mask addressing mode bbb
          ORA #$80            ; set bit 7
AnOp_10   LSR A               ; A,X = aaa bbb (cc = x0)
          TAX                 ; A,X = aaa bb  (cc = 10)
          LDA Mon_Mode,X      ; get addressing mode index
          BCS AnOp_20         ; branch on cc = 10
          LSR A               ; move nibble for cc = 00
          LSR A
          LSR A
          LSR A
AnOp_20   AND #15             ; mask addressing mode index
          BNE AnOp_40         ; branch for valid mode
AnOp_30   LDY #$80            ; set invalid opcode
          LDA #0
AnOp_40   TAX                 ; X = addressing mode index
          LDA Mon_Address,X   ; A = addressing mode format
          STA M_Format        ; format
          AND #3
          STA M_Op_Size
          TYA                 ; restore opcode
          AND #$8f            ; mask
          TAX
          TYA                 ; restore opcode
          LDY #3
          CPX #$8a            ; TXS,TAX,TSX,DEX,NOP
          BEQ AnOp_70
AnOp_50   LSR A
          BCC AnOp_70
          LSR A
AnOp_60   LSR A
          ORA #$20
          DEY
          BNE AnOp_60
          INY
AnOp_70   DEY
          BNE AnOp_50
          RTS

; ********************
  Mon_Mnemonic ; $b6a1
; ********************

          TAY
          LDA Mon_Mne_Left,Y
          STA M_Bval
          LDA Mon_Mne_Right,Y
          STA M_Bval+1
MoMn_10   LDA #0
          LDY #5              ; 5 bit encoding
MoMn_20   ASL M_Bval+1
          ROL M_Bval
          ROL A
          DEY
          BNE MoMn_20
          ADC #$3f            ; add offset
          JSR K_BSOUT
          DEX
          BNE MoMn_10
          JMP Mon_Blank

; ****************
  Mon_Mode ; $b6c3
; ****************

          .BYTE $40           ; $4 BRK        $0 ---
          .BYTE $02           ; $0 ---        $2 ASL zz
          .BYTE $45           ; $4 PHP        $5 ASL A
          .BYTE $03           ; $0 ---        $3 ASL nnnn

          .BYTE $d0           ; $d BPL oo     $0 ---
          .BYTE $08           ; $0 ---        $8 ASL zz,X
          .BYTE $40           ; $4 CLC        $0 ---
          .BYTE $09           ; $0 ---        $9 ASL nnnn,X

          .BYTE $30           ; $3 JSR nnnn   $0 --
          .BYTE $22           ; $2 BIT zz     $2 ROL zz
          .BYTE $45           ; $4 PLP        $5 ROL A
          .BYTE $33           ; $3 BIT nnnn   $3 ROL nnnn

          .BYTE $d0           ; $d BMI oo     $0 ---
          .BYTE $08           ; $0 ---        $8 ROL zz,X
          .BYTE $40           ; $4 SEC        $0 ---
          .BYTE $09           ; $0 ---        $9 ROL nnnn,X

          .BYTE $40           ; $4 RTI        $0 ---
          .BYTE $02           ; $0 ---        $2 LSR zz
          .BYTE $45           ; $4 PHA        $5 LSR A
          .BYTE $33           ; $3 JMP nnnn   $3 LSR nnnn

          .BYTE $d0           ; $d BVC oo     $0 ---
          .BYTE $08           ; $0 ---        $8 LSR zz,X
          .BYTE $40           ; $4 CLI        $0 ---
          .BYTE $09           ; $0 ---        $9 LSR nnnn,X

          .BYTE $40           ; $4 RTS        $0 ---
          .BYTE $02           ; $0 ---        $2 ROR zz
          .BYTE $45           ; $4 PLA        $5 ROR A
          .BYTE $b3           ; $b JMP (nnnn) $3 ROR nnnn

          .BYTE $d0           ; $d BVS oo     $0 ---
          .BYTE $08           ; $0 ---        $8 ROR zz,X
          .BYTE $40           ; $4 SEI        $0 ---
          .BYTE $09           ; $0 ---        $9 ROR nnnn,X

          .BYTE $00           ; $0 ---        $0 ---
          .BYTE $22           ; $2 STY zz     $2 STX zz
          .BYTE $44           ; $4 DEY        $4 TXA
          .BYTE $33           ; $3 STY nnnn   $3 STX nnnn

          .BYTE $d0           ; $d BCC oo     $0 ---
          .BYTE $8c           ; $8 STY zz,X   $c STX zz,Y
          .BYTE $44           ; $4 TYA        $4 TXS
          .BYTE $00           ; $0 ---        $0 ---

          .BYTE $11           ; $1 LDY #      $1 LDX #
          .BYTE $22           ; $2 LDY zz     $2 LDX zz
          .BYTE $44           ; $4 TAY        $4 TAX
          .BYTE $33           ; $3 LDY nnnn   $3 LDX nnnn

          .BYTE $d0           ; $d BCS oo     $0 ---
          .BYTE $8c           ; $8 LDY zz,X   $c LDX zz,Y
          .BYTE $44           ; $4 CLV        $4 TSX
          .BYTE $9a           ; $9 LDY nnnn,X $a LDX nnnn,Y

          .BYTE $10           ; $1 CPY #      $0 ---
          .BYTE $22           ; $2 CPY zz     $2 DEC zz
          .BYTE $44           ; $4 INY        $4 DEX
          .BYTE $33           ; $3 CPY nnnn   $3 DEC nnnn

          .BYTE $d0           ; $d BNE oo     $0 ---
          .BYTE $08           ; $0 ---        $8 DEC zz,X
          .BYTE $40           ; $4 CLD        $0 ---
          .BYTE $09           ; $0 ---        $9 DEC nnnn,X

          .BYTE $10           ; $1 CPX #      $0 ---
          .BYTE $22           ; $2 CPX zz     $2 INC zz
          .BYTE $44           ; $4 INX        $4 NOP
          .BYTE $33           ; $3 CPX nnnn   $3 INC nnnn

          .BYTE $d0           ; $d BEQ oo     $0 ---
          .BYTE $08           ; $0 ---        $8 INC zz,X
          .BYTE $40           ; $4 SED        $0 ---
          .BYTE $09           ; $0 ---        $9 INC nnnn,X

          .BYTE $62           ; $6 (zz,X)     $2 zz
          .BYTE $13           ; $1 #          $3 nnnn
          .BYTE $78           ; $7 (zz),Y     $8 zz,X
          .BYTE $a9           ; $a nnnn,Y     $9 nnnn,X

; *******************
  Mon_Address ; $b707
; *******************

;                 76543210
;                 --------
;                 x         $
;                  x        ($
;                   x       #$
;                    x      ,X
;                     x     )
;                      x    ,Y
;                       xx  length - 1

           .BYTE %00000000  ; 0         implicit
           .BYTE %00100001  ; 1  $#     immediate
           .BYTE %10000001  ; 2  $zz    zeropage
           .BYTE %10000010  ; 3  $nnnn  absolute
           .BYTE %00000000  ; 4         implicit
           .BYTE %00000000  ; 5         implicit
           .BYTE %01011001  ; 6 ($zz,X) indexed indirect
           .BYTE %01001101  ; 7 ($zz),Y indirect indexed
           .BYTE %10010001  ; 8 $zz,X   zeropage,X
           .BYTE %10010010  ; 9 $nnnn,X absolute,X
           .BYTE %10000110  ; a $nnnn,Y absolute,Y
           .BYTE %01001010  ; b ($nnnn) indirect
           .BYTE %10000101  ; c $zz,Y   zeropage,Y
           .BYTE %10011101  ; d $nnnn   relative

;                 1    2    3    4    5    6
Mon_Char1  .BYTE ",", ")", ",", "#", "(", "$"
Mon_Char2  .BYTE "Y",  0 , "X", "$", "$",  0

; ********************
  Mon_Mne_Left ; $b721
; ********************

          .BYTE >"BRK"
          .BYTE >"PHP"
          .BYTE >"BPL"
          .BYTE >"CLC"
          .BYTE >"JSR"
          .BYTE >"PLP"
          .BYTE >"BMI"
          .BYTE >"SEC"
          .BYTE >"RTI"
          .BYTE >"PHA"
          .BYTE >"BVC"
          .BYTE >"CLI"
          .BYTE >"RTS"
          .BYTE >"PLA"
          .BYTE >"BVS"
          .BYTE >"SEI"
          .BYTE >"???"
          .BYTE >"DEY"
          .BYTE >"BCC"
          .BYTE >"TYA"
          .BYTE >"LDY"
          .BYTE >"TAY"
          .BYTE >"BCS"
          .BYTE >"CLV"
          .BYTE >"CPY"
          .BYTE >"INY"
          .BYTE >"BNE"
          .BYTE >"CLD"
          .BYTE >"CPX"
          .BYTE >"INX"
          .BYTE >"BEQ"
          .BYTE >"SED"
          .BYTE >"???"
          .BYTE >"BIT"
          .BYTE >"JMP"
          .BYTE >"JMP"
          .BYTE >"STY"
          .BYTE >"LDY"
          .BYTE >"CPY"
          .BYTE >"CPX"
          .BYTE >"TXA"
          .BYTE >"TXS"
          .BYTE >"TAX"
          .BYTE >"TSX"
          .BYTE >"DEX"
          .BYTE >"???"
          .BYTE >"NOP"
          .BYTE >"???"
          .BYTE >"ASL"
          .BYTE >"ROL"
          .BYTE >"LSR"
          .BYTE >"ROR"
          .BYTE >"STX"
          .BYTE >"LDX"
          .BYTE >"DEC"
          .BYTE >"INC"
          .BYTE >"ORA"
          .BYTE >"AND"
          .BYTE >"EOR"
          .BYTE >"ADC"
          .BYTE >"STA"
          .BYTE >"LDA"
          .BYTE >"CMP"
          .BYTE >"SBC"

; *********************
  Mon_Mne_Right ; $b761
; *********************

          .BYTE <"BRK"
          .BYTE <"PHP"
          .BYTE <"BPL"
          .BYTE <"CLC"
          .BYTE <"JSR"
          .BYTE <"PLP"
          .BYTE <"BMI"
          .BYTE <"SEC"
          .BYTE <"RTI"
          .BYTE <"PHA"
          .BYTE <"BVC"
          .BYTE <"CLI"
          .BYTE <"RTS"
          .BYTE <"PLA"
          .BYTE <"BVS"
          .BYTE <"SEI"
          .BYTE <"???"
          .BYTE <"DEY"
          .BYTE <"BCC"
          .BYTE <"TYA"
          .BYTE <"LDY"
          .BYTE <"TAY"
          .BYTE <"BCS"
          .BYTE <"CLV"
          .BYTE <"CPY"
          .BYTE <"INY"
          .BYTE <"BNE"
          .BYTE <"CLD"
          .BYTE <"CPX"
          .BYTE <"INX"
          .BYTE <"BEQ"
          .BYTE <"SED"
          .BYTE <"???"
          .BYTE <"BIT"
          .BYTE <"JMP"
          .BYTE <"JMP"
          .BYTE <"STY"
          .BYTE <"LDY"
          .BYTE <"CPY"
          .BYTE <"CPX"
          .BYTE <"TXA"
          .BYTE <"TXS"
          .BYTE <"TAX"
          .BYTE <"TSX"
          .BYTE <"DEX"
          .BYTE <"???"
          .BYTE <"NOP"
          .BYTE <"???"
          .BYTE <"ASL"
          .BYTE <"ROL"
          .BYTE <"LSR"
          .BYTE <"ROR"
          .BYTE <"STX"
          .BYTE <"LDX"
          .BYTE <"DEC"
          .BYTE <"INC"
          .BYTE <"ORA"
          .BYTE <"AND"
          .BYTE <"EOR"
          .BYTE <"ADC"
          .BYTE <"STA"
          .BYTE <"LDA"
          .BYTE <"CMP"
          .BYTE <"SBC"

          .BYTE "\r   "       ; unused

; ********************
  Mon_Get_Aval ; $b7a5
; ********************

          DEC DS_LEN

; ********************
  Mon_Got_Aval ; $b7a7
; ********************

          JSR Mon_Eval
          BCS MoGA_20
          JSR Mon_Got_Char
          BNE MoGA_10         ; -> not at end
          DEC DS_LEN          ; buffer index
          LDA M_Count         ; bytes read
          BNE MoGA_40         ; -> return with carry clear (OK)
          BEQ MoGA_30         ; -> return with carry set

MoGA_10   CMP #' '
          BEQ MoGA_40         ; delimiter blank
          CMP #','
          BEQ MoGA_40         ; delimiter comma
MoGA_20   PLA
          PLA                 ; remove return address
          JMP Mon_Error

MoGA_30   SEC
          .BYTE $24           ; skip CLC
MoGA_40   CLC
          LDA M_Count
          RTS

; ****************
  Mon_Eval ; $b7ce
; ****************

          LDA #0              ; clear result
          STA M_Aval
          STA M_Aval+1
          STA M_Aval+2
          STA M_Count         ; # of chars
          TXA                 ; save X
          PHA
          TYA                 ; save Y
          PHA
MoEv_10   JSR Mon_Get_Char
          BNE MoEv_15
          JMP MoEv_65         ; -> finish

MoEv_15   CMP #' '
          BEQ MoEv_10         ; -> skip blanks

          LDX #3
MoEv_20   CMP cmdnum,X        ; $ + & %
          BEQ MoEv_25
          DEX
          BPL MoEv_20
          INX
          DEC DS_LEN          ; buffer index
MoEv_25   LDY Mon_Base,X      ; 16 ($), 10 (+), 8 (&), 2 (%)
          LDA Mon_Shift,X     ;  4       3      3      1
          STA M_Shift
MoEv_30   JSR Mon_Get_Char
          BEQ MoEv_65
          SEC
          SBC #'0'
          BCC MoEv_65         ; -> below '0' not alphanumeric
          CMP #10
          BCC MoEv_35         ; -> inside (0 - 9)
          SBC #7
          CMP #16             ; hex ?
          BCS MoEv_65         ; -> invalid

MoEv_35   STA M_Number          ; store digit
          CPY M_Number          ; compare with base
          BCC MoEv_60         ; -> out of range
          BEQ MoEv_60         ; -> out of range
          INC M_Count         ; # of chars
          CPY #10             ; base 10 ?
          BNE MoEv_45         ; -> no

          LDX #2
MoEv_40   LDA M_Aval,X      ; TEMPS = TENEXP
          STA M_Temp,X
          DEX
          BPL MoEv_40

MoEv_45   LDX M_Shift           ; shifts for base 16, 8 or 2
MoEv_50   ASL M_Aval
          ROL M_Aval+1
          ROL M_Aval+2
          BCS MoEv_60
          DEX
          BNE MoEv_50

          CPY #10             ; base 10 ?
          BNE MoEv_55         ; -> no
          ASL M_Temp           ; M_Aval = TENEXP << 3 + TENEXP + TENEXP
          ROL M_Temp+1
          ROL M_Temp+2
          BCS MoEv_60
          LDA M_Temp
          ADC M_Aval
          STA M_Aval
          LDA M_Temp+1
          ADC M_Aval+1
          STA M_Aval+1
          LDA M_Temp+2
          ADC M_Aval+2
          STA M_Aval+2
          BCS MoEv_60         ; -> overflow

MoEv_55   CLC
          LDA M_Number
          ADC M_Aval
          STA M_Aval
          TXA
          ADC M_Aval+1
          STA M_Aval+1
          TXA
          ADC M_Aval+2
          STA M_Aval+2
          BCS MoEv_60         ; -> overflow
          AND #%1111 0000     ; check bank value
          BNE MoEv_60         ; -> overflow
          BEQ MoEv_30         ; -> OK
MoEv_60   SEC
          .BYTE $24
MoEv_65   CLC
          STY M_Shift
          PLA
          TAY                 ; restore Y
          PLA
          TAX                 ; restore X
          LDA M_Count         ; # of chars
          RTS

Mon_Base  .BYTE 16,10, 8, 2   ; supported bases for input
Mon_Shift .BYTE  4, 3, 3, 1   ; shifts for digit multiplying

; ********************
  Mon_Hex_Cval ; $b892
; ********************

          LDA M_Cval+2
          JSR Mon_Bin_To_Hex
          TXA
          JSR K_BSOUT
          LDA M_Cval
          LDX M_Cval+1

; ********************
  Mon_Hex_Word ; $b89f
; ********************

          PHA
          TXA
          JSR Mon_Hex
          PLA

; *********************
  Mon_Hex_Blank ; $b8a5
; *********************

          JSR Mon_Hex

; *****************
  Mon_Blank ; $b8a8
; *****************

          LDA #' '
          JMP K_BSOUT

; ***************
  Mon_BOL ; $b8ad
; ***************

          JSR K_PRIMM
          .BYTE CR,UP,0
          RTS

; **************
  Mon_CR ; $b8b4
; **************

          LDA #CR
          JMP K_BSOUT

; **********************
  Mon_Blank_Line ; $b8b9
; **********************

          JSR K_PRIMM
          .BYTE CR,ESC,"Q ",0
          RTS

; ***************
  Mon_Hex ; $b8c2
; ***************

          STX M_Save_XR
          JSR Mon_Bin_To_Hex
          JSR K_BSOUT
          TXA
          LDX M_Save_XR
          JMP K_BSOUT

; **********************
  Mon_Bin_To_Hex ; $b8d2
; **********************

          PHA
          JSR Mon_Nib_Hex
          TAX
          PLA
          LSR A
          LSR A
          LSR A
          LSR A

; *******************
  Mon_Nib_Hex ; $b8dc
; *******************

          AND #15
          CMP #10
          BCC MoNH_10
          ADC #6
MoNH_10   ADC #'0'
          RTS

; ********************
  Mon_Got_Char ; $b8e7
; ********************

          DEC DS_LEN

; ********************
  Mon_Get_Char ; $b8e9
; ********************

          STX M_Save_XR       ; save X
          LDX DS_LEN          ; buffer index
          LDA BUF,X
          BEQ MGNC_10         ; zero -> exit
          CMP #':'
          BEQ MGNC_10         ; set Z flag for ':'
          CMP #'?'            ; set Z flag for '?'
MGNC_10   PHP                 ; push flags
          INC DS_LEN          ; buffer index
          LDX M_Save_XR       ; restore X
          PLP                 ; pull flags
          RTS

; ************************
  Mon_Aval_To_Cval ; $b901
; ************************

; Copy Aval (3 bytes at M_Aval) to Bval (3 bytes at M_Cval)

          LDA M_Aval
          STA M_Cval
          LDA M_Aval+1
          STA M_Cval+1
          LDA M_Aval+2
          STA M_Cval+2
          RTS

; ***************************
  Mon_Aval_Minus_Cval ; $b90e
; ***************************

          SEC
          LDA M_Aval
          SBC M_Cval
          STA M_Aval
          LDA M_Aval+1
          SBC M_Cval+1
          STA M_Aval+1
          LDA M_Aval+2
          SBC M_Cval+2
          STA M_Aval+2
          RTS

; ********************
  Mon_Dec_Aval ; $b922
; ********************

          LDA #1

; ********************
  Mon_Sub_Aval ; $b924
; ********************

          STA M_Save_XR
          SEC
          LDA M_Aval
          SBC M_Save_XR
          STA M_Aval
          LDA M_Aval+1
          SBC #0
          STA M_Aval+1
          LDA M_Aval+2
          SBC #0
          STA M_Aval+2
          RTS

; ********************
  Mon_Dec_Bval ; $b93c
; ********************

          SEC
          LDA M_Bval
          SBC #1
          STA M_Bval
          LDA M_Bval+1
          SBC #0
          STA M_Bval+1
          LDA M_Bval+2
          SBC #0
          STA M_Bval+2
          RTS

; ********************
  Mon_Inc_Cval ; $b950
; ********************

          LDA #1

; ********************
  Mon_Add_Cval ; $b952
; ********************

          CLC
          ADC M_Cval
          STA M_Cval
          BCC MoAC_Ret
          INC M_Cval+1
          BNE MoAC_Ret
          INC M_Cval+2
MoAC_Ret  RTS

; ********************
  Mon_Dec_Cval ; $b960
; ********************

          SEC
          LDA M_Cval
          SBC #1
          STA M_Cval
          LDA M_Cval+1
          SBC #0
          STA M_Cval+1
          LDA M_Cval+2
          SBC #0
          STA M_Cval+2
          RTS

; ***********************
  Mon_Aval_To_PCB ; $b974
; ***********************

          BCS MPCB_Ret
          LDA M_Aval
          LDY M_Aval+1
          LDX M_Aval+2
          STA PC_LO
          STY PC_HI
          STX BANK
MPCB_Ret  RTS

; *****************
  Mon_Range ; $b983
; *****************

; Parse a range of 20 bit values (16 bit address and 4 bit bank)

; Output: Bval  = range
;         Cval  = 1st. address
;         M_Temp = 2nd. address
;         C = 0 : OK,  C = 1 : Error

          BCS MoRa_Err
          JSR Mon_Aval_To_Cval ; Cval  = 1st. address
          JSR Mon_Got_Aval     ; Aval  = 2nd. address
          BCS MoRa_Err
          LDA M_Aval           ; M_Temp = 2nd. address
          STA M_Temp
          LDA M_Aval+1
          STA M_Temp+1
          LDA M_Aval+2
          STA M_Temp+2
          JSR Mon_Aval_Minus_Cval ; Aval = range
          LDA M_Aval              ; Bval = range
          STA M_Bval
          LDA M_Aval+1
          STA M_Bval+1
          LDA M_Aval+2
          STA M_Bval+2
          BCC MoRa_Err
          CLC
          .BYTE $24
MoRa_Err  SEC
          RTS

; *******************
  Mon_Convert ; $b9b1
; *******************

          JSR Mon_Get_Aval    ; read value
          JSR Mon_Blank_Line
          LDA #'$'            ; hex number
          JSR K_BSOUT
          LDA M_Aval+2
          BEQ MoCo_10         ; bank value ?
          JSR Mon_Bin_To_Hex
          TXA
          JSR K_BSOUT
MoCo_10   LDA M_Aval
          LDX M_Aval+1
          JSR Mon_Hex_Word
          JSR Mon_Blank_Line
          LDA # '+'           ; decimal number
          JSR K_BSOUT
          JSR Mon_Bin_BCD
          LDA #0              ; suppress leading zeroes
          LDX #8              ; # of digits
          LDY #3              ; bits per digit - 1
          JSR Mon_Print_Number
          JSR Mon_Blank_Line
          LDA #'&'            ; octal number
          JSR K_BSOUT
          LDA #0              ; suppress leading zeroes
          LDX #8              ; # of digits
          LDY #2              ; bits per digit - 1
          JSR Mon_Print_Aval
          JSR Mon_Blank_Line
          LDA #'%'            ; dual number
          JSR K_BSOUT
          LDA #0              ; suppress leading zeroes
          LDX #24             ; # of digits
          LDY #0              ; bits per digit - 1
          JSR Mon_Print_Aval
          JMP Mon_Main

; *******************
  Mon_Bin_BCD ; $ba07
; *******************

; Input : Aval = 24 bit binary integer
; Output: M_Operand =  8 digit BCD  integer

          JSR Mon_Aval_To_Cval
          LDA #0
          LDX #7
MoBD_10   STA M_Operand,X
          DEX
          BPL MoBD_10
          INC M_Operand+7
          LDY #23             ; 24 bits for 3 bytes
          PHP
          SEI                 ; disable interrupt
          SED                 ; set decimal mode
MoBD_20   LSR M_Cval+2
          ROR M_Cval+1
          ROR M_Cval
          BCC MoBD_40         ; -> skip adding
          CLC
          LDX #3
MoBD_30   LDA M_Operand+4,X
          ADC M_Operand,X
          STA M_Operand,X
          DEX
          BPL MoBD_30
MoBD_40   CLC
          LDX #3
MoBD_50   LDA M_Operand+4,X
          ADC M_Operand+4,X
          STA M_Operand+4,X
          DEX
          BPL MoBD_50         ; double M_Operand+4
          DEY
          BPL MoBD_20         ; loop for next bit
          PLP                 ; clear decimal and IRQ mode
          RTS

; **********************
  Mon_Print_Aval ; $ba47
; **********************

          PHA
          LDA M_Aval
          STA M_Operand+2
          LDA M_Aval+1
          STA M_Operand+1
          LDA M_Aval+2
          STA M_Operand
          LDA #0
          STA M_Operand+3
          PLA

; ************************
  Mon_Print_Number ; $ba5d
; ************************

; Input : A = 0 suppress printing of leading zeroes
;         X = # of digits to print
;         Y = # of shifts formatting
;         (M_Operand) := four byte binary number

          STA M_Count       ; suppress leading zeroes ?
          STY M_Shift
MoPN_10   LDY M_Shift
          LDA #0
MoPN_20   ASL M_Operand+3
          ROL M_Operand+2
          ROL M_Operand+1
          ROL M_Operand
          ROL A
          DEY                 ; rotate SHIFT bytes into A
          BPL MoPN_20
          TAY
          BNE MoPN_30         ; -> print digit if not 0
          CPX #1
          BEQ MoPN_30         ; -> print digit if last
          LDY M_Count
          BEQ MoPN_40         ; -> skip leading zeroes
MoPN_30   INC M_Count       ; -> switch off zero suppression
          ORA #'0'            ; convert digit to ASCII
          JSR K_BSOUT         ; print it
MoPN_40   DEX                 ; # of digits
          BNE MoPN_10
          RTS

; ****************
  Mon_Disk ; $ba90
; ****************

          BNE MonD_10
          LDX #8              ; default device
          BIT
MonD_10   LDX M_Aval
          CPX #4
          BCC MonD_Err        ; -> error: device <  4
          CPX #31
          BCS MonD_Err        ; -> error: device > 31
          STX M_Aval
          LDA #0
          STA M_Aval+2
          STA FNLEN
          TAX
          JSR K_SETBNK        ; bank 0
          JSR Mon_Get_Char
          DEC DS_LEN
          CMP #'$'            ; loading directory ?
          BEQ Mon_Dir         ; -> yes
          LDA #0              ; LA
          LDX M_Aval        ; FA
          LDY #15             ; SA
          JSR K_SETLFS
          JSR K_OPEN          ; OPEN 0,FA,15
          BCS MonD_50         ; -> error
          LDX #0
          JSR K_CKOUT         ; select output channel
          BCS MonD_50         ; -> error
MonD_20   LDX DS_LEN          ; buffer pointer
          INC DS_LEN
          LDA BUF,X           ; load command character
          BEQ MonD_30         ; -> finish
          JSR K_BSOUT         ; send to device
          BCC MonD_20         ; -> loop
MonD_30   JSR K_CLRCH         ; command has been sent
          JSR Mon_CR
          LDX #0
          JSR K_CHKIN         ; select input channel
          BCS MonD_50         ; -> error
MonD_40   JSR K_BASIN
          JSR K_BSOUT         ; get char and print
          CMP #CR             ; until CR
          BEQ MonD_50
          LDA STATUS
          AND #%1011 1111     ; check EOI flag
          BEQ MonD_40         ; loop

MonD_50   JSR K_CLRCH         ; clear channel
          LDA #0
          SEC
          JSR K_CLOSE         ; close command channel
          JMP Mon_Main
MonD_Err  JMP Mon_Error

; ***************
  Mon_Dir ; $bb03
; ***************

          LDY #$ff
          LDX DS_LEN          ; buffer pointer
          DEX
MDir_10   INY                 ; count length of pattern
          INX
          LDA BUF,X           ; pattern character
          BNE MDir_10         ; loop if not at end
          TYA                 ; A = length
          LDX DS_LEN          ; start of pattern low
          LDY #>BUF           ; start of pattern high
          JSR K_SETNAM
          LDA #0
          LDX M_Aval
          LDY #$60
          JSR K_SETLFS        ; OPEN 0,FA,$60 (LOAD)
          JSR K_OPEN
          BCS MonD_50         ; -> error
          LDX #0
          JSR K_CHKIN
          JSR Mon_CR
          LDY #3              ; load adr, link, blocks
MDir_20   STY M_Bval
MDir_30   JSR K_BASIN
          STA M_Aval        ; low byte
          LDA STATUS
          BNE MonD_50         ; -> finish
          JSR K_BASIN
          STA M_Aval+1      ; high byte
          LDA STATUS
          BNE MonD_50         ; -> finish
          DEC M_Bval
          BNE MDir_30         ; loop read word
          JSR Mon_Bin_BCD
          LDA #0
          LDX #8
          LDY #3
          JSR Mon_Print_Number ; blocks
          LDA #' '
          JSR K_BSOUT
MDir_40   JSR K_BASIN         ; print header / dir entry / free blcoks
          BEQ MDir_50
          LDX STATUS
          BNE MonD_50
          JSR K_BSOUT
          BCC MDir_40
MDir_50   JSR Mon_CR
          JSR K_STOP
          BEQ MonD_50
          LDY #2              ; link, blocks
          BNE MDir_20

          .FILL $bfc0-* ($ff) ; 1102 bytes

          .BYTE "(C)1986 COMMODORE ELECTRONICS"
          .BYTE ", LTD. ALL RIGHTS RESERVED."
          .BYTE $ff,$ff,$ff,$ff,$c8,$cd
          .WORD $c501 ; 15103

