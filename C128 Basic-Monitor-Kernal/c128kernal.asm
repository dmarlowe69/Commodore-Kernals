; Set KEYBOARD:
;   0 = Germany / Austria
;   2 = France / Belgium
;   3 = switzerland
;   4 = Sweden / Finland
;   5 = Norway
;   6 = Italy
; 255 = International / USA

KEYBOARD = 0
;.enc "petscii"  ;define an ascii->petscii encoding
.edef "\n", $0a  ;one byte control codes
.edef "\r", $0d  ;one byte control codes

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
;:w
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

;.STORE $4000, $4000, "4000.basiclo"
;.STORE $8000, $4000, "8000.basichi"
;.STORE $C000, $1000, "c000.edit"
;.STORE $E000, $2000, "e000.kernal"

* = $4000   ; *** 128.rom ***  Commodore 128


; ********************
  B_Cold_Start ; $4000
; ********************

          JMP Cold_Start

; ********************
  B_Warm_Start ; $4003
; ********************

          JMP Warm_Start

; *******************
  B_BASIC_IRQ ; $4006
; *******************

          JMP BASIC_IRQ

; ******************
  Warm_Start ; $4009
; ******************

          JSR K_CLRCH
          JSR Init_MMU
          JSR Stop_Sprites
          JSR Init_SID
          JSR Init_BASIC_Stack
          LDA #0 ; keyboard channel
          STA CHANNL
Go_Ready  CLI
          JMP BASIC_Ready

          .BYTE $00,$ff,$ff ; unused

; ******************
  Cold_Start ; $4023
; ******************

          JSR Init_MMU
          JSR Init_RAM_Vectors
          JSR Init_BASIC
          JSR Show_Startup_Message
          LDA INIT_STATUS
          ORA #1
          STA INIT_STATUS
          LDX #<B_Warm_Start
          STX RESET_VECTOR    ; switch from cold to warm start
          LDX #$fb
          TXS
          JSR K_PHOENIX
          JMP Go_Ready

; ******************
  Init_BASIC ; $4045
; ******************

          LDA #$4c ; JMP instruction
          STA JUMPER
          STA FUNC_USR
          LDA #<Error_Illegal_Quantity
          LDY #>Error_Illegal_Quantity
          STA FUNC_USR+1
          STY FUNC_USR+2
          LDA #<FAC1_To_Int_AY
          LDY #>FAC1_To_Int_AY
          STA ADRAY1
          STY ADRAY1+1
          LDA #<Integer_To_Real
          LDY #>Integer_To_Real
          STA ADRAY2
          STY ADRAY2+1
          LDX #$55 ; 'U'
InBA_10   LDA ROM_CHRGET-1,X
          STA CHRGET-1,X
          DEX
          BNE InBA_10
          STX BITS
          STX CHANNL
          STX LASTPT+1
          STX TRCFLG
          STX RAMBOT
          STX MVDFLG
          STX AUTINC
          STX AUTINC+1
          STX WIDTH
          STX SCALEM
          STX FILFLG
          STX RNDX
          STX DOS_FA
          STX INT_TRIP_FLAG
          STX INT_TRIP_FLAG+1
          STX Light_Pen_Flag
          STX INT_VAL
          LDY #$58 ; 'X'
InBA_20   STA SPRITE_DATA,Y
          DEY
          BPL InBA_20
          INX
          STX BUF-3
          STX BUF-4
          LDX #15
          STX USER_BANK
          LDX #13
          STX FG_COL
          LDX #1
          STX MULCO1
          LDX #2
          STX MULCO2
          JSR setpcl
          LDX #$1b
          STX TEMPPT
          LDX #<PROGRAM_START
          LDY #>PROGRAM_START
          STX TXTTAB
          STY TXTTAB+1
          LDA #<VAR_START
          LDY #>VAR_START
          STA VARTAB
          STY VARTAB+1
          LDA #<MMU_CR
          LDY #>MMU_CR
          STA TEXT_MAX
          STY TEXT_MAX+1
          LDA #<MMU_CR
          LDY #>MMU_CR
          STA MEMSIZ
          STY MEMSIZ+1

; Initialize sprite pointer

; sprite 0 : $07f8 : pointer = $38 ($38 * $40) = $0e00
; sprite 1 : $07f9 : pointer = $39 ($39 * $40) = $0e40
; sprite 7 : $07ff : pointer = $3f ($3f * $40) = $0fc0

          LDX #$3f
          LDY #7
InBA_30   TXA
          STA BASIC_STACK-8,Y
          DEX
          DEY
          BPL InBA_30

          LDA #0
          LDX #$6c
InBA_40   STA SPRITE_DATA,X
          DEX
          BPL InBA_40
          JSR Init_SID
          LDA #$d0
          STA CHARGEN_GRAF
          LDA #$d8
          STA CHARGEN_TEXT
          JMP NEW_10

; ****************
  Init_SID ; $4112
; ****************

          LDA #<$0120         ; default duration
          LDY #>$0120
          STA Snd_Dur_Tmp
          STY Snd_Dur_Tmp+1
          LDA #4
          STA Snd_Octave
          LDA #16
          STA Snd_Tempo
          LDA #0
          STA SID_Control_1
          STA SID_Control_2
          STA SID_Control_3
          STA IRQ_ACTIVE_FLAG
          LDA #15
          STA Old_Filter
          STA Old_Volume
          STA SID_Volume
          LDY #$1d
ISID_10   LDA stkmus,Y
          STA ATKTAB,Y
          DEY
          BPL ISID_10
          LDX #9
ISID_20   LDA pwhmus,X
          STA PULSHI,X
          DEX
          BPL ISID_20
          STX Sound_Duration_1_Hi
          STX Sound_Duration_2_Hi
          STX Sound_Duration_3_Hi
          STX Snd_Duration+1
          STX Snd_Duration+3
          STX Snd_Duration+5
          LDY #2
          STY VOICE
ISID_30   LDX #0
          JSR Set_Envelope
          DEC VOICE
          BPL ISID_30
ISID_40   INC VOICE
          RTS

; ****************
  Init_MMU ; $417a
; ****************

          JSR Map_IO
          LDX #3
IMMU_10   LDA MMU_Preconfiguration,X
          STA MMU_PCRA,X
          DEX
          BPL IMMU_10
          RTS

; ****************************
  MMU_Preconfiguration ; $4189
; ****************************

          .BYTE $3f
          .BYTE $7f
          .BYTE $01
          .BYTE $41

; ********************
  Stop_Sprites ; $418d
; ********************

          LDA #0
          LDY #7
StSp_10   LDX Sprite_Offset,Y
          STA SPRITE_DATA,X
          DEY
          BPL StSp_10
          RTS

; ****************************
  Show_Startup_Message ; $419b
; ****************************

          LDY #0
SSM_10    LDA Startup_Message,Y
          CMP #'@'
          BNE SSM_30
          BIT MODE_80
          BPL SSM_40
          LDX #$13
SSM_20    LDA #' '
          JSR B_BSOUT
          DEX
          BNE SSM_20
SSM_30    JSR B_BSOUT
SSM_40    INY
          CPY #$96
          BNE SSM_10
          RTS


; ***************
  Startup_Message
; ***************

           .BYTE $93,$0d,$40
           .TEXT " COMMODORE BASIC V7.0"
           .TEXT " 122365 BYTES FREE"
           .BYTE $0d,$40
           .TEXT "   (C)1986 COMMODORE"
           .TEXT " ELECTRONICS, LTD."
           .BYTE $0d,$40
           .TEXT "         (C)1977"
           .TEXT " MICROSOFT CORP."
           .BYTE $0d,$40
           .TEXT "           ALL RIGHTS"
           .TEXT " RESERVED\r",0


; ************************
  Init_RAM_Vectors ; $4251
; ************************

          LDX #$11
IRV_10    LDA ROM_BASIC_Vector_Table,X
          STA IERROR,X
          DEX
          BPL IRV_10
          LDA #<CALL_80       ; init USR vector
          STA USRVEC
          LDA #>CALL_80
          STA USRVEC+1
          RTS

; ******************************
  ROM_BASIC_Vector_Table ; $4267
; ******************************

          .WORD DEF_ERROR     ; $0300 IERROR
          .WORD DEF_MAIN      ; $0302 IMAIN
          .WORD DEF_CRUNCH    ; $0304 ICRNCH
          .WORD DEF_QPLOP     ; $0306 IQPLOP
          .WORD DEF_GONE      ; $0308 IGONE
          .WORD DEF_EVAL      ; $030a IEVAL
          .WORD DEF_ESCLK     ; $030c IESCLK
          .WORD DEF_ESCPR     ; $030e IESCPR
          .WORD DEF_ESCEX     ; $0310 IESCEX

; ******************
  ROM_CHRGET ; $4279
; ******************

          INC TXTPTR
          BNE CHRG_10
          INC TXTPTR+1
CHRG_10   STA MMU_LCRA
          LDY #0
          LDA (TXTPTR),Y
          STA MMU_LCRC
          CMP #':'
          BCS CHRG_RET
          CMP #' '
          BEQ ROM_CHRGET
          SEC
          SBC #$30 ; '0'
          SEC
          SBC #$d0
CHRG_RET  RTS

; *******************
  ROM_Fetch_0 ; $4298
; *******************

          STA Fetch_0+7       ; modify ZP address
          STA MMU_LCRA
          LDA (0),Y           ; <-- modified
          STA MMU_LCRC
          RTS

; *******************
  ROM_Fetch_1 ; $42a4
; *******************

          STA Fetch_1+7       ; modify ZP address
          STA MMU_LCRB
          LDA (0),Y           ; <-- modified
          STA MMU_LCRD
          RTS

; ************************
  ROM_Get_INDEXA_1 ; $42b0
; ************************

          STA MMU_LCRB
          LDA (INDEXA),Y
          STA MMU_LCRD
          RTS

; ************************
  ROM_Get_INDEXB_0 ; $42b9
; ************************

          STA MMU_LCRA
          LDA (INDEXB),Y
          STA MMU_LCRC
          RTS

; ******************
  ROM_INDTXT ; $42c2
; ******************

          STA MMU_LCRA
          LDA (TXTPTR),Y
          STA MMU_LCRC
          RTS

          .BYTE $00,$00,$00

; **************************
  GRBPNT_from_Bank_1 ; $42ce
; **************************

          LDA #GRBPNT
          JMP Fetch_1

; **************************
  FNDPNT_from_Bank_1 ; $42d3
; **************************

          LDA #FNDPNT
          JMP Fetch_1

; ********************
  Get_DSCPNT_1 ; $42d8
; ********************

          LDA #DSCPNT
          JMP Fetch_1

; ********************
  Get_HIGHTR_0 ; $42dd
; ********************

          LDA #HIGHTR
          JMP Fetch_0

; ********************
  Get_HIGHTR_1 ; $42e2
; ********************

          LDA #HIGHTR
          JMP Fetch_1

; *********************
  Get_FAC1_M3_1 ; $42e7
; *********************

          LDA #FAC1_M3
          JMP Fetch_1

; *******************
  Get_LOWTR_0 ; $42ec
; *******************

          LDA #LOWTR
          JMP Fetch_0

; ********************
  Get_STRPTR_0 ; $42f1
; ********************

          LDA #STRPTR
          JMP Fetch_0

; ********************
  Get_STRPTR_1 ; $42f6
; ********************

          LDA #STRPTR
          JMP Fetch_1

; *******************************
  GRBPNT_from_Bank_1_Copy ; $42fb
; *******************************

          LDA #GRBPNT
          JMP Fetch_1

; *******************
  Get_LOWTR_1 ; $4300
; *******************

          LDA #LOWTR
          JMP Fetch_1

; ********************
  Get_INDEXA_0 ; $4305
; ********************

          LDA #INDEXA
          JMP Fetch_0

; **************
  CRUNCH ; $430a
; **************

          JMP (ICRNCH)

; ******************
  DEF_CRUNCH ; $430d
; ******************

          LDA TXTPTR
          PHA
          LDA TXTPTR+1
          PHA
CRUN_05   JSR CHRGOT
          JMP CRUN_15
CRUN_10   JSR CHRGET
CRUN_15   BCC CRUN_10
          JMP (IESCLK)

; *****************
  DEF_ESCLK ; $4321
; *****************

          BCS CRUN_25
          JMP CRUN_85
CRUN_25   CMP #0
          BEQ CRUN_75
          CMP #$3a ; ':'
          BEQ CRUN_10
          CMP #$3f ; '?'
          BNE CRUN_30
          LDA #$99
          BNE CRUN_65
CRUN_30   CMP #$80
          BCC CRUN_35
          CMP #$ff
          BEQ CRUN_10
          LDY #1
          JSR kloop
          BEQ CRUN_05
CRUN_35   CMP #$22 ; '"'
          BNE CRUN_45
CRUN_40   JSR CHRGET
          CMP #0
          BEQ CRUN_75
          CMP #$22 ; '"'
          BEQ CRUN_10
          BNE CRUN_40
CRUN_45   LDA #$46 ; 'F'
          LDY #9
          JSR reser
          BCC CRUN_50
          LDA #$81
          LDX #0
          BEQ CRUN_80
CRUN_50   LDA #>BASIC_Keytab_D
          LDY #<BASIC_Keytab_D
          JSR reser
          BCC CRUN_55
          LDA #$81
          LDX #$ff
          BNE CRUN_80
CRUN_55   LDA #$44 ; 'D'
          LDY #$17
          JSR reser
          BCC CRUN_10
          CPY #0
          BEQ CRUN_60
          JSR kloop
CRUN_60   LDA B_COUNT
CRUN_65   LDY #0
          STA (TXTPTR),Y
          CMP #$8f
          BEQ CRUN_70
          CMP #$83
          BNE CRUN_10
          JSR CHRGET
          JSR Skip_Statement
          JMP CRUN_05
CRUN_70   JSR CHRGET
          JSR BASIC_REM
CRUN_75   LDX TXTPTR
          PLA
          STA TXTPTR+1
          PLA
          STA TXTPTR
          SEC
          TXA
          SBC TXTPTR
          TAY
          INY
          RTS

; ***************
  CRUN_80 ; $43b0
; ***************

          ADC B_COUNT
CRUN_85   PHA
          DEY
          JSR kloop
          LDA #$fe
          INX
          BNE CRUN_90
          LDA #$ce
CRUN_90   LDY #0
          STA (TXTPTR),Y
          INY
          PLA
          STA (TXTPTR),Y
          JSR CHRGET
          JMP CRUN_10

; *************
  kloop ; $43cc
; *************

          CLC
          TYA
          ADC TXTPTR
          STA INDEXA
          LDA TXTPTR+1
          ADC #0
          STA INDEXA+1
          LDY #$ff
kloop_10  INY
          LDA (INDEXA),Y
          STA (TXTPTR),Y
          BNE kloop_10
          RTS

; *************
  reser ; $43e2
; *************

          STA INDEXA+1
          STY INDEXA
          LDY #0
          STY B_COUNT
          DEY
reser_10  INY
reser_20  LDA (TXTPTR),Y
          SEC
          SBC (INDEXA),Y
          BEQ reser_10
          CMP #$80
          BEQ reser_60
reser_30  LDA (INDEXA),Y
          BMI reser_40
          INY
          BNE reser_30
reser_40  INY
          INC B_COUNT
          CLC
          TYA
          ADC INDEXA
          STA INDEXA
          BCC reser_50
          INC INDEXA+1
reser_50  CLC
          LDY #0
          LDA (INDEXA),Y
          BNE reser_20
reser_60  ORA B_COUNT
          STA B_COUNT
          RTS

; **********************
  BASIC_Keytab_A ; $4417
; **********************

          .SHIFT "END" ;^     ; $80
          .SHIFT "FOR" ;^     ; $81
          .SHIFT "NEXT" ;^    ; $82
          .SHIFT "DATA" ;^    ; $83
          .SHIFT "INPUT#" ;^  ; $84
          .SHIFT "INPUT" ;^   ; $85
          .SHIFT "DIM" ;^     ; $86
          .SHIFT "READ" ;^    ; $87
          .SHIFT "LET" ;^     ; $88
          .SHIFT "GOTO" ;^    ; $89
          .SHIFT "RUN" ;^     ; $8a
          .SHIFT "IF" ;^      ; $8b
          .SHIFT "RESTORE" ;^ ; $8c
          .SHIFT "GOSUB" ;^   ; $8d
          .SHIFT "RETURN" ;^  ; $8e
          .SHIFT "REM" ;^     ; $8f
          .SHIFT "STOP" ;^    ; $90
          .SHIFT "ON" ;^      ; $91
          .SHIFT "WAIT" ;^    ; $92
          .SHIFT "LOAD" ;^    ; $93
          .SHIFT "SAVE" ;^    ; $94
          .SHIFT "VERIFY" ;^  ; $95
          .SHIFT "DEF" ;^     ; $96
          .SHIFT "POKE" ;^    ; $97
          .SHIFT "PRINT#" ;^  ; $98
          .SHIFT "PRINT" ;^   ; $99
          .SHIFT "CONT" ;^    ; $9a
          .SHIFT "LIST" ;^    ; $9b
          .SHIFT "CLR" ;^     ; $9c
          .SHIFT "CMD" ;^     ; $9d
          .SHIFT "SYS" ;^     ; $9e
          .SHIFT "OPEN" ;^    ; $9f
          .SHIFT "CLOSE" ;^   ; $a0
          .SHIFT "GET" ;^     ; $a1
          .SHIFT "NEW" ;^     ; $a2
          .SHIFT "TAB(" ;^    ; $a3
          .SHIFT "TO" ;^      ; $a4
          .SHIFT "FN" ;^      ; $a5
          .SHIFT "SPC(" ;^    ; $a6
          .SHIFT "THEN" ;^    ; $a7
          .SHIFT "NOT" ;^     ; $a8
          .SHIFT "STEP" ;^    ; $a9
          .SHIFT "+" ;^       ; $aa
          .SHIFT "-" ;^       ; $ab
          .SHIFT "*" ;^       ; $ac
          .SHIFT "/" ;^       ; $ad
          .SHIFT "^" ;^       ; $ae
          .SHIFT "AND" ;^     ; $af
          .SHIFT "OR" ;^      ; $b0
          .SHIFT ">" ;^       ; $b1
          .SHIFT "=" ;^       ; $b2
          .SHIFT "<" ;^       ; $b3
          .SHIFT "SGN" ;^     ; $b4
          .SHIFT "INT" ;^     ; $b5
          .SHIFT "ABS" ;^     ; $b6
          .SHIFT "USR" ;^     ; $b7
          .SHIFT "FRE" ;^     ; $b8
          .SHIFT "POS" ;^     ; $b9
          .SHIFT "SQR" ;^     ; $ba
          .SHIFT "RND" ;^     ; $bb
          .SHIFT "LOG" ;^     ; $bc
          .SHIFT "EXP" ;^     ; $bd
          .SHIFT "COS" ;^     ; $be
          .SHIFT "SIN" ;^     ; $bf
          .SHIFT "TAN" ;^     ; $c0
          .SHIFT "ATN" ;^     ; $c1
          .SHIFT "PEEK" ;^    ; $c2
          .SHIFT "LEN" ;^     ; $c3
          .SHIFT "STR$" ;^    ; $c4
          .SHIFT "VAL" ;^     ; $c5
          .SHIFT "ASC" ;^     ; $c6
          .SHIFT "CHR$" ;^    ; $c7
          .SHIFT "LEFT$" ;^   ; $c8
          .SHIFT "RIGHT$" ;^  ; $c9
          .SHIFT "MID$" ;^    ; $ca
          .SHIFT "GO" ;^      ; $cb
          .SHIFT "RGR" ;^     ; $cc
          .SHIFT "RCLR" ;^    ; $cd
          .BYTE $80

; **********************
  BASIC_Keytab_B ; $451e
; **********************

          .SHIFT "JOY" ;^        ; $cf
          .SHIFT "RDOT" ;^       ; $d0
          .SHIFT "DEC" ;^        ; $d1
          .SHIFT "HEX$" ;^       ; $d2
          .SHIFT "ERR$" ;^       ; $d3
          .SHIFT "INSTR" ;^      ; $d4
          .SHIFT "ELSE" ;^       ; $d5
          .SHIFT "RESUME" ;^     ; $d6
          .SHIFT "TRAP" ;^       ; $d7
          .SHIFT "TRON" ;^       ; $d8
          .SHIFT "TROFF" ;^      ; $d9
          .SHIFT "SOUND" ;^      ; $da
          .SHIFT "VOL" ;^        ; $db
          .SHIFT "AUTO" ;^       ; $dc
          .SHIFT "PUDEF" ;^      ; $dd
          .SHIFT "GRAPHIC" ;^    ; $de
          .SHIFT "PAINT" ;^      ; $df
          .SHIFT "CHAR" ;^       ; $e0
          .SHIFT "BOX" ;^        ; $e1
          .SHIFT "CIRCLE" ;^     ; $e2
          .SHIFT "GSHAPE" ;^     ; $e3
          .SHIFT "SSHAPE" ;^     ; $e4
          .SHIFT "DRAW" ;^       ; $e5
          .SHIFT "LOCATE" ;^     ; $e6
          .SHIFT "COLOR" ;^      ; $e7
          .SHIFT "SCNCLR" ;^     ; $e8
          .SHIFT "SCALE" ;^      ; $e9
          .SHIFT "HELP" ;^       ; $ea
          .SHIFT "DO" ;^         ; $eb
          .SHIFT "LOOP" ;^       ; $ec
          .SHIFT "EXIT" ;^       ; $ed
          .SHIFT "DIRECTORY" ;^  ; $ee
          .SHIFT "DSAVE" ;^      ; $ef
          .SHIFT "DLOAD" ;^      ; $f0
          .SHIFT "HEADER" ;^     ; $f1
          .SHIFT "SCRATCH" ;^    ; $f2
          .SHIFT "COLLECT" ;^    ; $f3
          .SHIFT "COPY" ;^       ; $f4
          .SHIFT "RENAME" ;^     ; $f5
          .SHIFT "BACKUP" ;^     ; $f6
          .SHIFT "DELETE" ;^     ; $f7
          .SHIFT "RENUMBER" ;^   ; $f8
          .SHIFT "KEY" ;^        ; $f9
          .SHIFT "MONITOR" ;^    ; $fa
          .SHIFT "USING" ;^      ; $fb
          .SHIFT "UNTIL" ;^      ; $fc
          .SHIFT "WHILE" ;^      ; $fd
          .BYTE $00

; **********************
  BASIC_Keytab_C ; $4609
; **********************

          .SHIFT "BANK" ;^       ; $fe02
          .SHIFT "FILTER" ;^     ; $fe03
          .SHIFT "PLAY" ;^       ; $fe04
          .SHIFT "TEMPO" ;^      ; $fe05
          .SHIFT "MOVSPR" ;^     ; $fe06
          .SHIFT "SPRITE" ;^     ; $fe07
          .SHIFT "SPRCOLOR" ;^   ; $fe08
          .SHIFT "RREG" ;^       ; $fe09
          .SHIFT "ENVELOPE" ;^   ; $fe0a
          .SHIFT "SLEEP" ;^      ; $fe0b
          .SHIFT "CATALOG" ;^    ; $fe0c
          .SHIFT "DOPEN" ;^      ; $fe0d
          .SHIFT "APPEND" ;^     ; $fe0e
          .SHIFT "DCLOSE" ;^     ; $fe0f
          .SHIFT "BSAVE" ;^      ; $fe10
          .SHIFT "BLOAD" ;^      ; $fe11
          .SHIFT "RECORD" ;^     ; $fe12
          .SHIFT "CONCAT" ;^     ; $fe13
          .SHIFT "DVERIFY" ;^    ; $fe14
          .SHIFT "DCLEAR" ;^     ; $fe15
          .SHIFT "SPRSAV" ;^     ; $fe16
          .SHIFT "COLLISION" ;^  ; $fe17
          .SHIFT "BEGIN" ;^      ; $fe18
          .SHIFT "BEND" ;^       ; $fe19
          .SHIFT "WINDOW" ;^     ; $fe1a
          .SHIFT "BOOT" ;^       ; $fe1b
          .SHIFT "WIDTH" ;^      ; $fe1c
          .SHIFT "SPRDEF" ;^     ; $fe1d
          .SHIFT "QUIT" ;^       ; $fe1e
          .SHIFT "STASH" ;^      ; $fe1f
          .SHIFT " " ;^          ; $fe20
          .SHIFT "FETCH" ;^      ; $fe21
          .SHIFT " " ;^          ; $fe22
          .SHIFT "SWAP" ;^       ; $fe23
          .SHIFT "OFF" ;^        ; $fe24
          .SHIFT "FAST" ;^       ; $fe25
          .SHIFT "SLOW" ;^       ; $fe26
          .BYTE $00

; **********************
  BASIC_Keytab_D ; $46c9
; **********************

          .SHIFT "POT" ;^      ; $ce02
          .SHIFT "BUMP" ;^     ; $ce03
          .SHIFT "PEN" ;^      ; $ce04
          .SHIFT "RSPPOS" ;^   ; $ce05
          .SHIFT "RSPRITE" ;^  ; $ce06
          .SHIFT "RSPCOLOR" ;^ ; $ce07
          .SHIFT "XOR" ;^      ; $ce08
          .SHIFT "RWINDOW" ;^  ; $ce09
          .SHIFT "POINTER" ;^  ; $ce0a
          .BYTE $00,$00,$00

; **********************
  BASIC_Action_A ; $46fc
; **********************

          .WORD BASIC_END     - 1; $80
          .WORD BASIC_FOR     - 1; $81
          .WORD BASIC_NEXT    - 1; $82
          .WORD Skip_Statement- 1; $83 DATA
          .WORD BASIC_INPUT_D - 1; $84
          .WORD BASIC_INPUT   - 1; $85
          .WORD BASIC_DIM     - 1; $86
          .WORD BASIC_READ    - 1; $87
          .WORD BASIC_LET     - 1; $88
          .WORD BASIC_GOTO    - 1; $89
          .WORD BASIC_RUN     - 1; $8a
          .WORD BASIC_IF      - 1; $8b
          .WORD BASIC_RESTORE - 1; $8c
          .WORD BASIC_GOSUB   - 1; $8d
          .WORD BASIC_RETURN  - 1; $8e
          .WORD BASIC_REM     - 1; $8f
          .WORD BASIC_STOP    - 1; $90
          .WORD BASIC_ON      - 1; $91
          .WORD BASIC_WAIT    - 1; $92
          .WORD BASIC_LOAD    - 1; $93
          .WORD BASIC_SAVE    - 1; $94
          .WORD BASIC_VERIFY  - 1; $95
          .WORD BASIC_DEF     - 1; $96
          .WORD BASIC_POKE    - 1; $97
          .WORD BASIC_PRINT_D - 1; $98
          .WORD BASIC_PRINT   - 1; $99
          .WORD BASIC_CONT    - 1; $9a
          .WORD BASIC_LIST    - 1; $9b
          .WORD BASIC_CLR     - 1; $9c
          .WORD BASIC_CMD     - 1; $9d
          .WORD BASIC_SYS     - 1; $9e
          .WORD BASIC_OPEN    - 1; $9f
          .WORD BASIC_CLOSE   - 1; $a0
          .WORD BASIC_GET     - 1; $a1
          .WORD BASIC_NEW     - 1; $a2

; **********************
  BASIC_Action_B ; $4742
; **********************

          .WORD BASIC_ELSE     - 1; $d5
          .WORD BASIC_RESUME   - 1; $d6
          .WORD BASIC_TRAP     - 1; $d7
          .WORD BASIC_TRON     - 1; $d8
          .WORD BASIC_TROFF    - 1; $d9
          .WORD BASIC_SOUND    - 1; $da
          .WORD BASIC_VOL      - 1; $db
          .WORD BASIC_AUTO     - 1; $dc
          .WORD BASIC_PUDEF    - 1; $dd
          .WORD BASIC_GRAPHIC  - 1; $de
          .WORD BASIC_PAINT    - 1; $df
          .WORD BASIC_CHAR     - 1; $e0
          .WORD BASIC_BOX      - 1; $e1
          .WORD BASIC_CIRCLE   - 1; $e2
          .WORD BASIC_GSHAPE   - 1; $e3
          .WORD BASIC_SSHAPE   - 1; $e4
          .WORD BASIC_DRAW     - 1; $e5
          .WORD BASIC_LOCATE   - 1; $e6
          .WORD BASIC_COLOR    - 1; $e7
          .WORD BASIC_SCNCLR   - 1; $e8
          .WORD BASIC_SCALE    - 1; $e9
          .WORD BASIC_HELP     - 1; $ea
          .WORD BASIC_DO       - 1; $eb
          .WORD BASIC_LOOP     - 1; $ec
          .WORD BASIC_EXIT     - 1; $ed
          .WORD BASIC_DIRCAT   - 1; $ee
          .WORD BASIC_DSAVE    - 1; $ef
          .WORD BASIC_DLOAD    - 1; $f0
          .WORD BASIC_HEADER   - 1; $f1
          .WORD BASIC_SCRATCH  - 1; $f2
          .WORD BASIC_COLLECT  - 1; $f3
          .WORD BASIC_COPY     - 1; $f4
          .WORD BASIC_RENAME   - 1; $f5
          .WORD BASIC_BACKUP   - 1; $f6
          .WORD BASIC_DELETE   - 1; $f7
          .WORD BASIC_RENUMBER - 1; $f8
          .WORD BASIC_KEY      - 1; $f9
          .WORD BASIC_MONITOR  - 1; $fa

; **********************
  BASIC_Action_C ; $478e
; **********************

          .WORD BASIC_BANK      - 1; $fe02
          .WORD BASIC_FILTER    - 1; $fe03
          .WORD BASIC_PLAY      - 1; $fe04
          .WORD BASIC_TEMPO     - 1; $fe05
          .WORD BASIC_MOVSPR    - 1; $fe06
          .WORD BASIC_SPRITE    - 1; $fe07
          .WORD BASIC_SPRCOLOR  - 1; $fe08
          .WORD BASIC_RREG      - 1; $fe09
          .WORD BASIC_ENVELOPE  - 1; $fe0a
          .WORD BASIC_SLEEP     - 1; $fe0b
          .WORD BASIC_DIRCAT    - 1; $fe0c
          .WORD BASIC_DOPEN     - 1; $fe0d
          .WORD BASIC_APPEND    - 1; $fe0e
          .WORD BASIC_DCLOSE    - 1; $fe0f
          .WORD BASIC_BSAVE     - 1; $fe10
          .WORD BASIC_BLOAD     - 1; $fe11
          .WORD BASIC_RECORD    - 1; $fe12
          .WORD BASIC_CONCAT    - 1; $fe13
          .WORD BASIC_DVERIFY   - 1; $fe14
          .WORD BASIC_DCLEAR    - 1; $fe15
          .WORD BASIC_SPRSAV    - 1; $fe16
          .WORD BASIC_COLLISION - 1; $fe17
          .WORD SYNTAX_ERROR    - 1; $fe18
          .WORD Skip_Statement  - 1; $fe19 BEGIN
          .WORD BASIC_WINDOW    - 1; $fe1a
          .WORD BASIC_BOOT      - 1; $fe1b
          .WORD BASIC_WIDTH     - 1; $fe1c
          .WORD BASIC_SPRDEF    - 1; $fe1d
          .WORD Unimplemented   - 1; $fe1e
          .WORD BASIC_STASH     - 1; $fe1f
          .WORD 1               - 1; $fe20
          .WORD BASIC_FETCH     - 1; $fe21
          .WORD 1               - 1; $fe22
          .WORD BASIC_SWAP      - 1; $fe23
          .WORD Unimplemented   - 1; $fe24
          .WORD BASIC_FAST      - 1; $fe25
          .WORD BASIC_SLOW      - 1; $fe26

; ************************
  BASIC_Function_A ; $47d8
; ************************

          .WORD FUNC_SGN  ; $b4
          .WORD FUNC_INT  ; $b5
          .WORD FUNC_ABS  ; $b6
          .WORD FUNC_USR  ; $b7
          .WORD FUNC_FRE  ; $b8
          .WORD FUNC_POS  ; $b9
          .WORD FUNC_SQR  ; $ba
          .WORD FUNC_RND  ; $bb
          .WORD FUNC_LOG  ; $bc
          .WORD FUNC_EXP  ; $bd
          .WORD FUNC_COS  ; $be
          .WORD FUNC_SIN  ; $bf
          .WORD FUNC_TAN  ; $c0
          .WORD FUNC_ATN  ; $c1
          .WORD FUNC_PEEK ; $c2
          .WORD FUNC_LEN  ; $c3
          .WORD FUNC_STR  ; $c4
          .WORD FUNC_VAL  ; $c5
          .WORD FUNC_ASC  ; $c6
          .WORD FUNC_CHR  ; $c7
          .WORD FUNC_LEFT ; $c8
          .WORD FUNC_RIGHT; $c9
          .WORD FUNC_MID  ; $ca

; ************************
  BASIC_Function_B ; $4806
; ************************

          .WORD FUNC_RGR ; $cc
          .WORD FUNC_RCLR; $cd
          .WORD 0        ; $ce
          .WORD FUNC_JOY ; $cf
          .WORD FUNC_RDOT; $d0
          .WORD FUNC_DEC ; $d1
          .WORD FUNC_HEX ; $d2
          .WORD FUNC_ERR ; $d3

; ************************
  BASIC_Function_C ; $4816
; ************************

          .WORD FUNC_POT      ; $ce02
          .WORD FUNC_BUMP     ; $ce03
          .WORD FUNC_PEN      ; $ce04
          .WORD FUNC_RSPPOS   ; $ce05
          .WORD FUNC_RSPRITE  ; $ce06
          .WORD FUNC_RSPCOLOR ; $ce07
          .WORD FUNC_XOR      ; $ce08
          .WORD FUNC_RWINDOW  ; $ce09
          .WORD FUNC_POINTER  ; $ce0a

; **********************
  BASIC_Operator ; $4828
; **********************

          .BYTE $79, <OP_PLUS-1    , >OP_PLUS-1
          .BYTE $79, <OP_MINUS-1   , >OP_MINUS-1
          .BYTE $7b, <OP_MULT-1    , >OP_MULT-1
          .BYTE $7b, <OP_DIV-1     , >OP_DIV-1
          .BYTE $7f, <OP_POWER-1   , >OP_POWER-1
          .BYTE $50, <OP_AND-1     , >OP_AND-1
          .BYTE $46, <OP_OR-1      , >OP_OR-1
          .BYTE $7d, <OP_NEG-1     , >OP_NEG-1
          .BYTE $5a, <OP_NOT-1     , >OP_NOT-1
          .BYTE $64, <OP_COMPARE-1 , >OP_COMPARE-1

; *********************
  Unimplemented ; $4846
; *********************

          LDX #$28
          JMP Print_Error_X

; **********************
  Error_Messages ; $484b
; **********************

          .SHIFT "TOO MANY FILES" ;^        ; $01
          .SHIFT "FILE OPEN" ;^             ; $02
          .SHIFT "FILE NOT OPEN" ;^         ; $03
          .SHIFT "FILE NOT FOUND" ;^        ; $04
          .SHIFT "DEVICE NOT PRESENT" ;^    ; $05
          .SHIFT "NOT INPUT FILE" ;^        ; $06
          .SHIFT "NOT OUTPUT FILE" ;^       ; $07
          .SHIFT "MISSING FILE NAME" ;^     ; $08
          .SHIFT "ILLEGAL DEVICE NUMBER" ;^ ; $09
          .SHIFT "NEXT WITHOUT FOR" ;^      ; $0a
          .SHIFT "SYNTAX" ;^                ; $0b
          .SHIFT "RETURN WITHOUT GOSUB" ;^  ; $0c
          .SHIFT "OUT OF DATA" ;^           ; $0d
          .SHIFT "ILLEGAL QUANTITY" ;^      ; $0e
          .SHIFT "OVERFLOW" ;^              ; $0f
          .SHIFT "OUT OF MEMORY" ;^         ; $10
          .SHIFT "UNDEF'D STATEMENT" ;^     ; $11
          .SHIFT "BAD SUBSCRIPT" ;^         ; $12
          .SHIFT "REDIM'D ARRAY" ;^         ; $13
          .SHIFT "DIVISION BY ZERO" ;^      ; $14
          .SHIFT "ILLEGAL DIRECT" ;^        ; $15
          .SHIFT "TYPE MISMATCH" ;^         ; $16
          .SHIFT "STRING TOO LONG" ;^       ; $17
          .SHIFT "FILE DATA" ;^             ; $18
          .SHIFT "FORMULA TOO COMPLEX" ;^   ; $19
          .SHIFT "CAN'T CONTINUE" ;^        ; $1a
          .SHIFT "UNDEF'D FUNCTION" ;^      ; $1b
          .SHIFT "VERIFY" ;^                ; $1c
          .SHIFT "LOAD" ;^                  ; $1d
          .TEXT "BREAK"
          .BYTE $00,$a0

; ***********************
  Error_Message_B ; $49dc
; ***********************

          .SHIFT "CAN'T RESUME" ;^          ; $1f
          .SHIFT "LOOP NOT FOUND" ;^        ; $20
          .SHIFT "LOOP WITHOUT DO" ;^       ; $21
          .SHIFT "DIRECT MODE ONLY" ;^      ; $22
          .SHIFT "NO GRAPHICS AREA" ;^      ; $23
          .SHIFT "BAD DISK" ;^              ; $24
          .SHIFT "BEND NOT FOUND" ;^        ; $25
          .SHIFT "LINE NUMBER TOO LARGE" ;^ ; $26
          .SHIFT "UNRESOLVED REFERENCE" ;^  ; $27
          .SHIFT "UNIMPLEMENTED COMMAND" ;^ ; $28
          .SHIFT "FILE READ" ;^             ; $29

; ***********************
  Set_Error_Index ; $4a82
; ***********************

          TAX
          LDY #0
          LDA #<Error_Messages
          STA INDEXB
          LDA #>Error_Messages
          STA INDEXB+1
SEI_10    DEX
          BMI SEI_Ret
SEI_20    LDA (INDEXB),Y
          PHA
          INC INDEXB
          BNE SEI_30
          INC INDEXB+1
SEI_30    PLA
          BPL SEI_20
          BMI SEI_10
SEI_Ret   RTS

; *****************
  Interpret ; $4a9f
; *****************

          JMP (IGONE)

; ****************
  DEF_GONE ; $4aa2
; ****************

          BIT RUNMOD
          BPL Inter_40
          LDA INT_VAL
          BMI Inter_40
          LDX #2
Inter_20  LDA INT_TRIP_FLAG,X
          BEQ Inter_30
          LDA #0
          STA INT_TRIP_FLAG,X
          LDA INT_ADR_LO,X
          STA LINNUM
          LDA INT_ADR_HI,X
          STA LINNUM+1
          TXA
          PHA
          LDA TXTPTR
          PHA
          LDA TXTPTR+1
          PHA
          LDA INT_VAL
          ORA #%10000000 ; $80
          STA INT_VAL
          JSR CHRGET
          JSR Push_GOSUB
          JSR GoTo
          JSR Next_Statement
          LDA INT_VAL
          AND #%01111111 ; $7f
          STA INT_VAL
          PLA
          STA TXTPTR+1
          PLA
          STA TXTPTR
          PLA
          TAX
Inter_30  DEX
          BPL Inter_20
Inter_40  JSR CHRGET
Inter_50  JSR Execute

; **********************
  Next_Statement ; $4af6
; **********************

          JSR Is_STOP_Key
          BIT RUNMOD
          BPL NeSt_10
          JSR TXTPTR_TO_OLDTXT
          TSX
          STX OLDSTK
NeSt_10   LDY #0
          JSR INDTXT
          BEQ NeSt_20
          JMP Exec_55
NeSt_20   BIT RUNMOD
          BPL NeSt_40
          LDY #2
          JSR INDTXT
          BEQ NeSt_40
          INY
          JSR INDTXT
          STA CURLIN
          INY
          JSR INDTXT
          STA CURLIN+1
          TYA
          CLC
          ADC TXTPTR
          STA TXTPTR
          BCC NeSt_30
          INC TXTPTR+1
NeSt_30   JMP Interpret
NeSt_40   JMP BASIC_Ready

; ************************
  TXTPTR_TO_OLDTXT ; $4b34
; ************************

          LDA TXTPTR
          LDY TXTPTR+1
          STA OLDTXT
          STY OLDTXT+1
TPOT_Ret  RTS

; ***************
  Execute ; $4b3f
; ***************

          BEQ TPOT_Ret
          BIT TRCFLG
          BPL Exec_05
          BIT RUNMOD
          BPL Exec_05
          PHA
          LDA #'['            ; trace
          JSR Print_Char
          JSR Print_CURLIN
          LDA #']'
          JSR Print_Char
          PLA
Exec_05   CMP #$fe
          BEQ Exec_35
          CMP #$cb            ; GO
          BNE Exec_10
          JMP BASIC_GO
Exec_10   CMP #$ca            ; MID$
          BEQ Exec_25
          CMP #$fb            ; USING
          BCS Exec_50
          CMP #$a3            ; TAB(
          BCC Exec_15
          CMP #$d5            ; ELSE
          BCC Exec_50
          SBC #$32
Exec_15   SEC
          SBC #$80
          BCS Exec_20
          JMP BASIC_LET
Exec_20   ASL A
          TAY
          LDA BASIC_Action_A+1,Y
          PHA
          LDA BASIC_Action_A,Y
          PHA
          JMP CHRGET

; assign to MID$

Exec_25   LDA #>MID_ASSIGN-1
          PHA
          LDA #<MID_ASSIGN-1
          PHA
Exec_30   JMP CHRGET
Exec_35   JSR CHRGET
          BEQ Exec_50
          CMP #2
          BCC Exec_40
          CMP #$27 ; '''
          BCS Exec_40
          ADC #$47 ; 'G'
          BNE Exec_20
Exec_40   SEC
          JMP (IESCEX)

; *****************
  DEF_ESCEX ; $4ba9
; *****************

          BCC Exec_30
Exec_50   JMP SYNTAX_ERROR
Exec_55   CMP #':'
          BNE Exec_50
          JMP Interpret

; *******************
  Is_STOP_Key ; $4bb5
; *******************

          JSR B_STOP
          BEQ ISK_10
          RTS

; **************
  ISK_10 ; $4bbb
; **************

          LDY TRAPNO+1
          INY
          BEQ END_20
ISK_20    JSR B_STOP
          BEQ ISK_20
          LDX #$1e
          JMP Print_Error_X

; ******************
  BASIC_STOP ; $4bcb
; ******************

          BCS END_10

; *****************
  BASIC_END ; $4bcd
; *****************

          CLC ; $80
END_10    BNE END_Ret
END_20    BIT RUNMOD
          BPL END_30
          JSR TXTPTR_TO_OLDTXT
          LDA CURLIN
          LDY CURLIN+1
          STA OLDLIN
          STY OLDLIN+1
END_30    PLA
          PLA
          BCC END_40
          JSR B_PRIMM
          .TEXT "\r\nBREAK",0
          JMP BAER_50
END_40    JMP BASIC_Ready
END_Ret   RTS

; *********************
  Call_Function ; $4bf7
; *********************

          CMP #$ce ; 2 byte token ?
          BEQ CALL_50
          CMP #$d5
          BCS Exec_50 ; illegal token
          CMP #$cb
          BCC CALL_10
          SBC #1 ; skip $cb token
CALL_10   PHA
          TAX
          JSR CHRGET
          CPX #$d3 ; ERR function
          BEQ CALL_20
          CPX #$cb ; function type B
          BCS CALL_30
          CPX #$c8
          BCC CALL_30
CALL_20   JSR Need_Left_Par
          JSR Eval_Expression
          JSR Need_Comma
          JSR Need_String
          PLA
          CMP #$d3
          BEQ CALL_90
          TAX
          LDA FAC1_M4
          PHA
          LDA FAC1_M3
          PHA
          TXA
          PHA
          JSR Get_Byte_Var
          PLA
          TAY
          TXA
          PHA
          TYA
          JMP CALL_40
CALL_30   JSR Get_Arg
          PLA
CALL_40   SEC
          SBC #$b4
          ASL A
          TAY
          LDA BASIC_Function_A+1,Y
          STA JUMPER+2
          LDA BASIC_Function_A,Y
          STA JUMPER+1
          JSR JUMPER
          JMP Assert_Numeric
CALL_50   JSR CHRGET
          BEQ CALL_99
          CMP #10
          BEQ CALL_60
          PHA
          JSR CHRGET
          JSR Need_Left_Par
          JSR Eval_Expression
          PLA
CALL_60   CMP #2
          BCC CALL_70
          CMP #11
          BCS CALL_70
          ADC #$d1
          BNE CALL_40
CALL_70   SEC
          JSR CALL_USR

; ***************
  CALL_80 ; $4c78
; ***************

          BCS CALL_99
          JMP Assert_Numeric

; ****************
  CALL_USR ; $4c7d
; ****************

          JMP (USRVEC)        ; initialized to CALL_80
CALL_90   JMP FUNC_INSTR
CALL_99   JMP SYNTAX_ERROR

; *************
  OP_OR ; $4c86
; *************

          LDY #$ff
          .byte $2c ;BIT

; **************
  OP_AND ; $4c89
; **************

          LDY #0
          STY B_COUNT
          JSR Real_To_Integer
          LDA FAC1_M3
          EOR B_COUNT
          STA CHARAC
          LDA FAC1_M4
          EOR B_COUNT
          STA ENDCHR
          JSR FAC2_To_FAC1
          JSR Real_To_Integer
          LDA FAC1_M4
          EOR B_COUNT
          AND ENDCHR
          EOR B_COUNT
          TAY
          LDA FAC1_M3
          EOR B_COUNT
          AND CHARAC
          EOR B_COUNT
          JMP Integer_To_Real

; ******************
  OP_COMPARE ; $4cb6
; ******************

          JSR Check_Var_Type
          BCS OPCO_10
          LDA FAC2_SI
          ORA #$7f
          AND FAC2_M1
          STA FAC2_M1
          LDA #<FAC2_EX
          LDY #>FAC2_EX
          JSR Compare_AY_FAC1
          TAX
          JMP OPCO_40
OPCO_10   LDA #0
          STA VALTYP
          DEC OP_TMP
          JSR Free_String_FAC1
          STA FAC1_EX
          STX FAC1_M1
          STY FAC1_M2
          LDA FAC2_M3
          LDY FAC2_M4
          JSR Free_String_AY
          STX FAC2_M3
          STY FAC2_M4
          TAX
          SEC
          SBC FAC1_EX
          BEQ OPCO_20
          LDA #1
          BCC OPCO_20
          LDX FAC1_EX
          LDA #$ff
OPCO_20   STA FAC1_SI
          LDY #$ff
          INX
OPCO_30   INY
          DEX
          BNE OPCO_50
          LDX FAC1_SI
OPCO_40   BMI OPCO_60
          CLC
          BCC OPCO_60
OPCO_50   LDA #$6d
          JSR Fetch_1
          PHA
          LDA #$64
          JSR Fetch_1
          STA SYNTMP
          PLA
          CMP SYNTMP
          BEQ OPCO_30
          LDX #$ff
          BCS OPCO_60
          LDX #1
OPCO_60   INX
          TXA
          ROL A
          AND TANSGN
          BEQ OPCO_70
          LDA #$ff
OPCO_70   JMP A_To_FAC1

; *******************
  Print_Ready ; $4d2a
; *******************

          JSR B_PRIMM
          .TEXT "\rREADY.\r",0
          RTS

; *******************
  BASIC_Ready ; $4d37
; *******************

          LDX #$80
          .byte $2c ;BIT

; *****************
  OOM_Error ; $4d3a
; *****************

          LDX #16

; *********************
  Print_Error_X ; $4d3c
; *********************

          JMP (IERROR)        ; default: DEF_ERROR

; *****************
  DEF_ERROR ; $4d3f
; *****************

          STA MMU_LCRC        ; bank 0 and ROM and I/O
          TXA                 ; error #
          BMI BAER_60         ; -> no error
          STX ERRNUM          ; store error #
          BIT RUNMOD
          BPL BAER_20         ; -> direct mode
          LDY #1
BAER_10   LDA CURLIN,Y        ; error line := current line
          STA ERRLIN,Y
          LDA OLDTXT,Y        ; error position := current position
          STA ERRTXT,Y
          DEY
          BPL BAER_10
          LDY TRAPNO+1
          INY
          BEQ BAER_20         ; -> no trap defined
          DEY                 ; Y = trap # high
          STY LINNUM+1
          STY TMPTRP
          LDY TRAPNO
          STY LINNUM          ; LINNUM := trap #
          LDX #$ff
          JSR Reset_Descriptor_Stack
          LDX OLDSTK
          TXS                 ; reset stack pointer
          JSR GoTo_10         ; locate  trap code
          JMP Next_Statement  ; execute trap code

BAER_20   DEX                 ; error # - 1
          TXA
          JSR Set_Error_Index ; let INDEXB point to message
          JSR B_CLRCH
          LDA #0
          STA CHANNL          ; default channel
          BIT MODE_80
          BMI BAER_30
          STA GRAPHM
BAER_30   JSR Print_CR
          JSR Print_Question_Mark
          LDY #0
BAER_40   LDA (INDEXB),Y
          PHA
          AND #$7f
          JSR Print_Char      ; print error message
          INY
          PLA
          BPL BAER_40
          JSR Init_BASIC_Stack
          JSR B_PRIMM
          .TEXT " ERROR",0    ; append "ERROR" to message
BAER_50   LDY CURLIN+1
          INY
          BEQ BAER_60
          JSR Print_IN_CURLIN ; print current line number
BAER_60   JSR Print_Ready     ; print prompt
          LDA #$80
          JSR K_SETMSG
          LDA #0
          STA RUNMOD          ; return to direct mode
BAER_70   JMP (IMAIN)         ; default: DEF_MAIN

; ****************
  DEF_MAIN ; $4dc6
; ****************

          LDX #$ff
          STX CURLIN+1        ; invalidate CURLIN
          JSR Read_String

MAIN_02   STX TXTPTR          ; (TXTPTR) := BUF-1
          STY TXTPTR+1
          JSR CHRGET          ; get 1st. char
          TAX

MAIN_04   BEQ BAER_70         ; no input: loop
          BCC MAIN_06         ; -> got number
          JSR CRUNCH          ; tokenize
          JSR CHRGOT          ; get 1st. char
          JMP Inter_50        ; execute direct

MAIN_06   JSR Scan_Linenumber
          JSR CRUNCH
          STY B_COUNT
          JSR Search_BASIC_Line
          BCC MAIN_18         ; -> not found
          LDY #0
          JSR Get_LOWTR_0     ; link low of current line
          SEC
          SBC LOWTR           ; subtract current address
          SEC
          SBC #4              ; subtract 4 for link & number
          SBC B_COUNT         ; subtract new length
          BCS MAIN_12         ; continue with high byte
          EOR #$ff
          ADC #1
          LDY TEXT_TOP+1      ; Y = old TEXT_TOP high
          ADC TEXT_TOP        ; A = new TEXT_TOP low
          BCC MAIN_08
          INY                 ; Y = new TEXT_TOP high
MAIN_08   CPY TEXT_MAX+1     ; test for Out Of Memory
          BCC MAIN_12
          BNE MAIN_10
          CMP TEXT_MAX
          BCC MAIN_12
MAIN_10   JMP OOM_Error

MAIN_12   LDY #1
          JSR Get_LOWTR_0     ; link high of current line
          STA INDEXA+1
          LDA TEXT_TOP
          STA INDEXA          ; (INDEXA) = read pointer
          LDA LOWTR+1
          STA INDEXB+1
          DEY
          JSR Get_LOWTR_0
          CLC
          SBC LOWTR
          EOR #%11111111 ; $ff
          CLC
          ADC TEXT_TOP
          STA TEXT_TOP
          STA INDEXB          ; (INDEXB) = write pointer
          LDA TEXT_TOP+1
          ADC #$ff
          STA TEXT_TOP+1
          SBC LOWTR+1
          TAX
          SEC
          LDA LOWTR
          SBC TEXT_TOP
          TAY
          BCS MAIN_14
          INX                 ; X = number of blocks to move
          DEC INDEXB+1
MAIN_14   CLC
          ADC INDEXA
          BCC MAIN_16
          DEC INDEXA+1
          CLC

MAIN_16   JSR Get_INDEXA_0    ; delete current line
          STA (INDEXB),Y      ; by moving upper part of program down
          INY
          BNE MAIN_16
          INC INDEXA+1
          INC INDEXB+1
          DEX
          BNE MAIN_16

;         Insert new BASIC line from buffer

MAIN_18   JSR Init_BASIC_Stack
          JSR Relink
          LDY #0
          LDA (TXTPTR),Y
          BNE MAIN_20
          JMP MAIN_04         ; -> nothing to insert
MAIN_20   CLC
          LDA TEXT_TOP
          LDY TEXT_TOP+1
          STA HIGHTR          ; (HIGHTR) = (TEXT_TOP)
          STY HIGHTR+1
          ADC B_COUNT         ; length of new line
          BCC MAIN_22
          INY
MAIN_22   CLC
          ADC #4              ; plus link & number
          BCC MAIN_24
          INY
MAIN_24   STA ARYPNT          ; (ARYPNT) = new TEXT_TOP
          STY ARYPNT+1
          CPY TEXT_MAX+1     ; check for OOM
          BCC MAIN_28
          BNE MAIN_26
          CMP TEXT_MAX
          BCC MAIN_28
MAIN_26   JMP OOM_Error

MAIN_28   STA TEXT_TOP        ; update TEXT_TOP
          STY TEXT_TOP+1
          SEC
          LDA HIGHTR
          SBC LOWTR
          STA INDEXA
          TAY
          LDA HIGHTR+1
          SBC LOWTR+1
          TAX
          INX
          TYA
          BEQ MAIN_36
          LDA HIGHTR
          SEC
          SBC INDEXA
          STA HIGHTR
          BCS MAIN_30
          DEC HIGHTR+1
          SEC
MAIN_30   LDA ARYPNT
          SBC INDEXA
          STA ARYPNT
          BCS MAIN_34
          DEC ARYPNT+1
          BCC MAIN_34

;          make room for new line

MAIN_32   JSR Get_HIGHTR_0
          STA (ARYPNT),Y
MAIN_34   DEY
          BNE MAIN_32
          JSR Get_HIGHTR_0
          STA (ARYPNT),Y
MAIN_36   DEC HIGHTR+1
          DEC ARYPNT+1
          DEX                 ; blocks to move
          BNE MAIN_34

;          insert new line from buffer

          LDY #0
          LDA #1
          STA (LOWTR),Y       ; Y=0: dummy link low
          INY
          STA (LOWTR),Y       ; Y=1: dummy link high
          INY
          LDA LINNUM
          STA (LOWTR),Y       ; Y=2: line # low
          LDA LINNUM+1
          INY
          STA (LOWTR),Y       ; Y=3: line # high
          CLC
          LDA LOWTR
          ADC #4
          STA LOWTR
          BCC MAIN_38
          INC LOWTR+1         ; (LOWTR) += 4
MAIN_38   LDY B_COUNT         ; length of new line
          DEY
MAIN_40   LDA (TXTPTR),Y      ; from BUF
          STA (LOWTR),Y       ; to program
          DEY
          CPY #$ff
          BNE MAIN_40

          JSR Relink
          JSR Reset_TXTPTR
          LDA AUTINC
          ORA AUTINC+1
          BEQ MAIN_46         ; -> no AUTO increment active
          LDA LINNUM
          CLC
          ADC AUTINC
          STA FAC1_M2
          LDA LINNUM+1
          ADC AUTINC+1
          BCS MAIN_46
          CMP #$fa            ; check for overflow 64000
          BCS MAIN_46
          STA FAC1_M1
          LDX #$90
          SEC
          JSR Word_To_FAC1
          JSR Format_FAC1     ; write new number to STACK
          LDX #0
MAIN_42   LDA STACK+1,X       ; insert new number into keyboard buffer
          BEQ MAIN_44
          STA KEYD,X
          INX
          BNE MAIN_42
MAIN_44   LDA #$1d            ; add cursor right
          STA KEYD,X
          INX
          STX NDX             ; update length of keyboard buffer
MAIN_46   JMP BAER_70


; Relink the BASIC program in bank 0 starting at (TXTTAB)
; The default value for the start adddress TXTTAB is $1c00
; This routine is called after loading a program and from
; the editor after insert or modify or delete operations.

; **************
  Relink ; $4f4f
; **************

          LDA TXTTAB
          LDY TXTTAB+1
          STA INDEXA
          STY INDEXA+1        ; (INDEXA) = start of program
          CLC
Reli_10   LDY #0
          JSR Get_INDEXA_0    ; old link low
          BNE Reli_20
          INY
          JSR Get_INDEXA_0    ; old link high
          BEQ Reli_Ret        ; finish for zero link
Reli_20   LDY #4
Reli_30   INY                 ; start with Y = 5
          JSR Get_INDEXA_0
          BNE Reli_30         ; loop until end of line
          INY                 ; Y = length of line
          TYA
          ADC INDEXA
          TAX                 ; X = new link low
          LDY #0              ; Y = 0
          STA (INDEXA),Y      ; update link low
          TYA                 ; A = 0
          ADC INDEXA+1        ; A = new link high
          INY                 ; Y = 1
          STA (INDEXA),Y      ; update link high
          STX INDEXA
          STA INDEXA+1        ; (INDEXA) = next line
          BCC Reli_10         ; branch always

; ********************
  Set_TEXT_TOP ; $4f82
; ********************

          CLC
          LDA INDEXA
          LDY INDEXA+1
          ADC #2
          BCC STT_10
          INY
STT_10    STA TEXT_TOP
          STY TEXT_TOP+1
Reli_Ret  RTS

; *******************
  Read_String ; $4f93
; *******************

          LDX #0
ReaS_10   JSR CHRIN
          CMP #CR
          BNE ReaS_20
          JMP Terminate_BUF
ReaS_20   STA BUF,X
          INX
          CPX #161            ; max. 2 lines at 80 characters each
          BCC ReaS_10
          JMP String_Too_Long

; FOR structure on BASIC stack
; ============================

;  0 : 81        loop marker (FOR token)
;  1 : FORPNT    address of index variable
;  2 : FORPNT+1

; ***************************
  Find_Token_On_Stack ; $4faa
; ***************************

          STA BANK            ; store search token
          JSR Init_FNDPNT     ; (FNDPNT) = (TOS) = $09ff
FTOS_10   LDA FNDPNT
          CMP #<BASIC_STACK+$1ff
          BNE FTOS_20
          LDA FNDPNT+1
          CMP #>BASIC_STACK+$1ff
          BEQ FTOS_60         ; -> stack is empty
FTOS_20   STA MMU_LCRC
          LDY #0
          LDA BANK            ; search token
          CMP #$81            ; FOR token
          BNE FTOS_40         ; -> not FOR token
          CMP (FNDPNT),Y      ; loop marker ?
          BNE FTOS_Ret
          LDY #2
          LDA FORPNT+1
          CMP #$ff
          BEQ FTOS_Ret        ; -> invalid address of (FORPNT)
          CMP (FNDPNT),Y
          BNE FTOS_30         ; -> index variables do not match
          DEY
          LDA FORPNT
          CMP (FNDPNT),Y
          BEQ FTOS_Ret        ; -> Found valid FOR structure
FTOS_30   LDX #$12            ; length of FOR structure
          BNE FTOS_50         ; branch always

FTOS_40   LDA (FNDPNT),Y
          CMP BANK
          BEQ FTOS_Ret        ; Found token on stack
          LDX #$12            ; length of FOR structure
          CMP #$81            ; looking for FOR ?
          BEQ FTOS_50
          LDX #5              ; length of other structures
FTOS_50   TXA
          CLC
          ADC FNDPNT          ; move FNDPNT to next structure
          STA FNDPNT
          BCC FTOS_10
          INC FNDPNT+1
          BNE FTOS_10         ; branch always
FTOS_60   LDY #1              ; Z=0 : not found
FTOS_Ret  RTS                 ; Z=1 : found

; ***************
  SUB_TOS ; $4ffe
; ***************

; Input : (A) = value to subtract from stack pointer TOS

          EOR #$ff
          SEC
          ADC TOS
          STA TOS
          LDY TOS+1
          BCS SUTO_10
          DEY
SUTO_10   STY TOS+1
          CPY #8
          BCC CMA_OOM
          BNE SUTO_Ret
          CMP TOS
          BCC CMA_OOM
SUTO_Ret  RTS

; ***********************
  Check_Mem_Avail ; $5017
; ***********************

; Input:  A = new top of variables low
;         Y = new top of variables high
; Return if OK
; Jump to OOM error if not

          CPY FRETOP+1
          BCC CMA_40
          BNE CMA_10
          CMP FRETOP
          BCC CMA_40
CMA_10    PHA
          LDX #9              ; push $59 - $62
          TYA
CMA_20    PHA
          LDA FACTPA,X
          DEX
          BPL CMA_20
          JSR Garbage_Collection
          LDX #$f7
CMA_30    PLA
          STA FAC1_EX,X       ; pull $59 - $62
          INX
          BMI CMA_30
          PLA
          TAY
          PLA
          CPY FRETOP+1
          BCC CMA_40
          BNE CMA_OOM
          CMP FRETOP
          BCS CMA_OOM
CMA_40    RTS
CMA_OOM   JMP OOM_Error

; *******************
  Init_FNDPNT ; $5047
; *******************

          LDA TOS
          STA FNDPNT
          LDA TOS+1
          STA FNDPNT+1
          RTS

; ******************
  Update_TOS ; $5050
; ******************

          LDA FNDPNT
          STA TOS
          LDA FNDPNT+1
          STA TOS+1
          RTS

; ****************
  Free_TOS ; $5059
; ****************

          TYA
          CLC
          ADC TOS
          STA TOS
          BCC FreT_Ret
          INC TOS+1
FreT_Ret  RTS

; *************************
  Search_BASIC_Line ; $5064
; *************************

          LDA TXTTAB
          LDX TXTTAB+1

; *****************************************
  Find_LINNUM_AX ; $5068 - original ; $5068
; *****************************************

          LDY #1
          STA LOWTR
          STX LOWTR+1
          JSR Get_LOWTR_0     ; link high
          BEQ SBL_30
          INY                 ; Y = 2
          INY                 ; Y = 3
          JSR Get_LOWTR_0     ; # high
          STA SYNTMP
          LDA LINNUM+1
          CMP SYNTMP
          BCC SBL_Ret         ; beyond # -> not found
          BEQ SBL_10          ; high bytes match: -> continue
          DEY                 ; Y = 2
          BNE SBL_20          ; branch always
SBL_10    DEY                 ; Y = 2
          JSR Get_LOWTR_0     ; # low
          STA SYNTMP
          LDA LINNUM
          CMP SYNTMP
          BCC SBL_Ret         ; beyond # -> not found
          BEQ SBL_Ret         ; -> found
SBL_20    DEY                 ; Y = 1
          JSR Get_LOWTR_0     ; link high
          TAX
          DEY                 ; Y = 0
          JSR Get_LOWTR_0     ; link low
          BCS Find_LINNUM_AX  ; brnach always
SBL_30    CLC                 ; C=0 : not found
SBL_Ret   RTS

; ***********************
  Scan_Linenumber ; $50a0
; ***********************

          LDX #0
          STX ENDCHR
          STX LINNUM
          STX LINNUM+1
ScLi_10   BCS ScLi_Ret
          INC ENDCHR
          SBC #$2f ; '/'
          STA CHARAC
          LDA LINNUM+1
          STA INDEXA
          CMP #$19
          BCC ScLi_20
          JMP SYNTAX_ERROR
ScLi_20   LDA LINNUM
          ASL A
          ROL INDEXA
          ASL A
          ROL INDEXA
          ADC LINNUM
          STA LINNUM
          LDA INDEXA
          ADC LINNUM+1
          STA LINNUM+1
          ASL LINNUM
          ROL LINNUM+1
          LDA LINNUM
          ADC CHARAC
          STA LINNUM
          BCC ScLi_30
          INC LINNUM+1
ScLi_30   JSR CHRGET
          JMP ScLi_10
ScLi_Ret  RTS

; ******************
  BASIC_LIST ; $50e2
; ******************

          JSR Get_Line_Range
LIST_10   LDY #1              ; Y = 1
          JSR Get_LOWTR_0     ; link high
          BNE LIST_20
          DEY                 ; Y = 0
          JSR Get_LOWTR_0     ; link low
          BEQ LIST_50         ; zero link: -> finish
LIST_20   JSR Is_STOP_Key     ; check STOP key
          JSR Print_CR        ; start listing with newline
          LDY #2              ; Y = 2
          JSR Get_LOWTR_0     ; line # low
          TAX
          INY                 ; Y = 3
          JSR Get_LOWTR_0     ; line # high
          CMP LINNUM+1        ; compare with end value
          BNE LIST_30
          CPX LINNUM
          BEQ LIST_40
LIST_30   BCS LIST_50         ; line # > end -> finish
LIST_40   JSR List_Line
          LDY #0              ; Y = 0
          JSR Get_LOWTR_0     ; link low
          TAX
          INY                 ; Y = 1
          JSR Get_LOWTR_0     ; link high
          STX LOWTR           ; set link to next line
          STA LOWTR+1
          JMP LIST_10         ; continue with next line
LIST_50   JMP Print_CR        ; LIST finished

; *****************
  List_Line ; $5123
; *****************

          LDY #3
          STY FORPNT
          STY GARBFL
          JSR Print_Integer_XA
          LDA #' '
LiLi_10   LDY FORPNT
          AND #$7f
LiLi_15   JSR Print_Char
          CMP #QUOTE
          BNE LiLi_20
          LDA GARBFL
          EOR #$ff
          STA GARBFL
LiLi_20   INY
          BEQ LIST_50
          BIT HELPER
          BPL LiLi_25
          JSR At_Error_Position
LiLi_25   JSR Get_LOWTR_0
          BEQ LiLi_60
          JMP (IQPLOP)

; *****************
  DEF_QPLOP ; $5151
; *****************

          BPL LiLi_15
          CMP #PICHAR
          BEQ LiLi_15
          BIT GARBFL
          BMI LiLi_15
          CMP #$fe            ; token group $fe..
          BEQ LiLi_65
          CMP #$ce            ; token group $ce..
          BEQ LiLi_70
          TAX
          STY FORPNT
          LDA #>BASIC_Keytab_A
          LDY #<BASIC_Keytab_A
LiLi_30   STA INDEXA+1
          STY INDEXA
          LDY #0
LiLi_35   DEX
          BPL LiLi_55
LiLi_40   LDA (INDEXA),Y
          PHA
          INC INDEXA
          BNE LiLi_45
          INC INDEXA+1
LiLi_45   PLA
          BPL LiLi_40
          BMI LiLi_35
LiLi_50   INY
LiLi_55   LDA (INDEXA),Y
          BMI LiLi_10
          JSR Print_Char
          BNE LiLi_50
LiLi_60   RTS
LiLi_65   TAX
          INY
          JSR Get_LOWTR_0
          BEQ LiLi_15
          STY FORPNT
          CMP #2
          BCC LiLi_75
          CMP #APOSTR
          BCS LiLi_75
          ADC #$7e
          TAX
          LDY #<BASIC_Keytab_C
          LDA #>BASIC_Keytab_C
          BNE LiLi_30
LiLi_70   TAX
          INY
          JSR Get_LOWTR_0
          BEQ LiLi_15
          STY FORPNT
          CMP #2              ; from $ce02 (POT)
          BCC LiLi_75
          CMP #11             ; to   $ce0a (POINTER)
          BCS LiLi_75
          ADC #$7e
          TAX
          LDY #<BASIC_Keytab_D
          LDA #>BASIC_Keytab_D
          BNE LiLi_30
LiLi_75   CPX #$fe
          BNE LiLi_80
          LDX #0
          .byte $2c ;BIT
LiLi_80   LDX #$ff
          SEC
          JMP (IESCPR)

; *****************
  DEF_ESCPR ; $51cd
; *****************

          BCS LiLi_85
          LDY #0
          BEQ LiLi_55         ; branch always
LiLi_85   JMP LiLi_15

; *****************
  BASIC_NEW ; $51d6
; *****************

          BEQ NEW_10
          RTS

; **************
  NEW_10 ; $51d9
; **************

          LDA #0
          TAY
          STA (TXTTAB),Y      ; insert zero link
          INY
          STA (TXTTAB),Y
          STA TRCFLG
          LDA TXTTAB
          CLC
          ADC #2
          STA TEXT_TOP        ; (TEXT_TOP) = (TXTTAB) + 2
          LDA TXTTAB+1
          ADC #0
          STA TEXT_TOP+1

; *****************************
  Reset_BASIC_Execution ; $51f3
; *****************************

          JSR Reset_TXTPTR    ; (TXTPTR) = (TXTTAB) - 1
          LDA #0

; *****************
  BASIC_CLR ; $51f8
; *****************

          BNE IBS_Ret

; *******************
  Clear_BASIC ; $51fa
; *******************

          JSR B_CLALL
          LDY #0
          STY DS_LEN
          DEY
          STY TRAPNO+1
          STY ERRLIN
          STY ERRLIN+1
          STY ERRNUM
          LDA MEMSIZ
          LDY MEMSIZ+1
          STA FRETOP
          STY FRETOP+1
          LDA #<BASIC_STACK+$1ff
          LDY #>BASIC_STACK+$1ff
          STA TOS
          STY TOS+1
          LDA VARTAB
          LDY VARTAB+1
          STA ARYTAB
          STY ARYTAB+1
          STA STREND
          STY STREND+1
          LDX #3
ClrB_10   LDA PUCHARS,X
          STA PU_FILL,X
          DEX
          BPL ClrB_10
ClrB_20   JSR Reset_DATPTR

; ************************
  Init_BASIC_Stack ; $5238
; ************************

          LDX #$1b
          STX TEMPPT
          PLA
          TAY
          PLA
          LDX #$fa            ; reset stackpointer
          TXS
          PHA
          TYA
          PHA
          LDA #0
          STA OLDTXT+1
          STA SUBFLG
          STA BITS
IBS_Ret   RTS

; ***************
  PUCHARS ; $5250
; ***************

          .TEXT " ,.$"        ; PU_FILL, PU_COMMA, PU_DOT, PU_MONEY

; ********************
  Reset_TXTPTR ; $5254
; ********************

          CLC
          LDA TXTTAB
          ADC #$ff
          STA TXTPTR
          LDA TXTTAB+1
          ADC #$ff
          STA TXTPTR+1
          RTS

; ********************
  BASIC_RETURN ; $5262
; ********************

          PLA
          PLA
          LDA #$8d            ; RETURN token
          JSR Find_Token_On_Stack
          BEQ RET_10
          LDX #12             ; RETURN WITHOUT GOSUB
          JMP Print_Error_X
RET_10    JSR Update_TOS
          LDY #5
          JSR Free_TOS
          DEY
          LDA (FNDPNT),Y
          STA TXTPTR+1
          DEY
          LDA (FNDPNT),Y
          STA TXTPTR
          DEY
          LDA (FNDPNT),Y
          JSR To_Direct_Mode
          LDA (FNDPNT),Y
          STA CURLIN
          JMP Skip_Statement     ; obsolete

; *****************************************
  Skip_Statement ; $528f BASIC_DATA ; $528f
; *****************************************

          JSR Skip_To_EOS

; **********************************
  Add_Y_To_Execution_Pointer ; $5292
; **********************************

          TYA
          CLC
          ADC TXTPTR
          STA TXTPTR
          BCC AYEP_Ret
          INC TXTPTR+1
AYEP_Ret  RTS

; *****************
  BASIC_REM ; $529d
; *****************

          JSR End_Of_Line
          BEQ Add_Y_To_Execution_Pointer

; *******************
  Skip_To_EOS ; $52a2
; *******************

          LDX #':'
          .byte $2c ;BIT

; *******************
  End_Of_Line ; $52a5
; *******************

          LDX #0
          STX CHARAC
          LDY #0
          STY ENDCHR
EOL_10    LDA ENDCHR
          LDX CHARAC
          STA CHARAC
          STX ENDCHR
EOL_20    JSR INDTXT
          BEQ AYEP_Ret
          CMP ENDCHR
          BEQ AYEP_Ret
          INY
          CMP #QUOTE
          BNE EOL_20
          BEQ EOL_10

; ****************
  BASIC_IF ; $52c5
; ****************

          JSR Eval_Expression
          JSR CHRGOT
          CMP #$89            ; GOTO token
          BEQ IF_10
          LDA #$a7            ; THEN token
          JSR Need_A
IF_10     LDA FAC1_EX         ; IF clause != 0 (true) or 0 (false)
          BNE IF_30
          JSR CHRGOT
          CMP #$fe            ; token group $fe..
          BNE IF_20
          INY
          JSR INDTXT
          CMP #$18            ; BEGIN token
          BNE IF_20
          JSR Skip_To_BEND
IF_20     JSR Skip_Statement
          LDY #0
          JSR INDTXT
          BEQ BASIC_REM       ; skip rest of line
          JSR CHRGET
          CMP #$d5            ; ELSE token
          BNE IF_20
          JSR CHRGET
IF_30     JSR CHRGOT
          BEQ IF_50
          BCS IF_40
          JMP BASIC_GOTO
IF_40     CMP #$fe            ; token group $fe..
          BNE IF_50
          INY
          JSR INDTXT
          CMP #$18            ; BEGIN token
          BNE IF_50
          JSR CHRGET
          JSR CHRGET
IF_50     JSR CHRGOT
          JMP Execute

; ********************
  Skip_To_BEND ; $5320
; ********************

          JSR CHRGET
          BNE BEND_30
BEND_10   CMP #':'
          BEQ Skip_To_BEND
BEND_20   BIT RUNMOD
          BPL BEND_Err
          LDY #2
          JSR INDTXT          ; link high
          BEQ BEND_Err
          INY                 ; Y = 3
          JSR INDTXT
          STA CURLIN
          INY                 ; Y = 4
          JSR INDTXT
          STA CURLIN+1
          TYA
          CLC
          ADC TXTPTR          ; next line
          STA TXTPTR
          BCC Skip_To_BEND
          INC TXTPTR+1
          BNE Skip_To_BEND
BEND_30   CMP #QUOTE
          BNE BEND_40
          JSR Skip_To_End_Of_String
          BEQ BEND_10
          BNE Skip_To_BEND
BEND_40   CMP #$8f            ; REM token
          BNE BEND_50
          JSR BASIC_REM
          JMP BEND_20
BEND_50   CMP #$fe            ; $fe.. token ?
          BNE Skip_To_BEND
          JSR CHRGET
          CMP #$19            ; $fe19 = BEND token
          BEQ BEND_60
          CMP #$18            ; $fe18 = BEGIN token
          BNE Skip_To_BEND
          JSR Skip_To_BEND    ; nested BEGIN .. BEND
          JMP Skip_To_BEND
BEND_60   RTS
BEND_Err  LDX #$25            ; BEND NOT FOUND
          JMP Print_Error_X

; *****************************
  Skip_To_End_Of_String ; $537c
; *****************************

          LDY #0
SEOS_10   INC TXTPTR
          BNE SEOS_20
          INC TXTPTR+1
SEOS_20   JSR INDTXT
          BEQ SEOS_Ret
          CMP #QUOTE
          BNE SEOS_10
          JMP CHRGET
SEOS_Ret  RTS

; ******************
  BASIC_ELSE ; $5391
; ******************

          CMP #$fe            ; $fe.. token ?
          BNE ELSE_10
          INY
          JSR INDTXT
          CMP #$18            ; BEGIN token
          BNE ELSE_10
          JSR Skip_To_BEND
ELSE_10   JMP BASIC_REM

; ****************
  BASIC_ON ; $53a3
; ****************

          JSR Get_Byte_Var
          PHA
          CMP #$8d            ; GOSUB
          BEQ ON_10
          CMP #$89            ; GOTO
          BEQ ON_10
          JMP SYNTAX_ERROR
ON_10     DEC FAC1_M4         ; ON value
          BNE ON_20
          PLA
          JMP Exec_05
ON_20     JSR CHRGET
          JSR Scan_Linenumber
          CMP #','
          BEQ ON_10           ; next target
          PLA
          RTS

; *****************
  BASIC_LET ; $53c6
; *****************

          JSR Parse_Name
          STA FORPNT
          STY FORPNT+1
          LDA #$b2            ; '=' token
          JSR Need_A
          LDA INTFLG          ; save attributes
          PHA                 ; of variable
          LDA VALTYP
          PHA
          JSR Eval_Expression ; FAC1 = value or pointer
          PLA                 ; VALTYP
          ROL A               ; C=1 : string   C=0 : numeric
          JSR Check_Var_Type
          BNE LET_20          ; branch for string
          PLA                 ; INTFLG

; *******************************
  Assign_Numeric_Variable ; $53e3
; *******************************

          BPL LET_10          ; branch for real
          JSR Round_FAC1
          JSR Real_To_Integer
          LDY #0
          LDA FAC1_M3
          STA MMU_LCRD        ; write to RAM 1
          STA (FORPNT),Y      ; integer high byte
          INY
          LDA FAC1_M4
          STA (FORPNT),Y      ; integer low  byte
          RTS

LET_10    LDX FORPNT
          LDY FORPNT+1
          STA MMU_LCRD        ; select RAM1
          JMP FAC1_To_XY      ; (FORPNT) := FAC1

LET_20    PLA                 ; INTFLG

; ******************************
  Assign_String_Variable ; $5405
; ******************************

          LDY FORPNT+1
          CPY #3              ; void string descriptor for TI$
          BNE Assign_Normal_String
          JSR Free_String_FAC1
          CMP #6              ; setting TI$ requires 6 digits
          BNE CLOCK_ERR
          LDY #0              ; FAC1 = 0.0
          STY FAC1_EX
          STY FAC1_SI
CLOCK_10  STY STRNG2
          JSR Add_TI_String_Digit_To_FAC1
          JSR Multiply_FAC1_BY_10
          INC STRNG2
          LDY STRNG2
          JSR Add_TI_String_Digit_To_FAC1
          JSR FAC1_Round_And_Copy_To_FAC2
          TAX
          BEQ CLOCK_20
          INX
          TXA                 ; FAC2 *= 2
          JSR Add_And_Double  ; FAC1  = (FAC1 + FAC2) * 2
CLOCK_20  LDY STRNG2
          INY
          CPY #6
          BNE CLOCK_10
          JSR Multiply_FAC1_BY_10
          JSR FAC1_INT
          LDX FAC1_M3
          LDY FAC1_M2
          LDA FAC1_M4
          JMP K_SETTIM

; ***********************************
  Add_TI_String_Digit_To_FAC1 ; $5448
; ***********************************

          JSR Get_INDEXA_1
          JSR ISNUM
          BCC ATSD_20
CLOCK_ERR JMP Error_Illegal_Quantity

ATSD_20   SBC #$2f            ; subtract "0" (C=0)
          JMP Add_A_To_FAC1

ANS_10    PLA
          INY
ANS_20    CMP FRETOP+1        ; address < FRETOP ?
          BCC ANS_40
          BNE ANS_30
          DEY
          JSR Get_FAC1_M3_1
          CMP FRETOP
          BCC ANS_40
ANS_30    LDY FAC1_M4
          CPY VARTAB+1
          BCC ANS_40
          BNE Assing_String_From_Variable
          LDA FAC1_M3
          CMP VARTAB
          BCS Assing_String_From_Variable
ANS_40    LDA FAC1_M3         ; static string
          LDY FAC1_M4
          JMP ANS_50

; ****************************
  Assign_Normal_String ; $547d
; ****************************

          LDY #2
          JSR Get_FAC1_M3_1
          CMP DS_ADR+1
          BNE ANS_20
          PHA
          DEY
          JSR Get_FAC1_M3_1
          CMP DS_ADR
          BNE ANS_10
          LDA DS_LEN
          BEQ ANS_10          ; -> DS$ undefined
          PLA

; ***********************************
  Assing_String_From_Variable ; $5494
; ***********************************

          LDY #0
          JSR Get_FAC1_M3_1
          JSR Allocate_String_FAC1
          LDA DSCPNT
          LDY DSCPNT+1
          STA STRPTR
          STY STRPTR+1
          JSR Store_String_STRPTR
          LDA STRPTR
          LDY STRPTR+1
          JSR Pop_Descriptor_Stack
          LDA #<FAC1_EX
          LDY #>FAC1_EX

ANS_50    STA DSCPNT
          STY DSCPNT+1
          STA INDEXA
          STY INDEXA+1
          JSR Pop_Descriptor_Stack
          JSR Back_Reference_Position
          BCC ANS_60
          LDY #0
          LDA FORPNT
          STA MMU_LCRD
          STA (INDEXA),Y
          INY
          LDA FORPNT+1
          STA (INDEXA),Y
ANS_60    LDA FORPNT
          STA INDEXA
          LDA FORPNT+1
          STA INDEXA+1
          JSR Back_Reference_Position
          BCC ANS_70
          DEY
          LDA #$ff
          STA MMU_LCRD
          STA (INDEXA),Y
          DEY
          TXA
          STA (INDEXA),Y
ANS_70    LDY #2
ANS_80    LDA #$52 ; 'R'
          JSR Fetch_1
          STA (FORPNT),Y
          DEY
          BPL ANS_80
          RTS

; *******************************
  Back_Reference_Position ; $54f6
; *******************************

; Input:  INDEXA = pointer to string descriptor
; Output: INDEXA = points to address after string
;         X = length of string
;         C = 1 : INDEXA set
;         C = 0 : nothing changed

          LDY #0
          JSR Get_INDEXA_1        ; A = length
          PHA                 ; push length
          BEQ BRP_50
          INY
          JSR Get_INDEXA_1
          TAX                 ; X = pointer low
          INY
          JSR Get_INDEXA_1        ; A = pointer high
          CMP MEMSIZ+1
          BCC BRP_10
          BNE BRP_50
          CPX MEMSIZ       ; return for addr >= MEMTOP
          BCS BRP_50
BRP_10    JSR Get_INDEXA_1
          CMP FRETOP+1
          BCC BRP_50
          BNE BRP_20
          CPX FRETOP          ; return for addr < FRETOP
          BCC BRP_50
BRP_20    CMP DS_ADR+1
          BNE BRP_30
          CPX DS_ADR
          BEQ BRP_50          ; return for addr == DS$
BRP_30    STX INDEXA
          STA INDEXA+1        ; (INDEXA) = address of string
          PLA
          TAX
          CLC
          ADC INDEXA
          STA INDEXA
          BCC BRP_40
          INC INDEXA+1        ; (SP24IX) = address + length
BRP_40    SEC
          RTS
BRP_50    PLA
          CLC
          RTS

; *********************
  BASIC_PRINT_D ; $553a
; *********************

          JSR BASIC_CMD
          JMP Set_Default_Channels

; *****************
  BASIC_CMD ; $5540
; *****************

          JSR Get_Byte_Var
          BEQ CMD_10
          LDA #','
          JSR Need_A
CMD_10    PHP
          STX CHANNL
          JSR B_CKOUT
          PLP
          JMP BASIC_PRINT


PRINT_10  JSR Print_String_From_Descriptor
PRINT_20  JSR CHRGOT

; *******************
  BASIC_PRINT ; $555a
; *******************

          BEQ Print_CR
          CMP #$fb            ; USING
          BNE PRINT_30
          JMP PRINT_USING
PRINT_30  BEQ Print_Ret
          CMP #$a3            ; TAB(
          BEQ Tab_Spc
          CMP #$a6            ; SPC(
          CLC
          BEQ Tab_Spc
          CMP #','
          BEQ Comma_Tab
          CMP #';'
          BEQ TaSp_40
          JSR Eval_Expression
          BIT VALTYP
          BMI PRINT_10
          JSR Format_FAC1
          JSR Create_String_Descriptor
          JSR Print_String_From_Descriptor
          JSR Space_Or_Right
          BNE PRINT_20          ; always

; *********************
  Terminate_BUF ; $558b
; *********************

          LDA #0
          STA BUF,X
          LDX #<BUF-1
          LDY #>BUF-1
          LDA CHANNL
          BNE Print_Ret

; ****************
  Print_CR ; $5598
; ****************

          LDA #CR
          JSR Print_Char
          BIT CHANNL
          BPL Accu_EOR
          LDA #LF
          JSR Print_Char

; ****************
  Accu_EOR ; $55a6
; ****************

          EOR #$ff
Print_Ret RTS

; *****************
  Comma_Tab ; $55a9
; *****************

          SEC
          JSR B_PLOT
          TYA
          SEC
CoTa_10   SBC #10
          BCS CoTa_10
          EOR #$ff
          ADC #1
          BNE TaSp_10

; ***************
  Tab_Spc ; $55b9
; ***************

          PHP
          SEC
          JSR B_PLOT
          STY TRMPOS
          JSR Get_Next_Byte_Var
          CMP #')'
          BNE TaSp_50
          PLP
          BCC TaSp_20
          TXA
          SBC TRMPOS
          BCC TaSp_40
TaSp_10   TAX
TaSp_20   INX
TaSp_30   DEX
          BNE TaSp_60
TaSp_40   JSR CHRGET
          JMP PRINT_30
TaSp_50   JMP SYNTAX_ERROR
TaSp_60   JSR Space_Or_Right
          BNE TaSp_30

; ********************
  Print_String ; $55e2
; ********************

          JSR Create_String_Descriptor

; ************************************
  Print_String_From_Descriptor ; $55e5
; ************************************

          JSR Free_String_FAC1
          TAX
          LDY #0
          INX
PSFD_10   DEX
          BEQ Print_Ret
          JSR Get_INDEXA_1
          JSR Print_Char
          INY
          CMP #CR
          BNE PSFD_10
          JSR Accu_EOR
          JMP PSFD_10

; **********************
  Space_Or_Right ; $5600
; **********************

          LDA CHANNL
          BEQ SOR_10

; *******************
  Print_Blank ; $5604
; *******************

          LDA #' '
          .byte $2c ;BIT
SOR_10    LDA #RIGHT
          .byte $2c ;BIT

; ***************************
  Print_Question_Mark ; $5606
; ***************************

          LDA #'?'

; ******************
  Print_Char ; $560c
; ******************

          JSR CHROUT
          AND #$ff
          RTS

; *****************
  BASIC_GET ; $5612
; *****************

          JSR Assert_Non_Direct
          STA TEMP_A
          CMP #'#'
          BEQ GET_10
          CMP #$f9            ; KEY
          BNE GET_20
          JSR CHRGET
          JMP GET_20
GET_10    JSR CHRGET
          JSR Get_Byte_Var
          LDA #','
          JSR Need_A
          STX CHANNL
          JSR B_CHKIN
GET_20    LDX #1
          LDY #2
          LDA #0
          STA BUF+1
          LDA #$40
          JSR Read_Get
          LDX CHANNL
          BNE SDC_10
          RTS

; *********************
  BASIC_INPUT_D ; $5648
; *********************

          JSR Get_Byte_Var
          LDA #','
          JSR Need_A
          STX CHANNL
          JSR B_CHKIN
          JSR Input_String

; ****************************
  Set_Default_Channels ; $5658
; ****************************

          LDA CHANNL
SDC_10    JSR B_CLRCH
          LDX #0
          STX CHANNL
          RTS

; *******************
  BASIC_INPUT ; $5662
; *******************

          CMP #QUOTE
          BNE Input_String
          JSR Create_Descriptor_From_TXTPTR
          LDA #';'
          JSR Need_A
          JSR Print_String_From_Descriptor

; ********************
  Input_String ; $5671
; ********************

          JSR Assert_Non_Direct
          LDA #','
          STA BUF-1
InSt_10   JSR Prompt_And_Input
          LDA CHANNL
          BEQ InSt_20
          JSR B_READST
          AND #%00000010 ; $02
          BEQ InSt_20
          JSR Set_Default_Channels
          JMP Skip_Statement
InSt_20   LDA BUF
          BNE READ_10
          LDA CHANNL
          BNE InSt_10
          JSR Skip_To_EOS
          JMP Add_Y_To_Execution_Pointer

; ************************
  Prompt_And_Input ; $569c
; ************************

          LDA CHANNL
          BNE PAT_10
          JSR Print_Question_Mark
          JSR Print_Blank
PAT_10    JMP Read_String

; ******************
  BASIC_READ ; $56a9
; ******************

          LDX DATPTR
          LDY DATPTR+1
          LDA #$98
          .byte $2c ;BIT
READ_10   LDA #0

; ****************
  Read_Get ; $56b2
; ****************

          STA INPFLG
          STX INPPTR
          STY INPPTR+1

; loop reading variables

READ_12   JSR Parse_Name
          STA FORPNT
          STY FORPNT+1
          LDX #1
READ_14   LDA TXTPTR,X
          STA VARTXT,X
          LDA INPPTR,X
          STA TXTPTR,X
          DEX
          BPL READ_14
          JSR CHRGOT
          BNE READ_30
          BIT INPFLG
          BVC READ_22         ; bit 6 set: GETIN
          LDA TEMP_A
          CMP #$f9
          BNE READ_18
READ_16   JSR B_GETIN
          TAX
          BEQ READ_16
          BNE READ_20         ; always

READ_18   JSR B_GETIN
READ_20   STA BUF
          LDX #<BUF-1
          LDY #>BUF-1
          BNE READ_28         ; always

READ_22   BPL READ_24         ; bit 7 set: READ
          JMP READ_DATA
READ_24   LDA CHANNL
          BNE READ_26
          JSR Print_Question_Mark
READ_26   JSR Prompt_And_Input
READ_28   STX TXTPTR
          STY TXTPTR+1

; loop reading character

READ_30   JSR CHRGET
          BIT VALTYP
          BPL READ_38
          BIT INPFLG
          BVC READ_32
          INX
          STX TXTPTR
          LDA #0
          STA CHARAC
          BEQ READ_34
READ_32   STA CHARAC
          CMP #QUOTE
          BEQ READ_35
          LDA #':'
          STA CHARAC
          LDA #','
READ_34   CLC
READ_35   STA ENDCHR
          LDA TXTPTR
          LDY TXTPTR+1
          ADC #0
          BCC READ_36
          INY
READ_36   JSR Create_String_Descriptor_AY
          JSR Restore_Execution_Pointer
          JSR Assign_String_Variable
          JMP READ_40

READ_38   LDX #0
          JSR Read_Real_To_FAC1
          LDA INTFLG
          JSR Assign_Numeric_Variable
READ_40   JSR CHRGOT
          BEQ READ_52
          CMP #','
          BEQ READ_52
          LDA INPFLG
          BEQ READ_44
          BMI READ_42
          LDX CHANNL
          BNE READ_46
READ_42   LDX #$16            ; TYPE MISMATCH
          BNE READ_48
READ_44   LDA CHANNL
          BEQ READ_50
READ_46   LDX #$18            ; FILE DATA
READ_48   JMP Print_Error_X
READ_50   JSR B_PRIMM
          .TEXT "?REDO FROM START\r",0

          LDA OLDTXT
          LDY OLDTXT+1
          STA TXTPTR
          STY TXTPTR+1
          RTS

READ_52   LDX #1
READ_54   LDA TXTPTR,X
          STA INPPTR,X
          LDA VARTXT,X
          STA TXTPTR,X
          DEX
          BPL READ_54
          JSR CHRGOT
          BEQ READ_56
          JSR Need_Comma
          JMP READ_12
READ_56   LDA INPPTR
          LDY INPPTR+1
          LDX INPFLG
          BPL READ_58
          STA DATPTR
          STY DATPTR+1
          RTS

READ_58   LDY #0
          LDA #INPPTR
          JSR Fetch_0
          BEQ READ_Ret
          LDA CHANNL
          BNE READ_Ret
          JSR B_PRIMM
          .TEXT "?EXTRA IGNORED\r",0

READ_Ret  RTS

; *****************
  READ_DATA ; $57ca
; *****************

          JSR Skip_To_EOS
          INY
          TAX
          BNE REDA_10
          LDX #13
          INY
          JSR INDTXT
          BEQ NEXT_40
          INY
          JSR INDTXT
          STA DATLIN
          INY
          JSR INDTXT
          INY
          STA DATLIN+1
REDA_10   JSR Add_Y_To_Execution_Pointer
          JSR CHRGOT
          TAX
          CPX #$83            ; DATA token
          BNE READ_DATA
          JMP READ_30

; ******************
  BASIC_NEXT ; $57f4
; ******************

          BNE NEXT_20         ; branch if index after NEXT
          LDY #$ff
          BNE NEXT_30         ; mark no index variable given
NEXT_10   LDY #$12            ; size of FOR..NEXT structure
          JSR Free_TOS
          JSR CHRGOT
          CMP #','
          BNE NEXT_Ret
          JSR CHRGET
NEXT_20   JSR Parse_Name
          STA FORPNT
NEXT_30   STY FORPNT+1
          LDA #$81            ; FOR marker
          JSR Find_Token_On_Stack
          BEQ NEXT_50
          LDX #10             ; NEXT WITHOUT FOR
NEXT_40   JMP Print_Error_X
NEXT_50   JSR Update_TOS
          LDA FNDPNT
          CLC
          ADC #3
          LDY FNDPNT+1
          BCC NEXT_60
          INY
NEXT_60   JSR Load_FAC1_AY    ; STEP value
          LDY #8
          LDA (FNDPNT),Y      ; STEP sign
          STA FAC1_SI
          LDY #1
          LDA (FNDPNT),Y
          PHA
          TAX
          INY
          LDA (FNDPNT),Y
          PHA
          TAY
          TXA
          JSR Add_Var_AY_To_FAC1 ; FAC1 = index + STEP
          PLA
          TAY
          PLA
          TAX
          STA MMU_LCRD
          JSR FAC1_To_XY      ; store new index value
          LDA FNDPNT
          CLC
          ADC #9
          LDY FNDPNT+1        ; (A/Y) = address of TO value
          BCC NEXT_70
          INY
NEXT_70   STA MMU_LCRC
          JSR Compare_AY_FAC1
          LDY #8
          SEC
          SBC (FNDPNT),Y
          BEQ NEXT_10         ; -> exit FOR..NEXT loop
          LDY #$11
          LDA (FNDPNT),Y      ; set TXTPTR and CURLIN to loop start
          STA TXTPTR          ; and continue
          DEY
          LDA (FNDPNT),Y
          STA TXTPTR+1
          DEY
          LDA (FNDPNT),Y
          STA CURLIN+1
          DEY
          LDA (FNDPNT),Y
          STA CURLIN
NEXT_Ret  RTS

DIM_10    JSR Need_Comma

; *****************
  BASIC_DIM ; $587b
; *****************

          TAX
          JSR Get_Array_Address
          JSR CHRGOT
          BNE DIM_10
          RTS

; *****************
  BASIC_SYS ; $5885
; *****************

          JSR Get_Integer
          LDA LINNUM
          STA PC_LO
          LDA LINNUM+1
          STA PC_HI
          LDA USER_BANK
          STA BANK
          JSR Get_Byte_Or_Void
          BCC SYS_10
          STX A_REG
SYS_10    JSR Get_Byte_Or_Void
          BCC SYS_20
          STX X_REG
SYS_20    JSR Get_Byte_Or_Void
          BCC SYS_30
          STX Y_REG
SYS_30    JSR Get_Byte_Or_Void
          BCC SYS_40
          STX S_REG
SYS_40    JMP K_JSRFAR

; ******************
  BASIC_TRON ; $58b4
; ******************

          LDA #$ff
          .BYTE $2C ;BIT

; *******************
  BASIC_TROFF ; $58b7
; *******************

          LDA #0
          STA TRCFLG
          RTS

; ******************
  BASIC_RREG ; $58bd
; ******************

          LDA #0
          STA B_COUNT         ; count arguments
RREG_10   JSR CHRGOT
          BEQ RREG_25
          CMP #','
          BEQ RREG_20         ; next argument
          JSR Parse_Name
          STA FORPNT
          STY FORPNT+1        ; variable name
          LDA VALTYP
          BNE RREG_30         ; -> string variable not allowed
          LDY B_COUNT
          LDA A_REG,Y
          CPY #3
          BNE RREG_15
          LDA S_REG
RREG_15   TAY
          LDA #0
          JSR Integer_To_Real
          LDA INTFLG
          JSR Assign_Numeric_Variable
RREG_20   INC B_COUNT
          LDA B_COUNT
          CMP #4
          BCS RREG_25         ; loaded A,X,Y,S
          JSR CHRGOT
          BEQ RREG_25
          JSR CHRGET
          BNE RREG_10
RREG_25   RTS
RREG_30   JMP TYPE_MISMATCH

; ******************
  MID_ASSIGN ; $5901
; ******************

          JSR Need_Left_Par
          JSR Parse_Name
          STA FORPNT
          STY FORPNT+1
          JSR Need_String
          JSR Comma_And_Byte
          DEX
          STX KEYSIZ          ; start of substring
          CMP #')'
          BEQ MIDA_10
          JSR Comma_And_Byte
          .BYTE $2C ;BIT
MIDA_10   LDX #$ff
          STX TEMP_A          ; length of substring
          JSR Need_Right_Par
          LDA #$b2            ; '=' token
          JSR Need_A
          JSR Eval_Expression
          JSR Need_String
          LDY #2
MIDA_20   LDA #FORPNT
          JSR Fetch_1
          STA HIGHTR+1,Y
          JSR Get_FAC1_M3_1
          STA TENEXP,Y
          DEY
          BPL MIDA_20
          SEC
          LDA LOWTR
          SBC KEYSIZ
          STA LOWTR
          BCS MIDA_30
          DEC LOWTR+1         ; (LOWTR) = start of substring
MIDA_30   LDA TEMP_A
          CMP TENEXP
          BCC MIDA_40
          LDA TENEXP
MIDA_40   TAX
          BEQ MIDA_70
          CLC
          ADC KEYSIZ
          BCS MIDA_Err
          CMP HIGHTR+1
          BCC MIDA_50
          BNE MIDA_Err
MIDA_50   LDY KEYSIZ
MIDA_60   LDA #LOWTR          ; copy content into substring
          JSR Fetch_1
          STA (FACTPB),Y
          INY
          DEX
          BNE MIDA_60
MIDA_70   JMP Free_String_FAC1
MIDA_Err  JMP Error_Illegal_Quantity

; ******************
  BASIC_AUTO ; $5975
; ******************

          JSR Assert_Direct_Mode
          JSR Scan_Linenumber
          LDA LINNUM
          STA AUTINC
          LDA LINNUM+1
          STA AUTINC+1
          JMP BASIC_Ready

; *************************
  BASIC_HELP ; 5986 ; $5986
; *************************

          LDX ERRNUM
          INX
          BEQ HELP_10
          LDA ERRLIN
          LDY ERRLIN+1
          STA LINNUM
          STY LINNUM+1
          JSR Search_BASIC_Line
          BCC HELP_10
          ROR HELPER
          JSR Print_CR
          LDX LINNUM
          LDA LINNUM+1
          JSR List_Line
          LSR HELPER
HELP_10   JMP Print_CR

; *************************
  At_Error_Position ; $59ac
; *************************

          LDX LOWTR+1
          TYA
          CLC
          ADC LOWTR
          BCC AEP_10
          INX
AEP_10    CPX ERRTXT+1
          BNE AEP_Ret
          CMP ERRTXT
          BCC AEP_Ret
          BEQ AEP_Ret
          LSR HELPER
          LDA #$12
          BIT MODE_80
          BPL AEP_20
          LDA #2
AEP_20    JMP Print_Char
AEP_Ret   RTS

; *******************
  BASIC_GOSUB ; $59cf
; *******************

          JSR Push_GOSUB
          JSR CHRGOT
          JSR BASIC_GOTO
          JMP Next_Statement

; ******************
  BASIC_GOTO ; $59db
; ******************

          JSR Scan_Linenumber
          LDA ENDCHR          ; line # needed
          BEQ GoTo_Err        ; SYNTAX ERROR

; ************
  GoTo ; $59e2
; ************

          JSR End_Of_Line
          SEC
          LDA CURLIN
          SBC LINNUM
          LDA CURLIN+1
          SBC LINNUM+1
          BCS GoTo_10
          TYA
          SEC
          ADC TXTPTR
          LDX TXTPTR+1
          BCC GoTo_20
          INX
          BCS GoTo_20

; ***************
  GoTo_10 ; $59fb
; ***************

          LDA TXTTAB
          LDX TXTTAB+1
GoTo_20   JSR Find_LINNUM_AX
          BCC UNDEFINED_STATEMENT
          LDA LOWTR
          SBC #1
          STA TXTPTR
          LDA LOWTR+1
          SBC #0
          STA TXTPTR+1
          BIT RUNMOD
          BPL Set_Run_Mode
          RTS

; ***************************
  UNDEFINED_STATEMENT ; $5a15
; ***************************

          LDX #$11            ; UNDEF'D STATEMENT
          JMP Print_Error_X
GoTo_Err  JMP SYNTAX_ERROR

; ******************
  Push_GOSUB ; $5a1d
; ******************

          LDA #5
          JSR SUB_TOS
          LDY #4
          LDA TXTPTR+1
          STA (TOS),Y
          DEY
          LDA TXTPTR
          STA (TOS),Y
          DEY
          LDA CURLIN+1
          STA (TOS),Y
          DEY
          LDA CURLIN
          STA (TOS),Y
          DEY
          LDA #$8d            ; GOSUB token
          STA (TOS),Y
          RTS

; ****************
  BASIC_GO ; $5a3d
; ****************

          JSR CHRGET
          CMP #$a4            ; TO token
          BNE GO_10
          JSR CHRGET
          JMP BASIC_GOTO
GO_10     JSR Get_Byte_Var
          CPX #64             ; GO64 ?
          BEQ GO_20
          JMP SYNTAX_ERROR
GO_20     JSR ARE_YOU_SURE
          BNE GO_Ret
          JSR Map_IO
          JMP K_C64
GO_Ret    RTS

; ******************
  BASIC_CONT ; $5a60
; ******************

          BNE SRM_Ret
          BIT RUNMOD
          BMI SRM_Ret
          LDX #$1a            ; CAN'T CONTINUE
          LDY OLDTXT+1
          BNE CONT_10
          JMP Print_Error_X
CONT_10   LDA OLDTXT
          STA TXTPTR
          STY TXTPTR+1
          LDA OLDLIN
          LDY OLDLIN+1
          STA CURLIN
          STY CURLIN+1

; ********************
  Set_Run_Mode ; $5a81
; *******************

          LDA #$80
          STA RUNMOD
          ASL A               ; A = 0
          STA AUTINC          ; disable AUTO
          STA AUTINC+1
          STA INT_VAL
          STA INSFLG
          LDX #2
SRM_10    STA INT_TRIP_FLAG,X
          DEX
          BPL SRM_10
          JMP K_SETMSG
SRM_Ret   RTS

; *****************
  BASIC_RUN ; $5a9b
; *****************

          BEQ RUN_10          ; RUN
          BCC RUN_20          ; RUN line
          LDA #$40
          STA RUNMOD
          JSR BASIC_DLOAD     ; LOAD and RUN

; ****************
  LINK_RUN ; $5aa6
; ****************

          JSR Set_Run_Mode
          JSR Reset_BASIC_Execution
          JSR Relink
          JSR Print_CR
          JMP Next_Statement
RUN_10    JSR Set_Run_Mode
          JMP Reset_BASIC_Execution
RUN_20    JSR Clear_BASIC
          JSR CHRGOT
          JSR BASIC_GOTO
          JSR Set_Run_Mode
          JMP Next_Statement

; *********************
  BASIC_RESTORE ; $5aca
; *********************

          BEQ Reset_DATPTR
          JSR Get_Integer
          STY LINNUM
          STA LINNUM+1
          JSR Search_BASIC_Line
          BCS REST_10X
          JMP UNDEFINED_STATEMENT
REST_10X  LDA LOWTR
          LDY LOWTR+1
          BCS ReDP_10

; ********************
  Reset_DATPTR ; $5ae1
; ********************

          SEC
          LDA TXTTAB
          LDY TXTTAB+1
ReDP_10   SBC #1
          BCS ReDP_20
          DEY
ReDP_20   STA DATPTR
          STY DATPTR+1
          RTS


; **************
  Renumber_Token
; **************

           .BYTE $89 ; GOTO
           .BYTE $8a ; RUN
           .BYTE $8d ; GOSUB
           .BYTE $a7 ; THEN
           .BYTE $8c ; RESTORE
           .BYTE $d6 ; RESUME
           .BYTE $d7 ; TRAP
           .BYTE $d5 ; ELSE

; **************
  BASIC_RENUMBER
; **************

           JSR Assert_Direct_Mode
           LDA #>10           ; default start & increment = 10
           LDX #<10
           STX Ren_Line_Lo
           STA Ren_Line_Hi
           STX Ren_Step_Lo
           STA Ren_Step_Hi
           STA HIGHTR
           STA HIGHTR+1
           JSR CHRGOT
           BEQ RENU_08        ; -> no arguments after RENUMBER
           JSR Scan_Linenumber
           LDA ENDCHR
           BEQ RENU_02        ; -> only increment given
           LDA LINNUM
           LDX LINNUM+1
           STA Ren_Line_Lo    ; new start value
           STX Ren_Line_Hi
RENU_02    JSR Get_Comma_And_Integer
           BCC RENU_06
           STY Ren_Step_Lo    ; increment value
           STA Ren_Step_Hi
           ORA Ren_Step_Lo    ; test for zero
           BNE RENU_06
RENU_04    JMP Error_Illegal_Quantity ; zero increment
RENU_06    JSR Get_Comma_And_Integer
           BCC RENU_08        ; -> no old start value given
           STY HIGHTR
           STY LINNUM
           STA HIGHTR+1
           STA LINNUM+1
           JSR Search_BASIC_Line
           LDA LOWTR
           LDX LOWTR+1
           STA ARYPNT
           STX ARYPNT+1
           LDA Ren_Line_Lo
           LDX Ren_Line_Hi
           STA LINNUM
           STX LINNUM+1
           JSR Search_BASIC_Line
           SEC
           LDA LOWTR
           SBC ARYPNT
           LDA LOWTR+1
           SBC ARYPNT+1
           BCC RENU_04
RENU_08    JSR Ren_Line_To_FAC          ; RENUMBER pass 1
           JSR Next_Byte                ; check range of new line numbers
           INY
           JSR INDTXT
           BEQ RENUMBER_PASS_2
RENU_10    INY
           JSR INDTXT
           SEC
           SBC HIGHTR
           INY
           JSR INDTXT
           SBC HIGHTR+1
           BCS RENU_12
           JSR Next_BASIC_Line
           BNE RENU_10
           BEQ RENUMBER_PASS_2
RENU_12    JSR Next_BASIC_Line
           BEQ RENUMBER_PASS_2
           JSR Add_Renumber_Step
           BCS RENU_14
           CMP #$f9           ; line number < $f900 (63744)
           BCC RENU_12
RENU_14    LDX #$26           ; line number too large
           JMP Print_Error_X

; ***************
  Next_BASIC_Line
; ***************

           LDY #0
           JSR INDTXT
           TAX
           INY
           JSR INDTXT
           BEQ NBL_Ret
           STX TXTPTR
           STA TXTPTR+1
NBL_Ret    RTS

; ***************
  RENUMBER_PASS_2
; ***************

           LDA #1
           STA TEMP_A         ; Flag for test run
           LDA TEXT_TOP
           LDX TEXT_TOP+1
           STA FNDPNT
           STX FNDPNT+1
           JSR Replace_Targets
           DEC TEMP_A         ; Flag for run
           JSR Replace_Targets
RENU_20    JSR Get_Link_Hi
           BEQ RENU_26
           JSR Next_Byte
           STA LINNUM         ; line # lo
           INY
           JSR INDTXT         ; line # hi
           SEC
           SBC HIGHTR+1
           BCC RENU_24        ; -> line # < old start
           BNE RENU_22
           LDA LINNUM
           SBC HIGHTR
           BCC RENU_24        ; -> line # < old start
RENU_22    LDA FAC1_M1
           STA (TXTPTR),Y     ; new line # hi
           DEY
           LDA FAC1_M2
           STA (TXTPTR),Y     ; new line # lo
           JSR Next_Byte
           JSR Next_Number
           BEQ RENU_20
RENU_24    JSR Next_Byte
           JSR Skip_To_EOL
           BEQ RENU_20
RENU_26    JMP Relink_Set_Top ; finished

; ***************
  Replace_Targets
; ***************

           JSR Reset_TXTPTR
RENU_30    JSR Get_Link_Hi
           BNE RENU_32
           JMP Ren_Line_To_FAC ; -> return
RENU_32    JSR Next_Byte
           STA FORPNT
           JSR Next_Byte
           STA FORPNT+1       ; (FORPNT) := old number
RENU_34    JSR Next_Byte
RENU_36    CMP #QUOTE
           BNE RENU_40
RENU_38    JSR Next_Byte
           BEQ RENU_30
           CMP #QUOTE
           BNE RENU_38
           BEQ RENU_34
RENU_40    TAX
           BEQ RENU_30        ; -> end of line
           BPL RENU_34        ; -> no token
           LDX #8             ; # of tokens
RENU_42    CMP Renumber_Token-1,X
           BEQ RENU_50
           DEX
           BNE RENU_42
           CMP #$cb           ; GO token
           BNE RENU_46
RENU_44    JSR CHRGET
           BEQ RENU_30
           CMP #$a4           ; TO token
           BEQ RENU_50
           BNE RENU_34
RENU_46    CMP #$fe           ; start of 2-byte token
           BNE RENU_34
           JSR CHRGET
           BEQ RENU_44
           CMP #$17           ; COLLISION token
           BNE RENU_34
RENU_48    JSR CHRGET
           BEQ RENU_44
           CMP #','
           BNE RENU_48
RENU_50    LDA TXTPTR         ; found token with target
           STA OLDLIN
           LDA TXTPTR+1
           STA OLDLIN+1
           JSR CHRGET
           BCS RENU_36
           JSR Scan_Linenumber
           JSR Replace_Number
           LDA OLDLIN
           STA TXTPTR
           LDA OLDLIN+1
           STA TXTPTR+1
           JSR CHRGET
           LDA TXTPTR
           BNE RENU_52
           DEC TXTPTR+1
RENU_52    DEC TXTPTR
           LDX #$ff
           LDA TEMP_A         ; test run or active run ?
           BEQ RENU_60        ; -> do replacement
           JSR Test_OOM_CHRGOT
RENU_54    CMP #','
           BEQ RENU_50        ; -> multiple targets
           BNE RENU_36        ; -> look for next token

; ***************
  Test_OOM_Bank_0
; ***************

           INX                ; X = length of old number
           LDA STACK+1,X
           BEQ OOM0_30
           JSR CHRGET
           BCC Test_OOM_Bank_0
OOM0_10    INC FNDPNT
           BNE OOM0_20
           INC FNDPNT+1
OOM0_20    SEC
           LDA FNDPNT
           SBC TEXT_MAX
           LDA FNDPNT+1
           SBC TEXT_MAX+1
           BCS OOM0_Err
           INX
           LDA STACK+1,X
           BNE OOM0_10
           RTS
OOM0_30    JSR CHRGET
           BCS OOM0_Ret
           LDA FNDPNT
           BNE OOM0_40
           DEC FNDPNT+1
OOM0_40    DEC FNDPNT
           BCC OOM0_30
OOM0_Ret   RTS
OOM0_Err   JMP OOM_Error



; *******
  RENU_60
; *******

           INX
RENU_62    LDA STACK+1,X
           BEQ RENU_68
           PHA
           JSR Next_Byte
           CMP #':'
           BCS RENU_64
           CMP #' '
           BEQ RENU_64
           SEC
           SBC #'0'
           SEC
           SBC #$d0
           BCC RENU_66        ; -> no digit
RENU_64    JSR Save_TXTPTR
           INC FAC2_M3
           JSR Move_Text_Down ; delete old number
           INC TEXT_TOP
           BNE RENU_66
           INC TEXT_TOP+1
RENU_66    PLA
           LDY #0
           STA (TXTPTR),Y
           INX
           BNE RENU_62
RENU_68    JSR CHRGET
           BCS RENU_54
RENU_70    JSR Save_TXTPTR
           DEC FAC2_M3
           JSR Move_Text_Up   ; insert new number
           LDA TEXT_TOP
           BNE RENU_72
           DEC TEXT_TOP+1
RENU_72    DEC TEXT_TOP
           JSR CHRGOT
           BCC RENU_70
           JMP RENU_54        ; replacement done

; **************
  Replace_Number
; **************

           JSR Ren_Line_To_FAC
RENU_80    JSR Get_Link_Hi
           BNE RENU_82
           LDX #$27           ; unresolved reference
           LDA FORPNT
           STA CURLIN
           LDA FORPNT+1
           STA CURLIN+1
           JMP Print_Error_X
RENU_82    JSR Next_Byte      ; line # lo
           STA ARYPNT
           CMP LINNUM
           BNE RENU_88
           JSR Next_Byte      ; line # hi
           STA ARYPNT+1
           CMP LINNUM+1
           BNE RENU_90
           SEC
           SBC HIGHTR+1
           BCC RENU_84
           BNE RENU_86
           LDA LINNUM
           SBC HIGHTR
           BCS RENU_86
RENU_84    LDA LINNUM
           STA FAC1_M2
           LDA LINNUM+1
           STA FAC1_M1
RENU_86    LDX #$90
           SEC
           JSR Word_To_FAC1
           JMP Format_FAC1

RENU_88    JSR Next_Byte
           STA ARYPNT+1
RENU_90    JSR Next_Line
           BEQ RENU_80

; ***************
  Ren_Line_To_FAC
; ***************

           LDA Ren_Line_Lo
           STA FAC1_M2
           LDA Ren_Line_Hi
           STA FAC1_M1
           JMP Reset_TXTPTR

; *********
  Next_Line
; *********

           LDA ARYPNT
           SEC
           SBC HIGHTR
           LDA ARYPNT+1
           SBC HIGHTR+1
           BCC Skip_To_EOL

; ***********
  Next_Number
; ***********

           JSR Add_Renumber_Step

; ***********
  Skip_To_EOL
; ***********

           JSR Next_Byte
           BNE Skip_To_EOL
           RTS

; *****************
  Add_Renumber_Step
; *****************

           LDA FAC1_M2
           CLC
           ADC Ren_Step_Lo
           STA FAC1_M2
           LDA FAC1_M1
           ADC Ren_Step_Hi
           STA FAC1_M1
           RTS

; ***********
  Get_Link_Hi
; ***********

           JSR Next_Byte

; *********
  Next_Byte
; *********

           LDY #0
           INC TXTPTR
           BNE NeBy_10
           INC TXTPTR+1
NeBy_10    JMP INDTXT

; ***********
  Save_TXTPTR
; ***********

           LDA TXTPTR
           STA INDEXA
           LDA TXTPTR+1
           STA INDEXA+1
           LDA TEXT_TOP
           STA INDEXB
           LDA TEXT_TOP+1
           STA INDEXB+1
           LDY #0
           STY B_COUNT
           STY FAC2_M3
           RTS


; **********
  Inc_INDEXB
; **********

           INC INDEXA
           BNE Move_Text_Up
           INC INDEXA+1

; ************
  Move_Text_Up
; ************

           LDY B_COUNT
           INY
           JSR Get_INDEXA_0
           LDY FAC2_M3
           INY
           STA (INDEXA),Y
           JSR INDEXA_EQ_INDEXB
           BNE Inc_INDEXB
           RTS


; **********
  Dec_INDEXB
; **********

           LDA INDEXB
           BNE DEI2_10
           DEC INDEXB+1
DEI2_10    DEC INDEXB

; **************
  Move_Text_Down
; **************

           LDY B_COUNT
           JSR Get_INDEXB_0
           LDY FAC2_M3
           STA (INDEXB),Y
           JSR INDEXA_EQ_INDEXB
           BNE Dec_INDEXB
           RTS

; ****************
  INDEXA_EQ_INDEXB
; ****************

           LDA INDEXA
           CMP INDEXB
           BNE CII2_Ret
           LDA INDEXA+1
           CMP INDEXB+1
CII2_Ret   RTS


; *****************
  BASIC_FOR ; $5df9
; *****************

          LDA #$80
          STA SUBFLG          ; Inhibit integer index
          JSR BASIC_LET       ; define index variable
          LDA #$81            ; FOR token
          JSR Find_Token_On_Stack
          BEQ FOR_10          ; -> found
          LDA #$12            ; allocate 18 bytes for structure
          JSR SUB_TOS
          JSR Init_FNDPNT
FOR_10    JSR Update_TOS
          JSR Skip_To_EOS
          TYA
          LDY #$11
          CLC
          ADC TXTPTR
          STA (TOS),Y         ; 11 : TXTPTR of loop body
          LDA TXTPTR+1
          ADC #0
          DEY
          STA (TOS),Y         ; 10 : TXTPTR+1
          LDA CURLIN+1
          DEY
          STA (TOS),Y         ; 0f : CURLIN+1
          LDA CURLIN
          DEY
          STA (TOS),Y         ; 0e : CURLIN
          LDA #$a4            ; TO token
          JSR Need_A
          JSR Assert_Numeric
          JSR Eval_Numeric
          LDA FAC1_SI
          ORA #$7f
          AND FAC1_M1         ; put sign bit into M1
          STA FAC1_M1
          LDX #4
          LDY #13
FOR_20    LDA FAC1_EX,X       ; 09-0d : store TO value
          STA (TOS),Y
          DEX                 ; non fatal bug
          DEY                 ; X<0 should end the loop
          BPL FOR_20
          LDA #<Real_1        ; default STEP value = 1.0
          LDY #>Real_1
          JSR Load_FAC1_AY
          JSR CHRGOT
          CMP #$a9            ; STEP token
          BNE FOR_30
          JSR CHRGET
          JSR Eval_Numeric    ; get STEP value
FOR_30    JSR Test_FAC1_Sign
          PHA
          JSR Round_FAC1
          PLA
          LDY #8
          LDX #5
FOR_40    STA (TOS),Y         ; 08    : store STEP sign
          LDA FAC1_EX-1,X     ; 03-07 : store STEP value
          DEY
          DEX
          BPL FOR_40
          LDA FORPNT+1
          STA (TOS),Y         ; 02 : FORPNT+1
          LDA FORPNT
          DEY
          STA (TOS),Y         ; 01 : FORPNT
          LDA #$81
          DEY
          STA (TOS),Y         ; 00 : FOR token marker
          RTS
FOR_Err   JMP SYNTAX_ERROR

; ********************
  BASIC_DELETE ; $5e87
; ********************

          JSR Assert_Direct_Mode
          JSR CHRGOT
          BEQ FOR_Err
          JSR Get_Line_Range
          LDA LOWTR
          LDX LOWTR+1
          STA INDEXB
          STX INDEXB+1
          JSR Search_BASIC_Line
          BCC DEL_20          ; -> not found
          LDY #1
          JSR Get_LOWTR_0     ; link high
          DEY
          TAX
          BNE DEL_10
          JSR Get_LOWTR_0     ; link low
          BEQ DEL_20          ; -> end of program
DEL_10    JSR Get_LOWTR_0
          STA LOWTR
          STX LOWTR+1         ; (LOWTR) = next line
DEL_20    LDA INDEXB
          SEC
          SBC LOWTR
          TAX
          LDA INDEXB+1
          SBC LOWTR+1
          TAY
          BCS Relink_Set_Top  ; -> finished deleting
          TXA
          CLC
          ADC TEXT_TOP
          STA TEXT_TOP
          TYA
          ADC TEXT_TOP+1
          STA TEXT_TOP+1
          LDY #0
DEL_30    JSR Get_LOWTR_0     ; move upper part of program
          STA (INDEXB),Y      ; down, deleting current line
          INC LOWTR
          BNE DEL_40
          INC LOWTR+1
DEL_40    JSR Inc_INDEXB_Cmp_TEXT_TOP
          BCC DEL_30
          NOP
          NOP
          NOP

; **********************
  Relink_Set_Top ; $5ee5
; **********************

          JSR Relink
          LDA INDEXA
          LDX INDEXA+1
          CLC
          ADC #2
          STA TEXT_TOP
          BCC ReST_10
          INX
ReST_10   STX TEXT_TOP+1
          RTS

          .FILL $5efb-* , $00 ;    2 bytes

; **********************
  Get_Line_Range ; $5efb
; **********************

          BEQ GLR_10          ; -> no arguments
          BCC GLR_10          ; -> digit
          CMP #$ab            ; leading '-' token
          BNE GLR_ERR         ; neither number nor minus
          LDY #1
          JSR INDTXT          ; char after -
          BEQ GLR_ERR         ; none:  -> error
          CMP #':'
          BEQ GLR_ERR         ; colon: -> error
          SEC
GLR_10    JSR Scan_Linenumber
          JSR Search_BASIC_Line
          JSR CHRGOT
          BEQ GLR_20          ; -> end of statement
          CMP #$ab            ; '-' token
          BNE GLR_ERR
          JSR CHRGET
          JSR Scan_Linenumber
          BNE GLR_ERR
GLR_20    LDA ENDCHR          ; # of digits
          BNE GLR_Ret
          LDA #$ff            ; endline default = $ffff
          STA LINNUM
          STA LINNUM+1
GLR_Ret   RTS
GLR_ERR   JMP SYNTAX_ERROR

; *******************
  BASIC_PUDEF ; $5f34
; *******************

          JSR Eval_String
          TAY                 ; length of string
          DEY
          CPY #4
          BCC PUDEF_10
          JMP Error_Illegal_Quantity ; PUDEF string too long
PUDEF_10  JSR Get_INDEXA_1
          STA MMU_LCRC
          STA PU_FILL,Y        ; redefine PU characters
          DEY
          BPL PUDEF_10
          RTS

; ******************
  BASIC_TRAP ; $5f4d
; ******************

          JSR Assert_Non_Direct
          JSR CHRGOT
          BEQ TRAP_10         ; -> disable trapping
          JSR Get_Integer
          STY TRAPNO
          .BYTE $2C ;BIT
TRAP_10   LDA #$ff
          STA TRAPNO+1
          RTS

; ********************
  BASIC_RESUME ; $5f62
; ********************

          JSR Assert_Non_Direct
          LDX ERRLIN+1
          INX
          BEQ CANT_RESUME     ; no error line defined
          JSR CHRGOT
          BEQ Resume_Execution
          BCC RESU_30
          CMP #$82            ; NEXT token
          BNE RESU_Err
          JSR Resume_Execution
          LDY #0
          JSR INDTXT
          BNE RESU_20
          INY
          JSR INDTXT
          BNE RESU_10
          INY
          JSR INDTXT
          BNE RESU_10
          JMP BASIC_Ready
RESU_10   LDY #3
          JSR INDTXT
          STA CURLIN
          INY
          JSR INDTXT
          STA CURLIN+1
          TYA
          CLC
          ADC TXTPTR
          STA TXTPTR
          BCC RESU_20
          INC TXTPTR+1
RESU_20   JSR CHRGET
          JMP Skip_Statement
RESU_30   JSR Get_Integer
          STA LINNUM+1
          JSR Clear_Error_Flag
          JMP GoTo_10

; *********************************
  Resume_Execution ; $ 5fb7 ; $5fb7
; *********************************

          LDX #1
ReEx_10   LDA ERRLIN,X
          STA CURLIN,X
          LDA ERRTXT,X
          STA TXTPTR,X
          DEX
          BPL ReEx_10

; ************************
  Clear_Error_Flag ; $5fc6
; ************************

          LDX #$ff
          STX ERRNUM
          STX ERRLIN
          STX ERRLIN+1
          LDX TMPTRP
          STX TRAPNO+1
          RTS
RESU_Err  JMP SYNTAX_ERROR

; ****************************
  CANT_RESUME ; $b5fdb ; $5fdb
; ****************************

      LDX #$1f
      JMP Print_Error_X

; ****************
  BASIC_DO ; $5fe0
; ****************

          LDY #1
DO_10     LDA TXTPTR,Y        ; save position and line #
          STA TEXT_TMP,Y
          LDA CURLIN,Y
          STA TEXT_LIN,Y
          DEY
          BPL DO_10
          JSR CHRGOT
          BEQ DO_40           ; -> unconditional DO
          CMP #$fc            ; UNTIL token
          BEQ DO_30
          CMP #$fd            ; WHILE token
          BNE Exit_Syn        ; SYNTAX ERROR
          JSR Next_Expression
          LDA FAC1_EX
          BNE DO_40           ; -> WHILE(true)
DO_20     JSR CHRGOT
          JMP EXIT_10         ; -> WHILE(false)

DO_30     JSR Next_Expression
          LDA FAC1_EX
          BNE DO_20           ; -> UNTIL(true)
DO_40     LDA #5
          JSR SUB_TOS         ; allocate DO structure
          STA MMU_LCRC
          LDY #4
          LDA TEXT_TMP+1
          STA (TOS),Y         ; TXTPTR loop body
          DEY
          LDA TEXT_TMP
          STA (TOS),Y
          DEY
          LDA TEXT_LIN+1      ; LINE # loop body
          STA (TOS),Y
          DEY
          LDA TEXT_LIN
          STA (TOS),Y
          DEY
          LDA #$eb            ; DO token marker
          STA (TOS),Y
          RTS

; ******************
  BASIC_EXIT ; $6039
; ******************

          JSR Exit_DO
          JSR CHRGOT
          BEQ EXIT_10
Exit_Syn  JMP SYNTAX_ERROR

; *****************
  Exit_LOOP ; $6044
; *****************

          JSR CHRGET
EXIT_10   BEQ EXIT_30
          CMP #$ec            ; LOOP token
          BEQ EXIT_40
          CMP #QUOTE
          BEQ EXIT_20
          CMP #$eb            ; DO token
          BNE Exit_LOOP
          JSR Exit_LOOP
          JMP DO_20
EXIT_20   JSR Skip_To_End_Of_String
          BNE Exit_LOOP
EXIT_30   CMP #':'
          BEQ Exit_LOOP
          BIT RUNMOD
          BPL EXIT_50
          LDY #2
          JSR INDTXT
          BEQ EXIT_50
          INY
          JSR INDTXT
          STA CURLIN
          INY
          JSR INDTXT
          STA CURLIN+1
          TYA
          CLC
          ADC TXTPTR
          STA TXTPTR
          BCC Exit_LOOP
          INC TXTPTR+1
          BNE Exit_LOOP
EXIT_40   JMP Skip_Statement

; ******************
  BASIC_LOOP ; $608a
; ******************

          BEQ EXIT_80
          CMP #$fd
          BEQ EXIT_70
          CMP #$fc
          BNE Exit_Syn
          JSR Next_Expression
          LDA FAC1_EX
          BEQ EXIT_80

; ***************
  Exit_DO ; $609b
; ***************

          LDA #$eb            ; DO token
          JSR Find_Token_On_Stack
          BNE EXIT_60
          JSR Update_TOS
          LDY #5
          JMP Free_TOS

EXIT_50   LDA TEXT_LIN
          LDX TEXT_LIN+1
          STA CURLIN
          STX CURLIN+1
          LDX #$20            ; LOOP NOT FOUND
          .BYTE $2C ;BIT
EXIT_60   LDX #$21            ; LOOP WITHOUT DO
          JMP Print_Error_X
EXIT_70   JSR Next_Expression
          BEQ Exit_DO
EXIT_80   JSR Exit_DO
          DEY
          LDA (FNDPNT),Y
          STA TXTPTR+1
          DEY
          LDA (FNDPNT),Y
          STA TXTPTR
          DEY
          LDA (FNDPNT),Y
          JSR To_Direct_Mode
          LDA (FNDPNT),Y
          STA CURLIN
          JMP BASIC_DO

; ***********************
  Next_Expression ; $60db
; ***********************

          JSR CHRGET
          JMP Eval_Expression

; ******************
  Assign_Key ; $60e1
; ******************

          JSR Get_Byte_Var
          DEX                 ; key # minus 1
          CPX #8              ; 8 function keys
          BCC AsKe_10
          JMP Error_Illegal_Quantity
AsKe_10   STX TEMP_A
          JSR Need_Comma
          JSR Eval_String
          TAY
          LDA #1
          STA INDEXB
          LDA #INDEXA
          LDX TEMP_A
          INX                 ; X = key #
          JSR Map_IO
          JSR K_PFKEY
          BCS AsKe_OOM
          RTS
AsKe_OOM  JMP OOM_Error

; *****************
  BASIC_KEY ; $610a
; *****************

          BEQ BKEY_10         ; -> list key strings
          CMP #$91            ; ON token
          BEQ BKEY_Err
          CMP #$fe
          BNE Assign_Key
          JSR CHRGET
          CMP #$24            ; $fe24 = OFF token
          BEQ BKEY_Err
          JMP SYNTAX_ERROR
BKEY_Err  JMP Unimplemented

BKEY_10   LDX #0
          LDY #0
BKEY_15   INX
          LDA PKYBUF-1,X      ; length of key string
          BEQ BKEY_60          ; -> zero = unset
          STA KEYSIZ
          STX TEMP_A          ; key #
          LDX #5
BKEY_20   LDA KEYREV,X        ; print KEY N,
          DEX
          BNE BKEY_25
          ORA TEMP_A
BKEY_25   JSR B_BSOUT
          TXA
          BPL BKEY_20
          LDX #7
BKEY_30   LDA PKYDEF,Y        ; next char
          INY
          PHA
          STX SYNTMP          ; save X
          LDX #4
BKEY_35   CMP PFKEY_SPECIAL,X
          BEQ BKEY_65         ; -> found special char
          DEX
          BNE BKEY_35
          LDX SYNTMP          ; restore X
          CPX #8
          BCC BKEY_40
          BNE BKEY_45
          LDA #'+'
          JSR B_BSOUT
BKEY_40   LDA #QUOTE
          JSR B_BSOUT
BKEY_45   PLA
          JSR B_BSOUT
          LDX #9
BKEY_50   DEC KEYSIZ
          BNE BKEY_30
          CPX #9
          BCC BKEY_55
          LDA #QUOTE
          JSR B_BSOUT
BKEY_55   LDA #$8d            ; SHIFT RETURN
          JSR B_BSOUT
          LDX TEMP_A
BKEY_60   CPX #8
          BNE BKEY_15         ; -> loop to next key
          RTS

BKEY_65   LDX SYNTMP          ; handle printing of special chars
BKEY_70   LDA REVCHR-3,X
          JSR B_BSOUT
          DEX
          CPX #3
          BCS BKEY_70
          PLA
          JSR Print_Byte_A
          LDA #')'
          JSR B_BSOUT
          LDX #8
          BNE BKEY_50         ; always

REVCHR    .TEXT "($RHC+"

PFKEY_SPECIAL
          .BYTE $22,$0d,$8d,$22,$1b

; *******************
  BASIC_PAINT ; $61a8
; *******************

          JSR Assert_Color_Source
          LDX #4
          JSR Get_Graphics_XY
          JSR XY_DEST_To_POS
          JSR Get_Byte_Or_Zero
          CPX #2
          BCC PAINT_10        ; allow 0 or 1
          JMP Error_Illegal_Quantity
PAINT_10  TXA
          LSR A
          ROR A
          STA STOPNB
          BPL PAINT_15
          LDA COLSEL
          BEQ PAINT_20
PAINT_15  JSR Get_Pixel
          BCS PAINT_20
          BNE PAINT_25
PAINT_20  RTS

PAINT_25  JSR Garbage_Collection
          STA MMU_LCRC
          LDA STREND
          STA INDEXA
          LDA STREND+1
          STA INDEXA+1
          SEC
          LDA FRETOP
          SBC #3
          STA TEMPST
          LDA FRETOP+1
          SBC #0
          STA TEMPST+1
PAINT_30  LDX #0
          STX FAC1_EX
          STX FAC1_M1
PAINT_35  LDX YPOS
          BNE PAINT_40
          DEC YPOS+1
PAINT_40  DEC YPOS
          JSR Get_Pixel
          BCS PAINT_45
          BNE PAINT_35
PAINT_45  INC YPOS
          BNE PAINT_50
          INC YPOS+1
PAINT_50  JSR Set_Pixel
          LDX XPOS
          BNE PAINT_55
          DEC XPOS+1
PAINT_55  DEC XPOS
          LDA FAC1_EX
          JSR Test_Pixel
          STA FAC1_EX
          CLC
          LDA XPOS
          ADC #2
          STA XPOS
          BCC PAINT_60
          INC XPOS+1
PAINT_60  LDA FAC1_M1
          JSR Test_Pixel
          STA FAC1_M1
          LDX XPOS
          BNE PAINT_65
          DEC XPOS+1
PAINT_65  DEC XPOS
          INC YPOS
          BNE PAINT_70
          INC YPOS+1
PAINT_70  JSR Get_Pixel
          BCS PAINT_75
          BNE PAINT_50
PAINT_75  LDX #3
          LDY #0
          LDA INDEXA+1
          CMP STREND+1
          BNE PAINT_80
          LDA INDEXA
          CMP STREND
          BEQ PAINT_90
PAINT_80  LDA INDEXA
          BNE PAINT_85
          DEC INDEXA+1
PAINT_85  DEC INDEXA
          JSR Get_INDEXA_1
          STA MMU_LCRC
          STA XPOS,X
          DEX
          BPL PAINT_80
          JSR Is_STOP_Key
          JMP PAINT_30
PAINT_90  JMP XY_DEST_To_POS

; ******************
  Test_Pixel ; $627c
; ******************

          PHA
          JSR Get_Pixel
          BCS TePi_10
          BEQ TePi_10
          PLA
          BNE TePi_20
          TAX
          TAY
          LDA INDEXA+1
          CMP TEMPST+1
          BCC TePi_30
          BNE TePi_OOM
          LDA INDEXA
          CMP TEMPST
          BCC TePi_30
TePi_OOM  JMP OOM_Error
TePi_10   PLA
          LDA #0
TePi_20   RTS
TePi_30   LDA XPOS,X
          STA MMU_LCRD
          STA (INDEXA),Y
          STA MMU_LCRC
          INC INDEXA
          BNE TePi_40
          INC INDEXA+1
TePi_40   INX
          CPX #4
          BNE TePi_30
          LDA #$80
          RTS

; *****************
  BASIC_BOX ; $62b7
; *****************

          JSR Assert_Color_Source
          LDX #XCIRCL-XPOS    ; $1f = address of upper left corner
          JSR Get_Comma_And_Coordinates
          LDX #ANGBEG-XPOS    ; $2b = address of lower right corner
          JSR Get_Graphics_XY
          JSR Get_Comma_And_Integer
          STY XRADIUS
          STA XRADIUS+1
          JSR Get_Byte_Or_Zero
          CPX #2
          BCC BOX_02
          JMP Error_Illegal_Quantity
BOX_02    STX FILFLG
          TXA
          PHA
          JSR BOX_SUB
          PLA
          BNE BOX_12
          BEQ BOX_06

BOX_04    JSR BOX_PAINT
BOX_06    JSR Draw_Line
          LDA ANGCNT
          BNE BOX_04
BOX_08    LDX #4
BOX_10    LDA ANGBEG-1,X
          STA XPOS-1,X
          DEX
          BNE BOX_10
          STX FILFLG
          RTS
BOX_12    LDX #0
          LDA ANGSGN
          LSR A
          BCC BOX_14
          LDX #2
BOX_14    LDA XRCOS,X
          STA YDIST2
          LDA XRCOS+1,X
          STA YDIST2+1
          LDA #0
          LDX #3
BOX_16    STA YRADIUS,X
          DEX
          BPL BOX_16
BOX_18    LDX #7
BOX_20    LDA XPOS,X
          PHA
          DEX
          BPL BOX_20
          JSR Draw_Line
          LDX #0
BOX_22    PLA
          STA XPOS,X
          INX
          CPX #8
          BNE BOX_22
BOX_24    LDA YDIST2
          BNE BOX_26
          DEC YDIST2+1
          BMI BOX_08
BOX_26    DEC YDIST2
          LDX #$25 ; '%'
          LDY #$1b
          LDA ANGSGN
          LSR A
          BCC BOX_28
          LDY #$19
BOX_28    LDA #0
BOX_30    LSR A
          PHA
          JSR LAY_Y_ADD_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
          PLA
          BCC BOX_32
          ORA #%10100000 ; $a0
BOX_32    INX
          INX
          LDY #$19
          LSR ANGSGN
          BCC BOX_34
          LDY #$1b
BOX_34    ROL ANGSGN
          CPX #$27 ; '''
          BEQ BOX_30
          LDX #6
          ASL A
          BEQ BOX_24
BOX_36    BCC BOX_38
          INC XPOS,X
          BNE BOX_38
          INC XPOS+1,X
BOX_38    ASL A
          DEX
          DEX
          BPL BOX_36
          BMI BOX_18

; ***************
  BOX_SUB ; $6389
; ***************

          LDY #XRADIUS-XPOS   ; $23
          JSR Sin_Cos_Ang
          LDX #XCIRCL-XPOS    ; $1f
          LDY #ANGBEG-XPOS    ; $2b
BOSU_10   TYA
          PHA
          JSR LAY_ABS_DIFF
          STA XDEST,X
          STA XABS,X
          STA FCT,X
          TYA
          STA XDEST+1,X
          STA XABS+1,X
          STA FCT+1,X
          PLA
          TAY
          JSR LAY_Y_ADD_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
          LDY #ANGEND-XPOS    ; $2d
          INX
          INX
          CPX #YCIRCL-XPOS    ; $21
          BEQ BOSU_10
          LDA #$90
          JSR ANG_DIST
          LDA ANGSGN
          AND #%00000011     ; $03
          STA ANGSGN
          TAX
          LDA BoxTab,X
          JSR BOX_PAINT
          JSR XY_DEST_To_POS
          LDA ANGCNT
          JSR BOX_PAINT
          LDX ANGSGN
          LDA BoxTab,X
          AND #%11110000     ; $f0
          STA ANGCNT+1
          LDA AngTab,X
          STA ANGCNT
          RTS

BoxTab    .BYTE $be,$e4,$41,$1b
AngTab    .BYTE $41,$1b,$be,$e4

;           Credits

          .TEXT "FRED B\r"    ; Fred Bowen
          .TEXT "TERRY R\r"   ; Terry Ryan
          .TEXT "MIKE I\r"    ; Mike Isgur

; *****************
  BOX_PAINT ; $640b
; *****************

          JSR anglpt
          LDX #4
BOPA_10   LDA XPOS+1,X
          ASL A
          ROR XPOS+1,X
          ROR XPOS,X
          BCC BOPA_20
          INC XPOS,X
          BNE BOPA_20
          INC XPOS+1,X
BOPA_20   INX
          INX
          CPX #6
          BEQ BOPA_10
          RTS

; ********************
  BASIC_SSHAPE ; $642b
; ********************

          JSR Assert_Graphics_Mem
          JSR Parse_Name
          STA MMU_LCRC
          STA ANGEND+1
          STY XRCOS
          BIT VALTYP
          BMI SSHA_02
          JMP TYPE_MISMATCH
SSHA_02   LDX #$28
          JSR Get_Comma_And_Coordinates
          LDX #4
          JSR Get_Graphics_XY
          LDX #$2a
          LDY #6
          LDA #2
          STA VTEMPA
SSHA_04   JSR LAY_ABS_DIFF
          TAX
          TYA
          PHA
          LDY VTEMPA
          JSR DEST_To_POS
          BCC SSHA_06
          LDA ROTANG+1,Y
          STA XPOS,Y
          LDA YDIST2,Y
          STA XPOS+1,Y
SSHA_06   TXA
          STA ROTANG+1,Y
          STA SAVSIZ,Y
          PLA
          STA YDIST2,Y
          STA SAVSIZ+1,Y
          LDX #$28
          LDY #4
          DEC VTEMPA
          DEC VTEMPA
          BEQ SSHA_04
          LDY #$ff
          STY XRADIUS+1
          LDA XPOS
          STA ANGBEG+1
          LDA XPOS+1
          STA ANGEND
          TYA
          JSR Allocate_String_A
          STA MMU_LCRC
SSHA_08   JSR getpos
          LDA (GRAPNT),Y
          BCC SSHA_12
          LDA XPOS
          BIT GRAPHM
          BPL SSHA_10
          SEC
          ROL A
SSHA_10   AND #%00000111 ; $07
          TAX
          LDA #0
SSHA_12   BIT GRAPHM
          BPL SSHA_14
          DEX
SSHA_14   STX XRCOS+1
SSHA_16   ASL A
          DEX
          BPL SSHA_16
          ROR A
          STA VTEMPA
          LDA #8
          BIT GRAPHM
          BPL SSHA_18
          LSR A
SSHA_18   CLC
          ADC XPOS
          STA XPOS
          BCC SSHA_20
          INC XPOS+1
SSHA_20   JSR getpos
          LDA #0
          BCS SSHA_22
          LDA (GRAPNT),Y
SSHA_22   STA VTEMPA+1
          LDX XRCOS+1
SSHA_24   LSR A
          INX
          CPX #8
          BNE SSHA_24
          ORA VTEMPA
          INC XRADIUS+1
          LDY XRADIUS+1
          CPY #$fc
          BCC SSHA_26
          JMP String_Too_Long
SSHA_26      STA MMU_LCRD
          STA (FAC1_M1),Y
          STA MMU_LCRC
          LDX XRCOS+1
          LDA ROTANG+1
          SEC
          BIT GRAPHM
          BPL SSHA_28
          SBC #4
          .BYTE $2C ;BIT
SSHA_28   SBC #8
          STA ROTANG+1
          LDA VTEMPA+1
          BCS SSHA_16
          DEC YDIST2
          BPL SSHA_16
          LDX YDIST2+1
          BNE SSHA_34
          DEC ANGBEG
          BPL SSHA_34
          BIT GRAPHM
          BPL SSHA_30
          ASL SAVSIZ
          ROL SAVSIZ+1
SSHA_30   LDX #0
SSHA_32   LDA SAVSIZ,X
          INY
          STA MMU_LCRD
          STA (FAC1_M1),Y
          STA MMU_LCRC
          INX
          CPX #4
          BNE SSHA_32
          INY
          STY SAVSIZ
          LDA FAC1_M1
          STA SAVSIZ+1
          LDA FAC1_M2
          STA SAVSIZ+2
          LDA #$db
          STA FAC1_M3
          LDA #3
          STA FAC1_M4
          LDA ANGEND+1
          STA FORPNT
          LDA XRCOS
          STA FORPNT+1
          JSR Assing_String_From_Variable
          JMP XY_DEST_To_POS
SSHA_34   DEC YDIST2+1
          INC YPOS
          BNE SSHA_36
          INC YPOS+1
SSHA_36   LDA ANGBEG+1
          STA XPOS
          LDA ANGEND
          STA XPOS+1
          LDA SAVSIZ
          STA ROTANG+1
          LDA SAVSIZ+1
          STA YDIST2
          JMP SSHA_08

; ********************
  BASIC_GSHAPE ; $658d
; ********************

          JSR Assert_Graphics_Mem
          JSR Eval_String
          STA MMU_LCRC
          STA YCIRCL+1
          STX INDEXB
          STY INDEXB+1
          LDX #4
          JSR Get_Graphics_XY
          JSR Get_Byte_Or_Zero
          CPX #5
          BCC GSHA_02
          JMP Error_Illegal_Quantity
GSHA_02   STX XRADIUS
          LDX #3
          LDY YCIRCL+1
          CPY #5
          BCS GSHA_04
          RTS
GSHA_04   DEY
          LDA #$26 ; '&'
          JSR Fetch_1
          STA MMU_LCRC
          STA ROTANG+1,X
          DEX
          BPL GSHA_04
          STX XRADIUS+1
          JSR XY_DEST_To_POS
          LDA ROTANG+1
          STA ANGBEG+1
          LDA YDIST2
          STA ANGEND
GSHA_06   LDA #8
          STA BITCNT
          INC XRADIUS+1
          LDY XRADIUS+1
          LDA #$26 ; '&'
          JSR Fetch_1
          STA MMU_LCRC
          STA YRADIUS+1
GSHA_08   JSR Get_Pixel
          STA YRADIUS
          ASL YRADIUS+1
          ROL A
          DEC BITCNT
          BIT GRAPHM
          BPL GSHA_10
          ASL YRADIUS+1
          ROL A
          DEC BITCNT
GSHA_10   LDX XRADIUS
          CPX #3
          BCC GSHA_14
          BEQ GSHA_12
          EOR YRADIUS
          BCS GSHA_18
GSHA_12   AND YRADIUS
          BCS GSHA_18
GSHA_14   CPX #1
          BCC GSHA_18
          BEQ GSHA_16
          ORA YRADIUS
          .BYTE $2C ;BIT
GSHA_16   EOR #%11111111 ; $ff
GSHA_18   AND #%00000011 ; $03
          BIT GRAPHM
          BMI GSHA_20
          AND #%00000001 ; $01
GSHA_20   STA COLSEL
          JSR Set_Pixel
          INC XPOS
          BNE GSHA_22
          INC XPOS+1
GSHA_22   SEC
          LDA ANGBEG+1
          BIT GRAPHM
          BPL GSHA_24
          SBC #2
          .BYTE $2C ;BIT
GSHA_24   SBC #1
          STA ANGBEG+1
          LDA ANGEND
          SBC #0
          STA ANGEND
          BCS GSHA_30
          LDX #1
GSHA_26   LDA ROTANG+1,X
          STA ANGBEG+1,X
          LDA XDEST,X
          STA XPOS,X
          DEX
          BPL GSHA_26
          INC YPOS
          BNE GSHA_28
          INC YPOS+1
GSHA_28   SEC
          LDA YDIST2+1
          SBC #1
          STA YDIST2+1
          LDA ANGBEG
          SBC #0
          STA ANGBEG
          BCS GSHA_32
          RTS
GSHA_30   LDA BITCNT
          BEQ GSHA_32
          JMP GSHA_08
GSHA_32   JMP GSHA_06

; ********************
  BASIC_CIRCLE ; $668e
; ********************

          JSR Assert_Color_Source
          LDX #$1f
          JSR Get_Graphics_XY
          JSR Get_Comma_And_Integer
          STY XRADIUS
          STA XRADIUS+1
          JSR Get_Comma_And_Integer
          STY YRADIUS
          BCS CIRC_10
          LDA XRADIUS
          STA YRADIUS
          LDA XRADIUS+1
          BIT GRAPHM
          BPL CIRC_10
          ASL YRADIUS
          ROL A
CIRC_10   STA YRADIUS+1
          LDX #$23 ; '#'
          JSR Scale_XY
          NOP
          NOP
          NOP
          NOP
          NOP
          JSR Get_Comma_And_Integer
          STY ANGBEG
          STA ANGBEG+1
          JSR Get_Comma_And_Integer
          STY ANGEND
          STA ANGEND+1
          JSR Get_Comma_And_Integer
          STA TEMP_A
          TYA
          LDY TEMP_A
          JSR Sin_Cos_AY
          LDX #$2d ; '-'
          LDY #$2b ; '+'
          JSR LAY_Y_SUB_X
          BCC CIRC_20
          LDA #$68
          LDY #1
          JSR LAY_ADD_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
CIRC_20   LDX #3
CIRC_30   LDA XRADIUS,X
          STA ROTANG,X
          DEX
          BPL CIRC_30
          LDA #$90
          JSR ANG_DIST
          LDX #7
CIRC_40   LDA XRADIUS,X
          STA XRCOS,X
          DEX
          BPL CIRC_40
          JSR CIRC_SUB
          JSR XY_DEST_To_POS
          LDX #2
          JSR Get_Byte_Or_Void
          TXA
          BNE CIRC_50
          JMP Error_Illegal_Quantity
CIRC_50   STX ARC_SEG
          CLC
CIRC_60   LDA ARC_SEG
          ADC ANGBEG
          STA ANGBEG
          BCC CIRC_70
          INC ANGBEG+1
CIRC_70   LDX #$2d ; '-'
          LDY #$2b ; '+'
          JSR LAY_Y_SUB_X
          BCS CIRC_80
          JSR CIRC_SUB
          JSR Draw_Line
          BCC CIRC_60
CIRC_80   LDY #$2d ; '-'
          JSR CIRC_SUB_Y
          JMP Draw_Line

; ****************
  CIRC_SUB ; $6750
; ****************

          LDY #ANGBEG-XPOS    ; $2b

; ******************
  CIRC_SUB_Y ; $6752
; ******************

          JSR Sin_Cos_Ang
          LDX #7
CISU_10   LDA XRCOS,X
          STA XRADIUS,X
          DEX
          BPL CISU_10
          LDA #$50
          JSR ANG_DIST
          LDA #16

; **************
  anglpt ; $6767
; **************

          STA ANGCNT
          LDY #$1f
          LDX #$23 ; '#'
anglpt_1  ASL ANGCNT+1
          ROL ANGCNT
          JSR LAY_SUB_ADD
          INX
          INX
          ASL ANGCNT+1
          ROL ANGCNT
          JSR LAY_ADD_SUB
          PHA
          TYA
          PHA
          LDY #$21 ; '!'
          INX
          INX
          CPX #$27 ; '''
          BEQ anglpt_1
          LDX #3
anglpt_2  PLA
          STA XDEST,X
          DEX
          BPL anglpt_2
          RTS

; ******************
  BASIC_DRAW ; $6797
; ******************

          JSR Assert_Graphics_Mem
          LDX #1              ; default = foreground color
          STX COLSEL
          JSR CHRGOT
          CMP #$a4            ; TO token
          BEQ DRAW_10
          JSR Get_Color_Source
          JSR CHRGOT
          BNE DRAW_10
          JMP Double_Pixel
DRAW_10   JSR CHRGOT
          CMP #','
          BEQ DRAW_20
          CMP #$a4            ; TO token
          BEQ DRAW_20
          RTS
DRAW_20   PHA
          JSR CHRGET
          LDX #4
          JSR Get_Coordinates
          PLA
          BPL DRAW_30
          JSR Draw_Line
          JMP DRAW_10
DRAW_30   JSR XY_DEST_To_POS
          JSR Double_Pixel
          JMP DRAW_10

; ******************
  BASIC_CHAR ; $67d7
; ******************

          JSR Get_Color_Source
          LDX #$29 ; ')'
          LDY #$1a
          LDA GRAPHM
          BNE CHAR_10
          JSR K_SCRORG
          INX
          INY
CHAR_10   STX ANGEND
          STY ANGEND+1
          JSR Comma_And_Byte
          CPX ANGEND
          BCS CHAR_15
          STX ANGEND
          JSR Comma_And_Byte
          CPX ANGEND+1
          BCC CHAR_20
CHAR_15   JMP Error_Illegal_Quantity
CHAR_20   STX ANGEND+1
          JSR CHRGOT
          BNE CHAR_25
          LDA #0
          BEQ CHAR_30
CHAR_25   JSR Need_Comma
          JSR Eval_String
CHAR_30   STA MMU_LCRC
          STA NUMCNT
          TYA
          PHA
          TXA
          PHA
          JSR Get_Byte_Or_Zero
          TXA
          ROR A
          ROR XSGN
          PLA
          STA INDEXA
          PLA
          STA INDEXA+1
          LDA GRAPHM
          BNE CHAR_50
          LDX ANGEND+1
          LDY ANGEND
          CLC
          JSR J_PLOT
          LDY #0
          BIT XSGN
          BPL CHAR_35
          LDA #$12
          JSR J_PRINT
CHAR_35   CPY NUMCNT
          BEQ CHAR_40
          JSR Get_INDEXA_1
          JSR Map_IO
          JSR E_PRINT
          INY
          BNE CHAR_35
CHAR_40   BIT XSGN
          BPL CHAR_45
          LDA #$92
          JSR J_PRINT
CHAR_45   RTS
CHAR_50   JSR Assert_Graphics_Mem
          LDA CHARGEN_GRAF
          STA CHRPAG
          LDA FG_COL
          TAX
          PHA
          LDA COLSEL
          PHA
          BIT GRAPHM
          BPL CHAR_55
          PLA
          BEQ CHAR_60
          LSR A
          BEQ CHAR_60
          LDX MULCO1
          BCC CHAR_60
          LDX MULCO2
          BCS CHAR_60
CHAR_55   LDX FG_COL
          PLA
          BNE CHAR_60
          JSR Map_IO
          LDX VIC_BG_COL
CHAR_60   STX FG_COL
          LDX ANGEND+1
          LDY #0
          STY XRCOS
CHAR_65   LDY XRCOS
          INC XRCOS
          JSR Get_INDEXA_1
          STA MMU_LCRC
          DEC NUMCNT
          BMI CHAR_90
          CMP #14
          BNE CHAR_70
          LDA CHARGEN_TEXT
          BNE CHAR_75
CHAR_70   CMP #$8e
          BNE CHAR_80
          LDA CHARGEN_GRAF
CHAR_75   STA CHRPAG
          BNE CHAR_85
CHAR_80   LDY ANGEND
          JSR Display_Character
          INC ANGEND
CHAR_85   CPY #$27 ; '''
          BCC CHAR_65
          LDY #0
          STY ANGEND
          INX
          CPX #$18
          BCC CHAR_65
CHAR_90   PLA
          STA FG_COL
          RTS

; *************************
  Display_Character ; $68db
; *************************

          PHA
          JSR Color_Character
          TYA
          CLC
          ADC E_40_Line_Lo,X
          STA GRAPNT
          LDA E_40_Line_Hi,X
          ADC #0
          ASL GRAPNT
          ROL A
          ASL GRAPNT
          ROL A
          ASL GRAPNT
          ROL A
          STA GRAPNT+1
          STA MMU_LCRC
          LDA #0
          STA TEMP_A
          PLA
          PHA
          ASL A
          ROL TEMP_A
          ASL A
          ASL A
          ROL TEMP_A
          STA INDEXB
          LDA TEMP_A
          ADC CHRPAG
          STA INDEXB+1
          TYA
          PHA
          LDY #7
DiCh_10   LDA XSGN
          ASL A
          LDA (INDEXB),Y
          BCC DiCh_20
          EOR #%11111111 ; $ff
DiCh_20   BIT GRAPHM
          BPL DiCh_70
          AND #%10101010 ; $aa
          STA TEMP_A
          LDA COLSEL
          BNE DiCh_40
          LDA TEMP_A
          BCS DiCh_30
          LSR A
          EOR TEMP_A
          EOR #%10101010 ; $aa
          BNE DiCh_70
DiCh_30   ORA #%01010101 ; $55 ; 'U'
          BNE DiCh_70
DiCh_40   CMP #2
          BNE DiCh_50
          LDA TEMP_A
          BCS DiCh_70
DiCh_50   BCC DiCh_60
          LDA TEMP_A
          LSR A
          EOR TEMP_A
          BCC DiCh_70
DiCh_60   LDA TEMP_A
          LSR A
DiCh_70   STA (GRAPNT),Y
          DEY
          BPL DiCh_10
          PLA
          TAY
          PLA
          RTS

; ********************
  BASIC_LOCATE ; $6955
; ********************

          JSR Assert_Graphics_Mem
          LDX #4
          JSR Get_Coordinates
          JMP XY_DEST_To_POS

; *******************
  BASIC_SCALE ; $6960
; *******************

          JSR Get_Byte_Var
          CPX #2
          BCC SCAL_10
          JMP Error_Illegal_Quantity
SCAL_10   STX SCALEM
          JSR CHRGOT
          BNE SCAL_30
          LDX #0
          LDA #$50 ; 'P'
          LDY #$32 ; '2'
          BIT GRAPHM
          BPL SCAL_20
          LSR A
SCAL_20   STX SCALE_X
          STA SCALE_X+1
          STX SCALE_Y
          STY SCALE_Y+1
          RTS
SCAL_30   JSR Get_Scale
          LDA #<SC_320
          LDY #>SC_320
          JSR Load_FAC2_From_AY_ROM
          JSR OP_DIV
          JSR FAC1_To_LINNUM
          CMP #0
          BNE SCAL_40
          CPY #0
          BEQ GeSc_Err
SCAL_40   PHA
          TYA
          PHA
          JSR Get_Scale
          LDA #<SC_200
          LDY #>SC_200
          JSR Load_FAC2_From_AY_ROM
          JSR OP_DIV
          JSR FAC1_To_LINNUM
          CMP #0
          BNE SCAL_50
          CPY #0
          BEQ GeSc_Err
SCAL_50   STY SCALE_Y
          STA SCALE_Y+1
          PLA
          STA SCALE_X
          PLA
          STA SCALE_X+1
          RTS

; *****************
  Get_Scale ; $69c4
; *****************

          JSR Need_Comma
          JSR Eval_Numeric
          LDA FAC1_SI
          BMI GeSc_Err
          LDA FAC1_EX
          CMP #$90
          BCS GeSc_Err
          RTS
GeSc_Err  JMP Error_Illegal_Quantity

SC_320    .BYTE $99,$1f,$ff,$60,$00 ;.REAL $991fff6000 ; 20971200 = 320 * 65535
SC_200    .BYTE $98,$47,$ff,$38,$00 ;.REAL $9847ff3800 ; 13107000 = 200 * 65535

; *******************
  BASIC_COLOR ; $69e2
; *******************

          JSR Get_Byte_Var
          CPX #7
          BCS COLO_90
          STX TEMP_A
          JSR Comma_And_Byte
          DEX
          CPX #16
          BCS COLO_90
          JSR Map_IO
          TXA
          LDX TEMP_A
          CPX #1
          BEQ COLO_10
          BCS COLO_20
          STA VIC_BG_COL
          BNE COLO_80
COLO_10   STA FG_COL
          BEQ COLO_80
COLO_20   CPX #3
          BEQ COLO_30
          BCS COLO_40
          STA MULCO1
          BNE COLO_80
COLO_30   STA MULCO2
          BEQ COLO_80
COLO_40   CPX #5
          BEQ COLO_50
          BCS COLO_70
          STA Vd020
          BNE COLO_80
COLO_50   BIT MODE_80
          BPL COLO_60
          TAX
          LDA E_Attribute
          AND #%11110000 ; $f0
          ORA VDC_Color,X
COLO_60   STA E_Attribute
          JMP COLO_80
COLO_70   TAX
          LDA #$1a
          STA VDC_Register
          LDA VDC_Data
          AND #%11110000 ; $f0
          ORA VDC_Color,X
          STA VDC_Data
COLO_80   JSR setpcl
          JMP Get_Byte_Or_Void
COLO_90   JMP Error_Illegal_Quantity

VDC_Color .BYTE $00,$0f,$08,$07,$0b,$04,$02,$0d
          .BYTE $0a,$0c,$09,$06,$01,$05,$03,$0e

; **************
  setpcl ; $6a5c
; **************

          LDA FG_COL
          ASL A
          ASL A
          ASL A
          ASL A
          STA TEMP_A
          JSR Map_IO
          LDA VIC_BG_COL
          AND #%00001111 ; $0f
          ORA TEMP_A
          STA FG_BG
          LDA MULCO1
          ORA TEMP_A
          STA FG_MC1
          RTS

; ********************
  BASIC_SCNCLR ; $6a79
; ********************

          BNE SCLR_20
          JSR Get_Graphics_Mode
          CMP #5
          BCC SCLR_10
          SBC #5
          BEQ Clear_80_Column_Screen
          PHA
          JSR Clear_80_Column_Screen
          PLA
SCLR_10   TAX
          JMP SCLR_40
SCLR_20   JSR Get_Byte_Var
SCLR_30   CPX #5
          BEQ Clear_80_Column_Screen
          BCC SCLR_40
          JMP Error_Illegal_Quantity
SCLR_40   TXA
          BEQ Clear_40_Column_Screen
          JSR Assert_Graphics_Mem
          TXA
          PHA
          AND #%00000001 ; $01
          BNE SCLR_60
          JSR Clear_40_Column_Screen
          LDA MODE_80
          PHA
          BPL SCLR_50
          JSR K_SWAPPER
SCLR_50   LDA VSH_SPLIT
          SEC
          SBC #$30 ; '0'
          LSR A
          LSR A
          LSR A
          TAX
          LDY #0
          CLC
          JSR B_PLOT
          PLA
          BPL SCLR_60
          JSR K_SWAPPER
SCLR_60   PLA
          AND #%00000010 ; $02
          BEQ SCLR_70
          JSR Clear_Color_RAM
SCLR_70   JSR Clear_Graphics_RAM
          LDA #0
          LDX #3
SCLR_80   STA XPOS,X
          DEX
          BPL SCLR_80
          RTS

; ******************************
  Clear_80_Column_Screen ; $6ade
; ******************************

          LDA MODE_80
          PHA
          BMI CLR80_10
          JSR K_SWAPPER
CLR80_10  LDA #$93            ; clear window
          JSR B_BSOUT
          PLA
          BMI CLR80_20
          JSR K_SWAPPER
CLR80_20  RTS

; ******************************
  Clear_40_Column_Screen ; $6af2
; ******************************

          LDA MODE_80
          PHA
          BPL CLR40_10
          JSR K_SWAPPER
CLR40_10  LDA #$93
          JSR B_BSOUT
          PLA
          BPL CLR40_20
          JSR K_SWAPPER
CLR40_20  RTS

; ********************
  Fill_X_Pages ; $6b06
; ********************

          STY GRAPNT+1
          LDY #0
          STY GRAPNT
FXP_10    STA (GRAPNT),Y
          DEY
          BNE FXP_10
          INC GRAPNT+1
          DEX
          BNE FXP_10
          RTS

; ***********************
  Clear_Color_RAM ; $6b17
; ***********************

          JSR Map_IO
          SEI
          LDA R8502
          PHA
          AND #%11111110     ; $fe
          STA R8502           ; access color RAM
          LDA MULCO2          ; fill color
          LDY #>VIC_COLOR_RAM ; $d800
          LDX #4              ; 4 pages
          JSR Fill_X_Pages
          PLA
          STA R8502
          CLI
          RTS

; **************************
  Clear_Graphics_RAM ; $6b30
; **************************

          LDA #0              ; write zeroes
          LDY #>GRAFX_RAM     ; fill $2000 - $3fff
          LDX #$20            ; #$20 pages
          JSR Fill_X_Pages
          LDA FG_BG           ; foreground / background
          BIT GRAPHM
          BPL CGR_10
          LDA FG_MC1          ; foreground mulricolor 1
CGR_10    JSR Map_IO
          LDY #>COLOR_RAM     ; fill $1c00 - $1fff
          LDX #4              ; 4 pages
          JSR Fill_X_Pages

; Initialize sprite pointer

; sprite 0 : $1ff8 : pointer = $38 ($38 * $40) = $0e00
; sprite 1 : $1ff9 : pointer = $39 ($39 * $40) = $0e40
; sprite 7 : $1fff : pointer = $3f ($3f * $40) = $0fc0

          LDX #$3f            ; $0fc0 / $40
          LDY #7
CGR_20    TXA
          STA GRAFX_RAM-8,Y   ; init sprite pointer
          DEX
          DEY
          BPL CGR_20
          RTS

; *********************
  BASIC_GRAPHIC ; $6b5a
; *********************

          CMP #$9c
          BNE GRAP_10
          JSR Free_Graphics_RAM
          JSR CHRGET
          LDA #0
          STA GRAPHM
          RTS
GRAP_10   JSR Get_Byte_Var
          TXA
          PHA
          CPX #5
          BEQ GRAP_60
          BCS GRAP_70
          LDA Graphic_Modes,X
          STA GRAPHM
          BEQ GRAP_20
          JSR Allocate_Graphics_RAM
          BIT GRAPHM
          BVC GRAP_40
GRAP_20   BIT MODE_80
          BPL GRAP_40
GRAP_30   JSR K_SWAPPER
GRAP_40   JSR Get_Byte_Or_Zero
          CPX #2
          BCS GRAP_70
          TXA
          PHA
          LDX #$14
          JSR Get_Byte_Or_Void
          CPX #$1a
          BCS GRAP_70
          TXA
          ASL A
          ASL A
          ASL A
          ADC #$30 ; '0'
          STA VSH_SPLIT
          PLA
          TAY
          PLA
          TAX
          TYA
          BEQ GRAP_50
          JSR SCLR_30
GRAP_50   LDA #0
          STA SCALEM
          RTS
GRAP_60   BIT MODE_80
          BMI GRAP_40
          LDA GRAPHM
          AND #%10111111 ; $bf
          STA GRAPHM
          JMP GRAP_30
GRAP_70   JMP Error_Illegal_Quantity

; *********************
  Graphic_Modes ; $6bc4
; *********************

          .BYTE $00           ; Text
          .BYTE $20           ; High Resolution
          .BYTE $60           ; High Resolution - Split
          .BYTE $a0           ; Multicolor
          .BYTE $e0           ; Multicolor - Split

; ******************
  BASIC_BANK ; $6bc9
; ******************

          JSR Get_Byte_Var
          CPX #16
          BCS BANK_Err
          STX USER_BANK
          RTS
BANK_Err  JMP Error_Illegal_Quantity

; *******************
  BASIC_SLEEP ; $6bd7
; *******************

          JSR Get_Integer
          LDX #0
          SEI
          STY JIFFY_COUNTDOWN
          STA JIFFY_COUNTDOWN+1
          STX JIFFY_COUNTDOWN+2
          JSR ASL_TIMER
          JSR ADD_TIMER
          JSR TIMER_X4
          LDY JIFFY_COUNTDOWN
          LDA JIFFY_COUNTDOWN+1
          LDX JIFFY_COUNTDOWN+2
          JSR TIMER_X4
          JSR ADD_TIMER
          CLI
SLEEP_10  JSR Is_STOP_Key
          LDX JIFFY_COUNTDOWN+2
          INX
          BNE SLEEP_10
          RTS

; ****************
  TIMER_X4 ; $6c09
; ****************

          JSR ASL_TIMER

; *****************
  ASL_TIMER ; $6c0c
; *****************

          ASL JIFFY_COUNTDOWN
          ROL JIFFY_COUNTDOWN+1
          ROL JIFFY_COUNTDOWN+2
          RTS

; *****************
  ADD_TIMER ; $6c16
; *****************

          PHA
          TYA
          ADC JIFFY_COUNTDOWN
          STA JIFFY_COUNTDOWN
          PLA
          ADC JIFFY_COUNTDOWN+1
          STA JIFFY_COUNTDOWN+1
          TXA
          ADC JIFFY_COUNTDOWN+2
          STA JIFFY_COUNTDOWN+2
          RTS

; ******************
  BASIC_WAIT ; $6c2d
; ******************

          JSR LINNUM_Comma_Byte
          STX FORPNT
          LDX #0
          JSR CHRGOT
          BEQ WAIT_10
          JSR Comma_And_Byte
WAIT_10   STX FORPNT+1
WAIT_20   LDY #0
          LDX USER_BANK
          LDA #$16
          JSR K_INDFET
          EOR FORPNT+1
          AND FORPNT
          BEQ WAIT_20
          RTS

; ********************
  BASIC_SPRITE ; $6c4f
; ********************

          JSR Get_Sprite_Number
          JSR Get_Byte_Or_Void
          BCC SPRI_10
          LDY #$15
          JSR Switch_Sprite
SPRI_10   JSR Get_Byte_Or_Void
          BCC SPRI_20
          DEX
          CPX #16
          BCS SPRI_Err
          TXA
          LDX TEMP_A
          JSR Map_IO
          STA Vd027,X
SPRI_20   JSR Get_Byte_Or_Void
          BCC SPRI_30
          LDY #$1b
          JSR Switch_Sprite
SPRI_30   JSR Get_Byte_Or_Void
          BCC SPRI_40
          LDY #$1d
          JSR Switch_Sprite
SPRI_40   JSR Get_Byte_Or_Void
          BCC SPRI_50
          LDY #$17
          JSR Switch_Sprite
SPRI_50   JSR Get_Byte_Or_Void
          BCC SPRI_Ret
          LDY #$1c
          JSR Switch_Sprite
SPRI_Ret  RTS
SPRI_Err  JMP Error_Illegal_Quantity

; *********************
  Switch_Sprite ; $6c9b
; *********************

          TXA
          LSR A               ; C=1 ON , C=0 OFF
          BNE SPRI_Err
          LDX TEMP_A
          LDA Bit_Mask,X
          JSR Map_IO
          ORA VIC,Y
          BCS SwSp_10
          EOR Bit_Mask,X
SwSp_10   STA VIC,Y
          RTS

Bit_Mask  .BYTE $01,$02,$04,$08,$10,$20,$40,$80

; *************************
  Get_Sprite_Number ; $6cbb
; *************************

          JSR Get_Byte_Var
          DEX
          CPX #8
          BCS SPRI_Err
          STX TEMP_A
          RTS

; ********************
  BASIC_MOVSPR ; $6cc6
; ********************

          JSR Get_Sprite_Number
          JSR Get_Sprite_Coordinates
          BIT NUMCNT
          BVC MOVS_10
          JMP SYNTAX_ERROR
MOVS_10   STY XDEST
          STY YDEST
          STA XDEST+1
          STA YDEST+1
          JSR Get_Sprite_Coordinates
          BIT NUMCNT
          BVC MOVS_40
          BMI MOVS_30
          TYA
          PHA
          LDY #4
          JSR Sin_Cos_Ang
          LDX TEMP_A
          LDY Sprite_Offset,X
          LDA #0
          STA SPRITE_DATA,Y
          INY
          LDX #3
MOVS_15   LSR SINVAL,X
          DEX
          ROR SINVAL,X
          DEX
          BPL MOVS_15
MOVS_20   INX
          LDA ANGSGN,X
          INY
          STA SPRITE_DATA,Y
          CPX #4
          BNE MOVS_20
          LDA #0
MOVS_25   INY
          STA SPRITE_DATA,Y
          DEX
          BNE MOVS_25
          PLA
          AND #%00001111 ; $0f
          STA T3,Y
          RTS
MOVS_30   JSR Swap_XY
          TAY
          TXA
          JSR Sin_Cos_AY
          LDX #4
          JSR Scale_XY
          LDX #4
          CLC
MOVS_35   JSR LAY_SIN_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
          INX
          INX
          CPX #6
          BEQ MOVS_35
          ROR NUMCNT
          BMI MOVS_45
MOVS_40   STY YDEST
          STA YDEST+1
          LDX #4
          JSR Scale_XY
MOVS_45   LDA TEMP_A
          TAX
          ASL A
          TAY
          LDA YDEST
          ASL NUMCNT
          BCC MOVS_55
          CLC
          BPL MOVS_50
          EOR #%11111111 ; $ff
          SEC
MOVS_50   ADC VSH+1,Y
MOVS_55   SEI
          STA VSH+1,Y
          LDA XDEST
          ASL NUMCNT
          BPL MOVS_65
          CLC
          ADC VSH,Y
          STA VSH,Y
          BCS MOVS_60
          INC XDEST+1
MOVS_60   LDA VSH+16
          JMP MOVS_70
MOVS_65   STA VSH,Y
          LDA VSH+16
          ORA Bit_Mask,X
MOVS_70   LSR XDEST+1
          BCS MOVS_75
          EOR Bit_Mask,X
MOVS_75   STA VSH+16
          CLI
          RTS

; ******************************
  Get_Sprite_Coordinates ; $6d9e
; ******************************

          JSR Comma_Check
          ROR NUMCNT
          BPL GSC_10
          CMP #';'
          BEQ GSC_30
          CMP #'#'
          BEQ GSC_20
          JMP SYNTAX_ERROR
GSC_10    JSR CHRGOT
          CMP #$aa            ; +
          BEQ GSC_30
          CMP #$ab            ; -
          BEQ GSC_30
GSC_20    CLC
GSC_30    ROR NUMCNT
GSC_40    JSR Eval_Numeric    ; Call entry
          JMP F1TL_10

; *******************
  Comma_Check ; $6dc6
; *******************

          JSR CHRGOT
          BEQ CoCh_20
          CMP #','
          CLC
          BEQ CoCh_10
          SEC
CoCh_10   PHP
          PHA
          JSR CHRGET
          PLA
          PLP
CoCh_20   RTS

; *********************
  Sprite_Offset ; $6dd9
; *********************

; offset = sprite number * 11

          .BYTE $00,$0b,$16,$21,$2c,$37,$42,$4d

; ******************
  BASIC_PLAY ; $6de1
; ******************

          JSR Eval_String
          STA MMU_LCRC
          STA TEMP_A
          JSR Clear_Tone_Flags
          STA KEYSIZ
PLAY_10   LDY KEYSIZ
          CPY TEMP_A
          BEQ PLAY_Ret
          JSR Get_INDEXA_1
          STA MMU_LCRC
          JSR Play_Note
          INC KEYSIZ
          BNE PLAY_10
PLAY_Ret  RTS

; *****************
  Play_Note ; $6e02
; *****************

          CMP #' '
          BNE PlNo_10
          RTS
PlNo_10   CMP #'A'
          BCC PlNo_15
          CMP #'H'
          BCS PlNo_15
          JMP Set_Note
PlNo_15   LDX #4
PlNo_20   CMP notes,X
          BNE PlNo_25
          JMP Set_Duration
PlNo_25   DEX
          BPL PlNo_20
          CMP #'R'
          BNE PlNo_30
          JMP SeNo_75
PlNo_30   CMP #'.'
          BNE PlNo_35
          JMP Store_DNOTE
PlNo_35   LDX #5
PlNo_40   CMP mutabl,X
          BNE PlNo_45
          JMP SeNo_40
PlNo_45   DEX
          BPL PlNo_40
          CMP #'#'
          BNE PlNo_50
          JMP Play_Sharp
PlNo_50   CMP #'$'
          BNE PlNo_55
          JMP Play_Flatc
PlNo_55   SEC
          SBC #'0'
          CMP #10
          BCC PlNo_60
          JMP Error_Exit
PlNo_60   ASL FLAG
          BCS PlNo_85
          ASL FLAG
          BCS PlNo_90
          ASL FLAG
          BCS PlNo_95
          ASL FLAG
          BCC Set_Volume
          CMP #2
          BCC PlNo_65
          JMP Error_Exit
PlNo_65   LSR A
          LDY VOICE
          LDX times2,Y
PlNo_70   LDA Snd_Duration+1,X
          BPL PlNo_70
          LDA Bit_Mask,Y
          ORA FILTERS+2
          BCS PlNo_75
          EOR Bit_Mask,Y
PlNo_75   STA FILTERS+2
          LDA Old_Filter
          STA Old_Volume
          LDX #3
PlNo_80   LDA FILTERS,X
          JSR Map_IO
          STA SID_Cutoff,X
          DEX
          BPL PlNo_80
          BMI Clear_FLAG
PlNo_85   TAX
          DEX
          CPX #3
          BCS Error_Exit
          STX VOICE
          BCC Clear_FLAG
PlNo_90   CMP #7
          BCS Error_Exit
          STA Snd_Octave
          BCC Clear_FLAG
PlNo_95   TAX

; ********************
  Set_Envelope ; $6eb2
; ********************

          JSR Map_IO
          LDY VOICE
          LDA WAVTAB,X
          STA WAVE0,Y
          LDA offtab,Y
          TAY
          LDA ATKTAB,X
          STA SID_Attack_1,Y
          LDA SUSTAB,X
          STA SID_Sustain_1,Y
          LDA PULSLO,X
          STA SID_Pulse_1,Y
          LDA PULSHI,X
          STA SID_Pulse_1+1,Y
          JMP Clear_FLAG

; ******************
  Set_Volume ; $6edd
; ******************

          TAX
          LDA Old_Filter
          AND #%11110000 ; $f0
          ORA voltab,X
          STA Old_Filter
          LDA Old_Volume
          AND #%11110000 ; $f0
          ORA voltab,X
          JSR Map_IO
          STA SID_Volume

; ******************
  Clear_FLAG ; $6ef7
; ******************

          LDA #0
          STA FLAG
          RTS

; ******************
  Error_Exit ; $6efd
; ******************

          JSR Clear_FLAG
          JMP Error_Illegal_Quantity

; *******************
  Store_DNOTE ; $6f03
; *******************

          STA DNOTE
          RTS

; ********************
  Set_Duration ; $6f07
; ********************

          LDY #<$0480
          STY Snd_Dur_Tmp
          LDY #>$0480
          STY Snd_Dur_Tmp+1
SeDu_10   DEX
          BMI SeDu_Ret
          LSR Snd_Dur_Tmp+1
          ROR Snd_Dur_Tmp
          JMP SeDu_10
SeDu_Ret  RTS

; ****************
  Set_Note ; $6f1e
; ****************

          SEC
          SBC #'A'
          TAX
          LDA scalen,X
          TAX
          LDA #6
          SEC
          SBC Snd_Octave
          TAY
          TXA
          CLC
          ADC Snd_Sharp
          BPL SeNo_10
          LDA #11
          INY
SeNo_10   CMP #12
          BCC SeNo_20
          LDA #0
          DEY
SeNo_20   TAX
          LDA Pitch_NTSC_Low,X
          STA Snd_Pitch
          JSR Get_Pitch       ; patch for NTSC / PAL pitch
SeNo_30   DEY
          BMI SeNo_70
          LSR A
          ROR Snd_Pitch
          JMP SeNo_30
SeNo_40   CMP #$4d ; 'M'
          BEQ SeNo_50
          LDA rbits,X
          STA FLAG
          RTS
SeNo_50   LDY #5
SeNo_60   LDA Snd_Duration,Y
          BPL SeNo_60
          DEY
          DEY
          BPL SeNo_60
          RTS

; ******************
  Play_Sharp ; $6f69
; ******************

          LDA #1
          .BYTE $2C ;BIT

; ******************
  Play_Flatc ; $6f6c
; ******************

          LDA #$ff
          STA Snd_Sharp
          RTS

SeNo_70   STA Snd_Pitch+1
          LDA #0
          .BYTE $2C ;BIT
SeNo_75   LDA #$ff
          PHA
          LDX VOICE
          LDY times2,X
SeNo_80   LDA Snd_Duration+1,Y
          BPL SeNo_80
          LDA Snd_Dur_Tmp
          STA Snd_Duration,Y
          LDA Snd_Dur_Tmp+1
          STA Snd_Duration+1,Y
          LDA DNOTE
          BEQ SeNo_85
          LDA Snd_Dur_Tmp+1
          LSR A
          PHA
          LDA Snd_Dur_Tmp
          ROR A
          CLC
          ADC Snd_Duration,Y
          STA Snd_Duration,Y
          PLA
          ADC Snd_Duration+1,Y
          STA Snd_Duration+1,Y
SeNo_85   PLA
          BMI Clear_Tone_Flags
          JSR Map_IO
          LDY offtab,X
          LDA Snd_Pitch
          STA SID_Freq_1,Y
          LDA Snd_Pitch+1
          STA SID_Freq_1+1,Y
          LDA #8
          STA SID_Control_1,Y
          LDA WAVE0,X
          STA SID_Control_1,Y

; ************************
  Clear_Tone_Flags ; $6fce
; ************************

          LDA #0
          STA Snd_Sharp
          STA DNOTE
          RTS

; *******************
  BASIC_TEMPO ; $6fd7
; *******************

          JSR Get_Byte_Var
          TXA
          BEQ TEMPO_Err
          STX Snd_Tempo
          RTS
TEMPO_Err JMP Error_Illegal_Quantity

times2    .BYTE $00,$02,$04
notes     .TEXT "WHQIS"
mutabl    .TEXT "VOTXUM"
scalen    .BYTE $09,$0b,$00,$02,$04,$05,$07

Pitch_NTSC_Low
          .BYTE $0f,$0c,$45,$bf,$7d,$83,$d6,$79
          .BYTE $73,$c7,$7c,$97

Pitch_NTSC_High
          .BYTE $43,$47,$4b,$4f,$54,$59,$5e,$64
          .BYTE $6a,$70,$77,$7e

stkmus    .BYTE $09,$c0,$00,$05,$94,$09,$09,$09
          .BYTE $89,$09
susmus    .BYTE $00,$c0,$f0,$50,$40,$21,$00,$90
          .BYTE $41,$00
wavmus    .BYTE $41,$21,$11,$81,$11,$21,$41,$41
          .BYTE $41,$11
pwhmus    .BYTE $06,$00,$00,$00,$00,$00,$02,$08
          .BYTE $02,$00
offtab    .BYTE $00,$07,$0e
voltab    .BYTE $00,$01,$03,$05,$07,$08,$0a,$0c
          .BYTE $0e,$0f

; ********************
  BASIC_FILTER ; $7046
; ********************

          PHA
          LDY #3
FILT_10   LDA FILTERS,Y
          STA FLTSAV,Y
          DEY
          BPL FILT_10
          PLA
          CMP #','
          BEQ FILT_20
          JSR Get_Integer
          CMP #8
          BCS FILT_Err
          STY FLTSAV
          STY FLTSAV+1
          LSR A
          ROR FLTSAV+1
          LSR A
          ROR FLTSAV+1
          LSR A
          ROR FLTSAV+1
FILT_20   LDA #16
          STA FLTFLG
FILT_30   JSR Get_Byte_Or_Void
          BCC FILT_60
          CPX #1
          BCC FILT_40
          BEQ FILT_40
          JMP Error_Illegal_Quantity
FILT_40   LDA FLTSAV+3
          ORA FLTFLG
          BCS FILT_50
          EOR FLTFLG
FILT_50   STA FLTSAV+3
FILT_60   ASL FLTFLG
          BPL FILT_30
          JSR Get_Byte_Or_Void
          BCC FILT_70
          CPX #16
          BCS FILT_Err
          TXA
          ASL A
          ASL A
          ASL A
          ASL A
          STA NIBBLE
          LDA FLTSAV+2
          AND #%00001111 ; $0f
          ORA NIBBLE
          STA FLTSAV+2
FILT_70   LDY #3
FILT_80   LDA FLTSAV,Y
          STA FILTERS,Y
          DEY
          BPL FILT_80
          RTS
FILT_Err  JMP Error_Illegal_Quantity

; **********************
  BASIC_ENVELOPE ; $70c1
; **********************

          JSR Get_Byte_Var
          CPX #10
          BCC ENVE_20
ENVE_10   JMP Error_Illegal_Quantity
ENVE_20   STX TONNUM
          LDA ATKTAB,X
          STA TONVAL
          LDA SUSTAB,X
          STA TONVAL+1
          LDA WAVTAB,X
          STA TONVAL+2
          LDX #0
ENVE_30   STX PARCNT
          JSR Get_Byte_Or_Void
          BCC ENVE_40
          TXA
          ASL A
          ASL A
          ASL A
          ASL A
          STA NIBBLE
          LDX PARCNT
          LDA TONVAL,X
          AND #%00001111 ; $0f
          ORA NIBBLE
          STA TONVAL,X
ENVE_40   JSR Get_Byte_Or_Void
          BCC ENVE_50
          TXA
          AND #%00001111 ; $0f
          STA NIBBLE
          LDX PARCNT
          LDA TONVAL,X
          AND #%11110000 ; $f0
          ORA NIBBLE
          STA TONVAL,X
ENVE_50   LDX PARCNT
          INX
          CPX #1
          BEQ ENVE_30
          JSR Get_Byte_Or_Void
          BCC ENVE_70
          LDA #$15
          CPX #4
          BEQ ENVE_60
          BCS ENVE_10
          LDA Bit_Mask+4,X
          ORA #%00000001 ; $01
ENVE_60   STA TONVAL+2
ENVE_70   JSR Get_Comma_And_Integer
          BCC ENVE_80
          TAX
          LDA TONVAL+2
          AND #%01000000 ; $40 ; '@'
          BEQ ENVE_80
          TXA
          LDX TONNUM
          STA PULSHI,X
          TYA
          STA PULSLO,X
ENVE_80   LDX TONNUM
          LDA TONVAL
          STA ATKTAB,X
          LDA TONVAL+1
          STA SUSTAB,X
          LDA TONVAL+2
          STA WAVTAB,X
          RTS

; ***********************
  BASIC_COLLISION ; $7164
; ***********************

          JSR Get_Byte_Var
          DEX
          CPX #3
          BCS COLL_Err
          STX Collision_Type
          JSR Get_Comma_And_Integer
          PHP
          LDX Collision_Type
          STA INT_ADR_HI,X
          TYA
          STA INT_ADR_LO,X
          LDA INT_VAL
          ORA Bit_Mask,X
          PLP
          BCS COLL_10
          EOR Bit_Mask,X
COLL_10   STA INT_VAL
          RTS
COLL_Err  JMP Error_Illegal_Quantity

; **********************
  BASIC_SPRCOLOR ; $7190
; **********************

          CMP #$2c ; ','
          BEQ SPRC_10
          JSR Get_Byte_Var
          DEX
          CPX #16
          BCS SPRC_Err
          JSR Map_IO
          STX Vd025
SPRC_10   JSR Get_Byte_Or_Void
          BCC SPRC_Ret
          DEX
          CPX #16
          BCS SPRC_Err
          JSR Map_IO
          STX Vd026
SPRC_Ret  RTS
SPRC_Err  JMP Error_Illegal_Quantity

; *******************
  BASIC_WIDTH ; $71b6
; *******************

          JSR Get_Byte_Var
          DEX
          CPX #2
          BCS WIDT_Err
          STX WIDTH
          RTS
WIDT_Err  JMP Error_Illegal_Quantity

; *****************
  BASIC_VOL ; $71c5
; *****************

          JSR Get_Byte_Var
          CPX #16
          BCS VOL_Err
          STX TEMP_A
          LDA Old_Filter
          AND #%11110000 ; $f0
          ORA TEMP_A
          STA Old_Filter
          LDA Old_Volume
          AND #%11110000 ; $f0
          ORA TEMP_A
          STA Old_Volume
          JSR Map_IO
          STA SID_Volume
          RTS
VOL_Err   JMP Error_Illegal_Quantity

; *******************
  BASIC_SOUND ; $71ec
; *******************

          JSR Get_Byte_Var
          DEX
          CPX #3
          BCC SOUND_10
SOUND_Err JMP Error_Illegal_Quantity
SOUND_10  STX Voice_Number
          JSR Comma_And_LINNUM
          STY TEMP_MAX_LO
          STA TEMP_MAX_HI
          STY TEMP_FREQ_LO
          STA TEMP_FREQ_HI
          JSR Comma_And_LINNUM
          CMP #$80
          BCS SOUND_Err
          STY TEMP_TIME_LO
          STA TEMP_TIME_HI
          JSR Get_Byte_Or_Zero
          CPX #3
SOUND_15  BCS SOUND_Err
          TXA
          STA TEMP_DIRECTION
          AND #%00000001 ; $01
          PHP
          JSR Get_Comma_And_Integer
          STY TEMP_MIN_LO
          STA TEMP_MIN_HI
          JSR Get_Comma_And_Integer
          PLP
          BEQ SOUND_20
          PHA
          TYA
          EOR #%11111111 ; $ff
          CLC
          ADC #1
          TAY
          PLA
          EOR #%11111111 ; $ff
          ADC #0
SOUND_20  STA TEMP_STEP_HI
          TYA
          STA TEMP_STEP_LO
          LDX #2
          JSR Get_Byte_Or_Void
          CPX #4
          BCS SOUND_15
          LDA Bit_Mask+4,X
          ORA #%00000001 ; $01
          STA TEMP_WAVEFORM
          JSR Get_Comma_And_Integer
          BCS SOUND_25
          LDA #8
          LDY #0
SOUND_25  CMP #16
          BCS SOUND_Err
          STY TEMP_PULSE_LO
          STA TEMP_PULSE_HI
          LDA TEMP_TIME_LO
          ORA TEMP_TIME_HI
          BEQ SOUND_50
          LDX Voice_Number
          TXA
          ASL A
          TAY
SOUND_30  LDA Snd_Duration+1,Y
          BPL SOUND_30
SOUND_35  LDA Sound_Duration_1_Hi,X
          BPL SOUND_35
          LDY #0
SOUND_40  LDA TEMP_MAX_LO,Y
          STA SOUND_MAX_LO,X
          INX
          INX
          INX
          INY
          CPY #9
          BNE SOUND_40
          LDX Voice_Number
          LDY offtab,X
          JSR Map_IO
          LDA #8
          STA SID_Control_1,Y
          LDA #0
          STA SID_Attack_1,Y
          LDA #$f0
          STA SID_Sustain_1,Y
          LDX #0
SOUND_45  LDA TEMP_FREQ_LO,X
          STA SID_Freq_1,Y
          INY
          INX
          CPX #5
          BNE SOUND_45
SOUND_50  LDX Voice_Number
          LDY TEMP_TIME_LO
          LDA TEMP_TIME_HI
          SEI
          STA Sound_Duration_1_Hi,X
          TYA
          STA Sound_Duration_1_Lo,X
          CLI
          RTS

; ********************
  BASIC_WINDOW ; $72cc
; ********************

          JSR Get_Byte_Var
          CPX #40             ; limit for 40 column screen
          BIT MODE_80
          BPL WIND_10
          CPX #80             ; limit for 80 column screen
WIND_10   BCS WIND_Err
          STX Win_XL
          JSR Comma_And_Byte
          CPX #25             ; row limit
          BCS WIND_Err
          STX Win_YL
          JSR Comma_And_Byte
          CPX #40             ; limit for 40 column screen
          BIT MODE_80
          BPL WIND_20
          CPX #80             ; limit for 80 column screen
WIND_20   BCS WIND_Err
          STX Win_XH
          CPX Win_XL
          BCC WIND_Err
          JSR Comma_And_Byte
          CPX #25
          BCS WIND_Err
          STX Win_YH
          CPX Win_YL
          BCC WIND_Err
          JSR Get_Byte_Or_Zero
          CPX #2
          BCS WIND_Err
          TXA
          PHA
          LDX Win_XL
          LDA Win_YL
          CLC
          JSR E_WINDOW
          LDX Win_XH
          LDA Win_YH
          SEC
          JSR E_WINDOW
          LDX #$13            ; HOME
          PLA
          BEQ WIND_30
          LDX #$93            ; CLR
WIND_30   TXA
          JMP B_BSOUT
WIND_Err  JMP Error_Illegal_Quantity

; ******************
  BASIC_BOOT ; $7335
; ******************

          LDA #$e6
          LDX #$fc
          JSR DOS_Parser_AX
          LDA DOSFLA
          LSR A
          BCC BABO_20
          JSR BLOAD
          BCS BABO_Err
          LDX USER_BANK
          LDA DOSFLB
          LSR A
          BCC BABO_10
          LDX DOS_BANK
BABO_10   STX BANK
          LDA SAL
          STA PC_LO
          LDA SAH
          STA PC_HI
          JMP K_JSRFAR
BABO_20   LDA DOS_DRIVE_1
          ORA #'0'
          LDX DOS_FA
          JSR Map_IO
          JSR K_BOOT
          BCS BABO_Err
          RTS
BABO_Err  JMP Break_On_Error


; ********************
  BASIC_SPRDEF ; $7372
; ********************

          JSR Allocate_Graphics_RAM
          JSR Map_IO
          LDA #$d0
          STA CHRPAG          ; $d000 : character rom
          LDA #$20
          STA GRAPHM          ; $2000 : graphics screen
          JSR Clear_Graphics_RAM
          LDY #$80
          STY XSGN
          LDY #24             ; display
          LDA #' '
          LDX #0
SPRD_05   JSR Display_Character
          INX
          CPX #21             ; display 21 blanks
          BCC SPRD_05
SPRD_10   JSR Display_Character
          DEY
          BPL SPRD_10
          JSR Map_IO
          LDA E_Attribute
          PHA
          LDA VIC_BG_COL
          STA E_Attribute
          LDA #'+'            ; sprite cursor
          LDX #0
          STX XSGN
SPRD_15   LDY #0
SPRD_20   JSR Display_Character
          INY
          CPY #24
          BCC SPRD_20
          INX
          CPX #21
          BCC SPRD_15
          PLA
          STA E_Attribute
          JSR Clear_Sprite
SPRD_25   LDY #2
          LDX #$17
SPRD_30   LDA SPRITE_NO-2,Y
          BEQ SPRD_35
          JSR Display_Character
          INY
          BNE SPRD_30
SPRD_35   JSR Map_IO
SPRD_40   JSR K_GETIN
          BEQ SPRD_40
          CMP #CR
          BNE SPRD_45
          JSR Clear_Graphics_RAM
          LDA #0
          STA GRAPHM
          RTS
SPRD_45   SEC
          SBC #'1'
          STA SPRNUM
          CMP #8
          BCS SPRD_40
          TAX
          ASL A
          TAY
          LDA Bit_Mask,X
          STA BITMSK
          AND Vd01c
          BEQ SPRD_50
          LDA #$80
SPRD_50   STA DEFMOD
          LDA #8
          STA VSH,Y
          LDA #$4a ; 'J'
          STA VSH+1,Y
          LDA BITMSK
          ORA VSH+16
          STA VSH+16
          LDA BITMSK
          STA VIC_SPR_ENA
          LDX SPRNUM
          LDY Sprite_Offset,X
          LDA #0
          STA SPRITE_DATA,Y
          TXA
          LDY #$11
          LDX #$17
          CLC
          ADC #'1'
          JSR Display_Character
          JSR Map_IO
          LDA SPRNUM
          LSR A
          ROR A
          ROR A
          STA FORPNT
          LDY #14
          BCC SPRD_55
          INY
SPRD_55   STY FORPNT+1
          JSR Show_Sprite
          LDY #$3f
SPRD_60   LDA (FORPNT),Y
          STA SAVRAM,Y
          DEY
          BPL SPRD_60
SPRD_65   LDX #0
          STX ANGEND+1
          STX ANGEND
SPRD_70   JSR Show_Sprite_Cursor
SPRD_75   JSR K_GETIN
          BEQ SPRD_75
          PHA
          JSR Show_Sprite_Cursor
          PLA
          LDX #16
SPRD_80   CMP SPRITECOL-1,X
          BNE SPRD_85
          DEX
          TXA
          LDX SPRNUM
          STA Vd027,X
          JSR Show_Sprite
          BCS SPRD_70
SPRD_85   DEX
          BNE SPRD_80
          LDX #$11
SPRD_90   CMP SPRITECMD,X
          BEQ SPRD_95
          DEX
          BPL SPRD_90
          BMI SPRD_70
SPRD_95   TXA
          TAY
          ASL A
          TAX
          LDA Sprite_Jump_Table,X
          PHA
          LDA Sprite_Jump_Table+1,X
          PHA
          RTS

; *****************
  SPR_Pixel ; $7497
; *****************

          TYA
          STA VTEMPA+1
          JSR Load_Sprite_Color
          PHA
          LDY ANGEND
          LDX ANGEND+1
          JSR Set_Graphics_Pointer
          PLA
          JSR Store_Graphic_Byte
          LDY ANGEND
          TYA
          AND #%00000111 ; $07
          TAX
          TYA
          LSR A
          LSR A
          LSR A
          CLC
          ADC ANGEND+1
          ADC ANGEND+1
          ADC ANGEND+1
          TAY
          LDA (FORPNT),Y
          BIT DEFMOD
          BPL SPix_10
          STA VTEMPA
          LDA rbits,X
          ORA rbits+1,X
          PHA
          ORA VTEMPA
          STA VTEMPA
          PLA
          LDX VTEMPA+1
          AND colval,X
          EOR VTEMPA
          JMP SPix_12

SPix_10   ORA rbits,X
          ASL VTEMPA+1
          BNE SPix_12
          EOR rbits,X
SPix_12   STA (FORPNT),Y
          BIT DEFMOD
          BVC SPix_30
          JMP SPRD_70

SPix_14   LDY #$3f
SPix_16   LDA SAVRAM,Y
          STA (FORPNT),Y
          DEY
          BPL SPix_16
SPix_18   LDA #0
          STA VIC_SPR_ENA
          JMP SPRD_25

SPix_20   LDA DEFMOD
          EOR #%10000000 ; $80
          STA DEFMOD
          JSR Show_Sprite
          LDA ANGEND
          AND #%11111110 ; $fe
          STA ANGEND
          LDY #$1c
          .BYTE $2C ;BIT
SPix_22   LDY #$17
          .BYTE $2C ;BIT
SPix_24   LDY #$1d
          LDA VIC,Y
          LDX SPRNUM
          EOR Bit_Mask,X
          STA VIC,Y
          JMP SPRD_70

SPix_26   LDY #$3f
          LDA #0
SPix_28   STA (FORPNT),Y
          DEY
          BPL SPix_28
          JSR Clear_Sprite
          JMP SPRD_65

SPix_30   LDA #1
          .BYTE $2C ;BIT
SPix_32   LDA #$ff
          BIT DEFMOD
          BPL SPix_34
          ASL A
SPix_34   CLC
          ADC ANGEND
          BMI SPix_36
          CMP #$18
          BCS SPix_48
          STA ANGEND
          BCC SPix_46
SPix_36   LDX #$17
          BIT DEFMOD
          BPL SPix_38
          DEX
SPix_38   STX ANGEND
SPix_40   LDA #$ff
          .BYTE $2C ;BIT
SPix_42   LDA #1
          CLC
          ADC ANGEND+1
          CMP #$15
          BCS SPix_46
          STA ANGEND+1
          BCC SPix_46
SPix_44   LDA DEFMOD
          EOR #%01000000 ; $40 ; '@'
          STA DEFMOD
SPix_46   JMP SPRD_70

SPix_48   LDA #0
          STA ANGEND
          BEQ SPix_42
SPix_50   LDY #2
          LDX #$18
SPix_52   LDA COPY_FROM-2,Y
          BEQ SPix_54
          JSR Display_Character
          INY
          BNE SPix_52
SPix_54   JSR Map_IO
SPix_56   JSR K_GETIN
          BEQ SPix_56
          CMP #CR
          BEQ SPix_62
          SEC
          SBC #$31 ; '1'
          CMP #8
          BCS SPix_56
          LSR A
          ROR A
          ROR A
          STA VTEMPA
          LDY #14
          BCC SPix_58
          INY
SPix_58   STY VTEMPA+1
          LDY #$3f
SPix_60   LDA (VTEMPA),Y
          STA (FORPNT),Y
          DEY
          BPL SPix_60
          JSR Show_Sprite
SPix_62   LDA #0
          TAY
SPix_64   STA V3e00,Y
          DEY
          BNE SPix_64
          JMP SPRD_70

          .BYTE $ff,$ff,$ff ; unused

; *******************
  Show_Sprite ; $75d1
; *******************

          LDX #0
          STX XRCOS
ShSp_10   STX LINCNT
          JSR Set_Graphics_Pointer
          LDY #0
ShSp_20   LDX #8
          STY NUMCNT
          LDY XRCOS
          LDA (FORPNT),Y
          INC XRCOS
          LDY NUMCNT
ShSp_30   ASL A
          BIT DEFMOD
          BPL ShSp_40
          ROL A
          DEX
ShSp_40   PHA
          ROL A
          JSR Load_Sprite_Color
          JSR Store_Graphic_Byte
          INY
          PLA
          DEX
          BNE ShSp_30
          CPY #$18
          BCC ShSp_20
          LDX LINCNT
          INX
          CPX #$15
          BCC ShSp_10
          RTS

; *************************
  Load_Sprite_Color ; $7610
; *************************

          AND #3
          LSR A
          ROR A
          BEQ LSC_10
          BIT DEFMOD
          BPL LSC_20
          LDA Vd025
          BCC Expand_Color_Nibble
          LDA Vd026
          BCS Expand_Color_Nibble
LSC_10    LDA VIC_BG_COL
          BCC Expand_Color_Nibble
LSC_20    STX VTEMPA
          LDX SPRNUM
          LDA Vd027,X
          LDX VTEMPA

; ***************************
  Expand_Color_Nibble ; $7634
; ***************************

          AND #%00001111 ; $0f
          STA VTEMPA
          ASL A
          ASL A
          ASL A
          ASL A
          ORA VTEMPA
          RTS

; **************************
  Store_Graphic_Byte ; $763f
; **************************

          STA (GRAPNT),Y
          BIT DEFMOD
          BPL SGB_10
          INY
          STA (GRAPNT),Y
SGB_10    RTS

; **************************
  Show_Sprite_Cursor ; $764a
; **************************

          LDX ANGEND+1
          JSR Set_Graphics_Pointer
          LDY ANGEND
          BIT DEFMOD
          BPL Toggle_Graphic_Bit7
          JSR Toggle_Graphic_Bit7

; ***************************
  Toggle_Graphic_Bit7 ; $764a
; ***************************

          LDA (GRAPNT),Y
          EOR #%10000000 ; $80
          STA (GRAPNT),Y
          INY
          RTS

COPY_FROM .TEXT "COPY FROM?",0
SPRITE_NO .TEXT "SPRITE NUMBER?  ",0
SPRITECMD .TEXT "1234",$03,$8d,"XYM",$9d
          .BYTE $1d,$91,$11,$93,$13,$41,$0d,$43

; *************************
  Sprite_Jump_Table ; $7691
; *************************

          .BYTE >[SPR_Pixel -1],<[SPR_Pixel -1]
          .BYTE >[SPR_Pixel -1],<[SPR_Pixel -1]
          .BYTE >[SPR_Pixel -1],<[SPR_Pixel -1]
          .BYTE >[SPR_Pixel -1],<[SPR_Pixel -1]
          .BYTE >[SPix_14   -1],<[SPix_14   -1]
          .BYTE >[SPix_18   -1],<[SPix_18   -1]
          .BYTE >[SPix_24   -1],<[SPix_24   -1]
          .BYTE >[SPix_22   -1],<[SPix_22   -1]
          .BYTE >[SPix_20   -1],<[SPix_20   -1]
          .BYTE >[SPix_32   -1],<[SPix_32   -1]
          .BYTE >[SPix_30   -1],<[SPix_30   -1]
          .BYTE >[SPix_40   -1],<[SPix_40   -1]
          .BYTE >[SPix_42   -1],<[SPix_42   -1]
          .BYTE >[SPix_26   -1],<[SPix_26   -1]
          .BYTE >[SPRD_65   -1],<[SPRD_65   -1]
          .BYTE >[SPix_44   -1],<[SPix_44   -1]
          .BYTE >[SPix_48   -1],<[SPix_48   -1]
          .BYTE >[SPix_50   -1],<[SPix_50   -1]

SPRITECOL .BYTE $90,$05,$1c,$9f,$9c,$1e,$1f,$9e
          .BYTE $81,$95,$96,$97,$98,$99,$9a,$9b

; ****************************
  Set_Graphics_Pointer ; $76c5
; ****************************

          LDA E_40_Line_Lo,X
          STA GRAPNT
          LDA E_40_Line_Hi,X
          AND #%00000011 ; $03
          ORA #%00011100 ; $1c
          STA GRAPNT+1
          RTS

; ********************
  Clear_Sprite ; $76d4
; ********************

          LDA VIC_BG_COL
          JSR Expand_Color_Nibble
          LDX #20             ; start at row 20
ClSp_10   PHA
          JSR Set_Graphics_Pointer
          PLA
          LDY #23             ; start at column 23
ClSp_20   STA (GRAPNT),Y
          DEY                 ; next column
          BPL ClSp_20
          DEX                 ; next row
          BPL ClSp_10
          RTS

; ********************
  BASIC_SPRSAV ; $76ec
; ********************

          JSR Get_Sprite_Address
          BCS SPRS_20
          STA FORPNT
          STY FORPNT+1
          LDY #$3e            ; length of sprite data
SPRS_10   LDA (FORPNT),Y
          STA SAVRAM,Y
          DEY
          BPL SPRS_10
          INY                 ; Y = 0
          STY SAVRAM+$40      ; width  high
          STY SAVRAM+$42      ; height high
          LDA #$17
          STA SAVRAM+$3f      ; width  low = 23
          LDA #$14
          STA SAVRAM+$41      ; height low = 20
          LDX #<SAVRAM
          LDY #>SAVRAM
          STX STRPTR
          STY STRPTR+1
          LDA #$43            ; sprite data + size
          JSR Store_String_Bank_0
          JSR LXAY_Descriptor
SPRS_20   STX SAVSIZ          ; string descriptor
          STA SAVSIZ+1
          STY SAVSIZ+2
          JSR Need_Comma
          LDA TXTPTR
          STA SPRTMP
          LDA TXTPTR+1
          STA SPRTMP+1
          JSR Get_Sprite_Address
          BCS SPRS_50
          STA GRAPNT
          STY GRAPNT+1
          LDA SAVSIZ+1
          STA FORPNT
          LDA SAVSIZ+2
          STA FORPNT+1
          LDY #0
SPRS_30   CPY SAVSIZ
          BEQ SPRS_40
          LDA #FORPNT
          JSR Fetch_1
          STA MMU_LCRC
          STA (GRAPNT),Y
          INY
          CPY #$3f
          BNE SPRS_30
SPRS_40   RTS
SPRS_50   LDA SPRTMP
          STA TXTPTR
          LDA SPRTMP+1
          STA TXTPTR+1
          JSR Parse_Name
          STA FORPNT
          STY FORPNT+1
          LDA #<SAVSIZ
          STA FAC1_M3
          LDA #>SAVSIZ
          STA FAC1_M4
          JMP Assign_String_Variable

; **************************
  Get_Sprite_Address ; $777c
; **************************

          JSR Eval_Expression
          BIT VALTYP
          BMI LXAY_Descriptor
          JSR Eval_Byte
          DEX
          CPX #8
          BCS GSA_Err
          TXA
          LSR A
          ROR A
          ROR A
          LDY #14
          BCC GSA_10
          INY
GSA_10    CLC
          RTS
GSA_Err   JMP Error_Illegal_Quantity

; ***********************
  LXAY_Descriptor ; $7799
; ***********************

          LDA FAC1_M3
          LDY FAC1_M4
          JSR Pop_Descriptor_Stack
          LDY #0
          JSR Get_FAC1_M3_1
          TAX
          INY
          JSR Get_FAC1_M3_1
          PHA
          INY
          JSR Get_FAC1_M3_1
          TAY
          PLA
          SEC
          RTS

; ******************
  BASIC_FAST ; $77b3
; ******************

          JSR Map_IO
          LDA VIC_Ctrl_1
          AND #%01101111     ; clear device enable bit 4
          STA VIC_Ctrl_1
          LDA #1
          STA VIC_SPEED       ; set CPU speed to 2MHz
          RTS

; ******************
  BASIC_SLOW ; $77c4
; ******************

          JSR Map_IO
          LDA #0
          STA VIC_SPEED       ; set CPU speed to 1MHz
          LDA VIC_Ctrl_1
          AND #%01111111     ; clear RST8
          ORA #%00010000     ; set device enable bit 4
          STA VIC_Ctrl_1
          RTS

; ********************
  Eval_Numeric ; $77d7
; ********************

          JSR Eval_Expression

; **********************
  Assert_Numeric ; $77da
; **********************

          CLC
          BCC Check_Var_Type

; *******************
  Need_String ; $77dd
; *******************

          SEC

; **********************
  Check_Var_Type ; $77de
; **********************

          BIT VALTYP          ; $FF = string   $00 = numeric
          BMI CVT_10          ; branch on string type
          BCS TYPE_MISMATCH   ; string assert -> TYPE MISMATCH
CVT_Ret   RTS
CVT_10    BCS CVT_Ret         ; looking for string, found string

; *********************
  TYPE_MISMATCH ; $77e7
; *********************

          LDX #$16            ; TYPE MISMATCH
          .BYTE $2C ;BIT                 ; skip word
Err_FTC   LDX #$19            ; FORMULA TOO COMPLEX
          JMP Print_Error_X

; ***********************
  Eval_Expression ; $77ef
; ***********************

          LDX TXTPTR          ; TXTPTR--
          BNE EvEx_05
          DEC TXTPTR+1
EvEx_05   DEC TXTPTR
          LDX #0
          .BYTE $24           ; skip next PHA
EvEx_10   PHA                 ; push ACCSYM (comparison op + type)
          TXA
          PHA                 ; push X
          TSX
          CPX #$63            ; remaining stack < $63
          BCC Err_FTC
          JSR Vectored_EVAL
          LDA #0
          STA OP_TMP
EvEx_15   JSR CHRGOT
EvEx_20   SEC
          SBC #$b1            ; > token ( start of comparison ops)
          BCC EvEx_25
          CMP #3              ; ( 3 comparison operators > = < )
          BCS EvEx_25         ; -> function
          CMP #1              ; CMP #2
          ROL A               ; ADC #1
          EOR #1              ; '>'  A = 1
          EOR OP_TMP          ; '='  A = 2
          CMP OP_TMP          ; '<'  A = 4
          BCC SynErr1
          STA OP_TMP
          JSR CHRGET
          JMP EvEx_20         ; loop (maybe <= or >= or <>)

EvEx_25   LDX OP_TMP
          BNE EvEx_50
          BCS Pop_FAC2          ; function ( SGN INT ... MID$ )
          ADC #7
          BCC Pop_FAC2          ; branch always
          ADC VALTYP          ; C=1               0 1 2 3 4  5  6
          BNE EvEx_30         ; binary operator ( + - * / ^ AND OR )
          JMP Concatenate     ; '+' with strings

EvEx_30   ADC #$ff
          STA INDEXA          ; op code (0-9 for '+' to '<')
          ASL A               ; op code * 2
          ADC INDEXA          ; op code * 3
          TAY                 ; Y = index
EvEx_35   PLA                 ; precedence
          CMP BASIC_Operator,Y
          BCS PoFA_20         ; previous op has higher precedence
          JSR Assert_Numeric
EvEx_40   PHA                 ; save precedence
EvEx_45   JSR Use_Operator
          PLA                 ; restore precedence
          LDY VARTXT          ; restore index
          BPL EvEx_60
          TAX
          BEQ PoFA_10
          BNE PoFA_40         ; always

EvEx_50   LSR VALTYP          ; clear type
          TXA                 ; comparison operator
          ROL A               ; com op * 2
          LDX TXTPTR          ; TXTPTR--
          BNE EvEx_55
          DEC TXTPTR+1
EvEx_55   DEC TXTPTR
          LDY #$1b            ; index to Op_COMPARE
          STA OP_TMP
          BNE EvEx_35
EvEx_60   CMP BASIC_Operator,Y
          BCS PoFA_40         ; higher or equal precedence
          BCC EvEx_40         ; lower precedence

; ********************
  Use_Operator ; $7871
; ********************

          LDA BASIC_Operator+2,Y
          PHA
          LDA BASIC_Operator+1,Y
          PHA
          JSR Push_Operand
          LDA OP_TMP
          JMP EvEx_10
SynErr1   JMP SYNTAX_ERROR

; ********************
  Push_Operand ; $7884
; ********************

          LDA FAC1_SI
          LDX BASIC_Operator,Y
          TAY
          CLC
          PLA
          ADC #1
          STA INDEXA          ; return address low
          PLA
          ADC #0
          STA INDEXA+1        ; return address high
          TYA
          PHA                 ; sign of operand
          JSR Round_FAC1
          LDA FAC1_M4
          PHA
          LDA FAC1_M3
          PHA
          LDA FAC1_M2
          PHA
          LDA FAC1_M1
          PHA
          LDA FAC1_EX
          PHA
          JMP (INDEXA)        ; RTS

; ****************
  Pop_FAC2 ; $78ac
; ****************

          LDY #$ff
          PLA
PoFA_10   BEQ PoFA_50
PoFA_20   CMP #$64            ; precedence of Op_COMPARE
          BEQ PoFA_30         ; strings may be comapred too
          JSR Assert_Numeric
PoFA_30   STY VARTXT
PoFA_40   PLA
          LSR A               ; C = VALTYPE
          STA TANSGN          ; comparison operator
          PLA
          STA FAC2_EX
          PLA
          STA FAC2_M1
          PLA
          STA FAC2_M2
          PLA
          STA FAC2_M3
          PLA
          STA FAC2_M4
          PLA
          STA FAC2_SI
          EOR FAC1_SI
          STA STRPTR
PoFA_50   LDA FAC1_EX
          RTS

; *********************
  Vectored_EVAL ; $78d7
; *********************

          JMP (IEVAL)

; ****************
  DEF_EVAL ; $78da
; ****************

          LDA #0
          STA VALTYP          ; default numeric
Eva_10    JSR CHRGET
          BCS Eva_30          ; branch if not numeric
Eva_20    LDX #0
          JMP Read_Real_To_FAC1
Eva_30    JSR Is_Alpha
          BCC Eva_40
          JMP Get_Var
Eva_40    CMP #$ff            ; PI token
          BNE qdot
          LDA #<Real_PI
          LDY #>Real_PI
          JSR Load_FAC1_AY
          JMP CHRGET

Real_PI   .BYTE $82,$49,$0f,$da,$a1 ;REAL $82490fdaa1;    3.14159265254

; ************
  qdot ; $7903
; ************

          CMP #'.'
          BEQ Eva_20
          CMP #$ab            ; -
          BEQ Prep_Minus_Op
          CMP #$aa            ; +
          BEQ Eva_10
          CMP #QUOTE
          BNE qdot_10

; *************************************
  Create_Descriptor_From_TXTPTR ; $7913
; *************************************

          LDA TXTPTR
          LDY TXTPTR+1
          ADC #0
          BCC CDFT_10
          INY
CDFT_10   JSR Create_String_Descriptor

; *********************************
  Restore_Execution_Pointer ; $791f
; *********************************

          LDX STRNG2
          LDY STRNG2+1
          STX TXTPTR
          STY TXTPTR+1
          RTS

qdot_10   CMP #$a8            ; compare with token for NOT
          BNE qdot_20         ; -> continue evaluation
          LDY #$18            ; offset to NOT function
          BNE Prep_Operation  ; always

; **************
  OP_NOT ; $7930
; **************

          JSR Real_To_Integer
          LDA FAC1_M4
          EOR #$ff
          TAY
          LDA FAC1_M3
          EOR #$ff

; ***********************
  Integer_To_Real ; $793c
; ***********************

          JSR Integer_To_FAC1
          JMP AFACX

qdot_20   CMP #$a5            ; FN
          BNE qdot_30
          JMP Eval_FNX
qdot_30   CMP #$b4            ; SGN
          BCC Get_Arg
          JMP Call_Function

; ***************
  Get_Arg ; $7950
; ***************

          JSR Need_Left_Par
          JSR Eval_Expression

; **********************
  Need_Right_Par ; $7956
; **********************

          LDA #')'
          .byte $2c ;BIT

; *********************
  Need_Left_Par ; $7959
; *********************

          LDA #'('
          .byte $2c ;BIT

; ******************
  Need_Comma ; $795c
; ******************

          LDA #','

; **************
  Need_A ; $795e
; **************

          LDY #0
          STA SYNTMP
          JSR INDTXT
          CMP SYNTMP
          BNE SYNTAX_ERROR
          JMP CHRGET

; ********************
  SYNTAX_ERROR ; $796c
; ********************

          LDX #11
          JMP Print_Error_X

; *********************
  Prep_Minus_Op ; $7971
; *********************

          LDY #$15            ; set offset from base to > operator

; **********************
  Prep_Operation ; $7973
; **********************

          PLA                 ; dump return address low byte
          PLA                 ; dump return address high byte
          JMP EvEx_45         ; execute function then continue evaluation

; ***************
  Get_Var ; $7978
; ***************

          JSR Parse_Name
          STA FAC1_M3         ; save variable pointer
          STY FAC1_M4
          LDX VARNAM
          LDY VARNAM+1
          LDA VALTYP          ; get data type flag, $FF = string, $00 = numeric
          BEQ Load_Value
          LDA #0
          STA STRPTR+1        ; clear FAC1 rounding byte
          CPX #'T'            ; TI$ ?
          BNE GeVa_10
          CPY #'I'+$80        ; TI$ ?
          BNE GeVa_Ret
          LDA FAC1_M3
          CMP #<NULL_DESC
          BNE GeVa_Ret
          LDA FAC1_M4
          CMP #>NULL_DESC
          BNE GeVa_Ret
          JSR Load_Jiffy_Clock
          STY TENEXP
          DEY
          STY STRNG2
          LDY #6              ; HHMMSS = 6 digits
          STY TMPVAR
          LDY #$24
          JSR Format_Clock_String
          JMP Create_Descriptor_for_FORMAT
GeVa_Ret  RTS
GeVa_10   CPX #'D'            ; DS$ ?
          BNE GeVa_Ret
          CPY #'S'+$80        ; DS$ ?
          BNE GeVa_Ret
          JSR Get_Disk_Status
          LDY #$ff
GeVa_20   INY
          LDA #DS_ADR
          JSR Fetch_1
          CMP #0
          BNE GeVa_20
          TYA                 ; Y = length of DS$
          JSR Allocate_String_FAC1
          TAY
          BEQ GeVa_40
GeVa_30   DEY
          LDA #DS_ADR
          JSR Fetch_1
          STA (FRESPC),Y      ; store string in RAM
          TYA
          BNE GeVa_30
          JSR Adjust_FRESPC   ; obsolete (add 0 to FRESPC)
GeVa_40   JMP Push_String_Descriptor

; ***********************
  Get_Disk_Status ; $79e3
; ***********************

          LDA DS_LEN
          BNE LJC_Ret
          JMP Update_DS

; ******************
  Load_Value ; $79ea
; ******************

          BIT INTFLG          ; test data type flag, $80 = integer, $00 = float
          BPL LoVa_10
          LDY #0
          JSR Get_FAC1_M3_1   ; get integer varlue low byte
          TAX
          INY
          JSR Get_FAC1_M3_1   ; get integer value high byte
          TAY
          TXA
          JMP Integer_To_Real
LoVa_10   LDA FAC1_M4
          CMP #>NULL_DESC
          BNE LoVa_60
          LDA FAC1_M3
          CMP #<NULL_DESC
          BNE LoVa_60
          CPX #'T'            ; TI ?
          BNE LoVa_20
          CPY #'I'            ; TI ?
          BNE LoVa_60
          JSR Load_Jiffy_Clock
          TYA                 ; clear A
          LDX #$a0            ; set exponent to 32 bit value
          JMP IFACX     ; set exponent = X and normalise FAC1

; ************************
  Load_Jiffy_Clock ; $7a1a
; ************************

          JSR K_RDTIM
          STX FAC1_M3
          STY FAC1_M2
          STA FAC1_M4
          LDY #0
          STY FAC1_M1
LJC_Ret   RTS

LoVa_20   CPX #'S'            ; ST ?
          BNE LoVa_30
          CPY #'T'            ; ST ?
          BNE LoVa_60
          JSR B_READST
          JMP A_To_FAC1
LoVa_30   CPX #'D'            ; DS ?
          BNE LoVa_40
          CPY #'S'            ; DS ?
          BNE LoVa_60
          JSR Get_Disk_Status
          LDY #0
          LDA #DS_ADR
          JSR Fetch_1         ; 1st. digit of status
          AND #$0f            ; ASCII -> binary
          ASL A               ; multiply with 10
          STA GARBFL
          ASL A
          ASL A
          ADC GARBFL
          STA GARBFL
          INY
          LDA #DS_ADR
          JSR Fetch_1         ; 2nd. digit of status
          AND #$0f            ; ASCII -> binary
          ADC GARBFL          ; combine 1st. and 2nd. digit
          JMP A_To_FAC1

LoVa_40   CPX #'E'            ; ER or EL ?
          BNE LoVa_60
          CPY #'R'            ; ER ?
          BEQ LoVa_50
          CPY #'L'            ; EL ?
          BNE LoVa_60
          STA MMU_LCRC
          LDA ERRLIN+1
          LDY ERRLIN
          JMP AY_To_FAC1

LoVa_50   STA MMU_LCRC
          LDA ERRNUM
          JMP A_To_FAC1

LoVa_60   LDA FAC1_M3         ; A/Y = address of variable
          LDY FAC1_M4
LoVa_70   STA INDEXA
          STY INDEXA+1
          LDY #0
          JSR Get_INDEXA_1
          STA FAC1_EX
          STY FROUND          ; FROUND = 0
          INY
          JSR Get_INDEXA_1
          STA FAC1_SI
          ORA #%10000000 ; $80
          STA FAC1_M1
          INY
          JSR Get_INDEXA_1
          STA FAC1_M2
          INY
          JSR Get_INDEXA_1
          STA FAC1_M3
          INY
          JSR Get_INDEXA_1
          STA FAC1_M4
          RTS

; ******************
  Parse_Name ; $7aaf
; ******************

          LDX #0
          JSR CHRGOT

; ********************************
  Get_Array_Address ; 7ab4 ; $7ab4
; ********************************

          STX DIMFLG

; **********************
  Get_FN_Address ; $7ab6
; **********************

          STA VARNAM
          JSR CHRGOT
          JSR Is_Alpha
          BCS GeAd_05
GeAd_Err  JMP SYNTAX_ERROR
GeAd_05   LDX #0              ; set defaults
          STX VALTYP          ; numeric
          STX INTFLG          ; real
          JSR CHRGET          ; 2nd. char of name
          BCC GeAd_10         ; -> branch if numeric
          JSR Is_Alpha
          BCC GeAd_20         ; -> branch if not alpha
GeAd_10   TAX                 ; X = 2nd. char of name
GeAd_15   JSR CHRGET          ; skip all alphanumeric characters
          BCC GeAd_15         ; after the 2nd. one
          JSR Is_Alpha
          BCS GeAd_15
GeAd_20   CMP #'$'            ; string ?
          BNE GeAd_25
          LDA #$ff            ; set string flag
          STA VALTYP          ; $ff = string  $00 = numeric
          BNE GeAd_30
GeAd_25   CMP #'%'            ; integer ?
          BNE GeAd_35
          LDA SUBFLG          ; integer allowed ?
          BNE GeAd_Err        ; -> not in this context
          LDA #$80
          STA INTFLG          ; integer flag
          ORA VARNAM
          STA VARNAM          ; mark variable as integer
GeAd_30   TXA                 ; A = 2nd. char
          ORA #$80            ; set string/integer bit
          TAX                 ; X = 2nd. char OR $80
          JSR CHRGET          ; next char after '$' or '%'
GeAd_35   STX VARNAM+1        ; store 2nd. char of name
          SEC
          ORA SUBFLG          ; Or with FOR, FN flag
          SBC #'('            ; array ?
          BNE GeAd_40         ; -> no
          JMP Find_Array      ; read subscripts
GeAd_40   LDY #0
          STY SUBFLG          ; clear integer disable flag
          LDA VARTAB
          LDX VARTAB+1        ; (A/X) = VARTAB
GeAd_45   STX LOWTR+1         ; find variable in (VARTAB..ARYTAB)
GeAd_50   STA LOWTR           ; LOWTR = (A/X)
          CPX ARYTAB+1
          BNE GeAd_55
          CMP ARYTAB
          BEQ Create_Var      ; (A/X) == ARYTAB -> not found
GeAd_55   JSR Get_LOWTR_1
          CMP VARNAM          ; compare 1st. char
          BNE GeAd_65
          INY                 ; Y = 1
          JSR Get_LOWTR_1
          CMP VARNAM+1        ; compare 2nd. char
          BNE GeAd_60
          JMP CrVa_90         ; -> found
GeAd_60   DEY                 ; Y = 0
GeAd_65   CLC
          LDA LOWTR           ; LOWTR += 7
          ADC #7
          BCC GeAd_50
          INX
          BNE GeAd_45         ; always

; ****************
  Is_Alpha ; $7b3c
; ****************

          CMP #'A'
          BCC IsAl_Ret
          SBC #'Z'+1
          SEC
          SBC #$a5            ; restore original content
IsAl_Ret  RTS                 ; C=1 if (A..Z)

; ******************
  Create_Var ; $7b46
; ******************

          TSX
          LDA STACK+2,X
          CMP #>FUNC_Call+2 ; $83 called from FUNC_POINTER ?
          BEQ CrVa_05
          CMP #>Get_Var+2   ; $79 called from Get_Var
          BNE CrVa_35
CrVa_05   LDA #<NULL_DESC     ; load NULL descriptor
          LDY #>NULL_DESC
          RTS
CrVa_10   CPY #'I'+$80        ; TI$ = "hhmmss" sets jiffy clock
          BEQ CrVa_05         ; so don't create variable
          CPY #'I'            ; TI  (read only variable)
          BNE CrVa_40
          BEQ CrVa_30
CrVa_15   CPY #'S'+$80        ; DS$ (read only variable)
          BEQ CrVa_30
          CPY #'S'            ; DS  (read only variable)
          BNE CrVa_40
          BEQ CrVa_30

CrVa_20   CPY #'T'            ; ST  (read only variable)
          BNE CrVa_40
          BEQ CrVa_30

CrVa_25   CPY #'R'           ;
          BEQ CrVa_30
          CPY #'L'
          BNE CrVa_40
CrVa_30   JMP SYNTAX_ERROR

CrVa_35   LDA VARNAM
          LDY VARNAM+1
          CMP #'T'
          BEQ CrVa_10         ; -> check TI and TI$
          CMP #'S'
          BEQ CrVa_20         ; -> check ST
          CMP #'E'
          BEQ CrVa_25         ; -> check ER and EL
          CMP #'D'
          BEQ CrVa_15         ; -> check DS and DS$

CrVa_40   LDA ARYTAB
          LDY ARYTAB+1
          STA LOWTR
          STY LOWTR+1         ; LOWTR  = ARYTAB
          LDA STREND
          LDY STREND+1
          STA HIGHTR
          STY HIGHTR+1        ; HIGHTR = STREND
          CLC
          ADC #7              ; 7 bytes for a new variable
          BCC CrVa_45
          INY
CrVa_45   STA ARYPNT
          STY ARYPNT+1        ; ARYPNT = STREND + 7
          JSR Open_Up_Space   ; Move array space upwards
          LDA ARYPNT
          LDY ARYPNT+1
          INY
          STA ARYTAB          ; ARYTAB = ARYPNT + 256
          STY ARYTAB+1
          STA ARYPNT
          STY ARYPNT+1

; scan through array area and adjust all dynamic string
; back references to the new descriptor position

CrVa_50   LDA ARYPNT
          LDX ARYPNT+1
CrVa_55   CPX STREND+1
          BNE CrVa_60
          CMP STREND
          BNE CrVa_60         ; *** obsolete ***
          BEQ CrVa_80
CrVa_60   STA INDEXA
          STX INDEXA+1
          LDY #0
          JSR Get_INDEXA_1
          TAX                 ; X = 1st. char
          INY                 ; Y = 1
          JSR Get_INDEXA_1
          PHP                 ; push flags of 2nd. char
          INY                 ; Y = 2
          JSR Get_INDEXA_1    ; A = array length low
          ADC ARYPNT
          STA ARYPNT
          INY                 ; Y = 3
          JSR Get_INDEXA_1    ; A = array length high
          ADC ARYPNT+1
          STA ARYPNT+1        ; ARYPNT += array length
          PLP                 ; flags of 2nd. char
          BPL CrVa_50         ; -> branch for real array
          TXA                 ; flags for 1st. char
          BMI CrVa_50         ;-> branch for integer
          INY                 ; Y = 4
          JSR Get_INDEXA_1    ; A = # of dimensions
          LDY #0
          ASL A               ; dimensions * 2
          ADC #5              ; plus 5 bytes for header
          ADC INDEXA
          STA INDEXA
          BCC CrVa_65
          INC INDEXA+1        ; INDEXA += header size
CrVa_65   LDX INDEXA+1
          CPX ARYPNT+1        ; INDEXA == ARYPNT (end of array) ?
          BNE CrVa_70
          CMP ARYPNT
          BEQ CrVa_55         ; -> branch on end of array
CrVa_70   LDY #0
          JSR Get_INDEXA_1    ; length of string
          BEQ CrVa_75         ; -> next item
          STA SYNTMP          ; save length
          INY                 ; Y = 1
          JSR Get_INDEXA_1    ; address low
          CLC
          ADC SYNTMP          ; add length
          STA HIGHTR
          INY                 ; Y = 2
          JSR Get_INDEXA_1    ; address high
          ADC #0
          STA HIGHTR+1        ; HIGHTR = back reference
          LDY #0
          JSR Get_HIGHTR_1    ; back reference low
          ADC #7              ; add 7
          STA (HIGHTR),Y      ; store back
          INY                 ; Y = 1
          JSR Get_HIGHTR_1    ; back reference high
          ADC #0              ; add carry
          STA (HIGHTR),Y      ; store back
CrVa_75   LDA #3              ; position to next descriptor
          CLC
          ADC INDEXA
          STA INDEXA
          BCC CrVa_65
          INC INDEXA+1        ; INDEXA += 3 (next descriptor)
          BNE CrVa_65         ; branch always

; create a new entry for a variable with the contents initialized to zero

CrVa_80   LDY #0
          LDA VARNAM
          STA MMU_LCRD
          STA (LOWTR),Y       ; byte 0: 1st. char
          INY
          LDA VARNAM+1
          STA (LOWTR),Y       ; byte 1: 2nd. char
          LDA #0
CrVa_85   INY
          STA (LOWTR),Y       ; byte 2-6: 0
          CPY #6
          BNE CrVa_85
CrVa_90   LDA LOWTR
          CLC
          ADC #2
          LDY LOWTR+1
          BCC CrVa_95
          INY
CrVa_95   STA VARPNT          ; VARPTR = value of variable
          STY VARPNT+1
          RTS

; *********************
  Open_Up_Space ; $7c66
; *********************

; Input:  A = new top of variables low
;         Y = new top of variables high
;         ARYPNT = target pointer (upper boundary)
;         HIGHTR = source pointer (upper boundary)
;         LOWTR  = source pointer (lower boundary)

          JSR Check_Mem_Avail ; may trigger a garbage collection
          STA STREND
          STY STREND+1        ; save new top of variables
          SEC
          LDA HIGHTR
          SBC LOWTR
          STA INDEXA
          TAY
          LDA HIGHTR+1
          SBC LOWTR+1
          TAX                 ; Y/X = bytes to move
          INX                 ; pages + 1
          TYA
          BEQ OUS_40          ; -> no partial page
          LDA HIGHTR
          SEC
          SBC INDEXA
          STA HIGHTR
          BCS OUS_10
          DEC HIGHTR+1        ; HIGHTR = source pointer
          SEC
OUS_10    LDA ARYPNT
          SBC INDEXA
          STA ARYPNT
          BCS OUS_30
          DEC ARYPNT+1        ; ARYPNT = traget pointer
          BCC OUS_30
OUS_20    JSR Get_HIGHTR_1
          STA (ARYPNT),Y
OUS_30    DEY
          BNE OUS_20
          JSR Get_HIGHTR_1    ; transfer for Y = 0
          STA (ARYPNT),Y
OUS_40    DEC HIGHTR+1
          DEC ARYPNT+1
          DEX
          BNE OUS_30
          RTS

; ******************
  Find_Array ; $7cab
; ******************

          LDA DIMFLG
          ORA INTFLG
          PHA                 ; push INTFLG (bit 7) and DIMFLG (6-0)
          LDA VALTYP
          PHA                 ; push VALTYP
          LDY #0
FiAr_10   TYA                 ; start loop evaluating subscripts
          PHA                 ; push Y
          LDA VARNAM+1
          PHA
          LDA VARNAM          ; push VARNAM
          PHA
          JSR Get_Positive_Integer
          PLA
          STA VARNAM
          PLA
          STA VARNAM+1        ; pull VARNAM
          PLA
          TAY                 ; pull Y
          TSX
          LDA STACK+2,X
          PHA                 ; push DIMFLG/INTFLG again
          LDA STACK+1,X
          PHA                 ; push VALTYP again
          LDA FAC1_M3
          STA STACK+2,X
          LDA FAC1_M4         ; replace value above these flags
          STA STACK+1,X       ; by the subscript pointer
          INY                 ; check next subscript index
          STY B_COUNT         ; # of subscripts
          JSR CHRGOT
          LDY B_COUNT
          CMP #','
          BEQ FiAr_10         ; -> more subscripts
          JSR Need_Right_Par  ; else finish
          PLA
          STA VALTYP
          PLA
          STA INTFLG
          AND #$7f            ; extract DIMFLG
          STA DIMFLG
          LDX ARYTAB
          LDA ARYTAB+1
FiAr_12   STX LOWTR           ; start search
          STA LOWTR+1
          CMP STREND+1
          BNE FiAr_14
          CPX STREND
          BEQ FiAr_22           ; -> end of array space
FiAr_14   LDY #0
          JSR Get_LOWTR_1
          INY
          CMP VARNAM
          BNE FiAr_16
          JSR Get_LOWTR_1
          CMP VARNAM+1
          BEQ FiAr_20
FiAr_16   INY
          JSR Get_LOWTR_1
          CLC
          ADC LOWTR
          TAX
          INY
          JSR Get_LOWTR_1
          ADC LOWTR+1
          BCC FiAr_12         ; always

FiAr_Bad  LDX #$12            ; BAD SUBSCRIPT
          .byte $2c ;BIT

;**********************
 Error_Illegal_Quantity
;**********************

          LDX #14
FiAr_Err  JMP Print_Error_X

FiAr_20   LDX #$13            ; REDIM'D ARRAY
          LDA DIMFLG
          BNE FiAr_Err
          JSR Array_Pointer_To_First
          LDY #4
          JSR Get_LOWTR_1     ; # of declared dimensions
          STA SYNTMP
          LDA B_COUNT         ; *** replace with CMP B_COUNT
          CMP SYNTMP          ;
          BNE FiAr_Bad
          JMP FiAr_38

; create array

FiAr_22   JSR Array_Pointer_To_First
          JSR Check_Mem_Avail
          LDY #0
          STY STRNG2+1
          LDX #5              ; # of bytes per element (default REAL)
          LDA VARNAM
          STA MMU_LCRD        ; select RAM bank 1
          STA (LOWTR),Y       ; store 1st. char
          BPL FiAr_24         ; branch if REAL or STRING
          DEX                 ; # of bytes = 4
FiAr_24   INY                 ; Y = 1
          LDA VARNAM+1
          STA (LOWTR),Y       ; store 2nd. char
          BPL FiAr_26         ; branch if REAL
          DEX
          DEX                 ; # of bytes (2 INTEGER, 3 STRING)
FiAr_26   STX STRNG2          ; store size of elemnts
          LDA B_COUNT         ; # of subscripts
          INY
          INY
          INY                 ; Y = 4
          STA (LOWTR),Y       ; store # of dimensions
FiAr_28   LDX #11             ; default dimension (0..10)
          LDA #0
          BIT DIMFLG
          BVC FiAr_30         ; -> branch for default dimension
          PLA
          CLC
          ADC #1              ; add 1 because indices start at 0
          TAX
          PLA
          ADC #0              ; (X/A) = (subscript + 1)
FiAr_30   INY                 ; Y = 5,7,...
          STA (LOWTR),Y       ; store dimension high
          INY                 ; Y = 6,8,...
          TXA
          STA (LOWTR),Y       ; store dimension low
          JSR Mult_16x16
          STX STRNG2          ; size low
          STA STRNG2+1        ; size high
          LDY INDEXA
          DEC B_COUNT         ; decrement dimension counter
          BNE FiAr_28         ; loop for next dimension
          ADC ARYPNT+1
          BCS FiAr_44         ; -> out of memory
          STA ARYPNT+1
          TAY
          TXA
          ADC ARYPNT
          BCC FiAr_32
          INY
          BEQ FiAr_44         ; -> out of memory
FiAr_32   JSR Check_Mem_Avail
          STA STREND
          STY STREND+1        ; new top of array area
          LDA #0              ; clear array content
          INC STRNG2+1        ; size high
          LDY STRNG2          ; Y = size low
          BEQ FiAr_36
FiAr_34   DEY
          STA (ARYPNT),Y      ; clear array
          BNE FiAr_34
FiAr_36   DEC ARYPNT+1
          DEC STRNG2+1
          BNE FiAr_34
          INC ARYPNT+1
          SEC
          LDA STREND
          SBC LOWTR
          LDY #2
          STA (LOWTR),Y       ; store array size low
          LDA STREND+1
          INY                 ; Y = 3
          SBC LOWTR+1
          STA (LOWTR),Y       ; store array size high
          LDA DIMFLG
          BNE FiAr_Ret
          INY                 ; Y = 4
FiAr_38   JSR Get_LOWTR_1
          STA B_COUNT         ; # of dimensions
          LDA #0
          STA STRNG2
FiAr_40   STA STRNG2+1
          INY                 ; Y = 5,7,...
          PLA
          TAX
          STA FAC1_M3
          JSR Get_LOWTR_1
          STA SYNTMP
          PLA
          STA FAC1_M4         ; FAC1M3/4 = subscript
          CMP SYNTMP          ; compare with dimension high
          BCC FiAr_46         ; -> lower
          BNE FiAr_42         ; greater -> out of range
          INY                 ; Y = 6,8,...
          JSR Get_LOWTR_1
          STA SYNTMP
          CPX SYNTMP          ; compare with dimension low
          BCC FiAr_48         ; -> lower
FiAr_42   JMP FiAr_Bad        ; BAD SUBSCRIPT
FiAr_44   JMP OOM_Error       ; OUT OF MEMORY
FiAr_46   INY                 ; Y = 6,8,...
FiAr_48   LDA STRNG2+1
          ORA STRNG2
          CLC
          BEQ FiAr_50         ; STRNG2 == 0 ?
          JSR Mult_16x16
          TXA
          ADC FAC1_M3
          TAX
          TYA
          LDY INDEXA
FiAr_50   ADC FAC1_M4
          STX STRNG2
          DEC B_COUNT
          BNE FiAr_40         ; next subscript
          STA STRNG2+1
          LDX #5              ; standard item size (REAL)
          LDA VARNAM
          BPL FiAr_52         ; -> REAL or STRING
          DEX                 ; X = 4
FiAr_52   LDA VARNAM+1
          BPL FiAr_54         ; -> REAL
          DEX
          DEX                 ; X = 2
FiAr_54   STX FAC3_M3         ; item size (I=2, S=3, R=5)
          LDA #0
          JSR Mult_16x16_A    ; # of items * item size
          TXA
          ADC ARYPNT
          STA VARPNT
          TYA
          ADC ARYPNT+1
          STA VARPNT+1        ; VARPTR = array element
          TAY
          LDA VARPNT          ; (A/Y) = VARPTR
FiAr_Ret  RTS

; ******************
  Mult_16x16 ; $7e3e
; ******************

          STY INDEXA
          JSR Get_LOWTR_1
          STA FAC3_M3
          DEY
          JSR Get_LOWTR_1

; ********************
  Mult_16x16_A ; $7e49
; ********************

          STA FAC3_M4         ; FAC3M3/3 = Dimension
          LDA #16
          STA TMPVAR          ; 16 bit multiplication
          LDX #0
          LDY #0
Mu16_10   TXA                 ; (X/Y) = FAC3M3 * TMPPTD
          ASL A
          TAX
          TYA
          ROL A
          TAY
          BCS FiAr_44
          ASL STRNG2
          ROL STRNG2+1
          BCC Mu16_20
          CLC
          TXA
          ADC FAC3_M3
          TAX
          TYA
          ADC FAC3_M4
          TAY
          BCS FiAr_44
Mu16_20   DEC TMPVAR          ; next bit
          BNE Mu16_10
          RTS

; ******************************
  Array_Pointer_To_First ; $7e71
; ******************************

          LDA B_COUNT         ; # of dimensions
          ASL A               ; in bytes
          ADC #5              ; plus header size
          ADC LOWTR           ; plus start of array
          LDY LOWTR+1
          BCC APTF_10
          INY
APTF_10   STA ARYPNT          ; pointer to first elemnt
          STY ARYPNT+1
          RTS

; **************
  J_PLOT ; $7e82
; **************

          JSR Map_IO
          JMP K_PLOT

; ***************
  J_PRINT ; $7e88
; ***************

          JSR Map_IO
          JMP E_PRINT

; ***********************
  Test_OOM_CHRGOT ; $7e8e
; ***********************

          JSR Test_OOM_Bank_0
          JMP CHRGOT

; *******************************
  Inc_INDEXB_Cmp_TEXT_TOP ; $7e94
; *******************************

          INC INDEXB
          BNE IICTT_10
          INC INDEXB+1
IICTT_10  SEC
          LDA INDEXB
          SBC TEXT_TOP
          LDA INDEXB+1
          SBC TEXT_TOP+1
          RTS

; *****************
  Get_Pitch ; $7ea6
; *****************

          BIT PALNTS          ; $ff = PAL , $00 = NTSC
          BMI GePi_PAL        ; -> PAL
          LDA Pitch_NTSC_High,X
          RTS
GePi_PAL  LDA Pitch_PAL_Low,X
          STA Snd_Pitch
          LDA Pitch_PAL_High,X
          RTS

; *********************
  Pitch_PAL_Low ; $7eb9
; *********************

          .BYTE $9c,$bf,$22,$c8,$b4,$eb,$71,$4c
          .BYTE $7f,$12,$08,$68

; **********************
  Pitch_PAL_High ; $7ec5
; **********************

          .BYTE $45,$49,$4e,$52,$57,$5c,$62,$68
          .BYTE $6e,$75,$7c,$83

; ******************************
  Reset_Descriptor_Stack ; $7ed1
; ******************************

          STX TRAPNO+1
          LDX #$1b
          STX TEMPPT
          RTS

;         .REAL 0.0
;         .REAL 1.0
;         .REAL 2.0
;         .REAL 3.0
;         .REAL 4.0
;         .REAL 5.0
;         .REAL 6.0
;         .REAL 7.0
;         .REAL 8.0
;         .REAL 9.0

          .FILL $7fc0-* ,$ff ; 231 bytes

          .TEXT "(C)1986 COMMODORE ELECTRONICS"
          .TEXT ", LTD. ALL RIGHTS RESERVED."
          .BYTE $ff,$ff,$ff,$ff
          .BYTE $ef,$8d,$01,$61

; ****************
  FUNC_FRE ; $8000
; ****************

          JSR Eval_Byte       ; allow FRE(0) or FRE(1)
          CPX #1
          BCC FRE_10          ; -> FRE(0) bank 0
          BEQ FRE_30          ; -> FRE(1) bank 1
          JMP Error_Illegal_Quantity
FRE_10    SEC                 ; bank 0: MAX_MEM - TEXT_TOP
          LDA TEXT_MAX
          SBC TEXT_TOP
          TAY                 ; Y = low
          LDA TEXT_MAX+1
          SBC TEXT_TOP+1      ; A = high
          BCS FRE_40          ; -> convert to REAL
          LDX FRETOP          ; TEXT_TOP > MAX_MEM triggers EasterEgg
          INX
          INY
          STA STRPTR
          TYA
          SEC
          SBC #5
          STA FROUND
FRE_20    LDA FROUND
          EOR EasterEgg-44,X
          EOR STRPTR
          BEQ VAL_Ret
          JSR K_BSOUT         ; print easter egg message
          INC FROUND
          INX
          BNE FRE_20
          RTS
FRE_30    JSR Garbage_Collection
          SEC                 ; bank 1: FRETOP - STREND
          LDA FRETOP
          SBC STREND
          TAY
          LDA FRETOP+1
          SBC STREND+1
FRE_40    JMP AY_To_FAC1

; ****************
  FUNC_VAL ; $804a
; ****************

          JSR Eval_String_Desc
          BNE VAL_10
          JMP Clear_FAC1      ; -> empty string
VAL_10    CLC
          ADC INDEXA
          STA STRNG2
          LDA INDEXA+1
          ADC #0
          STA STRNG2+1        ; STRNG2 = position after string
          LDY #0
          LDA #STRNG2
          JSR Fetch_1
          PHA                 ; save string delimiter
          TYA
          STA (STRNG2),Y      ; insert zero as delimiter
          JSR CHRGOT_INDEXA
          LDX #1
          JSR Read_Real_To_FAC1
          PLA                 ; restore string delimiter
          LDY #0
          STA (STRNG2),Y      ; reinsert delimiter
VAL_Ret   RTS

; ****************
  FUNC_DEC ; $8076
; ****************

          JSR Eval_String_Desc
          STA INDEXB          ; string length
          LDY #0
          STY INDEXB+1        ; digit counter
          STY STRNG2
          STY STRNG2+1
DEC_10    CPY INDEXB          ; at end of string ?
          BEQ DEC_40          ; -> finish
          JSR Get_INDEXA_1    ; load next hex digit
          INY
          CMP #' '
          BEQ DEC_10          ; -> skip blanks
          INC INDEXB+1        ; increment digit counter
          LDX INDEXB+1        ; X = counter
          CPX #5              ; max. 4 digits allowed
          BEQ DEC_Err         ; -> too many digits
          CMP #'0'
          BCC DEC_Err
          CMP #'9'+1
          BCC DEC_20          ; -> OK (0-9)
          CMP #'A'
          BCC DEC_Err
          CMP #'F'+1
          BCS DEC_Err
          SBC #7              ; convert 'A'-'F' to  A-F
DEC_20    SBC #'0'-1          ; C = 0
          ASL A
          ASL A
          ASL A
          ASL A               ; shift to high nibble
          LDX #4
DEC_30    ASL A               ; rotate into STRNG2
          ROL STRNG2
          ROL STRNG2+1
          DEX
          BNE DEC_30
          BEQ DEC_10          ; -> next digit

DEC_40    LDY STRNG2          ; convert value to REAL
          LDA STRNG2+1
          JMP AY_To_FAC1
DEC_Err   JMP Error_Illegal_Quantity

; *****************
  FUNC_PEEK ; $80c5
; *****************

          LDA LINNUM+1        ; save LINNUM
          PHA
          LDA LINNUM
          PHA
          JSR Assert_Numeric
          JSR FAC1_To_LINNUM
          LDX USER_BANK
          LDY #0
          LDA #LINNUM
          JSR K_INDFET
          TAY
          PLA
          STA LINNUM
          PLA
          STA LINNUM+1        ; restore LINNUM
          JMP Y_To_Real

;******************
 BASIC_POKE ; $80e5
;******************

          JSR LINNUM_Comma_Byte
          TXA
          LDY #0
          LDX #LINNUM
          STX STASH+10
          LDX USER_BANK
          JMP K_INDSTA

; ****************
  FUNC_ERR ; $80f6
; ****************

          JSR Eval_Byte
          DEX
          TXA
          CMP #$29            ; error < $ 29 ?
          BCS FERR_50         ; -> invalid arument
          JSR Set_Error_Index
          LDY #$ff
          LDX #0
FERR_10   INX
FERR_20   INY
          LDA (INDEXB),Y
          BMI FERR_30         ; -> last character
          CMP #' '
          BCC FERR_20         ; skip unprintable character
          BCS FERR_10         ; -> always

FERR_30   TXA
          JSR Allocate_String_A
          LDX #0
          LDY #$ff
          STA MMU_LCRD
FERR_40   INY
          LDA (INDEXB),Y
          CMP #' '
          BCC FERR_40
          JSR Swap_XY
          PHA
          AND #$7f
          STA (FAC1_M1),Y
          JSR Swap_XY
          INX
          PLA
          BPL FERR_40
          JMP Push_Descriptor
FERR_50   JMP Error_Illegal_Quantity

; ***************
  Swap_XY ; $8139
; ***************

          PHA
          TXA
          PHA
          TYA
          TAX
          PLA
          TAY
          PLA
          RTS

; ****************
  FUNC_HEX ; $8142
; ****************

          JSR Assert_Numeric
          LDA LINNUM          ; save LINNUM
          PHA
          LDA LINNUM+1
          PHA
          JSR FAC1_To_LINNUM
          LDA #4              ; create string of length 4
          JSR Allocate_String_A
          LDY #0
          LDA LINNUM+1
          STA MMU_LCRD
          JSR Byte_To_Hex
          LDA LINNUM
          JSR Byte_To_Hex
          PLA
          STA LINNUM+1
          PLA
          STA LINNUM          ; restore LINNUM
          JMP Push_Descriptor

; *******************
  Byte_To_Hex ; $816b
; *******************

          PHA
          LSR A
          LSR A
          LSR A
          LSR A
          JSR Nibble_To_Hex
          PLA

; *********************
  Nibble_To_Hex ; $8174
; *********************

          AND #%00001111 ; $0f
          CMP #10
          BCC NTH_10
          ADC #6
NTH_10    ADC #'0'
          STA (FAC1_M1),Y
          INY
          RTS

; ****************
  FUNC_RGR ; $8182
; ****************

          JSR Assert_Numeric
          JSR Get_Graphics_Mode
          TAY
          JMP Y_To_Real

; *************************
  Get_Graphics_Mode ; $818c
; *************************

          LDA GRAPHM
          CLC
          ROL A
          ROL A
          ROL A
          ADC #0
          BIT MODE_80
          BPL GGM_Ret
          ADC #5
GGM_Ret   RTS

; *****************
  FUNC_RCLR ; $819b
; *****************

          JSR Eval_Byte
          JSR Map_IO
          DEX
          BMI RCLR_10
          DEX
          BMI RCLR_20
          DEX
          BMI RCLR_30
          DEX
          BMI RCLR_40
          DEX
          BMI RCLR_50
          DEX
          BMI RCLR_60
          DEX
          BMI RCLR_70
          JMP Error_Illegal_Quantity
RCLR_10   LDA VIC_BG_COL
          AND #%01111111 ; $7f
          JMP RCLR_90
RCLR_20   LDA FG_COL
          JMP RCLR_90
RCLR_30   LDA MULCO1
          JMP RCLR_90
RCLR_40   LDA MULCO2
          JMP RCLR_90
RCLR_50   LDA Vd020
          JMP RCLR_90
RCLR_60   LDA E_Attribute
          BIT MODE_80
          BPL RCLR_90
          BMI RCLR_80
RCLR_70   LDA #$1a
          STA VDC_Register
          LDA VDC_Data
RCLR_80   AND #%00001111 ; $0f
          TAX
          LDA unadju_8563,X
RCLR_90   AND #%00001111 ; $0f
          TAY
          INY
          JMP Y_To_Real

; *******************
  unadju_8563 ; $81f3
; *******************

          .BYTE $00,$0c,$06,$0e,$05,$0d,$0b,$03
          .BYTE $02,$0a,$08,$04,$09,$07,$0f,$01

; ****************
  FUNC_JOY ; $8203
; ****************

          JSR Eval_Byte
          DEX
          CPX #2
          BCS JOY_30
          TXA
          EOR #%00000001 ; $01
          TAX
          PHP
          JSR Map_IO
          SEI
          LDA CIA1
          PHA
          LDY #$ff
          STY CIA1
JOY_10    LDA CIA1,X
          CMP CIA1,X
          BNE JOY_10
          TAX
          PLA
          STA CIA1
          TXA
          PLP
          AND #%00001111 ; $0f
          TAY
          LDA JOYTAB-5,Y
          TAY
          TXA
          AND #%00010000 ; $10
          BNE JOY_20
          TYA
          ORA #%10000000 ; $80
          TAY
JOY_20    JMP Y_To_Real
JOY_30    JMP Error_Illegal_Quantity

JOYTAB    .BYTE $04,$02,$03,$00,$06,$08,$07,$00
          .BYTE $05,$01,$00

; ****************
  FUNC_POT ; $824d
; ****************

          JSR Need_Right_Par
          JSR Eval_Byte
          DEX
          CPX #4
          BCS POT_Err
          JSR Map_IO
          LDY #0
          TXA
          LDX #$40
          LSR A
          BCC POT_10
          INY
POT_10    LSR A
          BCC POT_20
          LDX #$80
POT_20    STX POT_IEMP_1
          PHP
          SEI
          LDA CIA1
          PHA
          STX CIA1
          LDX #0
POT_30    INX                 ; wait 256 * 5 cycles = 1.28 msec
          BNE POT_30
POT_40    LDA SID_POT_X,Y
          CMP SID_POT_X,Y
          BNE POT_40
          STA POT_IEMP_2
          LDX #0
          BIT POT_IEMP_1
          BMI POT_50
          INX
POT_50    LDA #4
          DEY
          BMI POT_60
          ASL A
POT_60    LDY #$ff
          STY CIA1
          INY
          AND CIA1,X
          BNE POT_70
          INY
POT_70    PLA
          STA CIA1
          TYA
          LDY POT_IEMP_2
          PLP
          JMP AY_To_FAC1
POT_Err   JMP Error_Illegal_Quantity

; ****************
  FUNC_PEN ; $82ae
; ****************

          JSR Need_Right_Par
          JSR Eval_Byte
          CPX #5
          BCS POT_Err
          CPX #2
          BCS PEN_20
          LDY VSH_LPX,X
          STY POT_IEMP_1
          LDA #0
          STA VSH_LPX,X
          CPX #0
          BNE PEN_10
          ASL POT_IEMP_1
          ADC #0
PEN_10    LDY POT_IEMP_1
          JMP AY_To_FAC1
PEN_20    JSR Map_IO
          CPX #4
          BEQ PEN_40
          LDY #$11
          CPX #2
          BEQ PEN_30
          DEY
PEN_30    STY VDC_Register
          LDY VDC_Data
          JMP Y_To_Real
PEN_40    LDA VDC_Register
          LDY #0
          AND #%01000000 ; $40
          BEQ PEN_50
          INY
PEN_50    JMP Y_To_Real

; ********************
  FUNC_POINTER ; $82fa
; ********************

          JSR CHRGET
          JSR Need_Left_Par
          JSR Is_Alpha
          BCC POIN_Err
FUNC_Call JSR Parse_Name      ; calling address used by Parse_Name
          TAX
          TYA
          PHA
          JSR Need_Right_Par
          TXA
          TAY
          PLA
          CMP #>NULL_DESC     ; address of NULL descriptor ?
          BNE POIN_10
          LDA #0
          TAY                 ; return NULL
POIN_10   JMP AY_To_FAC1
POIN_Err  JMP SYNTAX_ERROR

; ********************
  FUNC_RSPRITE ; $831e
; ********************

          JSR Eval_Byte
          DEX
          CPX #8
          BCS RSPR_Err
          TXA
          PHA
          JSR Need_Comma
          JSR Get_Byte_Var
          JSR Need_Right_Par
          CPX #6
          BCS RSPR_Err
          PLA
          TAY
          JSR Map_IO
          LDA Vd027,Y
          AND #%00001111 ; $0f
          CLC
          ADC #1
          CPX #1
          BEQ RSPR_10
          LDA RSPMOD,X
          TAX
          LDA Bit_Mask,Y
          AND VIC,X
          BEQ RSPR_10
          LDA #1
RSPR_10   TAY
          JMP Y_To_Real
RSPR_Err  JMP Error_Illegal_Quantity

RSPMOD    .BYTE $15,$27,$1b,$1d,$17,$1c

; *********************
  FUNC_RSPCOLOR ; $8361
; *********************

          JSR Need_Right_Par
          JSR Eval_Byte
          DEX
          CPX #2
          BCS RSPC_Err
          JSR Map_IO
          LDA Vd025,X
          AND #%00001111 ; $0f
          TAY
          INY
          JMP Y_To_Real
RSPC_Err  JMP Error_Illegal_Quantity

; *****************
  FUNC_BUMP ; $837c
; *****************

          JSR Need_Right_Par
          JSR Eval_Byte
          DEX
          CPX #2
          BCS BUMP_Err
          SEI
          LDY VSH_SS_COLL,X
          LDA #0
          STA VSH_SS_COLL,X
          CLI
          JMP Y_To_Real
BUMP_Err  JMP Error_Illegal_Quantity

; *******************
  FUNC_RSPPOS ; $8397
; *******************

          JSR Eval_Byte
          DEX
          CPX #8
          BCS RSPP_Err
          TXA
          PHA
          JSR Need_Comma
          JSR Get_Byte_Var
          JSR Need_Right_Par
          CPX #3
          BCS RSPP_Err
          PLA
          TAY
          CPX #2
          BNE RSPP_10
          LDX Sprite_Offset,Y
          LDY SPRITE_DATA,X
          JMP Y_To_Real
RSPP_10   SEI
          LDA Bit_Mask,Y
          AND VSH+16
          BEQ RSPP_20
          LDA #1
RSPP_20   PHA
          TYA
          ASL A
          TAY
          TXA
          LSR A
          BCC RSPP_30
          INY
          PLA
          LDA #0
          PHA
RSPP_30   LDA VSH,Y
          CLI
          TAY
          PLA
          JMP AY_To_FAC1
RSPP_Err  JMP Error_Illegal_Quantity

; ****************
  FUNC_XOR ; $83e1
; ****************

          LDA LINNUM          ; save LINNUM
          PHA
          LDA LINNUM+1
          PHA
          JSR Assert_Numeric
          JSR FAC1_To_LINNUM
          PHA
          TYA
          PHA
          JSR Comma_And_LINNUM
          JSR Need_Right_Par
          PLA
          EOR LINNUM
          TAY
          PLA
          EOR LINNUM+1
          JSR AY_To_FAC1      ; store result
          PLA
          STA LINNUM+1
          PLA
          STA LINNUM          ; restore LINNUM
          RTS

; ********************
  FUNC_RWINDOW ; $8407
; ********************

          JSR Need_Right_Par
          JSR Eval_Byte
          CPX #2
          BEQ RWIN_20
          BCS RWIN_Err
          CPX #0
          BNE RWIN_10
          LDA Margin_Bottom
          SEC
          SBC Margin_Top
          BCS RWIN_30
RWIN_10   LDA Margin_Right
          SEC
          SBC Margin_Left
          BCS RWIN_30
RWIN_20   LDA #40
          BIT MODE_80
          BPL RWIN_30
          LDA #80
RWIN_30   TAY
          JMP Y_To_Real
RWIN_Err  JMP Error_Illegal_Quantity

; ****************
  FUNC_RND ; $8434
; ****************

          JSR Test_FAC1_Sign
RND_10    BMI RND_30
          BNE RND_20
          JSR Map_IO          ; RND(0)
          LDA CIA1_TBLO
          STA FAC1_M1
          LDA CIA1_TBHI
          STA FAC1_M3
          LDA CIA1_TALO
          STA FAC1_M2
          LDA CIA1_TAHI
          STA FAC1_M4
          JMP RND_40
RND_20    LDA #<RNDX          ; RND(+)
          LDY #>RNDX
          JSR Load_FAC1_AY
          LDA #<rmulc
          LDY #>rmulc
          JSR Multiply_AY_To_FAC1
          LDA #<raddc
          LDY #>raddc
          JSR Add_AY_To_FAC1
RND_30    LDX FAC1_M4         ; RND(-)
          LDA FAC1_M1
          STA FAC1_M4
          STX FAC1_M1
          LDX FAC1_M2
          LDA FAC1_M3
          STA FAC1_M2
          STX FAC1_M3
RND_40    LDA #0
          STA FAC1_SI
          LDA FAC1_EX
          STA FROUND
          LDA #$80
          STA FAC1_EX
          JSR Normalise_FAC1
          LDX #<RNDX
          LDY #>RNDX
          JMP FAC1_To_XY

rmulc     .BYTE $98,$35,$44,$7a,$00 ;.REAL $9835447a00 ; 11879546.00000000000
raddc     .BYTE $68,$28,$b1,$46,$00 ;.REAL $6828b14600 ;        0.00000003928
n32768    .BYTE $90,$80,$00,$00,$00 ;.REAL $9080000000 ;   -32768.00000000000

; **********************
  FAC1_To_Int_AY ; $849f
; **********************

          JSR Real_To_Integer
          LDA FAC1_M3
          LDY FAC1_M4
          RTS

; ****************************
  Get_Positive_Integer ; $84a7
; ****************************

          JSR CHRGET
          JSR Eval_Expression

; *****************************
  Eval_Positive_Integer ; $84ad
; *****************************

          JSR Assert_Numeric
          LDA FAC1_SI
          BMI RIT_10

; ***********************
  Real_To_Integer ; $84b4
; ***********************

          LDA FAC1_EX
          CMP #$90            ; check if -32767 >= value >= 32767
          BCC RIT_20
          LDA #<n32768        ; check if value == -32768
          LDY #>n32768
          JSR Compare_AY_FAC1
RIT_10    BEQ RIT_20
          JMP Error_Illegal_Quantity
RIT_20    JMP FAC1_INT

; ******************
  AY_To_FAC1 ; $84c9
; ******************

          JSR Integer_To_FAC1
          SEC                 ; AY = positive 16bit number
          JMP Word_To_FAC1

; ****************
  FUNC_POS ; $84d0
; ****************

          SEC
          JSR B_PLOT

; *****************
  Y_To_Real ; $84d4
; *****************

          LDA #0
          JMP Integer_To_Real

; *************************
  Assert_Non_Direct ; $84d9
; *************************

          BIT RUNMOD
          BMI ITF_Ret
          LDX #$15            ; ILLEGAL DIRECT
          .BYTE $2C ;BIT
UNDEF_Err LDX #$1b            ; UNDEF'D FUNCTION
          JMP Print_Error_X

; ***********************
  Integer_To_FAC1 ; $84e5
; ***********************

          LDX #0
          STX VALTYP          ; numeric result
          STA FAC1_M1         ; high
          STY FAC1_M2         ; low
          LDX #$90            ; exponent
ITF_Ret   RTS

; **************************
  Assert_Direct_Mode ; $84f0
; **************************

          BIT RUNMOD
          BMI ADM_Err
          RTS
ADM_Err   LDX #$22            ; direct mode only
          JMP Print_Error_X

; *****************
  BASIC_DEF ; $84fa
; *****************

          JSR Get_FN          ; read function name
          JSR Assert_Non_Direct
          JSR Need_Left_Par
          LDA #$80
          STA SUBFLG          ; no integer function
          JSR Parse_Name
          JSR Assert_Numeric  ; only numeric arguments
          JSR Need_Right_Par
          LDA #$b2            ; '=' token
          JSR Need_A
          PHA
          LDA VARPNT+1
          PHA
          LDA VARPNT          ; push function argument address
          PHA
          LDA TXTPTR+1
          PHA
          LDA TXTPTR          ; push function address
          PHA
          JSR Skip_Statement
          JMP FNX_30           ; pull and store attributes

; **************
  Get_FN ; $8528
; **************

          LDA #$a5            ; FN token
          JSR Need_A
          ORA #$80
          STA SUBFLG          ; no integer function
          JSR Get_FN_Address
          STA GRBPNT
          STY GRBPNT+1
          JMP Assert_Numeric

; ****************
  Eval_FNX ; $853b
; ****************

          JSR Get_FN          ; address of function descriptor
          LDA GRBPNT+1        ; push function pointer
          PHA
          LDA GRBPNT
          PHA
          JSR Get_Arg
          JSR Assert_Numeric
          PLA
          STA GRBPNT
          PLA
          STA GRBPNT+1        ; restore function pointer
          LDY #2
          JSR GRBPNT_from_Bank_1
          STA VARPNT
          TAX
          INY                 ; Y = 3
          JSR GRBPNT_from_Bank_1
          BEQ UNDEF_Err
          STA VARPNT+1        ; VARPTR = address of argument variable
          INY                 ; Y = 4
FNX_10    LDA #VARPNT
          JSR Fetch_1
          PHA                 ; push value of variable (5 bytes)
          DEY
          BPL FNX_10
          LDY VARPNT+1
          STA MMU_LCRD
          JSR FAC1_To_XY      ; (X/Y) = VARPTR - Y=0 on return
          LDA TXTPTR+1
          PHA                 ; push TXTPTR
          LDA TXTPTR
          PHA
          JSR GRBPNT_from_Bank_1
          STA TXTPTR
          INY
          JSR GRBPNT_from_Bank_1
          STA TXTPTR+1        ; TXTPTR = function body
          LDA VARPNT+1
          PHA                 ; push VARPTR
          LDA VARPNT
          PHA
          JSR Eval_Numeric    ; execute function body
          PLA
          STA GRBPNT          ; GRBPNT = VARPNT
          PLA
          STA GRBPNT+1
          JSR CHRGOT
          BEQ FNX_20
          JMP SYNTAX_ERROR    ; function did not end properly
FNX_20    PLA
          STA TXTPTR
          PLA
          STA TXTPTR+1        ; restore execution pointer
FNX_30    LDY #0
          STA MMU_LCRD
FNX_40    PLA
          STA (GRBPNT),Y      ; restore value of argument variable
          INY
          CPY #5
          BNE FNX_40
          RTS

; ****************
  FUNC_STR ; $85ae
; ****************

          JSR Assert_Numeric
          LDY #0
          JSR Format_FAC1_Y
          PLA
          PLA

; ************************************
  Create_Descriptor_for_FORMAT ; $85b8
; ************************************

          LDA #<STACK-1
          LDY #>STACK-1
          JMP Create_String_Descriptor

; ****************
  FUNC_CHR ; $85bf
; ****************

          JSR Eval_Byte
          TXA
          PHA
          LDA #1
          JSR Allocate_String_A
          PLA
          LDY #0
          STA MMU_LCRD
          STA (FAC1_M1),Y

; ***********************
  Push_Descriptor ; $85d1
; ***********************

          PLA
          PLA
          JMP Push_String_Descriptor

; *****************
  FUNC_LEFT ; $85d6
; *****************

          JSR Pop_DSCPNT      ; get string address and 2nd. argument
          PHA
          JSR Get_DSCPNT_1
          STA SYNTMP
          PLA
          CMP SYNTMP          ; compare argument with length
          TYA                 ; A = 0
LEFT_10   BCC LEFT_20         ; branch if arg < length
          JSR Get_DSCPNT_1    ; get total length
          TAX                 ; string length
          TYA                 ; A = 0
LEFT_20   PHA                 ; push start index (0 for LEFT$)
LEFT_30   TXA                 ; A  = new length
LEFT_40   PHA                 ; push new length
          JSR Allocate_String_A
          LDA DSCPNT
          LDY DSCPNT+1
          JSR Free_String_AY  ; free string argument
          PLA
          TAY                 ; Y = length
          PLA                 ; A = start index
          CLC
          ADC INDEXA
          STA INDEXA
          BCC LEFT_50
          INC INDEXA+1
LEFT_50   TYA
          JSR Store_String_INDEXA
          JMP Push_String_Descriptor

; ******************
  FUNC_RIGHT ; $860a
; ******************

          JSR Pop_DSCPNT      ; get string address and 2nd. argument
          PHA
          JSR Get_DSCPNT_1
          STA SYNTMP
          PLA
          CLC
          SBC SYNTMP          ; length - argument
          EOR #%11111111     ; negate
          JMP LEFT_10

; ****************
  FUNC_MID ; $861c
; ****************

          LDA #255            ; default value for 3rd. argument
          STA FAC1_M4
          JSR CHRGOT
          CMP #')'
          BEQ MID_10
          JSR Need_Comma
          JSR Get_Byte_Var    ; 3rd. argument to FAC1M4
MID_10    JSR Pop_DSCPNT      ; get string address and 2nd. argument
          BEQ ASC_Err         ; null string -> error
          DEX                 ; start index to offset
          TXA
          PHA                 ; push offset
          LDX #0
          PHA
          JSR Get_DSCPNT_1
          STA SYNTMP
          PLA
          CLC
          SBC SYNTMP          ; offset - length
          BCS LEFT_30
          EOR #$ff            ; length - offset
          CMP FAC1_M4
          BCC LEFT_40         ; new length = rest of string
          LDA FAC1_M4         ; new length
          BCS LEFT_40         ; branch always

; ******************
  Pop_DSCPNT ; $864d
; ******************

          JSR Need_Right_Par
          PLA
          TAY                 ; return address low
          PLA
          STA JUMPER+1        ; return address high
          PLA
          PLA
          PLA
          TAX                 ; X = length
          PLA
          STA DSCPNT
          PLA
          STA DSCPNT+1        ; DSCPNT = string address
          LDA JUMPER+1
          PHA                 ; return address high
          TYA
          PHA                 ; return address low
          LDY #0
          TXA                 ; A = length
          RTS

; ****************
  FUNC_LEN ; $8668
; ****************

          JSR Eval_String_Desc
          JMP Y_To_Real

; ************************
  Eval_String_Desc ; $866e
; ************************

          JSR Eval_And_Free_String
          LDX #0
          STX VALTYP
          TAY
          RTS

; ****************
  FUNC_ASC ; $8677
; ****************

          JSR Eval_String_Desc
          BEQ ASC_10
          LDY #0
          JSR Get_INDEXA_1
          TAY
ASC_10    JMP Y_To_Real
ASC_Err   JMP Error_Illegal_Quantity

; ****************************
  Allocate_String_FAC1 ; $8688
; ****************************

          LDX FAC1_M3
          LDY FAC1_M4
          STX DSCPNT
          STY DSCPNT+1

; *************************
  Allocate_String_A ; $8690
; *************************

          JSR Allocate_String_Space
          STX FAC1_M1         ; addres low
          STY FAC1_M2         ; address high
          STA FAC1_EX         ; length
          RTS

; ********************************
  Create_String_Descriptor ; $869a
; ********************************

          LDX #QUOTE          ; set delimiter
          STX CHARAC
          STX ENDCHR

; ***********************************
  Create_String_Descriptor_AY ; $86a0
; ***********************************

          STA STRPTR
          STY STRPTR+1        ; set STRPTR from (A/Y)
          STA FAC1_M1
          STY FAC1_M2         ; set FAC1M1/2 from (A/Y)
          LDY #-1             ; pre increment loop
CSD_10    INY
          JSR Get_STRPTR_0
          BEQ CSD_30          ; end of string
          CMP CHARAC          ; closing delimiter
          BEQ CSD_20
          CMP ENDCHR
          BNE CSD_10          ; loop
CSD_20    CMP #QUOTE
          BEQ CSD_40
CSD_30    CLC
CSD_40    STY FAC1_EX         ; string length
          TYA
          ADC STRPTR
          STA STRNG2          ; STRNG2 = STRPTR + length
          LDX STRPTR+1
          BCC CSD_50
          INX
CSD_50    STX STRNG2+1
          TYA

; ***************************
  Store_String_Bank_0 ; $86cc
; ***************************

          JSR Allocate_String_FAC1
          TAY
          BEQ Push_String_Descriptor
          PHA
SSB0      DEY
          JSR Get_STRPTR_0
          STA MMU_LCRD
          STA (FRESPC),Y
          TYA
          BNE SSB0
          PLA
          JSR Adjust_FRESPC

; ******************************
  Push_String_Descriptor ; $86e3
; ******************************

          LDX TEMPPT          ; Descriptor stack pointer
          CPX #TEMPPT+12      ; Descriptor stack limit
          BNE PuSD_10
          LDX #$19            ; FORMULA TOO COMPLEX
          JMP Print_Error_X
PuSD_10   LDA FAC1_EX
          STA 0,X
          LDA FAC1_M1
          STA 1,X
          LDA FAC1_M2
          STA 2,X
          LDY #0
          STX FAC1_M3         ; mark stack position
          STY FAC1_M4
          STY STRPTR+1
          DEY                 ; Y = $ff
          STY VALTYP          ; type = string
          STX LASTPT          ; remember last used position
          INX                 ; increase descriptor stack pointer
          INX
          INX
          STX TEMPPT
          RTS

; *******************
  Concatenate ; $870d
; *******************

          LDA FAC1_M4         ; push address of left operand
          PHA
          LDA FAC1_M3
          PHA
          JSR Vectored_EVAL   ; evaluate right operand
          JSR Need_String
          PLA
          STA STRPTR
          PLA
          STA STRPTR+1        ; pull address of left operand
          LDY #0
          JSR Get_STRPTR_1
          STA SYNTMP          ; length of left  string
          JSR Get_FAC1_M3_1   ; length of right string
          CLC
          ADC SYNTMP          ; sum of lengths
          BCC Conc_10
          JMP String_Too_Long
Conc_10   JSR Allocate_String_FAC1
          JSR Store_String_STRPTR ; store left part
          LDA DSCPNT
          LDY DSCPNT+1
          JSR Free_String_AY
          JSR Store_String_INDEXA ; store right part
          LDA STRPTR
          LDY STRPTR+1
          JSR Free_String_AY
          JSR Push_String_Descriptor
          JMP EvEx_15

; ***************************
  Store_String_STRPTR ; $874e
; ***************************

          LDY #0
          JSR Get_STRPTR_1    ; A = length
          PHA
          INY
          JSR Get_STRPTR_1    ; X = address low
          TAX
          INY
          JSR Get_STRPTR_1    ; Y = address high
          TAY
          PLA
          STX INDEXA
          STY INDEXA+1

; ***************************
  Store_String_INDEXA ; $8763
; ***************************

          TAY
          BEQ Adjust_FRESPC
          PHA
SSI_10    DEY
          JSR Get_INDEXA_1
          STA (FRESPC),Y
          TYA
          BNE SSI_10
          PLA

; *********************
  Adjust_FRESPC ; $8771
; *********************

          CLC
          ADC FRESPC
          STA FRESPC
          BCC AdFR_Ret
          INC FRESPC+1
AdFR_Ret  RTS

; *******************
  Eval_String ; $877b
; *******************

          JSR Eval_Expression

; ****************************
  Eval_And_Free_String ; $877e
; ****************************

          JSR Need_String

; ************************
  Free_String_FAC1 ; $8781
; ************************

          LDA FAC1_M3
          LDY FAC1_M4

; **********************
  Free_String_AY ; $8785
; **********************

; Input:  (A/Y) = pointer to descriptor
; Output: (X/Y) = INDEXA = pointer to string
;         A     = length

          STA INDEXA
          STY INDEXA+1        ; INDEXA = pointer to descriptor
          JSR Pop_Descriptor_Stack
          BNE FSAY_40         ; -> load if not temporary
          JSR Back_Reference_Position
          BCC FSAY_40         ; -> branch if not a dynamic string
          DEY
          LDA #$ff
          STA MMU_LCRD
          STA (INDEXA),Y      ; invalidate string (backref 1)
          DEY                 ; Y = 0
          TXA
          STA (INDEXA),Y      ; store length (backref 0)
          PHA
          EOR #%11111111 ; $ff
          SEC
          ADC INDEXA
          LDY INDEXA+1
          BCS FSAY_10
          DEY
FSAY_10   STA INDEXA          ; INDEXA -= length
          STY INDEXA+1
          TAX
          PLA
          CPY FRETOP+1
          BNE PDS_Ret         ; return if INDEXA != FRETOP
          CPX FRETOP
          BNE PDS_Ret
          PHA
          SEC
          ADC FRETOP
          STA FRETOP
          BCC FSAY_20
          INC FRETOP+1
FSAY_20   INC FRETOP          ; FRETOP += length + 2
          BNE FSAY_30
          INC FRETOP+1
FSAY_30   PLA
          RTS
FSAY_40   LDY #0
          JSR Get_INDEXA_1
          PHA
          INY
          JSR Get_INDEXA_1
          TAX
          INY
          JSR Get_INDEXA_1
          TAY
          STX INDEXA
          STY INDEXA+1
          PLA
          RTS

; ****************************
  Pop_Descriptor_Stack ; $87e0
; ****************************

          CPY LASTPT+1
          BNE PDS_Ret
          CMP LASTPT
          BNE PDS_Ret
          STA TEMPPT
          SBC #3
          STA LASTPT
          LDY #0
PDS_Ret   RTS

; *************************
  Get_Next_Byte_Var ; $87f1
; *************************

          JSR CHRGET

; ********************
  Get_Byte_Var ; $87f4
; ********************

          JSR Eval_Numeric

; *****************
  Eval_Byte ; $87f7
; *****************

          JSR Eval_Positive_Integer
          LDX FAC1_M3
          BNE FTLI_Err
          LDX FAC1_M4
          JMP CHRGOT

; *************************
  LINNUM_Comma_Byte ; $8803
; *************************

          JSR Eval_Numeric
          JSR FAC1_To_LINNUM

; **********************
  Comma_And_Byte ; $8809
; **********************

          JSR Need_Comma
          JMP Get_Byte_Var

; ************************
  Comma_And_LINNUM ; $880f
; ************************

          JSR Need_Comma

; *******************
  Get_Integer ; $8812
; *******************

          JSR Eval_Numeric

; **********************
  FAC1_To_LINNUM ; $8815
; **********************

          LDA FAC1_SI
          BMI FTLI_Err        ; only positive numbers
F1TL_10   LDA FAC1_EX
          CMP #$91
          BCS FTLI_Err        ; -> greater 65536
          JSR FAC1_INT
          LDA FAC1_M3
          LDY FAC1_M4
          STY LINNUM
          STA LINNUM+1
          RTS
FTLI_Err  JMP Error_Illegal_Quantity

; *********************
  AY_Minus_FAC1 ; $882e
; *********************

          JSR Load_FAC2_From_AY_RAM

; ****************
  OP_MINUS ; $8831
; ****************

          LDA FAC1_SI
          EOR #$ff
          STA FAC1_SI
          EOR FAC2_SI
          STA STRPTR          ; pos = ADD, neg = SUB
          LDA FAC1_EX
          JMP OP_PLUS

AFTF_00   JSR FACX_Bit_Shift
          BCC AFTF_40

; **************************
  Add_Var_AY_To_FAC1 ; $8845
; **************************

          JSR Load_FAC2_From_AY_RAM

; ***************
  OP_PLUS ; $8848
; ***************

          BNE PLUS_10         ; -> branch if FAC1 is not 0
          JMP FAC2_To_FAC1    ; FAC1 = FAC2
PLUS_10   LDX FROUND          ; rounding byte
          STX OLDOV           ; copy it
          LDX #FAC2_EX        ; X points to FAC2
          LDA FAC2_EX

; ***************************
  AddSub_FAC2_To_FAC1 ; $8855
; ***************************

; The mantissa of the FAC with the lower exponent is shifted
; right until both exponents become equal.

; Input:  A = exponent of FAC2
;         X = address  of FAC2
;         STRPTR ($00:Add, $80:Subtract)

; Output: FAC1 = FAC1 + FAC2 (for STRPTR == $00)
;         FAC1 = FAC1 - FAC2 (for STRPTR == $80)

          TAY                 ; Y = exp 2
          BNE AFTF_10
          RTS                 ; return if FAC2 is zero
AFTF_10   SEC
          SBC FAC1_EX         ; A = exp 2 - exp 1
          BEQ AFTF_40         ; -> exponents are equal
          BCC AFTF_20         ; -> exp 2 < exp 1
          STY FAC1_EX         ; exp 1 = exp 2
          LDY FAC2_SI
          STY FAC1_SI         ; sign 1 = sign 2
          EOR #$ff
          ADC #0              ; A = exp 1 - exp 2
          LDY #0
          STY OLDOV           ; clear FAC2 rounding byte
          LDX #FAC1_EX        ; X points to FAC1
          BNE AFTF_30         ; always
AFTF_20   LDY #0
          STY FROUND          ; clear FAC1 rounding byte
AFTF_30   CMP #$f9
          BMI AFTF_00
          TAY
          LDA FROUND
          LSR 1,X
          JSR Rotate_FACX
AFTF_40   BIT STRPTR          ; add or subtract ?
          BPL AFTF_65           ; -> add mantissa of FAC2 to FAC1
          LDY #FAC1_EX
          CPX #FAC2_EX        ; if (X == FAC2) Y = FAC1
          BEQ AFTF_50
          LDY #FAC2_EX        ; else           Y = FAC2
AFTF_50   SEC
          EOR #$ff            ; negate rounding byte
          ADC OLDOV
          STA FROUND
          LDA 4,Y
          SBC 4,X
          STA FAC1_M4
          LDA 3,Y
          SBC 3,X
          STA FAC1_M3
          LDA 2,Y
          SBC 2,X
          STA FAC1_M2
          LDA 1,Y
          SBC 1,X
          STA FAC1_M1
AFTF_60   BCS Normalise_FAC1
          JSR Negate_FAC1

; **********************
  Normalise_FAC1 ; $88b6
; **********************

          LDY #0              ; Y = 0
          TYA                 ; A = 0
          CLC
NF1_10    LDX FAC1_M1         ; MSB of mantissa
          BNE AFTF_75         ; -> shift bitwise
          LDX FAC1_M2         ; shift bytes
          STX FAC1_M1
          LDX FAC1_M3
          STX FAC1_M2
          LDX FAC1_M4
          STX FAC1_M3
          LDX FROUND
          STX FAC1_M4
          STY FROUND          ; FROUND = 0
          ADC #8              ; A = shift count
          CMP #32             ; maximum shift = 32 bit
          BNE NF1_10          ; loop

; ******************
  Clear_FAC1 ; $88d6
; ******************

          LDA #0
CF1_10    STA FAC1_EX
CF1_20    STA FAC1_SI
          RTS

AFTF_65   ADC OLDOV           ; FAC2 rounding byte
          STA FROUND
          LDA FAC1_M4         ; add FAC2 mantissa to FAC1
          ADC FAC2_M4
          STA FAC1_M4
          LDA FAC1_M3
          ADC FAC2_M3
          STA FAC1_M3
          LDA FAC1_M2
          ADC FAC2_M2
          STA FAC1_M2
          LDA FAC1_M1
          ADC FAC2_M1
          STA FAC1_M1
          JMP AFTF_80
AFTF_70   ADC #1
          ASL FROUND
          ROL FAC1_M4
          ROL FAC1_M3
          ROL FAC1_M2
          ROL FAC1_M1
AFTF_75   BPL AFTF_70
          SEC
          SBC FAC1_EX
          BCS Clear_FAC1
          EOR #$ff
          ADC #1
          STA FAC1_EX
AFTF_80   BCC AFTF_Ret
AFTF_85   INC FAC1_EX
          BEQ Overflow_Error
          ROR FAC1_M1
          ROR FAC1_M2
          ROR FAC1_M3
          ROR FAC1_M4
          ROR FROUND
AFTF_Ret  RTS

; *******************
  Negate_FAC1 ; $8926
; *******************

          LDA FAC1_SI
          EOR #$ff
          STA FAC1_SI

; ****************************
  Negate_FAC1_Mantissa ; $892c
; ****************************

          LDA FAC1_M1
          EOR #$ff
          STA FAC1_M1
          LDA FAC1_M2
          EOR #$ff
          STA FAC1_M2
          LDA FAC1_M3
          EOR #$ff
          STA FAC1_M3
          LDA FAC1_M4
          EOR #$ff
          STA FAC1_M4
          LDA FROUND
          EOR #$ff
          STA FROUND
          INC FROUND
          BNE IFM_Ret

; *************************
  Inc_FAC1_Mantissa ; $894e
; *************************

          INC FAC1_M4
          BNE IFM_Ret
          INC FAC1_M3
          BNE IFM_Ret
          INC FAC1_M2
          BNE IFM_Ret
          INC FAC1_M1
IFM_Ret   RTS

; **********************
  Overflow_Error ; $895d
; **********************

          LDX #15
          JMP Print_Error_X

; ***********************
  FACX_Byte_Shift ; $8962
; ***********************

          LDX #FAC3_M1-1
FBS_10    LDY 4,X
          STY FROUND
          LDY 3,X
          STY 4,X
          LDY 2,X
          STY 3,X
          LDY 1,X
          STY 2,X
          LDY BITS
          STY 1,X

; **********************
  FACX_Bit_Shift ; $8979
; **********************

          ADC #8
          BMI FBS_10
          BEQ FBS_10
          SBC #8
          TAY
          LDA FROUND
          BCS FBS_40
FBS_20    ASL 1,X
          BCC FBS_30
          INC 1,X
FBS_30    ROR 1,X
          ROR 1,X

; *******************
  Rotate_FACX ; $8990
; *******************

          ROR 2,X
          ROR 3,X
          ROR 4,X
          ROR A
          INY
          BNE FBS_20
FBS_40    CLC
          RTS

Real_1    .BYTE $81,$00,$00,$00,$00 ;.REAL $8100000000;    1.00000000000

logcn2    .BYTE $03
          .BYTE $7f,$5e,$56,$cb,$79 ;.REAL $7f5e56cb79;    0.43425594189
          .BYTE $80,$13,$9b,$0b,$64 ;.REAL $80139b0b64;    0.57658454124
          .BYTE $80,$76,$38,$93,$16 ;.REAL $8076389316;    0.96180075919
          .BYTE $82,$38,$aa,$3b,$20 ;.REAL $8238aa3b20;    2.88539007306

Sqrt2half .BYTE $80,$35,$04,$f3,$34 ;.REAL $803504f334;    0.70710678119
Sqrt2     .BYTE $81,$35,$04,$f3,$34 ;.REAL $813504f334;    1.41421356238
Minus0_5  .BYTE $80,$80,$00,$00,$00 ;.REAL $8080000000;   -0.50000000000
Ln2       .BYTE $80,$31,$72,$17,$f8 ;.REAL $80317217f8;    0.69314718060

; ****************
  FUNC_LOG ; $89ca
; ****************

          JSR Test_FAC1_Sign
          BEQ LOG_10
          BPL LOG_20
LOG_10    JMP Error_Illegal_Quantity
LOG_20    LDA FAC1_EX
          SBC #$7f
          PHA
          LDA #$80
          STA FAC1_EX
          LDA #<Sqrt2half
          LDY #>Sqrt2half
          JSR Add_AY_To_FAC1
          LDA #<Sqrt2
          LDY #>Sqrt2
          JSR AY_Div_FAC1
          LDA #<Real_1
          LDY #>Real_1
          JSR FAC1_Minus_AY
          LDA #<logcn2
          LDY #>logcn2
          JSR Series_Evaluation
          LDA #<Minus0_5
          LDY #>Minus0_5
          JSR Add_AY_To_FAC1
          PLA
          JSR Add_A_To_FAC1
          LDA #<Ln2
          LDY #>Ln2

; ***************************
  Multiply_AY_To_FAC1 ; $8a08
; ***************************

          JSR Load_FAC2_From_AY_ROM
          JMP OP_MULT

; ***********************
  Add_0_5_To_FAC1 ; $8a0e
; ***********************

          LDA #<Real_0_5
          LDY #>Real_0_5

; **********************
  Add_AY_To_FAC1 ; $8a12
; **********************

          JSR Load_FAC2_From_AY_ROM
          JMP OP_PLUS

; *********************
  FAC1_Minus_AY ; $8a18
; *********************

          JSR Load_FAC2_From_AY_ROM
          JMP OP_MINUS

; *******************
  AY_Div_FAC1 ; $8a1e
; *******************

          JSR Load_FAC2_From_AY_ROM
          JMP OP_DIV

; ********************
  AY_Mult_FAC1 ; $8a24
; ********************

          JSR Load_FAC2_From_AY_RAM

; ***************
  OP_MULT ; $8a27
; ***************

          BNE MULT_10
          JMP MULT_Ret
MULT_10   JSR Add_Exponents
          LDA #0
          STA FAC3_M1
          STA FAC3_M2
          STA FAC3_M3
          STA FAC3_M4
          LDA FROUND
          JSR Mult_SubB
          LDA FAC1_M4
          JSR Mult_SubA
          LDA FAC1_M3
          JSR Mult_SubA
          LDA FAC1_M2
          JSR Mult_SubB
          LDA FAC1_M1
          JSR Mult_SubB
          JMP DIV_80

; *****************
  Mult_SubA ; $8a55
; *****************

          BNE Mult_SubB       ; do bitwise multiply if A is not zero
          NOP
          JMP FACX_Byte_Shift ; else shift FAC3 right 8 bits

; *****************
  Mult_SubB ; $8a5b
; *****************

          LSR A
          ORA #$80            ; make sure, that A remains not zero
MULT_20   TAY                 ; until 8 MoMe_60 are done
          BCC MULT_30
          CLC
          LDA FAC3_M4
          ADC FAC2_M4
          STA FAC3_M4
          LDA FAC3_M3
          ADC FAC2_M3
          STA FAC3_M3
          LDA FAC3_M2
          ADC FAC2_M2
          STA FAC3_M2
          LDA FAC3_M1
          ADC FAC2_M1
          STA FAC3_M1
MULT_30   ROR FAC3_M1
          ROR FAC3_M2
          ROR FAC3_M3
          ROR FAC3_M4
          ROR FROUND
          TYA
          LSR A
          BNE MULT_20
MULT_Ret  RTS

; *****************************
  Load_FAC2_From_AY_ROM ; $8a89
; *****************************

; Input:  (A/Y) = address of packed floating point value
; Output: FAC2  = read floating point value
;         A     = exponent of FAC1
;         Y     = 0
;         Flags = after loading FAC1 exponent

          STA INDEXA
          STY INDEXA+1
          LDY #4
          LDA (INDEXA),Y
          STA FAC2_M4
          DEY
          LDA (INDEXA),Y
          STA FAC2_M3
          DEY
          LDA (INDEXA),Y
          STA FAC2_M2
          DEY
          LDA (INDEXA),Y      ; bit7 = sign
          STA FAC2_SI         ; transfer sign to FAC2SI bit7
          EOR FAC1_SI         ; EOR with sign of FAC1
          STA STRPTR          ; flag sign comparison
          LDA FAC2_SI         ; load sign/byte 1 of mantissa
          ORA #$80            ; replace sign with 1 (normalize)
          STA FAC2_M1         ; M1 is now in unpacked mode
          DEY                 ; Y = 0
          LDA (INDEXA),Y      ; exponent
          STA FAC2_EX
          LDA FAC1_EX
          RTS

; *****************************
  Load_FAC2_From_AY_RAM ; $8ab4
; *****************************

          STA INDEXA
          STY INDEXA+1
          LDA MMU_CR
          PHA                 ; save bank
          LDY #4
          JSR Get_INDEXA_1
          STA FAC2_M4
          DEY
          JSR Get_INDEXA_1
          STA FAC2_M3
          DEY
          JSR Get_INDEXA_1
          STA FAC2_M2
          DEY
          JSR Get_INDEXA_1    ; bit7 = sign
          STA FAC2_SI         ; transfer sign to FAC2SI bit7
          EOR FAC1_SI         ; EOR with sign of FAC1
          STA STRPTR          ; flag sign comparison
          LDA FAC2_SI         ; load sign/byte 1 of mantissa
          ORA #$80            ; replace sign with 1 (normalize)
          STA FAC2_M1         ; M1 is now in unpacked mode
          DEY                 ; Y = 0
          JSR Get_INDEXA_1    ; exponent
          STA FAC2_EX
          PLA
          STA MMU_CR          ; restore bank
          LDA FAC1_EX
          RTS

; *********************
  Add_Exponents ; $8aec
; *********************

          LDA FAC2_EX
ChFA_10   BEQ ChFA_50         ; -> set result = 0.0
          CLC
          ADC FAC1_EX         ; (exp 1 + exp 2)
          BCC ChFA_20         ; -> no overflow
          BMI ChFA_Err        ; -> overflow
          CLC
          .BYTE $2C ;BIT
ChFA_20   BPL ChFA_50         ; -> underflow
          ADC #$80            ; adjust bias
          STA FAC1_EX         ; exp 1 += exp 2
          BNE ChFA_30
          JMP CF1_20
ChFA_30   LDA STRPTR
          STA FAC1_SI
          RTS

ChFA_40   LDA FAC1_SI         ; sign
          EOR #$ff            ; invert
          BMI ChFA_Err        ; -> error if sign was positive
ChFA_50   PLA
          PLA
          JMP Clear_FAC1      ; FAC1 = 0.0
ChFA_Err  JMP Overflow_Error

; ***************************
  Multiply_FAC1_BY_10 ; $8b17
; ***************************

          JSR FAC1_Round_And_Copy_To_FAC2
          TAX
          BEQ AAD_Ret
          CLC
          ADC #2
          BCS ChFA_Err

; **********************
  Add_And_Double ; $8b22
; **********************

          LDX #0
          STX STRPTR
          JSR AddSub_FAC2_To_FAC1
          INC FAC1_EX
          BEQ ChFA_Err
AAD_Ret   RTS

Real_10   .BYTE $84,$20,$00,$00,$00 ;.REAL $8420000000;   10.00000000000

DIV_ZERO  LDX #$14            ; DIVISION BY ZERO
          JMP Print_Error_X

; *************************
  Divide_FAC1_By_10 ; $8b38
; *************************

          JSR FAC1_Round_And_Copy_To_FAC2
          LDA #<Real_10
          LDY #>Real_10
          LDX #0

; *************************
  Divide_FAC2_By_AY ; $8b41
; *************************

          STX STRPTR
          JSR Load_FAC1_AY
          JMP OP_DIV

; **************************
  AY_Divided_By_FAC1 ; $8b49
; **************************

          JSR Load_FAC2_From_AY_RAM

; **************
  OP_DIV ; $8b4c
; **************

          BEQ DIV_ZERO        ; -> FAC1 was zero
          JSR Round_FAC1
          LDA #0
          SEC
          SBC FAC1_EX
          STA FAC1_EX
          JSR Add_Exponents
          INC FAC1_EX
          BEQ ChFA_Err
          LDX #$fc             ; wrap around index
          LDA #1
DIV_10    LDY FAC2_M1
          CPY FAC1_M1
          BNE DIV_20
          LDY FAC2_M2
          CPY FAC1_M2
          BNE DIV_20
          LDY FAC2_M3
          CPY FAC1_M3
          BNE DIV_20
          LDY FAC2_M4
          CPY FAC1_M4
DIV_20    PHP
          ROL A
          BCC DIV_30
          INX
          STA FAC3_M4,X
          BEQ DIV_60
          BPL DIV_70
          LDA #1
DIV_30    PLP
          BCS DIV_50
DIV_40    ASL FAC2_M4
          ROL FAC2_M3
          ROL FAC2_M2
          ROL FAC2_M1
          BCS DIV_20
          BMI DIV_10
          BPL DIV_20
DIV_50    TAY
          LDA FAC2_M4
          SBC FAC1_M4
          STA FAC2_M4
          LDA FAC2_M3
          SBC FAC1_M3
          STA FAC2_M3
          LDA FAC2_M2
          SBC FAC1_M2
          STA FAC2_M2
          LDA FAC2_M1
          SBC FAC1_M1
          STA FAC2_M1
          TYA
          JMP DIV_40
DIV_60    LDA #$40 ; '@'
          BNE DIV_30
DIV_70    ASL A
          ASL A
          ASL A
          ASL A
          ASL A
          ASL A
          STA FROUND
          PLP
DIV_80    LDA FAC3_M1
          STA FAC1_M1
          LDA FAC3_M2
          STA FAC1_M2
          LDA FAC3_M3
          STA FAC1_M3
          LDA FAC3_M4
          STA FAC1_M4
          JMP Normalise_FAC1

; ********************
  Load_FAC1_AY ; $8bd4
; ********************

          STA INDEXA
          STY INDEXA+1
          LDY #4
          LDA (INDEXA),Y
          STA FAC1_M4
          DEY
          LDA (INDEXA),Y
          STA FAC1_M3
          DEY
          LDA (INDEXA),Y
          STA FAC1_M2
          DEY
          LDA (INDEXA),Y
          STA FAC1_SI
          ORA #$80
          STA FAC1_M1
          DEY                 ; Y = 0
          LDA (INDEXA),Y
          STA FAC1_EX
          STY FROUND          ; FROUND = 0
          RTS

; **********************
  FAC1_To_FACTPB ; $8bf9
; **********************

          LDX #FACTPB
          .BYTE $2C ;BIT

; **********************
  FAC1_To_FACTPA ; $8bfc
; **********************

          LDX #FACTPA
          LDY #0

; ******************
  FAC1_To_XY ; $8c00
; ******************

          JSR Round_FAC1
          STX INDEXA
          STY INDEXA+1
          LDY #4
          LDA FAC1_M4
          STA (INDEXA),Y
          DEY
          LDA FAC1_M3
          STA (INDEXA),Y
          DEY
          LDA FAC1_M2
          STA (INDEXA),Y
          DEY
          LDA FAC1_SI
          ORA #$7f
          AND FAC1_M1
          STA (INDEXA),Y
          DEY
          LDA FAC1_EX
          STA (INDEXA),Y
          STY FROUND
          RTS

; ********************
  FAC2_To_FAC1 ; $8c28
; ********************

          LDA FAC2_SI

; ************************
  ASI_FAC2_To_FAC1 ; $8c2a
; ************************

          STA FAC1_SI
          LDX #5
F2F1_10   LDA FAC2_EX-1,X
          STA FAC1_EX-1,X
          DEX
          BNE F2F1_10
          STX FROUND
          RTS

; ***********************************
  FAC1_Round_And_Copy_To_FAC2 ; $8c38
; ***********************************

          JSR Round_FAC1

; ********************
  FAC1_To_FAC2 ; $8c3b
; ********************

          LDX #6
F1F2_10   LDA FAC1_EX-1,X
          STA FAC2_EX-1,X
          DEX
          BNE F1F2_10
          STX FROUND
F1F2_Ret  RTS

; ******************
  Round_FAC1 ; $8c47
; ******************

          LDA FAC1_EX
          BEQ F1F2_Ret
          ASL FROUND
          BCC F1F2_Ret

; ****************
  Inc_FAC1 ; $8c4f
; ****************

          JSR Inc_FAC1_Mantissa
          BNE F1F2_Ret
          JMP AFTF_85

; **********************
  Test_FAC1_Sign ; $8c57
; **********************

; Output: A =  0 for zero
;         A =  1 for positive number
;         A = -1 for negative number

          LDA FAC1_EX
          BEQ TFS_Ret
TFS_10    LDA FAC1_SI
TFS_20    ROL A
          LDA #-1
          BCS TFS_Ret
          LDA #1
TFS_Ret   RTS

; ****************
  FUNC_SGN ; $8c65
; ****************

          JSR Test_FAC1_Sign

; *****************
  A_To_FAC1 ; $8c68
; *****************

          STA FAC1_M1         ; value in M1
          LDA #0
          STA FAC1_M2         ; clear M2
          LDX #$88            ; exponent for integer in M1
AFACX     LDA FAC1_M1
          EOR #$ff            ; invert number
          ROL A               ; set carry for positive numbers

; ********************
  Word_To_FAC1 ; $8c75
; ********************

          LDA #0              ; clear lower half of mantissa
          STA FAC1_M4
          STA FAC1_M3
IFACX     STX FAC1_EX         ; X to exponent
          STA FROUND          ; clear rounding byte
          STA FAC1_SI         ; clear sign (assume 16 bit unsigned word)
          JMP AFTF_60         ; -> normalize FAC1

; ****************
  FUNC_ABS ; $8c84
; ****************

          LSR FAC1_SI         ; clear FAC1 sign
          RTS

; ***********************
  Compare_AY_FAC1 ; $8c87
; ***********************

          STA INDEXB          ; INDEXB = 1st. = left  operand
          STY INDEXB+1        ; FAC1   = 2nd. = right operand
          LDY #0
          LDA (INDEXB),Y      ; exp 1
          INY                 ; Y = 1
          TAX                 ; X = exp 1
          BEQ Test_FAC1_Sign  ; -> left = 0 : get sign of right
          LDA (INDEXB),Y      ; M1
          EOR FAC1_SI         ; EOR both sign bits
          BMI TFS_10          ; branch on different signs
          CPX FAC1_EX         ; compare exponents
          BNE CAYF_10         ; branch if not equal
          LDA (INDEXB),Y      ; M1
          ORA #$80            ; remove sign, set normalize bit
          CMP FAC1_M1         ; compare M1's
          BNE CAYF_10
          INY                 ; Y = 2
          LDA (INDEXB),Y
          CMP FAC1_M2         ; compare M2's
          BNE CAYF_10
          INY                 ; Y = 3
          LDA (INDEXB),Y
          CMP FAC1_M3         ; compare M3's
          BNE CAYF_10
          INY                 ; Y = 4
          LDA #$7f
          CMP FROUND          ; clear carry for rounding bit set
          LDA (INDEXB),Y
          SBC FAC1_M4         ; compare M4's with borrow
          BEQ FINT_20           ; numbers are equal
CAYF_10   LDA FAC1_SI
          BCC CAYF_20
          EOR #$ff
CAYF_20   JMP TFS_20

; ****************
  FAC1_INT ; $8cc7
; ****************

; Shift FAC1 right until the exponent is at $a0.
; This is the value for which the four mantissa bytes
; represent a 32 bit integer value.

          LDA FAC1_EX
          BEQ INT_0           ; clear all for zero exp
          SEC
          SBC #$a0
          BIT FAC1_SI
          BPL FINT_10
          TAX                 ; save exp
          LDA #$ff
          STA BITS
          JSR Negate_FAC1_Mantissa
          TXA                 ; restore exp
FINT_10   LDX #FAC1_EX
          CMP #$f9
          BPL FINT_30
          JSR FACX_Bit_Shift
          STY BITS
FINT_20   RTS
FINT_30   TAY
          LDA FAC1_SI
          AND #%10000000     ; propagate sign
          LSR FAC1_M1
          ORA FAC1_M1
          STA FAC1_M1
          JSR Rotate_FACX
          STY BITS
          RTS

; ****************
  FUNC_INT ; $8cfb
; ****************

; The BASIC int function is not restricted to the 16 bit
; range of integer variables. Its range is 32 bit.
; INT does not round, it looks for the integer lower or
; equal to the given value. E.g: int(-1.1) results in -2.

          LDA FAC1_EX
          CMP #$a0
          BCS INT_Ret         ; -> already integer
          JSR FAC1_Round_INT  ; -> convert to 32 bit integer
          STY FROUND          ; FROUND = 0
          LDA FAC1_SI
          STY FAC1_SI         ; FAC1_SI = 0
          EOR #$80
          ROL A
          LDA #$a0            ; exp value for 32 bit integer
          STA FAC1_EX
          LDA FAC1_M4
          STA CHARAC
          JMP AFTF_60
INT_0     STA FAC1_M1         ; clear mantissa
          STA FAC1_M2
          STA FAC1_M3
          STA FAC1_M4
          TAY                 ; Y = 0 on exit
INT_Ret   RTS

; *************************
  Read_Real_To_FAC1 ; $8d22
; *************************

; This subroutine parses a string via CHRGET_INDEXA and
; converts it into a floating point value in FAC1.

; Input:  A and flags set from a call to CHRGET

;         TMPVAR   = digits after decimal point
;         TENEXP   = exponent
;         LOWTR    = bit 7 : flag for '.' decimal point
;         DEGREE   = bit 7 : flag for '-' sign

          STX STR_BANK        ; bank for string to read
          LDY #0
          LDX #10
RRTF_10   STY TMPVAR,X        ; clear LOWTR, FAC1, etc.
          DEX
          BPL RRTF_10
          BCC RRTF_16         ; -> numeric
          CMP #'-'
          BNE RRTF_12
          STX DEGREE          ; $ff = flag for - sign
          BEQ RRTF_14         ; branch always
RRTF_12   CMP #'+'            ; skip + sign
          BNE RRTF_18
RRTF_14   JSR CHRGET_INDEXA   ; get next char
RRTF_16   BCC RRTF_42         ; -> numeric
RRTF_18   CMP #'.'            ; decimal point ?
          BEQ RRTF_28         ; -> now the fractional part
          CMP #'E'            ; exponent ?
          BNE RRTF_30
          JSR CHRGET_INDEXA   ; read character of exponent
          BCC RRTF_24         ; -> numeric
          CMP #$ab            ; '-' token
          BEQ RRTF_20
          CMP #'-'
          BEQ RRTF_20
          CMP #$aa            ; '+' token
          BEQ RRTF_22
          CMP #'+'
          BEQ RRTF_22
          BNE RRTF_26         ; always

RRTF_20   ROR LOWTR+1         ; flag negative sign
RRTF_22   JSR CHRGET_INDEXA   ; read character of exponent
RRTF_24   BCC RRTF_50           ; -> numeric
RRTF_26   BIT LOWTR+1
          BPL RRTF_30         ; -> positive exponent
          LDA #0
          SEC
          SBC TENEXP          ; -> negative exponent
          JMP RRTF_32

RRTF_28   ROR LOWTR           ; bit 7 = flag for '.'
          BIT LOWTR
          BVC RRTF_14         ; break if 2nd. dot read
RRTF_30   LDA TENEXP          ; exponent read
RRTF_32   SEC
          SBC TMPVAR          ; minus # of digits after '.'
          STA TENEXP          ; effective exponent
          BEQ RRTF_38         ; -> zero exponent
          BPL RRTF_36         ; -> pos. exponent

RRTF_34   JSR Divide_FAC1_By_10 ; neg. exponent
          INC TENEXP
          BNE RRTF_34
          BEQ RRTF_38

RRTF_36   JSR Multiply_FAC1_BY_10 ; positive exponent
          DEC TENEXP
          BNE RRTF_36
RRTF_38   LDA DEGREE          ; load sign
          BMI RRTF_40         ; -> negate result
          RTS
RRTF_40   JMP OP_NEG
RRTF_42   PHA
          BIT LOWTR
          BPL RRTF_44
          INC TMPVAR
RRTF_44   JSR Multiply_FAC1_BY_10
          PLA
          SEC
          SBC #'0'
          JSR Add_A_To_FAC1
          JMP RRTF_14

; *********************
  Add_A_To_FAC1 ; $8db0
; *********************

          PHA
          JSR FAC1_Round_And_Copy_To_FAC2
          PLA
          JSR A_To_FAC1
          LDA FAC2_SI
          EOR FAC1_SI
          STA STRPTR
          LDX FAC1_EX
          JMP OP_PLUS

; read digits for exponent

RRTF_50   LDA TENEXP          ; exponent so far
          CMP #10             ; alreay two digits ?
          BCC RRTF_52         ; -> OK if less than 10
          LDA #100            ; exponent = 100
          BIT LOWTR+1
          BMI RRTF_58         ; -> negative exponent
          JMP Overflow_Error  ; max value = 37
RRTF_52   ASL A               ; *  2
          ASL A               ; *  4
          CLC
          ADC TENEXP          ; *  5
          ASL A               ; * 10
          CLC
          LDY #0
          STA SYNTMP
          LDA STR_BANK
          BNE RRTF_54
          JSR INDTXT
          JMP RRTF_56
RRTF_54   JSR Get_INDEXA_1
RRTF_56   ADC SYNTMP
          SEC
          SBC #'0'
RRTF_58   STA TENEXP          ; new value for exponent
          JMP RRTF_22

; *********************
  CHRGET_INDEXA ; $8df5
; *********************

          LDA STR_BANK
          BNE CHXA_10
          JMP CHRGET          ; use default for bank 0
CHXA_10   INC INDEXA
          BNE CHRGOT_INDEXA
          INC INDEXA+1

; *********************
  CHRGOT_INDEXA ; $8e03
; *********************

          LDY #0
          JSR Get_INDEXA_1
          CMP #':'
          BCS CHXA_Ret
          CMP #' '
          BEQ CHXA_10
          SEC
          SBC #'0'
          SEC
          SBC #$d0
CHXA_Ret  RTS

R9E9      .BYTE $9b,$3e,$bc,$1f,$fd   ;.REAL $9b3ebc1ffd; 99999999.90625000000
R9E10     .BYTE $9e,$6e,$6b,$27,$fd  ;.REAL $9e6e6b27fd; 999999999.25000000000
R1E10     .BYTE $9e,$6e,$6b,$28,$00 ;.REAL $9e6e6b2800; 1000000000.00000000000

; ***********************
  Print_IN_CURLIN ; $8e26
; ***********************

          JSR B_PRIMM
          .TEXT " IN ",0

; ********************
  Print_CURLIN ; $8e2e
; ********************

          LDA CURLIN+1
          LDX CURLIN

; ************************
  Print_Integer_XA ; $8e32
; ************************

          STA FAC1_M1
          STX FAC1_M2
          LDX #$90            ; exponent for 16 bit integer in M1/M2
          SEC
          JSR Word_To_FAC1
          JSR Format_FAC1_Y
          JMP Print_String

; *******************
  Format_FAC1 ; $8e42
; *******************

          LDY #1              ; start of string storage

; *********************
  Format_FAC1_Y ; $8e44
; *********************

; Format floating point number in FAC1
; The string is stored starting at $ff for Y=0
; and extending into the bottom of the stack

          LDA #' '            ; default for positive number
          BIT FAC1_SI
          BPL FoFa_10
          LDA #'-'            ; sign for negative number
FoFa_10   STA STACK-1,Y        ; store sign character
          STA FAC1_SI         ; clear sign bit
          STY STRNG2          ; save Y
          INY                 ; next string position
          LDA #'0'            ; default for value zero

; if the value is zero, store '0' and finish

          LDX FAC1_EX
          BNE FoFa_12
          JMP FoFa_60

; if the value is less than 1.0, scale it with 1.0e+9
; and store the scaled 10's exponent (-9) in TMPVAR
; this saves 9 iterations

FoFa_12   LDA #0
          CPX #$80            ; exponent > 1.0 ?
          BEQ FoFa_14
          BCS FoFa_16         ; -> OK

FoFa_14   LDA #<R1E10
          LDY #>R1E10
          JSR Multiply_AY_To_FAC1
          LDA #-9
FoFa_16   STA TMPVAR          ; current 10's exponent
FoFa_18   LDA #<R9E10
          LDY #>R9E10
          JSR Compare_AY_FAC1
          BEQ FoFa_28
          BPL FoFa_24

; scale FAC1 up until the number has more than 8 digits

FoFa_20   LDA #<R9E9
          LDY #>R9E9
          JSR Compare_AY_FAC1
          BEQ FoFa_22
          BPL FoFa_26
FoFa_22   JSR Multiply_FAC1_BY_10
          DEC TMPVAR
          BNE FoFa_20

; scale FAC1 down until the number has less than 10 digits

FoFa_24   JSR Divide_FAC1_By_10
          INC TMPVAR          ; increment 10's exponent
          BNE FoFa_18

; scaling is done - now convert the digits before the decimal
; point into a 32 bit integer

FoFa_26   JSR Add_0_5_To_FAC1 ; add 0.5 for rounding
FoFa_28   JSR FAC1_INT        ; convert to integer
          LDX #1
          LDA TMPVAR          ; current 10's exponent
          CLC
          ADC #10             ; exp difference
          BMI FoFa_30         ; value < 1.0
          CMP #11
          BCS FoFa_32
          ADC #$ff
          TAX                 ; X = exp + 9
          LDA #2              ; fixed point
FoFa_30   SEC
FoFa_32   SBC #2
          STA TENEXP          ; exp print = 0 or exp+8
          STX TMPVAR          ; digits before decimal point
          TXA
          BEQ FoFa_34         ; -> if no digits before point
          BPL FoFa_38
FoFa_34   LDY STRNG2
          LDA # '.'
          INY
          STA STACK-1,Y        ; insert decimal point
          TXA
          BEQ FoFa_36
          LDA #'0'
          INY
          STA STACK-1,Y        ; insert '0'
FoFa_36   STY STRNG2
FoFa_38   LDY #0

; ***************************
  Format_Clock_String ; $8ecd
; ***************************

          LDX #$80
FoFa_40   LDA FAC1_M4
          CLC
          ADC Dec_Print_Tab+3,Y
          STA FAC1_M4
          LDA FAC1_M3
          ADC Dec_Print_Tab+2,Y
          STA FAC1_M3
          LDA FAC1_M2
          ADC Dec_Print_Tab+1,Y
          STA FAC1_M2
          LDA FAC1_M1
          ADC Dec_Print_Tab,Y
          STA FAC1_M1
          INX
          BCS FoFa_42
          BPL FoFa_40
          BMI FoFa_44

FoFa_42   BMI FoFa_40
FoFa_44   TXA
          BCC FoFa_46
          EOR #$ff
          ADC #10
FoFa_46   ADC #'0'-1
          INY
          INY
          INY
          INY                 ; Y += 4
          STY VARPNT          ; save index to Dec_Print_Tab
          LDY STRNG2          ; get index to string
          INY
          TAX
          AND #$7f
          STA STACK-1,Y        ; store digit
          DEC TMPVAR          ; # of digits
          BNE FoFa_48         ; -> if not zero
          LDA #'.'
          INY
          STA STACK-1,Y        ; store decimal point
FoFa_48   STY STRNG2          ; save string index
          LDY VARPNT          ; get table index
          TXA
          EOR #$ff
          AND #$80
          TAX
          CPY #$24            ; end of decimal table ?
          BEQ FoFa_50
          CPY #$3c            ; end of jiffy table ?
          BNE FoFa_40

; remove trailing zeroes

FoFa_50   LDY STRNG2
FoFa_52   LDA STACK-1,Y
          DEY
          CMP #'0'
          BEQ FoFa_52
          CMP #'.'
          BEQ FoFa_54
          INY
FoFa_54   LDA #'+'            ; default sign for exponent
          LDX TENEXP
          BEQ FoFa_62
          BPL FoFa_56
          LDA #0
          SEC
          SBC TENEXP
          TAX
          LDA #'-'            ; negative sign for exponent
FoFa_56   STA STACK+1,Y
          LDA #'E'
          STA STACK,Y
          TXA
          LDX #'0'-1
          SEC
FoFa_58   INX
          SBC #10
          BCS FoFa_58
          ADC #'9'+1
          STA STACK+3,Y
          TXA
          STA STACK+2,Y
          LDA #0
          STA STACK+4,Y
          BEQ FoFa_64         ; always

FoFa_60   STA STACK-1,Y
FoFa_62   LDA #0
          STA STACK,Y
FoFa_64   LDA #0
          LDY #1
          RTS

Real_0_5  .BYTE $80,$00,$00,$00,$00 ;.REAL $8000000000;    0.5

; *********************
  Dec_Print_Tab ; $8f7b
; *********************

          .BYTE $fa,$0a,$1f,$00 ; -100000000
          .BYTE $00,$98,$96,$80 ;   10000000
          .BYTE $ff,$f0,$bd,$c0 ;   -1000000
          .BYTE $00,$01,$86,$a0 ;     100000
          .BYTE $ff,$ff,$d8,$f0 ;     -10000
          .BYTE $00,$00,$03,$e8 ;       1000
          .BYTE $ff,$ff,$ff,$9c ;       -100
          .BYTE $00,$00,$00,$0a ;         10
          .BYTE $ff,$ff,$ff,$ff ;         -1

; **********************
 Clock_Print_Tab ; $8f9f
; **********************

          .BYTE $ff,$df,$0a,$80 ;   -2160000
          .BYTE $00,$03,$4b,$c0 ;     216000
          .BYTE $ff,$ff,$73,$60 ;     -36000
          .BYTE $00,$00,$0e,$10 ;       3600
          .BYTE $ff,$ff,$fd,$a8 ;       -600
          .BYTE $00,$00,$00,$3c ;         60

; ****************
  FUNC_SQR ; $8fb7
; ****************

          JSR FAC1_Round_And_Copy_To_FAC2
          LDA #<Real_0_5
          LDY #>Real_0_5
POT_XY    JSR Load_FAC1_AY

; ****************
  OP_POWER ; $8fc1
; ****************

          BEQ FUNC_EXP        ; -> FAC1 == 0
          LDA FAC2_EX
          BNE POW_10
          JMP CF1_10
POW_10    LDX #<GRBPNT
          LDY #>GRBPNT
          JSR FAC1_To_XY
          LDA FAC2_SI
          BPL POW_20
          JSR FUNC_INT
          LDA #<GRBPNT
          LDY #>GRBPNT
          JSR Compare_AY_FAC1
          BNE POW_20
          TYA
          LDY CHARAC
POW_20    JSR ASI_FAC2_To_FAC1
          TYA
          PHA
          JSR FUNC_LOG
          LDA #<GRBPNT
          LDY #>GRBPNT
          JSR AY_Mult_FAC1
          JSR FUNC_EXP
          PLA
          LSR A
          BCC NEG_Ret

; **************
  OP_NEG ; $8ffa
; **************

          LDA FAC1_EX
          BEQ NEG_Ret
          LDA FAC1_SI
          EOR #$ff
          STA FAC1_SI
NEG_Ret   RTS

; *********
  Rev_Log_2
; *********

          .BYTE $81,$38,$aa,$3b,$29 ;REAL $8138aa3b29;    1.44269504072

expcon    .BYTE $07
          .BYTE $71,$34,$58,$3e,$56 ;REAL $7134583e56;    0.00002149876
          .BYTE $74,$16,$7e,$b3,$1b ;REAL $74167eb31b;    0.00014352314
          .BYTE $77,$2f,$ee,$e3,$85 ;REAL $772feee385;    0.00134226348
          .BYTE $7a,$1d,$84,$1c,$2a ;REAL $7a1d841c2a;    0.00961401701
          .BYTE $7c,$63,$59,$58,$0a ;REAL $7c6359580a;    0.05550512686
          .BYTE $7e,$75,$fd,$e7,$c6 ;REAL $7e75fde7c6;    0.24022638460
          .BYTE $80,$31,$72,$18,$10 ;REAL $8031721810;    0.69314718619
          .BYTE $81,$00,$00,$00,$00 ;REAL $8100000000;    1.00000000000

; ****************
  FUNC_EXP ; $9033
; ****************

          LDA #<Rev_Log_2
          LDY #>Rev_Log_2
          JSR Multiply_AY_To_FAC1
          LDA FROUND
          ADC #$50            ; round exponential
          BCC EXP_10
          JSR Inc_FAC1
EXP_10    STA OLDOV
          JSR FAC1_To_FAC2
          LDA FAC1_EX
          CMP #$88
          BCC EXP_30          ; -> value < 128
EXP_20    JSR ChFA_40         ; FAC1 = 0.0 for tiny values
EXP_30    JSR FUNC_INT        ; convert to integer
          LDA CHARAC
          CLC
          ADC #$81
          BEQ EXP_20
          SEC
          SBC #1
          PHA
          LDX #5
EXP_40    LDA FAC2_EX,X       ; FAC1 <-> FAC2
          LDY FAC1_EX,X
          STA FAC1_EX,X
          STY FAC2_EX,X
          DEX
          BPL EXP_40
          LDA OLDOV
          STA FROUND
          JSR OP_MINUS
          JSR OP_NEG
          LDA #<expcon
          LDY #>expcon
          JSR Eval_Series_AY
          LDA #0
          STA STRPTR
          PLA
          JSR ChFA_10         ; do not JMP! (may return with PLA PLA)
          RTS

; *************************
  Series_Evaluation ; $9086
; *************************

          STA STRNG2
          STY STRNG2+1
          JSR FAC1_To_FACTPA
          LDA #FACTPA
          JSR AY_Mult_FAC1
          JSR Eval_Series
          LDA #<FACTPA
          LDY #>FACTPA
          JMP AY_Mult_FAC1

; **********************
  Eval_Series_AY ; $909c
; **********************

          STA STRNG2
          STY STRNG2+1

; *******************
  Eval_Series ; $90a0
; *******************

          JSR FAC1_To_FACTPB
          LDA (STRNG2),Y
          STA DEGREE
          LDY STRNG2
          INY
          TYA
          BNE EvSe_10
          INC STRNG2+1
EvSe_10   STA STRNG2
          LDY STRNG2+1
EvSe_20   JSR Multiply_AY_To_FAC1
          LDA STRNG2
          LDY STRNG2+1
          CLC
          ADC #5              ; advance polynomial pointer
          BCC EvSe_30
          INY
EvSe_30   STA STRNG2
          STY STRNG2+1
          JSR Add_AY_To_FAC1
          LDA #<FACTPB
          LDY #>FACTPB
          DEC DEGREE
          BNE EvSe_20
          RTS

; **********************
  Break_On_Error ; $90d0
; **********************

          TAX
          BNE BOE_Err
Break_Err LDX #$1e            ; BREAK
BOE_Err   JMP Print_Error_X

; **************
  B_OPEN ; $90d8
; **************

          JSR Map_IO
          JSR K_OPEN
          RTS

; **************
  CHROUT ; $90df
; **************

          JSR B_BSOUT
          BCS Break_On_Error
          RTS

; *************
  CHRIN ; $90e5
; *************

          JSR B_BASIN
          BCS Break_On_Error
          RTS

; ***************
  B_CKOUT ; $90eb
; ***************

          PHA
          JSR Map_IO
          JSR K_CKOUT
          JSR Invalidate_Disk_Status
          TAX
          PLA
          BCC BCOUT_Ret
          TXA
          BCS Break_On_Error
BCOUT_Ret RTS

; ***************
  B_CHKIN ; $90fd
; ***************

          JSR Map_IO
          JSR K_CHKIN
          JSR Invalidate_Disk_Status
          BCS Break_On_Error
          RTS

; ***************
  B_GETIN ; $9109
; ***************

          JSR Map_IO
          JSR K_GETIN
          BCS Break_Err
          RTS

; ******************
  BASIC_SAVE ; $9112
; ******************

          JSR Load_Save_Parameter
SAVE_10   LDX TEXT_TOP
          LDY TEXT_TOP+1
          LDA #TXTTAB         ; address of start address
SAVE_20   JSR Map_IO
          JSR K_SAVESP
          JSR Invalidate_Disk_Status
          BCS Break_On_Error
          RTS

; ********************
  BASIC_VERIFY ; $9129
; ********************

          LDA #1
          .byte $2c ;BIT

; ******************
  BASIC_LOAD ; $912c
; ******************

          LDA #0              ; 0 = LOAD mode
          STA B_VERCK         ; set LOAD or VERIFY flag
          JSR Load_Save_Parameter

; **************************
  LOAD_Parameter_Set ; $9133
; **************************

          JSR Map_IO
          LDA B_VERCK         ; LOAD (0) or VERIFY (1)
          LDX TXTTAB
          LDY TXTTAB+1
          JSR K_LOADSP        ; Kernel load routine
          PHP                 ; push status
          JSR Invalidate_Disk_Status
          PLP                 ; pull status
          BCS CLOSE_Err           ; -> load error
          LDA B_VERCK
          BEQ LPS_10          ; -> LOAD
          LDX #$1c            ; VERIFY
          JSR B_READST
          AND #%00010000     ; and VERIFY bit
          BNE LPS_20          ; -> verify error
          BIT RUNMOD
          BMI LPS_Ret         ; -> running
          JSR B_PRIMM         ; stopped
          .TEXT "\rOK\r",0
LPS_Ret   RTS

LPS_10    JSR B_READST
          AND #%10111111     ; test all but EOI (but 6)
          BEQ LPS_30
LPS_Err   LDX #$1d            ; LOAD
LPS_20    JMP Print_Error_X

LPS_30    STX TEXT_TOP        ; store load end address
          STY TEXT_TOP+1
          BIT RUNMOD
          BMI LPS_40          ; -> RUN [line]
          BVS LPS_Ret         ; -> RUN <filename>
          JSR Print_Ready
          JSR Relink
          JSR Reset_BASIC_Execution
          JMP BAER_70
LPS_40    JSR Reset_TXTPTR
          JSR Relink
          JMP ClrB_20

; ******************
  BASIC_OPEN ; $918d
; ******************

          JSR Get_Open_Close_Parameter
          CLC
          JSR B_OPEN
          JSR Invalidate_Disk_Status
          BCS CLOSE_Err
          RTS

; *******************
  BASIC_CLOSE ; $919a
; *******************

          JSR Get_Open_Close_Parameter
          JSR Map_IO
          LDA FORPNT
          CLC
          JSR B_CLOSE
          JSR Invalidate_Disk_Status
          BCC LPS_Ret
CLOSE_Err JMP Break_On_Error

; ***************************
  Load_Save_Parameter ; $91ae
; ***************************

          LDA #0
          JSR B_SETNAM        ; clear filename
          LDX #1              ; default unit = 1 tape
          LDY #0              ; default SA = 0
          JSR B_SETLFS        ; LA=0, FA=1, SA=0
          JSR B_SETBNK        ; bank = 0
          JSR CHRGOT_Or_BREAK ; more parameter ?
          JSR Get_Filename    ; read and store filename
          JSR CHRGOT_Or_BREAK ; more parameter ?
          JSR Comma_Byte      ; read unit
          LDY #0              ; Y = 0
          STX FORPNT          ; store unit
          JSR B_SETLFS        ; FA=X, SA=0
          JSR CHRGOT_Or_BREAK ; more parameter ?
          JSR Comma_Byte      ; read EOT parameter
          TXA                 ; A = EOT
          TAY                 ; Y = EOT
          LDX FORPNT          ; X = FA
          JMP B_SETLFS        ; LA=A, FA=X, SA=Y

; ******************
  Comma_Byte ; $91dd
; ******************

          JSR Need_Comma_And_Byte
          JMP Get_Byte_Var

; ***********************
  CHRGOT_Or_BREAK ; $91e3
; ***********************

          JSR CHRGOT
          BNE COB_Ret
          PLA
          PLA
COB_Ret   RTS

; ***************************
  Need_Comma_And_Byte ; $91eb
; ***************************

          JSR Need_Comma

; *****************
  Need_Byte ; $91ee
; *****************

          JSR CHRGOT
          BNE COB_Ret
          JMP SYNTAX_ERROR

; ********************************
  Get_Open_Close_Parameter ; $91f6
; ********************************

          LDA #0
          LDX #1
          JSR B_SETBNK        ; bank = 0
          JSR B_SETNAM        ; clear filename
          JSR Need_Byte       ; assert more
          JSR Get_Byte_Var    ; get logical address
          STX FORPNT          ; save it
          TXA                 ; A = LA
          LDX #1              ; X = FA = 1
          LDY #0              ; Y = SA = 0
          JSR B_SETLFS        ; set defaults
          JSR CHRGOT_Or_BREAK ; more ?
          JSR Comma_Byte      ; get unit
          STX FORPNT+1        ; save it
          LDY #0              ; Y = SA = 0
          LDA FORPNT          ; A = LA
          CPX #3              ; unit < 3 ?
          BCC GOCP_10         ; -> OK
          DEY                 ; SA = 255
GOCP_10   JSR B_SETLFS        ; set parameter
          JSR CHRGOT_Or_BREAK ; more ?
          JSR Comma_Byte      ; get SA
          TXA                 ; A = SA
          TAY                 ; Y = SA
          LDX FORPNT+1        ; X = FA
          LDA FORPNT          ; A = LA
          JSR B_SETLFS        ; set parameter
          JSR CHRGOT_Or_BREAK ; more ?
          JSR Need_Comma_And_Byte

; ********************
  Get_Filename ; $9239
; ********************

          JSR Eval_String     ; read filename
          LDX INDEXA          ; fn address low
          LDY INDEXA+1        ; fn address high
          JMP B_SETNAM        ; declare filename

; ******************************
  Invalidate_Disk_Status ; $9243
; ******************************

          PHP
          PHA
          LDA FA
          CMP #4
          BCC IDS_10
          JSR Free_DOS_Status_String
IDS_10    PLA
          PLP
          RTS

; ****************
  B_READST ; $9251
; ****************

          JSR Map_IO          ; not needed
          JMP K_READST

; ****************
  B_SETLFS ; $9257
; ****************

          JSR Map_IO          ; not needed
          JMP K_SETLFS

; ****************
  B_SETNAM ; $925d
; ****************

          JSR Map_IO          ; not needed
          JMP K_SETNAM

; ***************
  B_BASIN ; $9263
; ***************

          JSR Map_IO
          JMP K_BASIN

; ***************
  B_BSOUT ; $9269
; ***************

          JSR Map_IO
          JMP K_BSOUT

; ***************
  B_CLRCH ; $926f
; ***************

          JSR Map_IO
          JMP K_CLRCH

; ***************
  B_CLOSE ; $9275
; ***************

          JSR Map_IO
          JMP K_CLOSE

; ***************
  B_CLALL ; $927b
; ***************

          JSR Map_IO
          JMP K_CLALL

; ***************
  B_PRIMM ; $9281
; ***************

          JSR Map_IO
          JMP K_PRIMM

; ****************
  B_SETBNK ; $9287
; ****************

          JSR Map_IO
          JMP K_SETBNK

; **************
  B_PLOT ; $928d
; **************

          STA MMU_LCRC
          JMP K_PLOT

; **************
  B_STOP ; $9293
; **************

          JSR Map_IO
          JMP K_STOP

; *****************************
  Allocate_String_Space ; $9299
; *****************************

; Input:  A = length of string

; Input:  A = length of string
;         X = address low
;         Y = address high

          LSR GARBFL          ; clear bit 7 of GARBFL
ASS_10    TAX                 ; string length
          BEQ ASS_50          ; 0 -> nothing to do
          PHA                 ; save length
          LDA FRETOP
          SEC
          SBC #2              ; subtract 2 for back reference
          LDY FRETOP+1
          BCS ASS_20
          DEY
ASS_20    STA INDEXA          ; INDEXA = FRETOP - 2
          STY INDEXA+1
          TXA
          EOR #%11111111     ; negate
          SEC
          ADC INDEXA          ; subtract length
          BCS ASS_30
          DEY
ASS_30    CPY STREND+1        ; A/Y = FRETOP - length - 2
          BCC ASS_60          ; A/Y < STREND -> garbage collection
          BNE ASS_40
          CMP STREND
          BCC ASS_60          ; A/Y < STREND -> garbage collection
ASS_40    STA FRESPC
          STY FRESPC+1        ; FRESPC = FRETOP - length - 2
          LDY #1
          LDA #$ff
          STA MMU_LCRD
          STA (INDEXA),Y      ; mark as unassigned
          DEY                 ; Y = 0
          PLA                 ; length
          STA (INDEXA),Y      ; store length
          LDX FRESPC
          LDY FRESPC+1
          STX FRETOP
          STY FRETOP+1        ; FRETOP = FRESPC
ASS_50    RTS
ASS_60    LDA GARBFL
          BMI ASS_Err         ; 2nd. attempt -> OOM
          JSR Garbage_Collection
          SEC
          ROR GARBFL          ; set flag: collection was done
          PLA                 ; pull length
          BNE ASS_10          ; branch always
ASS_Err   JMP OOM_Error

; **************************
  Garbage_Collection ; $92ea
; **************************

; Input:  FRETOP = old lower boundary of string RAM
; Output: FRETOP = new lower boundary of string RAM

; Used:   FRESP  = current lower boundary
;         GRBPNT = current string old address
;         LOWTR  = current string new address
;         FACTPB = current trailer
;         INDEXA = current descriptor

; update back references from string descriptors on stack

          LDX TEMPPT          ; descriptor stack pointer
GaCo_10   CPX #TEMPST         ; start of stack ?
          BEQ GaCo_15         ; -> empty stack
          JSR Trailer_Address
          BEQ GaCo_10         ; zero length -> loop
          TXA                 ; A = stack pointer
          LDY #0
          STA MMU_LCRD
          STA (FACTPB),Y      ; back reference low
          TYA
          INY                 ; Y = 1
          STA (FACTPB),Y      ; back reference high
          BNE GaCo_10         ; always

GaCo_15   LDY #0
          STY ARYPNT          ; ARYPNT = 0
          LDX MEMSIZ
          LDY MEMSIZ+1
          STX LOWTR           ; LOWTR  = MEMSIZ
          STX GRBPNT          ; GRBPNT = MEMSIZ
          STX FRESPC          ; FRESPC = MEMSIZ
          STY LOWTR+1
          STY GRBPNT+1
          STY FRESPC+1
          TXA

GaCo_20   JSR Invalid_String  ; breaks out after reaching FRETOP
          BNE GaCo_30         ; -> string is valid

GaCo_25   DEY
          JSR GRBPNT_from_Bank_1_Copy ; A = length
          JSR GRBPNT_Minus_A          ; GRBPNT -= length
          SEC
          ROR ARYPNT          ; set flag
          BNE GaCo_20         ; always

GaCo_30   BIT ARYPNT
          BPL GaCo_50         ; -> no gap so far
          LDX #0
          STX ARYPNT          ; reset flag
          LDA #2              ; obsolete
GaCo_35   LDY #1
          JSR GRBPNT_from_Bank_1_Copy
          STA (LOWTR),Y
          DEY                 ; Y = 0
          JSR GRBPNT_from_Bank_1_Copy
          STA (LOWTR),Y       ; LOWTR = string address
          JSR Get_INDEXA_1    ; A = length
          TAX                 ; X = length
          JSR LOWTR_Minus_A
          STA FRESPC
          STY FRESPC+1        ; update FRESPC
          TXA                 ; A = length
          JSR GRBPNT_Minus_A  ; GRBPNT -= length
          TXA
          TAY

; copy string from old position to new one

GaCo_40   DEY
          JSR GRBPNT_from_Bank_1_Copy
          STA (LOWTR),Y
          DEX                 ; decrement string length
          BNE GaCo_40

; update descriptor

          LDY #2
GaCo_45   LDA TENEXP,Y
          STA (INDEXA),Y
          DEY
          BNE GaCo_45

          LDA GRBPNT
          LDY GRBPNT+1
          JSR Invalid_String
          BEQ GaCo_25
          BNE GaCo_35

GaCo_50   LDY #0
          JSR Get_INDEXA_1
          TAX
          JSR LOWTR_Minus_A
          STA FRESPC
          STY FRESPC+1        ; FRESPC = last found valid string
          TXA
          JSR GRBPNT_Minus_A
          JMP GaCo_20

; **********************
  Invalid_String ; $9383
; **********************

          CPY FRETOP+1
          BCC InvS_40         ; -> not in string RAM
          BNE InvS_10
          CMP FRETOP
          BEQ InvS_40         ; -> not in string RAM
          BCC InvS_40         ; -> not in string RAM

; string is located in string RAM

InvS_10   BIT ARYPNT
          BMI InvS_20
          LDA #2
          JSR LOWTR_Minus_A
InvS_20   LDA #2
          JSR GRBPNT_Minus_A
          LDY #1
          JSR GRBPNT_from_Bank_1_Copy
          CMP #$ff
          BNE InvS_30
          RTS                 ; return with Z=1
InvS_30   JSR GRBPNT_from_Bank_1_Copy
          STA INDEXA,Y
          DEY
          BPL InvS_30
          RTS                 ; return with Z=0

; scan strings from string descriptor stack

InvS_40   LDX TEMPPT
InvS_50   CPX #TEMPST
          BEQ InvS_60
          JSR Trailer_Address
          BEQ InvS_50
          LDY #0
          STA (FACTPB),Y      ; store length
          INY                 ; Y = 1
          LDA #$ff
          STA (FACTPB),Y      ; mark as invalid
          BNE InvS_50         ; always

InvS_60   PLA
          PLA                 ; remove return address
          LDA FRESPC
          LDY FRESPC+1
          STA FRETOP          ; FRETOP = FRESPC
          STY FRETOP+1
          RTS

; **********************
  GRBPNT_Minus_A ; $93d2
; **********************

          EOR #$ff            ; negate
          SEC
          ADC GRBPNT
          LDY GRBPNT+1
          BCS GMA_10
          DEY
GMA_10    STA GRBPNT
          STY GRBPNT+1
          RTS

; *********************
  LOWTR_Minus_A ; $93e1
; *********************

          EOR #$ff            ; negate
          SEC
          ADC LOWTR
          LDY LOWTR+1
          BCS LMA_10
          DEY
LMA_10    STA LOWTR
          STY LOWTR+1
          RTS

; ***********************
  Trailer_Address ; $93f0
; ***********************

          DEX
          LDA 0,X             ; string address high
          STA FACTPB+1
          DEX
          LDA 0,X             ; string address low
          STA FACTPB
          DEX
          LDA 0,X             ; string length
          PHA                 ; push length
          CLC
          ADC FACTPB
          STA FACTPB
          BCC TrAd_10
          INC FACTPB+1        ; FACTPB = string address + length
TrAd_10   PLA                 ; pull length (set flags)
          RTS

; ****************
  FUNC_COS ; $9409
; ****************

          LDA #<PI_Half
          LDY #>PI_Half
          JSR Add_AY_To_FAC1

; ****************
  FUNC_SIN ; $9410
; ****************

          JSR FAC1_Round_And_Copy_To_FAC2
          LDA #<Two_PI
          LDY #>Two_PI
          LDX FAC2_SI
          JSR Divide_FAC2_By_AY ; arg / (2 Pi)
          JSR FAC1_Round_And_Copy_To_FAC2
          JSR FUNC_INT
          LDA #0
          STA STRPTR
          JSR OP_MINUS
          LDA #<Real_0_25
          LDY #>Real_0_25
          JSR FAC1_Minus_AY
          LDA FAC1_SI
          PHA
          BPL SIN_10
          JSR Add_0_5_To_FAC1
          LDA FAC1_SI
          BMI SIN_20
          LDA TANSGN
          EOR #$ff
          STA TANSGN
SIN_10    JSR OP_NEG
SIN_20    LDA #<Real_0_25
          LDY #>Real_0_25
          JSR Add_AY_To_FAC1
          PLA
          BPL SIN_30
          JSR OP_NEG
SIN_30    LDA #<VAR_SIN
          LDY #>VAR_SIN
          JMP Series_Evaluation

; ****************
  FUNC_TAN ; $9459
; ****************

          JSR FAC1_To_FACTPA
          LDA #0
          STA TANSGN
          JSR FUNC_SIN
          LDX #<GRBPNT
          LDY #>GRBPNT
          JSR FAC1_To_XY
          LDA #<FACTPA
          LDY #>FACTPA
          JSR Load_FAC1_AY
          LDA #0
          STA FAC1_SI
          LDA TANSGN
          JSR TAN_10
          LDA #<GRBPNT
          LDY #>GRBPNT
          JMP AY_Divided_By_FAC1

; **************
  TAN_10 ; $9481
; **************

          PHA
          JMP SIN_10

PI_Half   .BYTE $81,$49,$0f,$da,$a2 ;.REAL $81490fdaa2;    1.57079632673
Two_PI    .BYTE $83,$49,$0f,$da,$a2 ;.REAL $83490fdaa2;    6.28318530694
Real_0_25 .BYTE $7f,$00,$00,$00,$00 ;.REAL $7f00000000;    0.25000000000

VAR_SIN   .BYTE $05
          .BYTE $84,$e6,$1a,$2d,$1b ;.REAL $84e61a2d1b;  -14.38139067218
          .BYTE $86,$28,$07,$fb,$f8 ;.REAL $862807fbf8;   42.00779712200
          .BYTE $87,$99,$68,$89,$01 ;.REAL $8799688901;  -76.70417025685
          .BYTE $87,$23,$35,$df,$e1 ;.REAL $872335dfe1;   81.60522368550
          .BYTE $86,$a5,$5d,$e7,$28 ;.REAL $86a55de728;  -41.34170210361
          .BYTE $83,$49,$0f,$da,$a2 ;.REAL $83490fdaa2;    6.28318530694

; ****************
  FUNC_ATN ; $94b3
; ****************

          LDA FAC1_SI
          PHA
          BPL ATN_10
          JSR OP_NEG
ATN_10    LDA FAC1_EX
          PHA
          CMP #$81
          BCC ATN_20
          LDA #<Real_1
          LDY #>Real_1
          JSR AY_Div_FAC1
ATN_20    LDA #<VAR_ATN
          LDY #>VAR_ATN
          JSR Series_Evaluation
          PLA
          CMP #$81
          BCC ATN_30
          LDA #<PI_Half
          LDY #>PI_Half
          JSR FAC1_Minus_AY
ATN_30    PLA
          BPL ATN_Ret
          JMP OP_NEG
ATN_Ret   RTS

; ***************
  VAR_ATN ; $94e3
; ***************

          .BYTE $0b
          .BYTE $76,$b3,$83,$bd,$d3 ;.REAL $76b383bdd3;   -0.00068479391
          .BYTE $79,$1e,$f4,$a6,$f5 ;.REAL $791ef4a6f5;    0.00485094216
          .BYTE $7b,$83,$fc,$b0,$10 ;.REAL $7b83fcb010;   -0.01611170184
          .BYTE $7c,$0c,$1f,$67,$ca ;.REAL $7c0c1f67ca;    0.03420963805
          .BYTE $7c,$de,$53,$cb,$c1 ;.REAL $7cde53cbc1;   -0.05427913276
          .BYTE $7d,$14,$64,$70,$4c ;.REAL $7d1464704c;    0.07245719654
          .BYTE $7d,$b7,$ea,$51,$7a ;.REAL $7db7ea517a;   -0.08980239538
          .BYTE $7d,$63,$30,$88,$7e ;.REAL $7d6330887e;    0.11093241343
          .BYTE $7e,$92,$44,$99,$3a ;.REAL $7e9244993a;   -0.14283980767
          .BYTE $7e,$4c,$cc,$91,$c7 ;.REAL $7e4ccc91c7;    0.19999912049
          .BYTE $7f,$aa,$aa,$aa,$13 ;.REAL $7faaaaaa13;   -0.33333331568
          .BYTE $81,$00,$00,$00,$00 ;.REAL $8100000000;    1.00000000000

; *******************
  PRINT_USING ; $9520
; *******************

          LDX #$ff
          STX ENDFD
          JSR CHRGET
          JSR Eval_Expression
          JSR Need_String     ; get using string
          LDA FAC1_M3
          PHA
          LDA FAC1_M4
          PHA                 ; push using string address
          LDY #2
PRUS_10   JSR Get_FAC1_M3_1
          DEY
          STA FNDPNT,Y        ; FNDPNT = using descriptor
          BNE PRUS_10

          JSR Get_FAC1_M3_1
          STA LFOR            ; length of using string
          TAY
          BEQ PRUS_20         ; -> error:  empty using string

; look for '#' in using string

PRUS_15   DEY
          JSR FNDPNT_from_Bank_1
          CMP #'#'            ; digit
          BEQ PRUS_25
          TYA
          BNE PRUS_15
PRUS_20   JMP SYNTAX_ERROR

PRUS_25   LDA #';'
PRUS_30   JSR Need_A
          STY TEMP_A
          STY BNR
          JSR Eval_Expression
          BIT VALTYP
          BPL PRUS_65
          JSR Init_Using
          JSR Analyse_Using
          LDX CHSN
          BEQ PRUS_40
          LDX #0
          SEC
          LDA CFORM
          SBC KEYSIZ
          BCC PRUS_40
          LDX #'='
          CPX CHSN
          BNE PRUS_35
          LSR A
          ADC #0
PRUS_35   TAX
PRUS_40   LDY #0
PRUS_45   TXA
          BEQ PRUS_55
          DEX
PRUS_50   LDA #' '
          BNE PRUS_60         ; always

PRUS_55   CPY KEYSIZ
          BCS PRUS_50
          JSR Get_INDEXA_1
          INY
PRUS_60   JSR Chrout_Using
          BNE PRUS_45
          BEQ PRUS_85

PRUS_65   JSR Format_FAC1
          LDY #$ff
PRUS_70   INY
          LDA STACK,Y
          BNE PRUS_70
          TYA
          JSR Allocate_String_A
          LDY #0
          STA MMU_LCRD
PRUS_75   LDA STACK,Y
          BEQ PRUS_80
          STA (FAC1_M1),Y
          INY
          BNE PRUS_75
PRUS_80   JSR Push_String_Descriptor
          JSR Init_Using
          JSR Print_Formatted
PRUS_85   JSR CHRGOT
          CMP #','
          BEQ PRUS_30
          SEC
          ROR TEMP_A
          JSR Analyse_Using
          PLA
          TAY
          PLA
          JSR Free_String_AY
          JSR CHRGOT
          CMP #';'
          BEQ PRUS_90
          JMP Print_CR
PRUS_90   JMP CHRGET

; ***********************
  Print_Formatted ; $95e7
; ***********************

; STACK   has a number printed in standard format
; Y       read  index to STACK - standard number format
; X       write index to STACK - formatted number

; Input:  A=0 X=0 Y=0

          STA MMU_LCRC        ; bank = 14
          LDA PU_FILL
          STA BLFD
          LDA #$ff
PrFo_10   STA SNO             ; handle negative sign
          JMP PrFo_20

PrFo_15   STX DOSFLA          ; clear bit 7: decimal point present

PrFo_20   CPY KEYSIZ
          BEQ PrFo_35
          LDA STACK,Y         ; load next character
          INY                 ; increment index
          CMP #' '            ; blank ?
          BEQ PrFo_20         ; -> skip
          CMP #'-'            ; minus sign ?
          BEQ PrFo_10         ; -> store it in SNO
          CMP #'.'            ; decimal point ?
          BEQ PrFo_15         ; store X in DOSFLA
          CMP #'E'            ; exponent ?
          BEQ PrFo_25         ; -> look for exponent sign
          STA STACK,X         ; copy to result
          STX ENR             ; save X index
          INX                 ; increment write position
          BIT DOSFLA
          BPL PrFo_20         ; ->loop
          INC VN
          JMP PrFo_20

PrFo_25   LDA STACK,Y         ; load char after 'E'
          CMP #'-'            ; negative exponent ?
          BNE PrFo_30         ; -> no
          ROR USGN            ; set bit 7 in flag USGN
PrFo_30   INY                 ; position after exponent sign
          STY UEXP            ; store index to exponent value

PrFo_35   LDA DOSFLA          ; decimal point there ?
          BPL PrFo_40         ; -> yes
          STX DOSFLA          ; add decimal point to end of number

PrFo_40   JSR Analyse_Using
          LDA VF
          CMP #$ff
          BEQ PrFo_50
          LDA FESP
          BEQ PrFo_70
          LDA UEXP
          BNE PrFo_45
          LDX ENR
          JSR Print_Using_Exp
          DEC STACK+2,X
          INX
          STX UEXP
          JSR Check_Zeroes
          BEQ PrFo_65
PrFo_45   LDY POSP
          BNE PrFo_60
          LDY SNO
          BMI PrFo_60
          LDA VF
PrFo_50   BEQ PrFo_82
          DEC VF
          BNE PrFo_55
          LDA NF
          BEQ PrFo_82
PrFo_55   INC SWE
PrFo_60   JSR Shift_Point
          JSR Using_Round
          JSR Shift_Point
PrFo_65   JMP Output_Formatted
PrFo_70   LDY UEXP
          BEQ PrFo_74
          STA KEYSIZ
          SEC
          ROR ETOF
          LDY DOSFLA
          LDA USGN
          BPL PrFo_72
          JSR ShPo_45
          JMP PrFo_76
PrFo_72   JSR ShPo_20
PrFo_74   LDY DOSFLA
          BEQ PrFo_76
          JSR Leading_Zero
          BEQ PrFo_78
PrFo_76   JSR Using_Round
          JMP PrFo_80
PrFo_78   DEC VN
PrFo_80   SEC
          LDA VF
          SBC VN
          BCC PrFo_82
          STA SWE
          LDY POSP
          BNE PrFo_86
          LDY SNO
          BMI PrFo_86
          TAY
          BEQ PrFo_82
          DEY
          BNE PrFo_88
          LDA NF
          ORA VN
          BNE PrFo_65
PrFo_82   LDA #'*'
PrFo_84   JSR Chrout_Using
          BNE PrFo_84
          RTS
PrFo_86   TAY
          BEQ PrFo_65
PrFo_88   LDA VN
          BNE PrFo_65
          DEC SWE
          INC TEMP_A
          JMP PrFo_65

; *******************
  Shift_Point ; $96ee
; *******************

          SEC
          LDA VF              ; chars before point
          SBC VN              ; minus digits before point
          BEQ ShPo_Ret
          LDY DOSFLA          ; point position
          BCC ShPo_25         ; -> more digits than chars
          STA KEYSIZ          ; chars - digits
ShPo_10   CPY ENR             ; at end ?
          BEQ ShPo_15         ; -> yes
          BCS ShPo_17           ; -> Y is beyond
ShPo_15   INY                 ; Y = after point
ShPo_17   INC VN              ; inc digits before point

; ***************
  ShPo_20 ; $9708
; ***************

          JSR Adjust_PU_Exp   ; Format exponent
          DEC KEYSIZ
          BNE ShPo_10         ; loop
          BEQ ShPo_50         ; -> finish

ShPo_25   EOR #$ff
          ADC #1
          STA KEYSIZ          ; KEYSIZ = -A
ShPo_30   CPY BNR             ; Y = at begin ?
          BEQ ShPo_35         ; ->
          DEY                 ; go backwards
          DEC VN              ; decrement chars after point
          JMP ShPo_40
ShPo_35   INC TEMP_A
ShPo_40   LDA #$80

; ***************
  ShPo_45 ; $9727
; ***************

          JSR Adjust_PU_Exp_A
          DEC KEYSIZ
          BNE ShPo_30
ShPo_50   STY DOSFLA
ShPo_Ret  RTS

; ******************
  Toggle_0_9 ; $9731
; ******************

          BNE APE_30
          EOR #9              ; '0' -> '9' or '9' -> '0'
          STA STACK,X
          DEX
          CPX UEXP
          RTS

; *********************
  Adjust_PU_Exp ; $973d
; *********************

          LDA #0

; ***********************
  Adjust_PU_Exp_A ; $973f
; ***********************

          LDX UEXP
          INX
          BIT ETOF
          BMI APE_20
          EOR USGN
          BEQ APE_20
APE_10    JSR Inc_Digit_X
          JSR Toggle_0_9
          BCS APE_10
          JMP Overflow_Error
APE_20    LDA STACK,X
          DEC STACK,X
          CMP #'0'
          JSR Toggle_0_9
          BCS APE_20
          BIT ETOF
          BPL APE_40
          STY DOSFLA
APE_30    PLA
          PLA
          RTS
APE_40    LDA USGN
          EOR #$80

; ***********************
  Print_Using_Exp ; $9774
; ***********************

          STA USGN
          LDA #'0'
          STA STACK+1,X
          LDA #'1'
          STA STACK+2,X
          RTS

; *******************
  Inc_Digit_X ; $9782
; *******************

          LDA STACK,X
          INC STACK,X
          CMP #'9'
          RTS

; *******************
  Inc_Using_Y ; $978b
; *******************

          CLC
          INY
          BEQ IUY_10
          CPY LFOR
          BCC IUY_20
IUY_10    LDY TEMP_A
          BNE APE_30
IUY_20    JSR FNDPNT_from_Bank_1
          INC CFORM
          RTS

; ******************
  Init_Using ; $979f
; ******************

; Initialize variables for formatted printing

; Output: A=0 X=0 Y=0

          JSR Free_String_FAC1
          STA KEYSIZ
          LDX #10
          LDA #0
InUs_10   STA SWE,X
          DEX
          BPL InUs_10
          STX FLAG            ; = $ff
          STX DOSFLA          ; = $ff
          STX DOLR            ; = $ff
          TAX
          TAY
          RTS

; *******************
  Using_Round ; $97b9
; *******************

          CLC
          LDA DOSFLA
          ADC NF
          BCS UsRo_Ret
          SEC
          SBC TEMP_A
          BCC UsRo_Ret
          CMP ENR
          BEQ UsRo_10
          BCS UsRo_Ret
UsRo_10   CMP BNR
          BCC UsRo_Ret
          TAX
          LDA STACK,X         ; char after last printable
          CMP #'5'            ; less 5 ?
          BCC UsRo_Ret        ; -> cut off
UsRo_20   CPX BNR             ; at begin ?
          BEQ UsRo_30         ; -> store 1
          DEX                 ; X = last printable position
          JSR Inc_Digit_X     ; round up
          STX ENR
          BEQ UsRo_20
          RTS
UsRo_30   LDA #'1'            ; 0.5 - 0.9 -> round to 1
          STA STACK,X
          INX
          STX DOSFLA
          DEC TEMP_A
          BPL UsRo_Ret
          INC TEMP_A
          INC VN
UsRo_Ret  RTS

; ********************
  Check_Zeroes ; $97fb
; ********************

          LDY DOSFLA          ; write position at start ?
          BEQ UsZe_20           ; -> remove leading zeroes

; ********************
  Leading_Zero ; $97ff
; ********************

          LDY BNR             ; Y = begin

; ******************
  Using_Zero ; $9802
; ******************

          LDA STACK,Y
          CMP #'0'
          RTS

UsZe_10   INC DOSFLA
          JSR Adjust_PU_Exp
          INC BNR
          CPY ENR
          BEQ UsRo_Ret
          INY
UsZe_20   JSR Using_Zero
          BEQ UsZe_10
          RTS

; ************************
  Output_Formatted ; $981c
; ************************

          LDA DOLR            ; dollar flag ?
          BMI OuFo_10         ; -> no $
          INC TEMP_A
OuFo_10   LDX BNR             ; X = begin index number string
          DEX
          LDY BEGFD           ; Y = begin index format string
OuFo_12   JSR FNDPNT_from_Bank_1
          INY                 ; advance index to number string
          CMP #','
          BNE OuFo_16         ; -> not a comma
          BIT FLAG            ; comma flag ?
          BMI OuFo_14         ; -> don't print commas
          STA MMU_LCRC
          LDA PU_COMMA          ; load comma separator symbol
          JMP OuFo_38         ; -> print it

OuFo_14   LDA BLFD            ; load fill character
          JMP OuFo_38         ; -> print it

OuFo_16   CMP #'.'
          BNE OuFo_18         ; -> no dot
          STA MMU_LCRC
          LDA PU_DOT
          JMP OuFo_38         ; -> print dot

OuFo_18   CMP #'+'
          BEQ OuFo_28         ; -> print + or -
          CMP #'-'
          BEQ OuFo_26         ; -> print blank or -
          CMP #'^'
          BNE OuFo_44
          LDA #'E'            ; -> print start of exponent
          JSR Chrout_Using
          LDY UEXP
          JSR Using_Zero
          BNE OuFo_20
          INY
          JSR Using_Zero
          BEQ OuFo_22
OuFo_20   LDA #'-'
          BIT USGN
          BMI OuFo_24
OuFo_22   LDA #'+'
OuFo_24   JSR Chrout_Using    ; print sign of exponent
          LDX UEXP
          LDA STACK,X
          JSR Chrout_Using
          LDY ENDFD
          JMP OuFo_32
OuFo_26   LDA SNO
          BMI OuFo_14
OuFo_28   LDA SNO
          JMP OuFo_38         ; -> print sign

OuFo_30   LDA TEMP_A
          BNE OuFo_42
          CPX ENR
          BEQ OuFo_34
OuFo_32   INX
          LDA STACK,X
          .BYTE $2C ;BIT
OuFo_34   LDA #'0'
OuFo_36   LSR FLAG
OuFo_38   JSR Chrout_Using
          BEQ OuFo_40
          JMP OuFo_12
OuFo_40   RTS

OuFo_42   DEC TEMP_A
          LDA DOLR
          BMI OuFo_34
          JSR Output_Comma
          NOP
          STA MMU_LCRC
          LDA PU_MONEY          ; currency symbol
          JMP OuFo_36

OuFo_44   LDA SWE
          BEQ OuFo_30
          DEC SWE
OuFo_46   BEQ OuFo_48
          JMP OuFo_14
OuFo_48   LDA POSP
          BMI OuFo_46
OuFo_50   JSR FNDPNT_from_Bank_1
          CMP #','
          BNE OuFo_26
          LDA BLFD
          JSR Chrout_Using
          INY
          JMP OuFo_50

; ********************
  Chrout_Using ; $98eb
; ********************

          JSR Print_Char
          DEC CFORM
          RTS

; *********************
  Analyse_Using ; $98f2
; *********************

          LDY ENDFD
AnUs_10   JSR Inc_Using_Y
          JSR Is_Format_Control_Char
          BNE AnUs_25
          STY BEGFD           ; index to start of format
          BCC AnUs_35         ; -> char is '#'
          TAX                 ; save char
AnUs_15   JSR Inc_Using_Y
          BCS AnUs_20         ; -> end of format
          JSR Is_Dot_Align
          BEQ AnUs_30
AnUs_20   LDY BEGFD
          TXA                 ; restore char
AnUs_25   JSR Print_Char      ; print char from format string
          JMP AnUs_10         ; -> loop

AnUs_30   BCS AnUs_15
          LDY BEGFD
AnUs_35   LDX TEMP_A
          BNE IFS_20
          STX CFORM
          DEY
AnUs_40   DEC CFORM
AnUs_45   JSR Inc_Using_Y
          BCS IFS_40
          CMP #','
          BEQ AnUs_45
          JSR Is_Format_Sign
          BCC AnUs_40
          CMP #'.'
          BNE AnUs_55
          INX
          CPX #2
          BCC AnUs_45
AnUs_50   JMP SYNTAX_ERROR
AnUs_55   JSR Is_Align
          BNE AnUs_65
          BCC AnUs_60
          STA CHSN
AnUs_60   INC VF,X
          JMP AnUs_45
AnUs_65   CMP #'$'
          BNE AnUs_70
          BIT DOLR
          BPL AnUs_60
          CLC
          ROR DOLR
          DEC VF
          JMP AnUs_60
AnUs_70   CMP #'^'
          BNE Is_Format_Sign
          LDX #2
AnUs_75   JSR Inc_Using_Y
          BCS AnUs_50
          CMP #'^'
          BNE AnUs_50
          DEX
          BPL AnUs_75
          INC FESP
          JSR Inc_Using_Y
          BCS IFS_40

; **********************
  Is_Format_Sign ; $997e
; **********************

          CMP #'+'
          BNE IFS_30
          LDA SNO
          BPL IFS_10
          LDA #'+'
          STA SNO
IFS_10    LDA POSP
          BNE AnUs_50
          ROR POSP
          STY ENDFD
          INC CFORM
IFS_20    RTS
IFS_30    CMP #'-'
          BEQ IFS_10
          SEC
IFS_40    STY ENDFD
          DEC ENDFD
          RTS

; ******************************
  Is_Format_Control_Char ; $99a7
; ******************************

          CMP #'+'
          BEQ Alig_Ret
          CMP #'-'
          BEQ Alig_Ret

; ********************
  Is_Dot_Align ; $99af
; ********************

          CMP #'.'
          BEQ Alig_Ret

; ****************
  Is_Align ; $99b3
; ****************

          CMP #'='            ; align left
          BEQ Alig_Ret
          CMP #'>'            ; align right
          BEQ Alig_Ret
          CMP #'#'            ; digit
          BNE Alig_Ret
          CLC
Alig_Ret  RTS

; ******************
  FUNC_INSTR ; $99c1
; ******************

          LDA FAC1_M3
          STA TMPDES
          LDA FAC1_M4
          STA TMPDES+1        ; TMPDES = address of descriptor
          JSR Eval_Expression
          JSR Need_String
          LDA FAC1_M3
          STA TMPDES+2
          LDA FAC1_M4
          STA TMPDES+3        ; TMPDES+2 = address of search descriptor
          LDX #1
          STX FAC1_M4         ; default start index
          JSR CHRGOT
          CMP #')'
          BEQ FUIN_10         ; -> end of arguments
          JSR Comma_And_Byte
FUIN_10   JSR Need_Right_Par
          LDX FAC1_M4         ; start index (1-255)
          BNE FUIN_20         ; must not be zero
          JMP Error_Illegal_Quantity
FUIN_20   DEX
          STX FAC1_EX         ; start index (0-254)
          LDX #3
FUIN_30   LDA TMPDES,X        ; copy string addresses
          STA FACTPA,X        ; FACTPA = TMPDES
          DEX
          BPL FUIN_30

; load descriptors

          LDY #2
FUIN_40   LDA #FACTPA
          JSR Fetch_1         ; next byte descriptor
          STA DESCA,Y         ; 3 bytes
          LDA #FACTPA+2
          JSR Fetch_1         ; next byte of search descriptor
          STA TENEXP,Y        ; 3 bytes
          DEY
          BPL FUIN_40

          LDA TENEXP          ; length of search string
          BEQ FUIN_90         ; -> empty search string: not found
FUIN_50   LDA #0              ; reset search index
          STA FAC1_M1
          CLC
          LDA TENEXP          ; A = length of search string
          ADC FAC1_EX         ; A += start index
          BCS FUIN_90         ; -> index overflow
          CMP DESCA           ; compare with length of string
          BCC FUIN_60         ; -> continue
          BNE FUIN_90         ; -> beyond end of string
FUIN_60   LDY FAC1_M1         ; search index
          CPY TENEXP          ; compare with search length
          BEQ FUIN_80         ; -> found!
          TYA
          CLC
          ADC FAC1_EX         ; position = search index + search start
          TAY
          LDA #DESCA+1        ; load next char string
          JSR Fetch_1
          STA SYNTMP          ; save it
          LDY FAC1_M1
          LDA #TENEXP+1       ; load next char of search string
          JSR Fetch_1
          CMP SYNTMP          ; compare string char with search char
          BEQ FUIN_70         ; -> continue if equal
          INC FAC1_EX         ; increment search index
          BNE FUIN_50         ; always

FUIN_70   INC FAC1_M1         ; increment search index
          BNE FUIN_60         ; branch always

FUIN_80   INC FAC1_EX         ; add 1 for range correction
          LDA FAC1_EX         ; load it as result
          .BYTE $2C ;BIT
FUIN_90   LDA #0
          STA MMU_LCRC
          PHA                 ; push result
          LDA TMPDES+2
          LDY TMPDES+3
          JSR Free_String_AY  ; free search pattern
          STA MMU_LCRC
          LDA TMPDES
          LDY TMPDES+1
          JSR Free_String_AY  ; free string
          PLA                 ; pop result
          TAY
          JMP Y_To_Real

; *******************
  Sin_Cos_Ang ; $9a74
; *******************

; Compute sine and cosine values via lookup table and interpolation
; The argument unit is [degree]
; The result unit is scaled [$000 - $ffff] for [0.0 - 1.0]

; Input : XPOS,Y   low  byte
;         XPOS+1,Y high byte

; Output: SINVAL   SIN low  byte
;         SINVAL+1 SIN high byte
;         SINVAL+2 COS low  byte
;         SINVAL+3 COS high byte

          JSR LAY_XPOS_Y      ; A/Y = XPOS,Y

; ******************
  Sin_Cos_AY ; $9a77
; ******************

          LDX #0
SCAY_10   INX                 ; X = 1 + (A/Y) / 90
          SEC
          SBC #90
          BCS SCAY_10
          DEY
          BPL SCAY_10
          STX ANGSGN          ; 1 + (A/Y) / 90
          PHA                 ; push A
          ADC #90
          JSR SCAY_20         ; COS(val)
          PLA                 ; pull A
          CLC
          EOR #$ff
          ADC #1              ; negate A
          DEC ANGSGN          ; quadrant = (A/Y) / 90

; *******
  SCAY_20
; *******

          LDX #$ff            ; start loop with X=0
SCAY_30   INX
          SEC
          SBC #10
          BCS SCAY_30
          ADC #10
          STA VTEMPA          ; A = angle % 10
          TXA                 ; X = angle / 10
          ASL A               ; X *= 2
          TAX
          LDA angval+1,X
          LDY angval,X        ; A/Y = SIN(X)  X unit = [10 deg]
SCAY_40   CLC
          DEC VTEMPA
          BMI SCAY_50
          ADC incval+1,X      ; linear interpolation
          PHA
          TYA
          ADC incval,X
          TAY
          PLA
          BCC SCAY_40         ; always

SCAY_50   PHA
          LDX #0
          LDA ANGSGN          ; quadrant
          LSR A
          BCS SCAY_60         ; -> odd quadrant
          LDX #2
SCAY_60   PLA
          STA SINVAL,X        ; result low
          TYA
          STA SINVAL+1,X      ; result high
          RTS

; *****************
  LAY_SIN_X ; $9ace
; *****************

          LDY #SINVAL-XPOS    ; $19
          BCC LSIN_10
          LDY #COSVAL-XPOS    ; $1b
LSIN_10   LDA ANGSGN          ; quadrant
          ADC #2
          LSR A
          LSR A
          PHP
          JSR LAY_XPOS_Y      ; load SIN or COS to AY/
          CPY #$ff
          BCC LSIN_20
          TXA
          TAY
          JSR LAY_XPOS_Y      ; load angle to A/Y
          BCS LSIN_30         ; always

LSIN_20   JSR LAY_MUL_X       ; scale
LSIN_30   PLP
          BCS ANDI_Ret
          JMP LABS_10

; ****************
  ANG_DIST ; $9af3
; ****************

          STA ANGCNT
          LDX #XRADIUS-XPOS   ; $23
ANDI_10   ASL ANGCNT
          JSR LAY_SIN_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
          INX
          INX
          CPX #ANGBEG-XPOS    ; $2b
          BCC ANDI_10
ANDI_Ret  RTS

; *****************
  FUNC_RDOT ; $9b0c
; *****************

          JSR Eval_Byte
          CPX #2
          BCC RDOT_30
          BEQ RDOT_10
          JMP Error_Illegal_Quantity
RDOT_10   JSR Get_Pixel
          TAY
          BCC RDOT_20
          LDY #0
RDOT_20   JMP Y_To_Real
RDOT_30   TXA
          ASL A
          TAX
          LDA XPOS,X
          TAY
          LDA XPOS+1,X
          JMP Integer_To_Real

; *****************
  Draw_Line ; $9b30
; *****************

          LDX #2
          LDY #6
DrLi_10   LDA #0
          STA XSGN,X
          STA XSGN+1,X
          JSR LAY_ABS_DIFF
          BPL DrLi_20
          DEC XSGN,X
          DEC XSGN+1,X
          BNE DrLi_40
DrLi_20   CMP #0
          BNE DrLi_30
          CPY #0
          BEQ DrLi_40
DrLi_30   INC XSGN,X
DrLi_40   STA XABS,X
          ASL A
          STA FCT,X
          TYA
          STA XABS+1,X
          ROL A
          STA FCT+1,X
          DEX
          DEX
          LDY #4
          CPX #0
          BEQ DrLi_10
          LDX #10
          LDY #8
          JSR LAY_Y_SUB_X
          LDA #0
          ROL A
          ROL A
          STA LESSER
          EOR #%00000010 ; $02
          STA GREATR
          CLC
          LDA #16
          ADC LESSER
          TAY
          PHA
          EOR #%00000010 ; $02
          TAX
          JSR LAY_Y_SUB_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
          PLA
          TAY
          CLC
          LDA #8
          ADC GREATR
          TAX
          JSR LAY_Y_SUB_X
          STA ERRVAL
          STY ERRVAL+1
DrLi_50   JSR Double_Pixel
          LDY GREATR
          SEC
          LDA XABS,Y
          SBC #1
          STA XABS,Y
          BCS DrLi_60
          LDA XABS+1,Y
          SBC #0
          STA XABS+1,Y
          BCS DrLi_60
          RTS
DrLi_60   LDX LESSER
          LDA ERRVAL+1
          BMI DrLi_70
          JSR Add_Increment
          LDX GREATR
DrLi_70   CLC
          LDA ERRVAL
          ADC FCT,X
          STA ERRVAL
          LDA ERRVAL+1
          ADC FCT+1,X
          STA ERRVAL+1
          LDX GREATR
          JSR Add_Increment
          BEQ DrLi_50

; *********************
  Add_Increment ; $9bea
; *********************

          LDY #2
          CLC
AdIn_10   LDA XPOS,X
          ADC XSGN,X
          STA XPOS,X
          INX
          DEY
          BNE AdIn_10
          RTS

; ********************
  Double_Pixel ; $9bfb
; ********************

          LDA FILFLG
          ORA WIDTH
          BEQ Set_Pixel
          INC XPOS            ; ++XPOS
          BNE DoPi_10
          INC XPOS+1
DoPi_10   JSR Set_Pixel       ; set neighbour pixel
          LDX XPOS
          BNE DoPi_20
          DEC XPOS+1          ; --XPOS
DoPi_20   DEC XPOS

; *****************
  Set_Pixel ; $9c19
; *****************

          JSR LXY_ROW_COL
          BCS SePi_30
          JSR Color_Character
          JSR getpos_10
          STA BITMSK
          LDA (GRAPNT),Y
          ORA BITMSK
          BIT GRAPHM
          BPL SePi_40
          PHA
          LDX COLSEL
          LDA BITMSK
          AND colval,X
          STA BITMSK
          PLA
SePi_10   EOR BITMSK
SePi_20   STA (GRAPNT),Y
SePi_30   RTS
SePi_40   LDX COLSEL
          BNE SePi_20
          BEQ SePi_10

; *****************
  Get_Pixel ; $9c49
; *****************

          JSR getpos
          BCS GePi_Ret
          STA BITMSK
          LDA (GRAPNT),Y
          AND BITMSK
GePi_10   ROL A
          DEX
          BPL GePi_10
          ROL A
          BIT STOPNB
          BMI GePi_20
          AND #%00000011 ; $03
          CMP COLSEL
          CLC
          RTS
GePi_20   CLC
          AND #%00000011 ; $03
          BEQ GePi_30
          LDX #0
          RTS
GePi_30   LDX #$ff
GePi_Ret  RTS

; ***********************
  Color_Character ; $9c70
; ***********************

          LDA E_40_Line_Lo,X ; same values for color RAM
          STA GRAPNT
          LDA ColRAM_Line_Hi,X
          STA GRAPNT+1
          LDA COLSEL
          BNE CCha_10
          LDA FG_BG
          BIT GRAPHM
          BPL CCha_20
          RTS
CCha_10   CMP #2
          BNE CCha_30
          LDA FG_MC1
CCha_20   AND #%00001111 ; $0f
          STA TEMP_A
          LDA (GRAPNT),Y
          AND #%11110000 ; $f0
          ORA TEMP_A
          STA (GRAPNT),Y
          RTS
CCha_30   BCS CCha_40
          LDA FG_BG
          AND #%11110000 ; $f0
          STA TEMP_A
          LDA (GRAPNT),Y
          AND #%00001111 ; $0f
          ORA TEMP_A
          STA (GRAPNT),Y
          RTS
CCha_40   LDA GRAPNT+1
          AND #%00000011 ; $03
          ORA #%11011000 ; $d8
          STA GRAPNT+1
          LDA #0
          STA MMU_CR
          SEI
          LDA R8502
          PHA
          AND #%11111110 ; $fe
          STA R8502
          LDA MULCO2
          STA (GRAPNT),Y
          PLA
          STA R8502
          CLI
          RTS

; **********************
  ColRAM_Line_Hi ; $9cca
; **********************

          .BYTE $1c,$1c,$1c,$1c,$1c ; line  0 -  4
          .BYTE $1c,$1c,$1d,$1d,$1d ; line  5 -  9
          .BYTE $1d,$1d,$1d,$1e,$1e ; line 10 - 14
          .BYTE $1e,$1e,$1e,$1e,$1e ; line 15 - 19
          .BYTE $1f,$1f,$1f,$1f,$1f ; line 20 - 24

; **************
  getpos ; $9ce3
; **************

          JSR LXY_ROW_COL
          BCS getpos_30

; *****************
  getpos_10 ; $9ce8
; *****************

          TYA
          CLC
          ADC E_40_Line_Lo,X
          STA GRAPNT
          LDA E_40_Line_Hi,X
          ADC #0
          ASL GRAPNT
          ROL A
          ASL GRAPNT
          ROL A
          ASL GRAPNT
          ROL A
          STA GRAPNT+1
          LDA YPOS
          AND #%00000111 ; $07
          TAY
          LDA XPOS
          BIT GRAPHM
          PHP
          BPL getpos_20
          ASL A
getpos_20 AND #%00000111 ; $07
          TAX
          LDA rbits,X
          PLP
          BPL getpos_30
          INX
          ORA rbits,X
getpos_30 RTS

rbits     .BYTE $80,$40,$20,$10,$08,$04,$02,$01

; *******************
  LXY_ROW_COL ; $9d24
; *******************

          LDA XPOS+1
          LSR A
          BNE LXYRC_20
          LDA XPOS
          ROR A
          LSR A
          BIT GRAPHM
          BMI LXYRC_10
          LSR A
LXYRC_10  TAY
          CPY #40             ; max columns
          BCS LXYRC_20
          LDA YPOS+1
          BNE LXYRC_20
          LDA YPOS
          LSR A
          LSR A
          LSR A
          TAX
          CMP #25             ; max rows
          RTS
LXYRC_20  SEC
          RTS

; ****************
  Scale_XY ; $9d4a
; ****************

          LDA SCALEM
          BEQ ScXY_Ret
          LDA SCALE_X
          LDY SCALE_X+1
          JSR ScXY_10
          LDA SCALE_Y
          LDY SCALE_Y+1

; ***************
  ScXY_10 ; $9d5a
; ***************

          JSR LAY_MUL_X
          STA XPOS,X
          TYA
          INX
          STA XPOS,X
          INX
ScXY_Ret  RTS

; *******************
  LAY_ADD_SUB ; $9d67
; *******************

          BCC LAY_ADD_X
          BCS LYSX_10

; *******************
  LAY_SUB_ADD ; $9d6b
; *******************

          BCS LAY_Y_SUB_X

; *******************
  LAY_Y_ADD_X ; $9d6d
; *******************

          JSR LAY_XPOS_Y

; *****************
  LAY_ADD_X ; $9d70
; *****************

          CLC
          ADC XPOS,X
          PHA
          TYA
          ADC XPOS+1,X
          TAY
          PLA
          RTS

; *******************
  LAY_Y_SUB_X ; $9d7c
; *******************

          JSR LAY_XPOS_Y
LYSX_10   SEC
          SBC XPOS,X
          STA FACTPA
          TYA
          SBC XPOS+1,X
          TAY
          PHP
          LDA FACTPA
          PLP
          RTS

; ******************
  LAY_XPOS_Y ; $9d8f
; ******************

          LDA XPOS,Y
          PHA
          LDA XPOS+1,Y
          TAY
          PLA
          RTS

; ********************
  LAY_ABS_DIFF ; $9d99
; ********************

          JSR LAY_Y_SUB_X

; ***************
  LAY_ABS ; $9d9c
; ***************

          BPL LABS_Ret
LABS_10   PHP
          CLC
          EOR #$ff
          ADC #1
          PHA
          TYA
          EOR #$ff
          ADC #0
          TAY
          PLA
          PLP
LABS_Ret  RTS

; *****************
  LAY_MUL_X ; $9dae
; *****************

          STY VTEMPA
          STA VTEMPA+1
          LDA XPOS,X
          LDY XPOS+1,X
          PHP
          JSR LAY_ABS
          STA XPOS,X
          TYA
          STA XPOS+1,X
          LDA #0
          STA VTEMP3
          LDY #16
LAYMX_10  LSR VTEMPA
          ROR VTEMPA+1
          BCC LAYMX_20
          CLC
          ADC XPOS,X
          PHA
          LDA VTEMP3
          ADC XPOS+1,X
          STA VTEMP3
          PLA
LAYMX_20  LSR VTEMP3
          ROR A
          DEY
          BNE LAYMX_10
          ADC #0
          LDY VTEMP3
          BCC LAYMX_30
          INY
LAYMX_30  PLP
          JMP LAY_ABS

; **********************
  XY_DEST_To_POS ; $9df2
; **********************

          LDY #0
          JSR DEST_To_POS
          LDY #2

; *******************
  DEST_To_POS ; $9df9
; *******************

          LDA XDEST,Y
          STA XPOS,Y
          LDA XDEST+1,Y
          STA XPOS+1,Y
          RTS

; *****************************
  Get_Comma_And_Integer ; $9e06
; *****************************

          JSR CHRGOT
          BEQ GCAI_10
          JSR Need_Comma
          CMP #','
          BEQ GCAI_10
          JSR Get_Integer
          SEC
          RTS
GCAI_10   LDA #0
          TAY
GCAI_CRet CLC
          RTS

; ************************
  Get_Byte_Or_Zero ; $9e1c
; ************************

          LDX #0

; ************************
  Get_Byte_Or_Void ; $9e1e
; ************************

          JSR CHRGOT
          BEQ GCAI_CRet
          JSR Need_Comma
          CMP #','
          BEQ GCAI_CRet
          JSR Get_Byte_Var
          SEC
          RTS

; ***************************
  Assert_Color_Source ; $9e2f
; ***************************

          JSR Assert_Graphics_Mem

; ************************
  Get_Color_Source ; $9e32
; ************************

          LDX #1              ; default color = foreground
          JSR CHRGOT
          BEQ GCS_10
          CMP #','
          BEQ GCS_10
          JSR Get_Byte_Var
          CPX #4
          BCS GCS_Err
          CPX #2
          BIT GRAPHM
          BMI GCS_10
          BCS GCS_Err
GCS_10    STX COLSEL
          RTS
GCS_Err   JMP Error_Illegal_Quantity

; ***********************
  Get_Graphics_XY ; $9e52
; ***********************

          JSR CHRGOT
          BEQ GGXY_10
          JSR Need_Comma
          CMP #','
          BNE Get_Coordinates
GGXY_10   LDY #0
GGXY_20   LDA XPOS,Y
          STA XPOS,X
          INX
          INY
          CPY #4
          BNE GGXY_20
          RTS

; *********************************
  Get_Comma_And_Coordinates ; $9e6d
; *********************************

          JSR Need_Comma

; ***********************
  Get_Coordinates ; $9e70
; ***********************

          STX VTEMP4
          JSR Get_Coordinate_Value
          JSR CHRGOT
          CMP #','
          BEQ GeCo_40
          CMP #';'
          BEQ GeCo_10
          JMP SYNTAX_ERROR
GeCo_10   JSR CHRGET
          JSR Get_Integer
          STA TEMP_A
          TYA
          LDY TEMP_A
          JSR Sin_Cos_AY
          LDX VTEMP4
          LDA XPOS,X
          STA YPOS,X
          LDA XPOS+1,X
          STA YPOS+1,X
          JSR Scale_XY
          LDA #14
          STA Rel_Abs_Flag
          CLC
          LDX VTEMP4
GeCo_20   JSR LAY_SIN_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
          LDY #0
          LSR Rel_Abs_Flag
          BCC GeCo_30
          LDY #2
GeCo_30   JSR LAY_SUB_ADD
          STA XPOS,X
          TYA
          STA XPOS+1,X
          INX
          INX
          LSR Rel_Abs_Flag
          BNE GeCo_20
          CLC
          RTS
GeCo_40   JSR CHRGET
          INC VTEMP4
          INC VTEMP4
          JSR Get_Coordinate_Value
          LDX VTEMP4
          DEX
          DEX
          JSR Scale_XY
          LDY #2
          LDX VTEMP4
          INX
          INX
GeCo_50   DEX
          DEX
          LSR Rel_Abs_Flag
          BCC GeCo_60
          JSR LAY_Y_ADD_X
          STA XPOS,X
          TYA
          STA XPOS+1,X
GeCo_60   LDY #0
          CPX VTEMP4
          BEQ GeCo_50
          CLC
          RTS

; ****************************
  Get_Coordinate_Value ; $9f08
; ****************************

          JSR CHRGOT
          CMP #$aa            ; + token
          BEQ GCV_10
          CMP #$ab            ; - token
          BEQ GCV_10
          CLC
GCV_10    ROL Rel_Abs_Flag    ; set bit 7 if + or -
          JSR GSC_40          ; evaluate numeric
          LDX VTEMP4          ; storage pointer
          STA XPOS+1,X        ; value high
          TYA
          STA XPOS,X          ; value low
          RTS

colval    .BYTE $ff,$aa,$55,$00

; lookup table for SIN/COS

angval    .WORD $0000 ; 0000 [00]  0.000
          .WORD $712c ; 2c71 [10]  0.174
          .WORD $8d57 ; 578d [20]  0.342
          .WORD $0080 ; 8000 [30]  0.500
          .WORD $8fa4 ; a48f [40]  0.643
          .WORD $19c4 ; c419 [50]  0.766
          .WORD $b2dd ; ddb2 [60]  0.866
          .WORD $90f0 ; f090 [70]  0.940
          .WORD $1cfc ; fc1c [80]  0.985
          .WORD $ffff ; ffff [90]  1.000

incval    .WORD $7204 ;  472
          .WORD $5004 ;  450
          .WORD $0b04 ;  40b
          .WORD $a803 ;  3a8
          .WORD $2803 ;  328
          .WORD $9002 ;  290
          .WORD $e301 ;  1e3
          .WORD $2801 ;  128
          .WORD $6300 ;   63

; *****************************
  Allocate_Graphics_RAM ; $9f4f
; *****************************

          LDA MVDFLG          ; graphics RAM reseved ?
          BEQ AGR_10          ; -> no
          RTS                 ; nothing to do
AGR_10    LDA TEXT_TOP+1
          CLC
          ADC #$24            ; 9 Kbyte free ?
          BCS AGR_15
          STA LOWTR+1         ; new value for TEXT_TOP+1
          CMP TEXT_MAX+1      ; compare with maximum ($ff)
          BCC AGR_20          ; -> OK below
          BNE AGR_15          ; -> OOM
          CPY TEXT_MAX        ; *** ERROR *** Y is undefined
          BCC AGR_20
AGR_15    JMP OOM_Error       ; Out Of Memory
AGR_20    DEC MVDFLG          ; MVDFLG = $ff
          LDA TEXT_TOP
          STA INDEXA
          LDA LOWTR+1
          STA INDEXA+1        ; INDEXA = TEXT_TOP + $2400
          LDX TEXT_TOP
          STX INDEXB
          LDA TEXT_TOP+1
          STA INDEXB+1        ; INDEXB = TEXT_TOP
          SEC
          SBC #$1c
          TAY
          TXA
          EOR #$ff
          STA GRBPNT
          TYA
          EOR #$ff
          STA GRBPNT+1        ; GRBPNT = $1c00 - TEXT_TOP
          LDY #0
AGR_25    INC GRBPNT          ; ++GRBPNT (bytes to move)
          BNE AGR_30
          INC GRBPNT+1
          BEQ AGR_45          ; -> exit loop
AGR_30    LDA INDEXA          ; --INDEXA (target pointer)
          BNE AGR_35
          DEC INDEXA+1
AGR_35    DEC INDEXA
          LDA INDEXB          ; --INDEXB (source pointer)
          BNE AGR_40
          DEC INDEXB+1
AGR_40    DEC INDEXB
          JSR Get_INDEXB_0    ; load  source
          STA (INDEXA),Y      ; store target
          JMP AGR_25          ; -> loop

AGR_45    CLC
          LDA TEXT_TOP+1      ; obsolete, is set below after Relink
          ADC #$24
          STA TEXT_TOP+1      ; TEXT_TOP += $2400
          LDA TXTTAB+1
          ADC #$24
          STA TXTTAB+1        ; TXTTAB   += $2400
          LDA DATPTR+1
          ADC #$24
          STA DATPTR+1        ; DATPTR   += $2400
AGR_50    JSR Relink
          JSR Set_TEXT_TOP
          BIT RUNMOD
          BPL AGR_65
          LDX #$24            ; add $2400
          BIT MVDFLG
          BMI AGR_55
          LDX #$dc            ; subtract $2400
AGR_55    TXA
          CLC
          ADC TXTPTR+1
          STA TXTPTR+1        ; adjust TXTPTR
          TXA
          CLC
          ADC OLDTXT+1
          STA OLDTXT+1        ; adjust OLDTXT
          TXA
          CLC
          ADC ERRTXT+1
          STA ERRTXT+1        ; adjust ERRTXT
          JSR Init_FNDPNT
AGR_60    LDA FNDPNT
          CMP #$ff
          BNE AGR_70
          LDA FNDPNT+1
          CMP #9
          BNE AGR_70
AGR_65    RTS
AGR_70    LDY #0              ; adjust structures on stack
          LDA (FNDPNT),Y
          CMP #$81
          BNE AGR_75
          LDY #16
          JSR Shift_Stack_Value
          LDA #$12
          BNE AGR_80
AGR_75    LDY #4
          JSR Shift_Stack_Value
          LDA #5
AGR_80    CLC
          ADC FNDPNT
          STA FNDPNT
          BCC AGR_60
          INC FNDPNT+1
          BNE AGR_60

; *************************
  Free_Graphics_RAM ; $a022
; *************************

          LDA MVDFLG          ; Graphics RAM allocated ?
          BNE FGR_10          ; -> yes : unallocate
          RTS
FGR_10    LDY #0
          STY MVDFLG
          STY INDEXA
          STY INDEXB
          LDA #$1c
          STA INDEXA+1        ; INDEXA = $1c00
          LDA #$40 ; '@'
          STA INDEXB+1        ; INDEXB = $4000
FGR_20    JSR Get_INDEXB_0    ; Load  source
          STA (INDEXA),Y      ; Store target
          INY
          BNE FGR_20
          INC INDEXA+1        ; next page target
          INC INDEXB+1        ; next page source
          LDA TEXT_TOP+1
          CMP INDEXB+1
          BCS FGR_20          ; loop until TEXT_TOP
          SEC
          LDA TXTTAB+1
          SBC #$24
          STA TXTTAB+1        ; TXTTAB -= $2400
          LDA TEXT_TOP+1
          SBC #$24
          STA TEXT_TOP+1      ; TEXT_TOP -= $2400
          LDA DATPTR+1
          SBC #$24
          STA DATPTR+1        ; DATPTR -= $2400
          JMP AGR_50

; *************************
  Shift_Stack_Value ; $a062
; *************************

          LDA (FNDPNT),Y
          BIT MVDFLG
          BNE SSV_10
          SEC
          SBC #$24
          STA (FNDPNT),Y
          RTS
SSV_10    CLC
          ADC #$24
          STA (FNDPNT),Y
          RTS

; ***************************
  Assert_Graphics_Mem ; $a074
; ***************************

          LDA MVDFLG
          BEQ NGA_Err
          RTS
NGA_Err   LDX #$23            ; NO GRAPHICS AREA
          JMP Print_Error_X

; ********************
  BASIC_DIRCAT ; $a07e
; ********************

          JSR DOS_Parser
          LDA DOSFLA
          AND #%11100110     ; $e6: @,W,TD,LA,TFN
          BEQ DIR_10
          JMP SYNTAX_ERROR
DIR_10    LDY #1              ; start of command string
          LDX #1              ; length of command string '$'
          LDA DOSFLA
          AND #%00010001     ; $11: drive, filename
          BEQ DIR_20          ; -> no drive or pattern
          LSR A               ; fn flag -> carry
          BCC DIR_15          ; -> no pattern
          INX
          INX                 ; "$0:"
DIR_15    INX                 ; "$0:pattern"
DIR_20    TXA                 ; length of command string
          JSR Build_DOS_Command
          LDA #0
          TAX
          JSR B_SETBNK        ; bank 0
          LDY #$60            ; SA
          LDX DOS_FA          ; FA
          LDA #0              ; LA
          JSR B_SETLFS
          SEC
          JSR B_OPEN          ; OPEN LA,FA,SA,"$0:pattern"
          BCC DIR_25          ; -> OK
          PHA                 ; push error #
          JSR DIR_55          ; close channel 0
          PLA                 ; pull error #
          TAX                 ; X  = error #
          JMP Print_Error_X   ; error exit

DIR_25    LDX #0              ; select channel 0
          JSR Map_IO
          JSR K_CHKIN
          LDY #3              ; read load address, link & number
DIR_30    STY T3              ; words to read
DIR_35    JSR B_BASIN
          STA T4              ; word low
          JSR B_READST        ; check status
          BNE DIR_55
          JSR B_BASIN
          STA T5              ; word high
          JSR B_READST        ; check status
          BNE DIR_55
          DEC T3              ; word count
          BNE DIR_35          ; -> ignore this word and loop
          LDX T4              ; blocks low
          LDA T5              ; blocks high
          JSR Print_Integer_XA; print blocks
          LDA #' '            ; print blank
          JSR B_BSOUT
DIR_40    JSR B_BASIN         ; next char of directory
          PHA                 ; push received byte
          JSR B_READST        ; status OK ?
          BNE DIR_50          ; no -> finish
          PLA                 ; restore received byte
          BEQ DIR_45          ; -> end of line
          JSR B_BSOUT         ; print char
          JMP DIR_40          ; loop

DIR_45    LDA #13             ; print return
          JSR B_BSOUT
          JSR B_STOP          ; check STOP key
          BEQ DIR_55          ; -> exit on STOP
          LDY #2              ; Y = words to read (link & number)
          BNE DIR_30          ; branch always

DIR_50    PLA
DIR_55    JSR B_CLRCH         ; clear channel
          LDA #0
          CLC
          JMP B_CLOSE         ; close directory file

; ********************
  BASIC_DOPEN ; $a11d
; *******************

          LDA #%00100010     ; inhibit second drive and filename
          JSR DOS_Parser_A
          JSR Require_LA_Filename
          JSR Find_Free_SA
          LDY #Pat_DOPEN - Pat_DCLEAR - 1 ; start of command
          LDX #4              ; length of OPEN command
          BIT DOSFLA          ; test DOS flags
          BVC APPE_10         ; -> No WRITE or REL flag
          LDX #8              ; length of OPEN command
          BNE APPE_10         ; always

; ********************
  BASIC_APPEND ; $a134
; ********************

;               @WDD ULFF
          LDA #%11100010     ; accept LA,Drive,Unit,File
          JSR DOS_Parser_A
          JSR Require_LA_Filename
          JSR Find_Free_SA
          LDY #Pat_APPEND - Pat_DCLEAR - 1
          LDX #$05 ;#?Pat_APPEND
APPE_10   TXA
          JSR Build_DOS_Command
          JSR B_CLRCH
          LDA #0
          TAX
          JSR B_SETBNK
          JSR B_OPEN
          NOP
          JMP PDC_20

; ********************
  Find_Free_SA ; $a157
; ********************

          LDY #$61            ; try SA from $62 to $6e
FFSA_10   INY                 ; address 2 - 14
          CPY #$6f
          BEQ FFSA_Err
          JSR Map_IO
          JSR K_LKUPSA        ; look up SA
          BCC FFSA_10         ; -> already in use
          STY DOS_SA          ; use this one
          RTS
FFSA_Err  LDX #1              ; TOO MANY FILES
          JMP Print_Error_X

; ********************
  BASIC_DCLOSE ; $a16f
; ********************

          LDA #%11110011     ; allow only LA and Unit
          JSR DOS_Parser_A
          JSR Free_DOS_Status_String
          LDA DOSFLA
          AND #%00000100     ; test LA bit
          BEQ B_CLOALL          ; -> no LA: close all
          LDA DOS_LA
          JMP B_CLOSE

; ****************
  B_CLOALL ; $a183
; ****************

          LDA DOS_FA
          JSR Map_IO
          JMP K_CLOALL

; *******************
  BASIC_DSAVE ; $a18c
; *******************

          LDA #$66
          JSR DOS_Parser_A
          JSR Assert_Filename
          LDY #Pat_DOPEN - Pat_DCLEAR  - 1
          LDA #4              ; command length
          JSR Build_DOS_Command
          LDA #0
          TAX
          JSR B_SETBNK        ; bank 0 is default
          JMP SAVE_10

; *********************
  BASIC_DVERIFY ; $a1a4
; *********************

          LDA #1              ; set verify flag
          .BYTE $2C ;BIT                 ; skip next statement

; *******************
  BASIC_DLOAD ; $a1a7
; *******************

          LDA #0
          STA B_VERCK
          LDA #$e6
          JSR DOS_Parser_A
          JSR Assert_Filename
          LDA #0
          STA DOS_SA
          LDY #Pat_DOPEN - Pat_DCLEAR  - 1
          LDA #4              ; command length
          JSR Build_DOS_Command
          LDA #0              ; bank for loading
          TAX                 ; bank for filename
          JSR B_SETBNK
          JMP LOAD_Parameter_Set

; *******************
  BASIC_BSAVE ; $a1c8
; *******************

          LDA #$66
          LDX #$f8
          JSR DOS_Parser_AX
          JSR Assert_Filename
          LDA DOSFLB
          AND #6
          CMP #6
          BEQ BSAV_10         ; -> all parameter set
          JMP SYNTAX_ERROR
BSAV_10   LDA DOS_END+1
          CMP DOS_BEG+1
          BCC BSAV_Err
          BNE BSAV_20
          LDA DOS_END
          CMP DOS_BEG
          BCC BSAV_Err
          BEQ BSAV_Err
BSAV_20   LDY #5
          LDA #4
          JSR Build_DOS_Command
          LDA DOS_BANK
          LDX #0
          JSR B_SETBNK
          LDX DOS_BEG
          LDY DOS_BEG+1
          LDA #ARYPNT         ; address of save address
          STX ARYPNT
          STY ARYPNT+1
          LDX DOS_END
          LDY DOS_END+1
          JMP SAVE_20
BSAV_Err  JMP Error_Illegal_Quantity

          .FILL $a218-* ,0

; *******************
  BASIC_BLOAD ; $a218
; *******************

          LDA #$e6            ; DOS flags
          LDX #$fc            ; DOS flags
          JSR DOS_Parser_AX

; *************
  BLOAD ; $a21f
; *************

          JSR Assert_Filename
          LDX DOS_BEG
          LDY DOS_BEG+1
          LDA #0
          CPX #$ff
          BNE BLOAD_10
          CPY #$ff
          BNE BLOAD_10
          LDA #$ff
BLOAD_10  STA DOS_SA
          LDY #Pat_DOPEN - Pat_DCLEAR  - 1
          LDA #4              ; command length
          JSR Build_DOS_Command
          LDA DOS_BANK        ; bank for loading
          LDX #0              ; bank for filename
          JSR B_SETBNK
          LDA #0
          LDX DOS_BEG
          LDY DOS_BEG+1
          JSR K_LOADSP
          PHP
          JSR Invalidate_Disk_Status
          PLP
          BCC BLOAD_20
          JMP Break_On_Error
BLOAD_20  JSR B_READST
          AND #%10111111 ; $bf
          BEQ BLOAD_30
          JMP LPS_Err
BLOAD_30  CLC
          RTS

; ********************
  BASIC_HEADER ; $a267
; ********************

          JSR DOS_Parser
          JSR Need_Name
          AND #1
          CMP #1
          BNE SCRA_40
          JSR B_CLALL
          JSR ARE_YOU_SURE
          BNE HEAD_Ret
          LDY #Pat_HEADER - Pat_DCLEAR - 1 ;$a643 - $a627 -1 = $1b
          LDA #$04 ;#?Pat_HEADER - 2 ; no ID ;$a643 - 2
          LDX DOS_ID
          BEQ HEAD_10
          LDA #$06 ;#?Pat_HEADER ;$a627 ? = high byte lower nibble $address &0f00 >> 8
HEAD_10   JSR Put_DOS_Command
          JSR Update_DS
          BIT RUNMOD
          BMI HEAD_Ret
          LDY #0
          LDA #DS_ADR
          JSR Fetch_1
          CMP #'2'
          BCC HEAD_Ret
          LDX #$24            ; BAD DISK
          JMP Print_Error_X
HEAD_Ret  RTS

; *********************
  BASIC_SCRATCH ; $a2a1
; *********************

          JSR DOS_Parser
          JSR Need_Name
          JSR ARE_YOU_SURE
          BNE SCRA_30
          LDY #Pat_SCRATCH - Pat_DCLEAR - 1
          LDA #$04 ;#?Pat_SCRATCH
          JSR Put_DOS_Command
          JSR Update_DS
          BIT RUNMOD
          BMI SCRA_30
          LDA #13
          JSR B_BSOUT
          LDY #0
SCRA_10   LDA #DS_ADR         ; print disk status
          JSR Fetch_1
          BEQ SCRA_20
          JSR B_BSOUT
          INY
          BNE SCRA_10
SCRA_20   LDA #13
          JSR CHROUT
SCRA_30   RTS
SCRA_40   JMP SYNTAX_ERROR

; ********************
  BASIC_RECORD ; $a2d7
; ********************

          LDA #'#'
          JSR Need_A
          JSR Get_Byte_Var
          CPX #0
          BEQ REC1_Err        ; LA # must be > 0
          STX DOS_LA
          JSR Comma_And_LINNUM; get record #
          LDX #1              ; default  position in record
          JSR Get_Byte_Or_Void; optional position in record
          CPX #0
          BEQ REC1_Err        ; position must be > 0
          CPX #$ff
          BEQ REC1_Err        ; position must be < 255
          STX DOS_RL          ; position
          LDA DOS_LA
          JSR Map_IO
          JSR K_LKUPLA        ; lookup FA,SA
          BCS REC4_Err
          STY REC_SA
          STX DOS_FA
          LDA #0              ; setup command channel
          STA DOS_LA
          LDA #$6f
          STA DOS_SA
          LDY #Pat_RECORD - Pat_DCLEAR - 1
          LDA #$04 ;#?Pat_RECORD
          BNE Put_DOS_Command
REC1_Err  JMP Error_Illegal_Quantity
REC4_Err  LDX #4              ; FILE NOT FOUND
          JMP Print_Error_X

; ********************
  BASIC_DCLEAR ; $a322
; ********************

          JSR DOS_Parser
          LDY #$ff
          LDA #2
          JSR Put_DOS_Command
          JMP B_CLOALL

; *********************
  BASIC_COLLECT ; $a32f
; *********************

          JSR DOS_Parser
          JSR Unit_And_Drive_Only
          JSR B_CLALL
          LDY #Pat_COLLECT - Pat_DCLEAR - 1
          LDX #1              ; collect with no drive
          LDA DOSFLA
          AND #%00010000     ; drive ?
          BEQ COLLE_10        ; -> no
          INX                 ; collect with drive
COLLE_10  TXA
          BNE Put_DOS_Command ; always

; ******************
  BASIC_COPY ; $a346
; ******************

          JSR DOS_Parser
          AND #%00110000   ; source & target drive
          CMP #%00110000
          BNE COPY_10
          LDA DOSFLA        ; source and target drive set
          AND #%11000111   ; @ W LA FN1 FN2
          BEQ COPY_20       ; -> copy *
COPY_10   LDA DOSFLA
          JSR Deny_AT_W_LA
          LDA DOSFLA        ; obsolete
COPY_20   LDY #Pat_COPY - Pat_DCLEAR - 1
          LDA #$08 ;#?Pat_COPY    ; command length
          BNE Put_DOS_Command

; ********************
  BASIC_CONCAT ; $a362
; ********************

          JSR DOS_Parser
          JSR Deny_AT_W_LA
          LDY #Pat_CONCAT - Pat_DCLEAR - 1
          LDA #12             ; overlap with APPEND
          BNE Put_DOS_Command

; ********************
  BASIC_RENAME ; $a36e
; ********************

          LDA #$e4
          JSR DOS_Parser_A
          JSR Require_Two_Filenames
          LDY #Pat_RENAME - Pat_DCLEAR  - 1
          LDA #$08 ;#?Pat_RENAME
          BNE Put_DOS_Command

; ********************
  BASIC_BACKUP ; $a37c
; ********************

          LDA #$c7
          JSR DOS_Parser_A
          AND #%00110000     ; source & target drive
          CMP #%00110000
          BEQ BACK_10
          JMP SYNTAX_ERROR
BACK_10   JSR ARE_YOU_SURE
          BEQ BACK_20
          RTS
BACK_20   JSR B_CLOALL
          LDY #$23 ; '#'
          LDA #4

; ***********************
  Put_DOS_Command ; $a397
; ***********************

          JSR Build_DOS_Command
PDC_10    JSR B_CLRCH
          LDA #0
          TAX
          JSR B_SETBNK
          SEC
          JSR B_OPEN
          PHP
          PHA
          LDA DOS_LA
          SEC
          JSR B_CLOSE
          PLA
          PLP
PDC_20    BCS PDC_Err
          RTS
PDC_Err   JMP Break_On_Error


dostbl     .BYTE $ff
           .BYTE $ff
           .BYTE $ff
           .BYTE $ff
           .BYTE $00          ; default LA
           .BYTE $08          ; default FA
           .BYTE $6f          ; default SA

; This is the universal DOS parser
; It is called by all BASIC 4 DOS commands and scans and stores

; DOS_LA          = logical address
; DOS_BANK        = bank for loading or saving
; DOS_FA          = primary address (UNIT)
; DOS_DRIVE_1     = source drive
; DOS_DRIVE_2     = target drive
; FNADR           = filename address of source file
; DOS_FNADR_2     = filename address of target file
; FNLEN           = filename length  of source file
; DOS_FNLEN_2     = filename length  of target file
; DOS_ID          = disk id for formatting
; DOS_RL          = record length
; DOS_BEG     = start address
; DOS_END       = end address

; DOSFLA flags for parsing BASIC 4 DOS commands

; bit 0: $01 = source Filename given
; bit 1: $02 = target Filename given
; bit 2: $04 = logical address set in LA
; bit 3: $08 = primary address set in FA
; bit 4: $10 = source drive set
; bit 5: $20 = target drive set
; bit 6: $40 = W (Write) or L (Relative file) given
; bit 7: $80 = Save and replace flag '@'

; The routine returns with the flags stored in DOSFLA and DOSFLB


; ******************
  DOS_Parser ; $a3bf
; ******************

           LDA #0             ; disabled flags

; ********************
  DOS_Parser_A ; $a3c1
; ********************

           LDX #$ff           ; enabled flags

; *********************
  DOS_Parser_AX ; $a3c3
; *********************

           PHA
           TXA
           PHA
           LDA #0
           STA DOSFLA
           STA DOSFLB
           LDX #$22
DOSP_10    STA STACK,X        ; clear $0101 to $0122
           DEX
           BNE DOSP_10
           LDX #6
DOSP_12    LDA dostbl,X
           STA DOS_BEG,X  ; set default values
           DEX
           BPL DOSP_12
           LDX USER_BANK
           STX DOS_BANK       ; set bank
           JSR CHRGOT
DOSP_13    BNE DOSP_16
DOSP_14    PLA                ; exit sequence
           AND DOSFLB         ; check forbidden parameter
           BNE DOSP_Syn
           PLA
           JSR Assert_DOSFLA  ; check required parameter
           LDA DOSFLA
           LDX DOSFLB
           RTS

DOSP_16    CMP #'#'           ; logical address ?
           BEQ DOSP_32
           CMP #'W'           ; write mode ?
           BEQ DOSP_36
           CMP #'L'           ; relative file ?
           BEQ DOSP_36
           CMP #'R'           ; read mode ?
           BEQ DOSP_22
           CMP #'D'           ; Drive ?
           BEQ DOSP_42
           CMP #$91           ; ON token
           BEQ DOSP_24
           CMP #'B'           ; Bank
           BEQ DOSP_30
           CMP #'U'           ; Unit ?
           BEQ DOSP_28
           CMP #'P'           ; Position ?
           BNE DOSP_18
           JMP DOSP_50
DOSP_18    CMP #'I'           ; ID parameter on HEADER ?
           BEQ DOSP_48
           CMP #QUOTE
           BEQ DOSP_20        ; -> start reading filename 1
           CMP #'('
           BEQ DOSP_20
           JMP SYNTAX_ERROR
DOSP_20    JMP DOSP_56

; READ mode (default) 'R'

DOSP_22    JSR CHRGET
           JMP DOSP_62

; read bank or unit after ON keyword

DOSP_24    JSR Get_Bank_Or_Unit
DOSP_26    JMP DOSP_60

; read unit 'U'

DOSP_28    JSR Get_Unit
           BNE DOSP_26        ; branch always

; read bank 'B'

DOSP_30    JSR Get_Bank
           BEQ DOSP_26

; read logical address after '#'

DOSP_32    LDA #4             ; bit 2 = LA set
           JSR Assert_DOSFLA  ; inhibit multiple settings
           JSR Get_DOS_Parameter_Byte
           CPX #0
           BEQ DOSP_Ill       ; ILLEGAL QUANTITY
           STX DOS_LA         ; set LA
           LDA #4             ; flag for LA defined
           BNE DOSP_26        ; branch always

DOSP_Syn   JMP SYNTAX_ERROR

; set WRITE 'W' or REL 'L' flag

DOSP_36    TAX
           LDA #$40           ; bit 6 = WRITE flag
           JSR Assert_DOSFLA
           CPX #'W'
           BNE DOSP_38        ; continue with L parameter
           JSR CHRGET
           JMP DOSP_40

; set record length after 'L'

DOSP_38    JSR Get_DOS_Parameter_Byte
           CPX #0
           BEQ DOSP_Ill       ; record length must be > 0
           CPX #$ff
           BEQ DOSP_Ill       ; record length must be < 255
           STX DOS_RL         ; set record length
DOSP_40    LDA #$40           ; WRITE or REL flag
           BNE DOSP_44        ; branch always

;set DRIVE

DOSP_42    LDA #16            ; bit 4 = DRIVE 1 set
           JSR Assert_DOSFLA
           JSR Get_DOS_Parameter_Byte
           CPX #2             ; DRIVE must be 0 or 1 only
           BCS DOSP_Ill
           STX DOS_DRIVE_1    ; source drive
           STX DOS_DRIVE_2    ; target drive
           LDA #16            ; DRIVE flag
DOSP_44    BNE DOSP_60        ; branch always

DOSP_Ill   JMP Error_Illegal_Quantity

; read ID 'I'

DOSP_48    LDA DOS_UNIT
           BNE DOSP_Syn
           JSR CHRGET
           STA DOS_ID
           JSR CHRGET
           STA DOS_ID+1
           LDA #$ff
           STA DOS_UNIT
           JSR CHRGET
           JMP DOSP_62

; read position 'P'

DOSP_50    LDA #2             ; bit 1 = binary load start
           JSR Assert_DOSFLB
           JSR Get_DOS_Parameter_Word
           STY DOS_BEG
           STA DOS_BEG+1
           LDA #2
DOSP_52    ORA DOSFLB
           STA DOSFLB
           BNE DOSP_62
DOSP_54    LDA #4             ; bit 2 = binary load end
           JSR Assert_DOSFLB
           JSR Get_DOS_Parameter_Word
           STY DOS_END
           STA DOS_END+1
           LDA #4
           BNE DOSP_52        ; branch always

; read 1st. filename

DOSP_56    LDA #1             ; read 1st. filename
           JSR Get_DOS_Filename
           STA DOS_FNLEN_1
           LDY #0
DOSP_58    JSR Get_INDEXA_1   ; copy filename to DOS buffer
           STA MMU_LCRC
           STA SAVRAM,Y
           INY
           CPY DOS_FNLEN_1
           BCC DOSP_58
           LDA #1             ; set flag: filename 1
DOSP_60    ORA DOSFLA
           STA DOSFLA
DOSP_62    JSR CHRGOT         ; next char
           BNE DOSP_72
DOSP_64    JMP DOSP_14        ; -> check & exit

; parse destination filename and parameters

DOSP_66    CMP #$91           ; ON token
           BNE DOSP_68
           JMP DOSP_24        ; Get bank or unit

DOSP_68    CMP #$a4           ; TO token
           BEQ DOSP_70        ; <- obsolete
           BNE DOSP_88          ; branch always

DOSP_70    JSR CHRGET
           CMP #'P'
           BNE DOSP_76
           BEQ DOSP_54        ; -> load start/end address

DOSP_72    CMP #','
           BNE DOSP_66
           JSR CHRGET
           JMP DOSP_16

DOSP_74    JSR CHRGET
DOSP_76    CMP #'D'           ; idestination drive
           BEQ DOSP_78
           CMP #$91           ; ON token
           BEQ DOSP_80
           CMP #'U'           ; destination unit
           BEQ DOSP_82
           CMP #QUOTE
           BEQ DOSP_84
           CMP #'('
           BEQ DOSP_84

; parse destination drive

DOSP_78    LDA #$20           ; drive 2 flag
           JSR Assert_DOSFLA
           JSR Get_DOS_Parameter_Byte
           CPX #2
           BCS DOSP_90
           STX DOS_DRIVE_2
           LDA #$20           ; drive 2 flag
           BNE DOSP_86        ; branch always

; parse destination unit after ON

DOSP_80    JSR Get_Bank_Or_Unit
           JMP DOSP_86

; parse destination unit

DOSP_82    JSR Get_Unit
           BNE DOSP_86

; parse destination filename

DOSP_84    LDA #2             ; read 2nd. filename
           JSR Get_DOS_Filename
           STA DOS_FNLEN_2
           STX DOS_FNADR_2
           STY DOS_FNADR_2+1
           LDA #2             ; flag 2nd. filename
DOSP_86    ORA DOSFLA
           STA DOSFLA
           JSR CHRGOT
           BEQ DOSP_64
           CMP #','
           BEQ DOSP_74
           CMP #$91           ; ON token
           BEQ DOSP_80
           CMP #'U'
           BEQ DOSP_82
DOSP_88    BNE GeBa_Err          ; SYNTAX ERROR
DOSP_90    JMP Error_Illegal_Quantity

; ************************
  Get_Bank_Or_Unit ; $a582
; ************************

           JSR CHRGET

; ********************
  Bank_Or_Unit ; $a585
; ********************

           CMP #'B'
           BEQ Get_Bank
           CMP #'U'
           BNE GeBa_Err

; ****************
  Get_Unit ; $a58d
; ****************

           JSR Get_DOS_Parameter_Byte
           CPX #$1f
           BCS GDF_30
           CPX #4
           BCC GDF_30
           STX DOS_FA
           LDA #8
           RTS

; ****************
  Get_Bank ; $a59e
; ****************

           LDA #1
           JSR Assert_DOSFLB
           JSR Get_DOS_Parameter_Byte
           CPX #16
           BCS DOSP_90
           STX DOS_BANK
           LDA #1
           ORA DOSFLB
           STA DOSFLB
           LDA #0
           RTS

GeBa_Err   JMP SYNTAX_ERROR

; ************************
  Get_DOS_Filename ; $a5b9
; ************************

           JSR Assert_DOSFLA  ; filename set already ?
           JSR Eval_String
           TAX
           BEQ GDF_20
           LDY #0
           JSR Get_INDEXA_1
           CMP #'@'           ; replace symbol
           BNE GDF_10
           LDA #$80
           JSR Assert_DOSFLA  ; check replace flag
           LDA DOSFLA
           ORA #%10000000    ; set replace flag
           STA DOSFLA
           DEX
           INC INDEXA         ; skip repplace char
           BNE GDF_10
           INC INDEXA+1
GDF_10     TXA
           CMP #$11
           BCS String_Too_Long
           LDX INDEXA
           LDY INDEXA+1
           RTS
GDF_20     LDX #8             ; MISSING FILE NAME
           .BYTE $2C ;BIT
GDF_30     LDX #9             ; ILLEGAL DEVICE NUMBER
           .BYTE $2C ;BIT

; ***************
  String_Too_Long
; ***************

           LDX #$17
           JMP Print_Error_X

; ******************************
  Get_DOS_Parameter_Byte ; $a5f2
; ******************************

           JSR CHRGET
           BEQ GeBa_Err
           BCC GDPB_10
           JSR Need_Left_Par
           JSR Get_Byte_Var
           JMP Need_Right_Par
GDPB_10    JMP Get_Byte_Var

; ******************************
  Get_DOS_Parameter_Word ; $a605
; ******************************

           JSR CHRGET
           BEQ GeBa_Err
           BCC GDPW_10
           JSR Need_Left_Par
           JSR Get_Integer
           JSR Need_Right_Par
           LDY LINNUM
           LDA LINNUM+1
           RTS
GDPW_10    JMP Get_Integer

; *********************
  Assert_DOSFLA ; $a61d
; *********************

           AND DOSFLA
           BNE GeBa_Err
           RTS

; *********************
  Assert_DOSFLB ; $a622
; *********************

           AND DOSFLB
           BNE GeBa_Err
           RTS


; Format strings for building DOS commands

; Values >= $80 are special codes:

; $c2 : SA secondary address
; $d0 : ID for formatting in HEADER
; $d1 : drive 1
; $d2 : drive 2
; $e0 : RL (record length) or 'W'
; $e1 : 'L' or 'S'
; $f0 : @ (save and replace) <- DO NOT USE (some drives are buggy)
; $f1 : filename 1
; $f2 : filename 2

; ******************
  Pat_DCLEAR ; $a627
; ******************

          .BYTE 'I',$d1       ; INITIALIZE drive

; *********************
  Pat_DIRECTORY ; $a629
; *********************

          .BYTE '$',$d1,':',$f1 ; $ drive : filename

; *****************
  Pat_DOPEN ; $a62d
; *****************

          .BYTE $f0,$d1,':',$f1,',',$e1,',',$e0

; ******************
  Pat_CONCAT ; $a635
; ******************

          .BYTE 'C',$d2,':',$f2,'=',$d2,':',$f2,','

; ******************
  Pat_APPEND ; $a63e
; ******************

          .TEXT $d1,':',$f1,",A"

; ******************
  Pat_HEADER ; $a643
; ******************

          .BYTE 'N',$d1,':',$f1,',',$d0

; *******************
  Pat_COLLECT ; $a649
; *******************

          .BYTE 'V',$d1

; ******************
  Pat_BACKUP ; $a64b
; ******************

          .BYTE 'D',$d2,'=',$d1

; ****************
  Pat_COPY ; $a64f
; ****************

          .BYTE 'C',$d2,':',$f2,'=',$d1,':',$f1

; ******************
  Pat_RENAME ; $a657
; ******************

          .BYTE 'R',$d1,':',$f2,'=',$d1,':',$f1

; *******************
  Pat_SCRATCH ; $a65f
; *******************

          .BYTE 'S',$d1,':',$f1

; ******************
  Pat_RECORD ; $a663
; ******************

          .BYTE 'P',$c2,$e2,$e0

; *************************
  Build_DOS_Command ; $a667
; *************************

          STA DOS_COUNT       ; length of format string
          TYA                 ; index to start of format string
          PHA                 ; save index
          JSR Free_DOS_Status_String
          LDX #0
BDC_10    PLA                 ; restore format index
          DEC DOS_COUNT       ; remaining format bytes
          BMI BDC_22          ; -> done
          TAY
          INY                 ; increment index
          TYA
          PHA                 ; save index
          LDA Pat_DCLEAR,Y    ; next byte
          BPL BDC_18          ; -> store as is
          CMP #$c2            ; SA secondary address
          BEQ BDC_24
          CMP #$d0            ; ID (formatting)
          BEQ BDC_30
          CMP #$e2            ; word (record number)
          BEQ BDC_36
          CMP #$e1            ; L or S
          BEQ BDC_32
          CMP #$f0            ; @
          BEQ BDC_26
          CMP #$f1            ; filename 1
          BEQ BDC_38
          CMP #$f2            ; filename 2
          BEQ BDC_20
          CMP #$e0            ; record length or 'W'
          BNE BDC_12
          LDA DOS_RL
          BNE BDC_18
BDC_12    CMP #$d1            ; drive 1
          BNE BDC_14
          LDA DOS_DRIVE_1
          BPL BDC_16
BDC_14    CMP #$d2            ; drive 2
          BNE BDC_10
          LDA DOS_DRIVE_2
BDC_16    ORA #'0'            ; bin to ASCII
BDC_18    STA DOSSTR,X
          INX
          BNE BDC_10          ; always
BDC_20    BEQ BDC_42          ; always

BDC_22    TXA
          PHA
          LDX #<DOSSTR
          LDY #>DOSSTR
          JSR B_SETNAM
          LDA DOS_LA
          LDX DOS_FA
          LDY DOS_SA
          JSR B_SETLFS
          PLA
          RTS

BDC_24    LDA REC_SA          ; insert SA
          BNE BDC_18

BDC_26    BIT DOSFLA          ; insert
          BMI BDC_28
          BPL BDC_10

BDC_28    LDA #$40 ; '@'      ; insert @
          BNE BDC_18

BDC_30    LDA DOS_ID          ; insert ID
          STA DOSSTR,X
          INX
          LDA DOS_ID+1
          BNE BDC_18

BDC_32    LDA DOS_RL          ; insert 'L'
          BEQ BDC_34
          LDA #'L'
          BNE BDC_18

BDC_34    LDA #'S'            ; insert "S,W"
          STA DOS_RL
          LDA #'W'
          BNE BDC_18

BDC_36    LDA LINNUM          ; insert binary word
          STA DOSSTR,X
          LDA LINNUM+1
          INX
          BNE BDC_18

BDC_38    LDY DOS_FNLEN_1     ; insert filename 1
          BEQ BDC_46
          LDY #0
BDC_40    LDA SAVRAM,Y
          STA DOSSTR,X
          INX
          INY
          CPY DOS_FNLEN_1
          BNE BDC_40
          BEQ BDC_48

BDC_42    LDA DOS_FNADR_2     ; insert filename 2
          STA INDEXA
          LDA DOS_FNADR_2+1
          STA INDEXA+1
          LDY DOS_FNLEN_2
          BEQ BDC_46
          LDY #0
BDC_44    JSR Get_INDEXA_1
          STA MMU_LCRC
          STA DOSSTR,X
          INX
          INY
          CPY DOS_FNLEN_2
          BNE BDC_44
          .BYTE $24
BDC_46    DEX
BDC_48    JMP BDC_10

; *****************
  Need_Name ; $a749
; *****************

          AND #%11100110 ; $e6
          BEQ Assert_Filename
NeNa_Err  JMP SYNTAX_ERROR

; ***********************
  Assert_Filename ; $a750
; ***********************

          LDA DOSFLA
          AND #1
          CMP #1
          BNE NeNa_Err
          LDA DOSFLA
          RTS

; ***************************
  Unit_And_Drive_Only ; $a75b
; ***************************

;                  D U
          AND #%11100111 ; $e7
          BNE NeNa_Err
          RTS

; ********************
  Deny_AT_W_LA ; $a760
; ********************

          AND #%11000100 ; $c4
          BNE NeNa_Err
          LDA DOSFLA

; *****************************
  Require_Two_Filenames ; $a766
; *****************************

          AND #3
          CMP #3
          BNE NeNa_Err
          LDA DOSFLA
          RTS

; ***************************
  Require_LA_Filename ; $a76f
; ***************************

          AND #5
          CMP #5
          BNE NeNa_Err
          LDA DOSFLA
          RTS

; *****************
  Update_DS ; $a778
; *****************

          LDA DS_LEN          ; Allocated ?
          BNE UpDS_10         ; -> yes
          LDA #40             ; fixed length
          STA DS_LEN
          JSR Allocate_String_Space
          STX DS_ADR
          STY DS_ADR+1
          LDY #40             ; fixed length
          STA MMU_LCRD
          LDA #<DS_LEN        ; address of descriptor low
          STA (DS_ADR),Y      ; back reference low
          INY
          LDA #>DS_LEN        ; address of descriptor high
          STA (DS_ADR),Y      ; back reference high
UpDS_10   LDX DOS_FA          ; unit
          BNE UpDS_20         ; use defined unit
          LDX #8              ; set default
          STX DOS_FA          ; FA
UpDS_20   LDA #0              ; LA
          LDY #$6f            ; SA (command channel 15)
          JSR B_SETLFS
          LDA #0
          JSR B_SETNAM        ; no name
          JSR B_OPEN          ; open command channel
          LDX #0
          JSR K_CHKIN         ; select for input
          BCS UpDS_50
          LDY #$ff            ; pre increment loop
UpDS_30   INY
          JSR B_BASIN         ; read from command channel
          STA MMU_LCRD
          CMP #CR             ; stop reading at CR
          BEQ UpDS_40
          STA (DS_ADR),Y      ; store message
          CPY #40             ; maximum length
          BCC UpDS_30         ; loop

; *******
  UpDS_40
; *******

          LDA #0              ; use zero instead of CR
          STA (DS_ADR),Y      ; insert string limiter
          JSR B_CLRCH         ; reset input channel
          LDA #0
          SEC
          JMP B_CLOSE         ; close channel and return

UpDS_50   PHA                 ; push error code
          JSR UpDS_40         ; close channel
          JSR Free_DOS_Status_String
          PLA                 ; pull error code
          TAX
          JMP Print_Error_X   ; print error and exit

; ********************
  ARE_YOU_SURE ; $a7e1
; ********************

          BIT RUNMOD
          BMI AYS_30          ; reply positive while running
          JSR B_PRIMM
          .TEXT "ARE YOU SURE?",0
          JSR B_CLRCH
          JSR B_BASIN
          PHA                 ; push first read char
AYS_10    CMP #CR
          BEQ AYS_20
          JSR B_BASIN
          BNE AYS_10          ; loop until CR
AYS_20    PLA                 ; pull first char
          CMP #'Y'            ; was it 'Y' ?
          RTS
AYS_30    LDA #0
          RTS

; ******************************
  Free_DOS_Status_String ; $a80d
; ******************************

          TYA                 ; save Y
          PHA
          LDA DS_LEN
          BEQ EDS_10          ; -> DS$ not allocated
          LDY #40             ; fixed length
          TYA
          STA MMU_LCRD
          STA (DS_ADR),Y      ; back reference low
          INY
          LDA #$ff
          STA (DS_ADR),Y      ; back reference high
EDS_10    LDA #0
          STA MMU_LCRC
          STA DS_LEN          ; mark as free
          PLA
          TAY                 ; restore Y
EDS_Ret   RTS

; **************
  KEYREV ; $a82a
; **************

          .TEXT ",0 YEK"

; ********************
  Print_Byte_A ; $a830
; ********************

          TAX                 ; X = low byte
          TYA
          PHA                 ; save Y
          LDA #0              ; A = high byte
          JSR Print_Integer_XA
          PLA
          TAY                 ; restore Y
          RTS

; **********************
  To_Direct_Mode ; $a83b
; **********************

          STA CURLIN+1        ; store current line high
          DEY                 ; decrement stack index
          TAX                 ; X = current line high
          INX                 ; ++X
          BNE TDM_Ret         ; -> branch if CURLIN+1 was not $ff
          STX RUNMOD          ; RUNMOD = 0 -> direct mode
TDM_Ret   RTS

; **************
  Map_IO ; $a845
; **************

          PHA
          LDA #0
          STA MMU_CR          ; Map in I/O and ROM
          PLA
          RTS

; *****************
  BASIC_IRQ ; $a84d
; *****************

          LDA IRQ_ACTIVE_FLAG ; already executing IRQ ?
          BEQ BIRQ_10         ; -> no  : continue
          RTS                 ; -> yes : return
BIRQ_10   INC IRQ_ACTIVE_FLAG ; flag IRQ as active

; Copy all sprite coordinates to VIC

          LDX #16
BIRQ_12   LDA VSH,X
          STA VIC,X
          DEX
          BPL BIRQ_12

; Perform sprite movement

          LDY #7              ; sprite index
BIRQ_14   LDA VIC_SPR_ENA
          AND Bit_Mask,Y
          BEQ BIRQ_20         ; -> sprite disabled
          LDX Sprite_Offset,Y ; X = index to sprite parameter
          LDA SPRITE_DATA,X   ; A = speed
          BEQ BIRQ_20         ; -> sprite doesn't move
          STA SPRITE_DATA+1,X ; set movement increment
BIRQ_16   TYA                 ; sprite index
          ASL A               ; * 2
          TAY
          LDA SPRITE_DATA+2,X ; quadrant
          SEC
          SBC #1              ; quadrant - 1
          INX
          INX                 ; sprite y position
          INY
          JSR Move_Sprite     ; update y position
          DEX
          DEX                 ; sprite x position
          DEY
          LDA SPRITE_DATA+2,X
          JSR Move_Sprite     ; update x position
          PHP
          TYA
          LSR A
          TAY                 ; sprite index
          PLP
          BCC BIRQ_18
          LDA VSH+16     ; MSB sprite postion
          EOR Bit_Mask,Y
          STA VSH+16     ; MSB sprite postion
BIRQ_18   DEC SPRITE_DATA+1,X
          BNE BIRQ_16
BIRQ_20   DEY
          BPL BIRQ_14          ; -> loop next sprite

; handle light pen, sprite-background and sprite-sprite collision

; 7....... interrupt flag
; .654.... unused
; ....3... light pen
; .....2.. sprite/sprite collision
; ......1. sprite/background collision
; .......0 raster interrupt

          LDA VIC_IRQ_REG     ; load IRQ mask
          STA VIC_IRQ_REG     ; reset all IRQ's
          AND #%00001110     ; light-pen, sprite collision
          BEQ BIRQ_30         ; -> no collision
          LSR A               ; shift out raster IRQ

          LDY #1              ; Y=1 sprite/background, Y=0 sprite/sprite
BIRQ_22   LSR A               ; C = collision
          BCC BIRQ_28         ; -> none
          PHA                 ; save IRQ flags1
          LDA VIC_SS_COLL,Y
          ORA VSH_SS_COLL,Y
          STA VSH_SS_COLL,Y   ; update collision shadow register
          LDA #0
          STA VIC_SS_COLL,Y   ; clear collision register

; 7....... working on collision
; .6543... unused
; .....2.. light pen
; ......1. sprite/background
; .......0 sprite/sprite

          LDA INT_VAL         ; flag for collision treatment
          CPY #0
          BEQ BIRQ_24         ; -> Y=0 : sprite/sprite coll
          LSR A
BIRQ_24   LSR A
          BCC BIRQ_26
          LDA #$ff
          STA INT_TRIP_FLAG,Y
BIRQ_26   PLA
BIRQ_28   DEY                 ; Y=1 sprite/background, Y=0 sprite/sprite
          BPL BIRQ_22

; handle light pen

          LSR A               ; C = light pen flag
          BCC BIRQ_30         ; -> none
          LDA VIC_LPX         ; copy positions from VIC to shadow
          STA VSH_LPX
          LDA VIC_LPY
          STA VSH_LPY
          LDA INT_VAL
          AND #%00000100     ; $04
          BEQ BIRQ_30         ; -> no light pen IRQ
          LDA #$ff
          STA Light_Pen_Flag  ; set flag

; play music

BIRQ_30   LDX #0              ; X=0,2,4 : voice = 1,2,3
BIRQ_32   LDA Snd_Duration+1,X      ; duration high
          BMI BIRQ_34         ; -> inactive
          LDA Snd_Duration,X        ; duration low
          SEC                 ; duration -= Snd_Tempo
          SBC Snd_Tempo
          STA Snd_Duration,X
          BCS BIRQ_34
          LDA Snd_Duration+1,X
          SBC #0
          STA Snd_Duration+1,X
          BCS BIRQ_34         ; -> greater 0 : continue
          TXA
          LSR A
          TAY                 ; voice #
          LDA WAVE0,Y         ; envelope
          AND #%11111110     ; $fe
          PHA
          LDA offtab,Y        ; SID offset
          TAY
          PLA
          STA SID_Control_1,Y ; set new envelope
BIRQ_34   INX
          INX                 ; next voice
          CPX #6
          BNE BIRQ_32         ; -> loop next voice

          LDY #2              ; loop for voices 2,1,0
BIRQ_36   LDA Sound_Duration_1_Hi,Y
          BPL BIRQ_40         ; -> voice is active
BIRQ_38   DEY
          BPL BIRQ_36
          JMP Exit_BASIC_IRQ

BIRQ_40   CLC
          LDA SOUND_FREQ_LO,Y
          ADC SOUND_STEP_LO,Y
          STA SOUND_FREQ_LO,Y
          LDA SOUND_FREQ_HI,Y
          ADC SOUND_STEP_HI,Y
          STA SOUND_FREQ_HI,Y
          LDA SOUND_DIR,Y
          TAX
          AND #1
          BEQ BIRQ_46
          BCC BIRQ_42
          SEC
          LDA SOUND_FREQ_LO,Y
          SBC SOUND_MIN_LO,Y
          LDA SOUND_FREQ_HI,Y
          SBC SOUND_MIN_HI,Y
          BCS BIRQ_54
BIRQ_42   CPX #2
          BCC BIRQ_44
          JSR Negate_Sound_Step
          LDA #2
          STA SOUND_DIR,Y
          BNE BIRQ_50
BIRQ_44   LDA SOUND_MAX_LO,Y
          STA SOUND_FREQ_LO,Y
          LDA SOUND_MAX_HI,Y
          STA SOUND_FREQ_HI,Y
          JMP BIRQ_54
BIRQ_46   BCS BIRQ_48
          LDA SOUND_FREQ_HI,Y
          CMP SOUND_MAX_HI,Y
          BCC BIRQ_54
          BNE BIRQ_48
          LDA SOUND_FREQ_LO,Y
          CMP SOUND_MAX_LO,Y
          BCC BIRQ_54
          BEQ BIRQ_54
BIRQ_48   CPX #2
          BCC BIRQ_50
          JSR Negate_Sound_Step
          LDA #3
          STA SOUND_DIR,Y
          BNE BIRQ_44
BIRQ_50   LDA SOUND_MIN_LO,Y
          STA SOUND_FREQ_LO,Y
          LDA SOUND_MIN_HI,Y
          STA SOUND_FREQ_HI,Y
BIRQ_54   LDX offtab,Y
          LDA SOUND_FREQ_LO,Y
          STA SID_Freq_1,X
          LDA SOUND_FREQ_HI,Y
          STA SID_Freq_1+1,X
          TYA
          TAX
          LDA Sound_Duration_1_Lo,X
          BNE BIRQ_56
          DEC Sound_Duration_1_Hi,X
BIRQ_56   DEC Sound_Duration_1_Lo,X
          LDA Sound_Duration_1_Hi,X
          BPL BIRQ_58
          LDA #8
          LDX offtab,Y
          STA SID_Control_1,X
BIRQ_58   JMP BIRQ_38


; *************************
  Negate_Sound_Step ; $a9da
; *************************

          LDA SOUND_STEP_LO,Y
          EOR #$ff
          CLC
          ADC #1
          STA SOUND_STEP_LO,Y
          LDA SOUND_STEP_HI,Y
          EOR #$ff
          ADC #0
          STA SOUND_STEP_HI,Y
          RTS


; **********************
  Exit_BASIC_IRQ ; $a9f0
; **********************

          DEC IRQ_ACTIVE_FLAG
          RTS

; *******************
  Move_Sprite ; $a9f4
; *******************

          PHA                 ; save quadrant
          CLC
          LDA SPRITE_DATA+3,X ; movement
          ADC SPRITE_DATA+7,X ; old position
          STA SPRITE_DATA+7,X ; new position
          LDA SPRITE_DATA+4,X
          ADC SPRITE_DATA+8,X
          STA SPRITE_DATA+8,X
          PLA                 ; restore quadrant
          BCC MoSp_Ret
          LSR A
          LSR A               ; C = bit2
          LDA VSH,Y
          BCS MoSp_10
          ADC #1
          JMP MoSp_20
MoSp_10   SBC #1
          CMP #$ff
MoSp_20   STA VSH,Y
MoSp_Ret  RTS

; *******************
  BASIC_STASH ; $aa1f
; *******************

          LDA #$84            ; STASH marker
          JMP SWAP_10

; *******************
  BASIC_FETCH ; $aa24
; *******************

          LDA #$85            ; FETCH marker
          JMP SWAP_10

; ******************
  BASIC_SWAP ; $aa29
; ******************

          LDA #$86            ; SWAP marker
SWAP_10   PHA                 ; save marker
          JSR Get_Integer     ; get byte count
          JSR Map_IO
          STY DMA_CNT_LO
          STA DMA_CNT_HI
          JSR Comma_And_LINNUM ; get internal address
          JSR Map_IO
          STY DMA_CBM_LO
          STA DMA_CBM_HI
          JSR Comma_And_LINNUM ; get external address
          JSR Map_IO
          STY DMA_REU_LO
          STA DMA_REU_HI
          JSR Comma_And_Byte   ; get external bank
          CPX #16              ; limit to 1 Mbyte
          BCS SWAP_Err
          JSR Map_IO
          STX DMA_REU_BA
          PLA                  ; restore marker
          TAY                  ; Y = marker
          LDX USER_BANK        ; user bank
          JMP K_DMA            ; do it
SWAP_Err  JMP Error_Illegal_Quantity

; **********************
  FAC1_Round_INT ; $aa68
; **********************

          JSR Round_FAC1
          JMP FAC1_INT

; ********************
  Output_Comma ; $aa6e
; ********************

          JSR FNDPNT_from_Bank_1
          CMP #','
          BNE OuCo_10
          LDA BLFD            ; fill character
          JSR Chrout_Using
          INY
OuCo_10   SEC
          ROR DOLR            ; flag dollar used
          RTS


          .FILL $ae63-* , $ff

; *****************
  EasterEgg ; $ae63
; *****************

          .BYTE $7b,$e9,$77,$6a,$5f,$5e,$5d,$be
          .BYTE $21,$3d,$24,$37,$3f,$22,$55,$20
          .BYTE $24,$4a,$30,$27,$3a,$4e,$2f,$35
          .BYTE $4d,$4c,$4f,$40,$47,$46,$68,$69
          .BYTE $88,$15,$1f,$0c,$08,$1f,$0f,$19
          .BYTE $69,$5f,$71,$96,$05,$13,$11,$74
          .BYTE $89,$05,$1e,$0d,$01,$43,$6d,$98
          .BYTE $06,$10,$13,$19,$67,$94,$1c,$05
          .BYTE $75,$37,$19,$ee,$70,$70,$1d,$f9
          .BYTE $61,$66,$66,$79,$79,$73,$38,$39
          .BYTE $e3,$6f,$7b,$6c,$78,$6f,$7f,$69
          .BYTE $19,$2f,$01,$e2,$6e,$6a,$05,$ec
          .BYTE $5e,$48,$5d,$15,$3f,$da,$5c,$4a
          .BYTE $56,$32,$d9,$51,$4e,$58,$5c,$51
          .BYTE $06,$2a,$cf,$5a,$4e,$40,$46,$2c
          .BYTE $d3,$43,$4d,$41,$4e,$47,$08,$09
          .BYTE $e9,$36,$b0,$b6,$b4,$de,$bc,$ae
          .BYTE $be,$a1,$dd,$b4,$b8,$b8,$d2,$a0
          .BYTE $cb,$a7,$a8,$a3,$aa,$ce,$b9,$a4
          .BYTE $a6,$af,$cf,$ed,$e7

          .FILL $af00-* ,0

; ************************
  BASIC_Jump_Table ; $af00
; ************************

          JMP Real_To_Integer
          JMP Integer_To_Real
          JMP Format_FAC1
          JMP VAL_10
          JMP FAC1_To_LINNUM
          JMP Word_To_FAC1
          JMP AY_Minus_FAC1
          JMP OP_MINUS
          JMP Add_Var_AY_To_FAC1
          JMP OP_PLUS
          JMP AY_Mult_FAC1
          JMP OP_MULT
          JMP AY_Divided_By_FAC1
          JMP OP_DIV
          JMP FUNC_LOG
          JMP FUNC_INT
          JMP FUNC_SQR
          JMP OP_NEG
          JMP POT_XY
          JMP OP_POWER
          JMP FUNC_EXP
          JMP FUNC_COS
          JMP FUNC_SIN
          JMP FUNC_TAN
          JMP FUNC_ATN
          JMP Round_FAC1
          JMP FUNC_ABS
          JMP Test_FAC1_Sign
          JMP Compare_AY_FAC1
          JMP RND_10
          JMP Load_FAC2_From_AY_RAM
          JMP Load_FAC2_From_AY_ROM
          JMP LoVa_70
          JMP Load_FAC1_AY
          JMP FAC1_To_XY
          JMP FAC2_To_FAC1
          JMP FAC1_Round_And_Copy_To_FAC2
          JMP BASIC_Operator
          JMP Draw_Line
          JMP Double_Pixel
          JMP CIRC_SUB
          JMP BASIC_RUN
          JMP Reset_BASIC_Execution
          JMP BASIC_CLR
          JMP BASIC_NEW
          JMP Relink
          JMP CRUNCH
          JMP Search_BASIC_Line
          JMP Next_Statement
          JMP Vectored_EVAL
          JMP Eval_Expression
          JMP LINK_RUN
          JMP Set_Run_Mode
          JMP Scan_Linenumber
          JMP Garbage_Collection
          JMP MAIN_02

          .FILL $b000-* ,$ff ;   88 bytes

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
          .TEXT "\rBREAK",7,0
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
          .TEXT "\rMONITOR",0

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
          .TEXT "\r    PC  SR AC XR YR SP\r; "
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

cmdchr    .TEXT "ACDFGHJMRTX@.>;"
cmdnum    .TEXT "$+&%"
          .TEXT "LSV"
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
          .byte $2c ;BIT

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
          AND #%00010000     ; $10 check verify error flag
          BEQ MLS_50          ; -> OK
          LDA K_VERCK
          BEQ MLS_30          ; was loading -> OK
          JSR K_PRIMM         ; start verify error message
          .TEXT " ERROR",0
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
          .TEXT "A ",ESC,"Q",0
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
          .TEXT "   ",0       ; no opcode, print blanks
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
Mon_Char1  .TEXT ",", ")", ",", "#", "(", "$"
Mon_Char2  .TEXT "Y",  0 , "X", "$", "$",  0

; ********************
  Mon_Mne_Left ; $b721
; ********************

          .BYTE $1C,$8A,$1C,$23,$5D,$8B,$1B,$A1
          .BYTE $9D,$8A,$1D,$23,$9D,$8B,$1D,$A1
          .BYTE $00,$29,$19,$AE,$69,$A8,$19,$23
          .BYTE $24,$53,$1B,$23,$24,$53,$19,$A1
          .BYTE $00,$1A,$5B,$5B,$A5,$69,$24,$24
          .BYTE $AE,$AE,$A8,$AD,$29,$00,$7C,$00
          .BYTE $15,$9C,$6D,$9C,$A5,$69,$29,$53
          .BYTE $84,$13,$34,$11,$A5,$69,$23,$A0

;         .TEXT >"BRK"
;         .TEXT >"PHP"
;         .TEXT >"BPL"
;         .TEXT >"CLC"
;         .TEXT >"JSR"
;         .TEXT >"PLP"
;         .TEXT >"BMI"
;         .TEXT >"SEC"
;         .TEXT >"RTI"
;         .TEXT >"PHA"
;         .TEXT >"BVC"
;         .TEXT >"CLI"
;         .TEXT >"RTS"
;         .TEXT >"PLA"
;         .TEXT >"BVS"
;         .TEXT >"SEI"
;         .TEXT >"???"
;         .TEXT >"DEY"
;         .TEXT >"BCC"
;         .TEXT >"TYA"
;         .TEXT >"LDY"
;         .TEXT >"TAY"
;         .TEXT >"BCS"
;         .TEXT >"CLV"
;         .TEXT >"CPY"
;         .TEXT >"INY"
;         .TEXT >"BNE"
;         .TEXT >"CLD"
;         .TEXT >"CPX"
;         .TEXT >"INX"
;         .TEXT >"BEQ"
;         .TEXT >"SED"
;         .TEXT >"???"
;         .TEXT >"BIT"
;         .TEXT >"JMP"
;         .TEXT >"JMP"
;         .TEXT >"STY"
;         .TEXT >"LDY"
;         .TEXT >"CPY"
;         .TEXT >"CPX"
;         .TEXT >"TXA"
;         .TEXT >"TXS"
;         .TEXT >"TAX"
;         .TEXT >"TSX"
;         .TEXT >"DEX"
;         .TEXT >"???"
;         .TEXT >"NOP"
;         .TEXT >"???"
;         .TEXT >"ASL"
;         .TEXT >"ROL"
;         .TEXT >"LSR"
;         .TEXT >"ROR"
;         .TEXT >"STX"
;         .TEXT >"LDX"
;         .TEXT >"DEC"
;         .TEXT >"INC"
;         .TEXT >"ORA"
;         .TEXT >"AND"
;         .TEXT >"EOR"
;         .TEXT >"ADC"
;         .TEXT >"STA"
;         .TEXT >"LDA"
;         .TEXT >"CMP"
;         .TEXT >"SBC"

; *********************
  Mon_Mne_Right ; $b761
; *********************

          .BYTE $D8,$62,$5A,$48,$26,$62,$94,$88
          .BYTE $54,$44,$C8,$54,$68,$44,$E8,$94
          .BYTE $00,$B4,$08,$84,$74,$B4,$28,$6E
          .BYTE $74,$F4,$CC,$4A,$72,$F2,$A4,$8A
          .BYTE $00,$AA,$A2,$A2,$74,$74,$74,$72
          .BYTE $44,$68,$B2,$32,$B2,$00,$22,$00
          .BYTE $1A,$1A,$26,$26,$72,$72,$88,$C8
          .BYTE $C4,$CA,$26,$48,$44,$44,$A2,$C8
          .BYTE $0D,$20,$20,$20

;         .TEXT <"BRK"
;         .TEXT <"PHP"
;         .TEXT <"BPL"
;         .TEXT <"CLC"
;         .TEXT <"JSR"
;         .TEXT <"PLP"
;         .TEXT <"BMI"
;         .TEXT <"SEC"
;         .TEXT <"RTI"
;         .TEXT <"PHA"
;         .TEXT <"BVC"
;         .TEXT <"CLI"
;         .TEXT <"RTS"
;         .TEXT <"PLA"
;         .TEXT <"BVS"
;         .TEXT <"SEI"
;         .TEXT <"???"
;         .TEXT <"DEY"
;         .TEXT <"BCC"
;         .TEXT <"TYA"
;         .TEXT <"LDY"
;         .TEXT <"TAY"
;         .TEXT <"BCS"
;         .TEXT <"CLV"
;         .TEXT <"CPY"
;         .TEXT <"INY"
;         .TEXT <"BNE"
;         .TEXT <"CLD"
;         .TEXT <"CPX"
;         .TEXT <"INX"
;         .TEXT <"BEQ"
;         .TEXT <"SED"
;         .TEXT <"???"
;         .TEXT <"BIT"
;         .TEXT <"JMP"
;         .TEXT <"JMP"
;         .TEXT <"STY"
;         .TEXT <"LDY"
;         .TEXT <"CPY"
;         .TEXT <"CPX"
;         .TEXT <"TXA"
;         .TEXT <"TXS"
;         .TEXT <"TAX"
;         .TEXT <"TSX"
;         .TEXT <"DEX"
;         .TEXT <"???"
;         .TEXT <"NOP"
;         .TEXT <"???"
;         .TEXT <"ASL"
;         .TEXT <"ROL"
;         .TEXT <"LSR"
;         .TEXT <"ROR"
;         .TEXT <"STX"
;         .TEXT <"LDX"
;         .TEXT <"DEC"
;         .TEXT <"INC"
;         .TEXT <"ORA"
;         .TEXT <"AND"
;         .TEXT <"EOR"
;         .TEXT <"ADC"
;         .TEXT <"STA"
;         .TEXT <"LDA"
;         .TEXT <"CMP"
;         .TEXT <"SBC"

;         .TEXT "\r   "       ; unused

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
          AND #%11110000     ; check bank value
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
          .TEXT CR,ESC,"Q ",0
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
          .byte $2c ;BIT
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
          AND #%10111111     ; check EOI flag
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

          .FILL $bfc0-* ,$ff ; 1102 bytes

          .TEXT "(C)1986 COMMODORE ELECTRONICS"
          .TEXT ", LTD. ALL RIGHTS RESERVED."
          .BYTE $ff,$ff,$ff,$ff,$c8,$cd
          .WORD $c501 ; 15103

; **************************
; EDITOR ROM ; $c000 - $cfff
; **************************

E_CINT    JMP Edit_Initialize
E_DISPLAY JMP Edit_Display
E_GETKEY  JMP Edit_Get_Key
E_GETSCR  JMP Edit_Get_Screen
E_PRINT   JMP Edit_Print
E_SCRORG  JMP Edit_Get_Window
.if KEYBOARD == 255
E_KEY     JMP Scan_Keyboard
.else
E_KEY     JMP K_Scan_Keyboard
.endif
E_REPEAT  JMP Edit_Repeat
E_PLOT    JMP Edit_Plot
E_CURSOR  JMP Edit_Cursor
E_ESCAPE  JMP Edit_Escape_Switch
E_PFKEY   JMP Edit_Set_FKey
E_RASTER  JMP Edit_Raster
E_DLCHR   JMP Edit_Load_Chargen
E_SWAPPER JMP Edit_Screen_Swapper
E_WINDOW  JMP Edit_Window_Corner

          .BYTE $ff,$ff,$ff

; ********************
  E_40_Line_Lo ; $c033
; ********************

          .BYTE <[VIC_TEXT +  0 * 40]
          .BYTE <[VIC_TEXT +  1 * 40]
          .BYTE <[VIC_TEXT +  2 * 40]
          .BYTE <[VIC_TEXT +  3 * 40]
          .BYTE <[VIC_TEXT +  4 * 40]
          .BYTE <[VIC_TEXT +  5 * 40]
          .BYTE <[VIC_TEXT +  6 * 40]
          .BYTE <[VIC_TEXT +  7 * 40]
          .BYTE <[VIC_TEXT +  8 * 40]
          .BYTE <[VIC_TEXT +  9 * 40]
          .BYTE <[VIC_TEXT + 10 * 40]
          .BYTE <[VIC_TEXT + 11 * 40]
          .BYTE <[VIC_TEXT + 12 * 40]
          .BYTE <[VIC_TEXT + 13 * 40]
          .BYTE <[VIC_TEXT + 14 * 40]
          .BYTE <[VIC_TEXT + 15 * 40]
          .BYTE <[VIC_TEXT + 16 * 40]
          .BYTE <[VIC_TEXT + 17 * 40]
          .BYTE <[VIC_TEXT + 18 * 40]
          .BYTE <[VIC_TEXT + 19 * 40]
          .BYTE <[VIC_TEXT + 20 * 40]
          .BYTE <[VIC_TEXT + 21 * 40]
          .BYTE <[VIC_TEXT + 22 * 40]
          .BYTE <[VIC_TEXT + 23 * 40]
          .BYTE <[VIC_TEXT + 24 * 40]

; ********************
  E_40_Line_Hi ; $c04c
; ********************

          .BYTE >[VIC_TEXT +  0 * 40]
          .BYTE >[VIC_TEXT +  1 * 40]
          .BYTE >[VIC_TEXT +  2 * 40]
          .BYTE >[VIC_TEXT +  3 * 40]
          .BYTE >[VIC_TEXT +  4 * 40]
          .BYTE >[VIC_TEXT +  5 * 40]
          .BYTE >[VIC_TEXT +  6 * 40]
          .BYTE >[VIC_TEXT +  7 * 40]
          .BYTE >[VIC_TEXT +  8 * 40]
          .BYTE >[VIC_TEXT +  9 * 40]
          .BYTE >[VIC_TEXT + 10 * 40]
          .BYTE >[VIC_TEXT + 11 * 40]
          .BYTE >[VIC_TEXT + 12 * 40]
          .BYTE >[VIC_TEXT + 13 * 40]
          .BYTE >[VIC_TEXT + 14 * 40]
          .BYTE >[VIC_TEXT + 15 * 40]
          .BYTE >[VIC_TEXT + 16 * 40]
          .BYTE >[VIC_TEXT + 17 * 40]
          .BYTE >[VIC_TEXT + 18 * 40]
          .BYTE >[VIC_TEXT + 19 * 40]
          .BYTE >[VIC_TEXT + 20 * 40]
          .BYTE >[VIC_TEXT + 21 * 40]
          .BYTE >[VIC_TEXT + 22 * 40]
          .BYTE >[VIC_TEXT + 23 * 40]
          .BYTE >[VIC_TEXT + 24 * 40]


; ********************
  Edit_Vectors ; $c065
; ********************

          .WORD Edit_Use_Ctrl
          .WORD Edit_Print_Shifted
          .WORD Edit_Escape_Switch
          .WORD Edit_Use_Scancode
          .WORD Edit_Use_Function_Key

; ************************
  ASCII_Key_Tables ; $c06f
; ************************

          .WORD Keytab_Normal
          .WORD Keytab_Shifted
          .WORD Keytab_CBM
          .WORD Keytab_Control
          .WORD Keytab_Normal
          .WORD Keytab_Capslock

; ***********************
  Edit_Initialize ; $c07b
; ***********************

          LDA #3              ; set Video Address VA14 and VA15
          ORA CIA2_PRA
          STA CIA2_PRA        ; store it
          LDA #%11111011     ; $fb
          AND R8502           ; switch $D000 to character ROM
          ORA #%00000010     ; $02
          STA R8502           ; switch $E000-$FFF to ROM
          JSR K_CLRCH         ; reset I/O channels
          LDA #0
.if KEYBOARD == 255
          STA SID_Volume
.else
          JSR Edit_Patch_DIN  ; Zero DINFLG and SID_Volume
.endif
          STA GRAPHM
          STA MODE_80
          STA NDX
          STA KYNDX
          STA CRSW
          STA PAUSE
          STA BLNON
          STA CHAREN
          STA VDC_RAM_PAGE    ; VDC base address = $0000
          LDA #$14
          STA VSH_TEXT        ; VIC text
          LDA #$78
          STA VSH_BITMAP      ; VIC bitmap
          LDA #8
          STA VDC_ATT_PAGE    ; VDC attribute RAM = $0800
          LDA E_40_Line_Hi
          STA VIC_RAM_PAGE    ; VIC text RAM
          LDA #10
          STA XMAX            ; max lenth of keyboad queue
          STA BLNCT           ;
          STA BLNSW           ; Not zero: blinking off
          STA DELAY
          LDA #4
          STA KOUNT
          JSR Set_Default_Tabstops
          STA RPTFLG          ; $80 = all keys repeat
          ORA MMU_MODE
          STA MMU_MODE
          LDA #$60
          STA CURMOD          ; normal blinking
          LDA #$d0
          STA VSH_SPLIT

          LDX #$1a
CINT_10   LDA ZP_40_COL,X     ; store default ZP values
          STA PNT,X           ; for 40 column screen in zero page
          LDA ZP_80_COL,X     ; store default ZP values
          STA ZP_SW_COL,X     ; for 80 column screen in swap area
          DEX
          BPL CINT_10

          LDX #9
CINT_20   LDA Edit_Vectors,X
          STA CTLVEC,X
          DEX
          BPL CINT_20
          BIT INIT_STATUS
          BVS CINT_40
.if KEYBOARD == 255
          LDX #$0B
CINTUS_10 LDA ASCII_Key_Tables,X
          STA DECODE,X
          DEX
          BPL CINTUS_10
.else
          JSR DIN_or_ASCII
          LDA #0
          STA DECODE+1
          JSR K_Scan_Keyboard
.endif
          LDX #$4c
CINT_30   LDA Edit_Default_FK,X
          STA PKYBUF,X
          DEX
          BPL CINT_30
          LDA #$40 ; '@'
          ORA INIT_STATUS
          STA INIT_STATUS
CINT_40   JSR Edit_Screen_Swapper
          JSR Set_Default_Tabstops
          JSR Set_Fullscreen
          JSR Clear_Window
          JSR Edit_Screen_Swapper
          JSR Set_Fullscreen
          JSR Clear_Window
          BIT MMU_MODE
          BMI CINT_Ret
          JSR Edit_Screen_Swapper
CINT_Ret  RTS

; ********************
  Clear_Window ; $c142
; ********************

          JSR Cursor_To_Window_Home
ClWi_10   JSR Set_Screen_Pointer_X
          JSR Clear_Window_Row_X
          CPX Margin_Bottom
          INX
          BCC ClWi_10

; *****************************
  Cursor_To_Window_Home ; $c150
; *****************************

          LDX Margin_Top
          STX Cursor_Row
          STX CurLst_Row

; *****************************
  Cursor_To_Left_Margin ; $c156
; *****************************

          LDY Margin_Left
          STY Cursor_Col
          STY CurLst_Col

; **************************
  Set_Screen_Pointer ; $c15c
; **************************

          LDX Cursor_Row

; ****************************
  Set_Screen_Pointer_X ; $c15e
; ****************************

          LDA E_40_Line_Lo,X
          BIT MODE_80
          BPL SSPX_10         ; -> 40 columns
          ASL A
SSPX_10   STA PNT             ; address low
          LDA E_40_Line_Hi,X
          AND #%00000011     ; use lowest bits
          BIT MODE_80
          BPL SSPX_20         ; -> 40 columns
          ROL A               ; double value + carry, clear carry
          ORA VDC_RAM_PAGE    ; 80 column address high
          BCC SSPX_30         ; always
SSPX_20   ORA VIC_RAM_PAGE    ; 40 column address high
SSPX_30   STA PNT+1           ; PNT = pointer to start of row X

; *****************************
  Set_Attribute_Pointer ; $c17c
; *****************************

          LDA PNT
          STA USER
          LDA PNT+1
          BIT MODE_80
          BPL SAP_10          ; -> 40 columns
          AND #%00000111     ; $07
          ORA VDC_ATT_PAGE
          BNE SAP_20          ; always
SAP_10    AND #%00000011     ; $03
          ORA #%11011000     ; $d8
SAP_20    STA USER+1
          RTS

; *******************
  Edit_Raster ; $c194
; *******************

          SEC
          LDA VIC_IRQ_REG
          AND #%00000001     ; raster interrupt ?
          BEQ RAST_10         ; -> no
          STA VIC_IRQ_REG     ; reset raster interrupt
          LDA GRAPHM          ; load graphics mode
          CMP #$ff            ; text/graphic/split ?
RAST_10   BEQ RAST_80         ;
          BIT VIC_Ctrl_1
          BMI RAST_20         ; -> branch on RST8 set
          AND #%01000000     ; test split screen
          BNE RAST_50         ; -> branch on split screen
RAST_20   SEC
          LDA GRAPHM
          BEQ RAST_50
          BIT GRAPHM
          BVC RAST_30         ; -> no split screen
          LDA VSH_SPLIT       ; VIC split shadow register
          STA VIC_RASTER
RAST_30   LDA R8502
          AND #%11111101     ; $E000-$EFFF : RAM
          ORA #%00000100     ; $D000-$Dfff : I/O
          PHA                 ; save mask
          LDA VSH_BITMAP      ; save bitmap pointer
          PHA
          LDA VIC_Ctrl_1
          AND #%01111111     ; reset bit8 of raster register
          ORA #%00100000     ; enable bitmap mode
          TAY                 ; save mask in Y
          LDA VIC_Ctrl_2
          BIT GRAPHM
          BMI RAST_40         ; -> multi color mode
          AND #%11101111     ; Disable multi color mode
          .byte $2c ;BIT                 ; skip next statement
RAST_40   ORA #%00010000     ; Enable multi color mode
          TAX                 ; save mask in X
          BNE RAST_70         ; branch always
RAST_50   LDA #$ff
          STA VIC_RASTER
          LDA R8502
          ORA #%00000010     ; $E000-$FFFF : Kernal  ROM
          AND #%11111011     ; $D000-$DFFF : Chargen ROM
          ORA CHAREN
          PHA                 ; save mask
          LDA VSH_TEXT
          PHA
          LDA VIC_Ctrl_1
          AND #%01011111     ; switch off bitmap mode
          TAY                 ; save mask in Y
          LDA VIC_Ctrl_2
          AND #%11101111     ; switch off multi color mode
          TAX                 ; save mask in X
          BCS RAST_70

          LDX #7              ; wait 0.03 ms
RAST_60   DEX
          BNE RAST_60
          NOP
          NOP
          TAX

RAST_70   PLA
          STA VIC_Memory
          PLA
          STA R8502
          STY VIC_Ctrl_1
          STX VIC_Ctrl_2
RAST_80   BCS RAST_90
          LDA VIC_SPEED
          AND #%00000001     ; mask CUP speed
          BEQ RAST_90         ; -> branch on 1 MHz
          LDA GRAPHM
          AND #%01000000     ; test split screen
          BEQ RAST_90         ; -> branch if not
          LDA VIC_Ctrl_1
          BPL RAST_90         ; -> RST8 clear
          SEC
RAST_90   CLI                 ; enable interrupts
          BCC RAST_Ret        ; -> skip key and cursor routines
.if KEYBOARD == 255
          JSR Scan_Keyboard
.else
          JSR K_Scan_Keyboard             ; scan keyboard
.endif
          JSR Blink_Cursor    ; blink cursor
          SEC
RAST_Ret  RTS

; ********************
  Edit_Get_Key ; $c234
; ********************

; look first for characters from function keys

          LDX KYNDX           ; chars in function key buffer
          BEQ GETK_10         ; -> none
          LDY KEYIDX          ; get text index
          LDA PKYDEF,Y        ; get next char
          DEC KYNDX           ; decrement remaining chars
          INC KEYIDX          ; increment index
          CLI                 ; enable interrupts
          CLC                 ; C=0 got new char
          RTS                 ; and return

; now look into the keyboard buffer

GETK_10   LDY KEYD            ; load next char into Y
GETK_20   LDA KEYD+1,X        ; scroll keyboard buffer
          STA KEYD,X
          INX
          CPX NDX
          BNE GETK_20         ; loop
          DEC NDX             ; decrement chars in buffer
          TYA                 ; A = char to return
          CLI                 ; enable interrupts
          CLC                 ; C=0 got new char
          RTS                 ; and return

GETK_30   JSR Edit_Print           ; display char
GETK_40   JSR Edit_Cursor_On
GETK_50   LDA NDX             ; chars in buffer
          ORA KYNDX           ; chars from function key
          BEQ GETK_50         ; -> waitloop if none

          JSR Edit_Cursor_Off
          JSR Edit_Get_Key    ; get next char
          CMP #CR
          BNE GETK_30         ; -> loop if not CR
          STA CRSW            ; not zero: screen input
          LDA #0
          STA QTSW            ; clear quote switch
          JSR Edit_Cursor_Last
          STX LINTMP
          JSR Start_Of_Line
          LDY Margin_Left
          LDA CurLst_Row
          BMI GETK_80         ; -> coupled row
          CMP Cursor_Row
          BCC GETK_80         ; -> input row != cursor row
          LDY CurLst_Col
          CMP LINTMP          ; input column == last input column ?
          BNE GETK_60         ; -> no
          CPY Cursor_End
          BEQ GETK_70         ; -> yes
GETK_60   BCS GETS_10
GETK_70   STA Cursor_Row
GETK_80   STY Cursor_Col
          JMP GETS_25

; ***********************
  Edit_Get_Screen ; $c29b
; ***********************

          TYA
          PHA                 ; save Y
          TXA
          PHA                 ; save X
          LDA CRSW            ; Cursor Wait ?
          BEQ GETK_40         ; -> get key
          BPL GETS_25         ; -> get char from screen RAM

GETS_10   LDA #0
          STA CRSW
          LDA #CR
          LDX #3
          CPX DFLTN
          BEQ GETS_15         ; -> input from screen
          CPX DFLTO
          BEQ GETS_20         ; -> output to screen
GETS_15   JSR Edit_Print
GETS_20   LDA #CR
          BNE GETS_55         ; -> exit with CR

GETS_25   JSR Set_Screen_Pointer
          JSR Edit_Get_Char
          STA DATAX           ; display code
          AND #%00111111
          ASL DATAX
          BIT DATAX
          BPL GETS_30
          ORA #%10000000
GETS_30   BCC GETS_35
          LDX QTSW
          BNE GETS_40
GETS_35   BVS GETS_40
          ORA #%01000000
GETS_40   JSR Edit_Toggle_Quote
          LDY Cursor_Row
          CPY LINTMP
          BCC GETS_45
          LDY Cursor_Col
          CPY Cursor_End
          BCC GETS_45
          ROR CRSW            ; set bit 7 of CRSW
          BMI GETS_50         ; always

GETS_45   JSR Edit_Cursor_Right
GETS_50   CMP #$de            ; Pi in display code
          BNE GETS_55
          LDA #$ff            ; Pi PETSCII
GETS_55   STA DATAX
          PLA
          TAX
          PLA
          TAY
          LDA DATAX
          CLC
          RTS

; *************************
  Edit_Toggle_Quote ; $c2ff
; *************************

          CMP #QUOTE
          BNE EdTQ_Ret
          LDA QTSW
          EOR #1
          STA QTSW
          LDA #QUOTE
EdTQ_Ret  RTS

; ***********************
  Edit_Print_Exit ; $c30c
; ***********************

          LDA DATAX           ; printed character
          STA LSTCHR          ; remember it
          JSR Edit_Cursor          ; update cursor
          LDA INSRT           ; outstanding inserts ?
          BEQ EdPE_10         ; -> no
          LSR QTSW            ; clear quote mode
EdPE_10   PLA
          TAY                 ; pull Y
          PLA
          TAX                 ; pull X
          PLA                 ; pull A
          CLC                 ; status OK
          RTS

; ***********************
  Print_To_Screen ; $c320
; ***********************

          ORA #$40
PTS_10    LDX E_Reverse
          BEQ PTS_30
PTS_20    ORA #$80            ; set reverse bit
PTS_30    LDX INSRT           ; insert mode ?
          BEQ PTS_40
          DEC INSRT           ; # of inserts pending
PTS_40    BIT INSFLG
          BPL PTS_50
          PHA
          JSR Edit_Shift_Text
          LDX #0
          STX INSRT           ; clear insert mode
          PLA
PTS_50    JSR Edit_Put_Char_Att

; ************************
  Edit_Cursor_Next ; $c33e
; ************************

          CPY Margin_Right
          BCC EdAC_10
          LDX Cursor_Row
          CPX Margin_Bottom
          BCC EdAC_10
          BIT Scroll_Locked
          BMI EdAC_Ret        ; -> scroll locked
EdAC_10   JSR Set_Screen_Pointer
          JSR Edit_Cursor_Right
          BCC EdAC_Ret        ; -> OK
          JSR Is_Coupled_Row
          BCS EdAC_20
          SEC
          BIT Scroll_Locked
          BVS EdAC_Ret
          JSR Edit_Scroll_Down
EdAC_20   CLC
EdAC_Ret  RTS

; ************************
  Edit_Cursor_Down ; $c363
; ************************

          LDX Cursor_Row
          CPX Margin_Bottom
          BCC EdCD_20         ; -> not at last row
          BIT Scroll_Locked
          BPL EdCD_10         ; -> scroll window
          LDA Margin_Top
          STA Cursor_Row      ; set cursor to upper margin
          BCS EdCD_30         ; branch always
EdCD_10   JSR Edit_Scroll_Up
          CLC
EdCD_20   INC Cursor_Row
EdCD_30   JMP Set_Screen_Pointer

; ************************
  Edit_Scroll_Down ; $c37c
; ************************

          LDX CurLst_Row
          BMI EdSD_10         ; -> cont row
          CPX Cursor_Row
          BCC EdSD_10
          INC CurLst_Row
EdSD_10   LDX Margin_Bottom
EdSD_20   JSR Set_Screen_Pointer_X
          LDY Margin_Left     ; copy row from left to right margin
          CPX Cursor_Row
          BEQ EdSD_30         ; -> finish at cursor row
          DEX
          JSR Is_Coupled_Row_X
          INX
          JSR Toggle_Cont_Flag_X
          DEX
          JSR Scroll_Row      ; X = source row
          JMP EdSD_20
EdSD_30   JSR Clear_Window_Row_X
          JMP Set_Cont_Flag

; **********************
  Edit_Scroll_Up ; $c3a6
; **********************

          LDX Margin_Top
ScUp_10   INX
          JSR Is_Coupled_Row_X
          BCC ScUp_20         ; -> single row
          CPX Margin_Bottom
          BCC ScUp_10
          LDX Margin_Top
          INX
          JSR Clear_Cont_Flag
ScUp_20   DEC Cursor_Row
          BIT CurLst_Row
          BMI ScUp_30         ; -> continuation row
          DEC CurLst_Row
ScUp_30   LDX Margin_Top
          CPX E_Row
          BCS ScUp_40
          DEC E_Row
ScUp_40   JSR Scroll_Window
          LDX Margin_Top
          JSR Is_Coupled_Row_X
          PHP
          JSR Clear_Cont_Flag
          PLP
          BCC ScUp_Ret
          BIT Scroll_Locked
          BMI Edit_Scroll_Up
ScUp_Ret  RTS

; *********************
  Scroll_Window ; $c3dc
; *********************

          JSR Set_Screen_Pointer_X
          LDY Margin_Left
          CPX Margin_Bottom
          BCS ScWi_10
          INX
          JSR Is_Coupled_Row_X
          DEX
          JSR Toggle_Cont_Flag_X
          INX
          JSR Scroll_Row
          JMP Scroll_Window

ScWi_10   JSR Clear_Window_Row_X
          LDA #$7f            ; test col 7
          STA CIA1_KBD_COL
          LDA CIA1_KBD_ROW
          CMP #%11011111    ; Commodore key ?
          BNE ScWi_Ret

; delay loop if Commodore key is held down

          LDY #0
ScWi_20   NOP
          DEX
          BNE ScWi_20
          DEY
          BNE ScWi_20
ScWi_Ret  RTS

; ******************
  Scroll_Row ; $c40d
; ******************

          BIT MODE_80
          BMI ScRo_20         ; -> 80 column screen
          LDA E_40_Line_Lo,X
          STA E_End           ; character low
          STA E_Beg           ; colour    low
          LDA E_40_Line_Hi,X
          AND #%00000011
          ORA VIC_RAM_PAGE
          STA E_Beg+1         ; character high
          AND #%00000011     ; $03
          ORA #%11011000     ; $d8
          STA E_End+1         ; colour    high
ScRo_10   LDA (E_Beg),Y
          STA (PNT),Y         ; copy character
          LDA (E_End),Y
          STA (USER),Y        ; copy colour
          CPY Margin_Right
          INY
          BCC ScRo_10
          RTS

; scroll row in 80 column mode

ScRo_20   STX VDC_ROW      ; save row
          STY VDC_COL      ; save col
          LDX #$18            ; VDC reg $18
          JSR VDC_Read_Register_X
          ORA #%10000000     ; $80
          JSR VDC_Write_Register_X
          JSR VDC_Set_Char_Address
          LDX VDC_ROW
          LDA E_40_Line_Lo,X
          ASL A
          STA E_Beg
          LDA E_40_Line_Hi,X
          AND #%00000011 ; $03
          ROL A
          ORA VDC_RAM_PAGE
          STA E_Beg+1
          LDX #$20            ; VDC reg $20
          CLC
          TYA
          ADC E_Beg
          STA E_Beg
          LDA #0
          ADC E_Beg+1
          STA E_Beg+1
          JSR VDC_Write_Register_X
          INX
          LDA E_Beg
          JSR VDC_Write_Register_X
          SEC
          LDX Margin_Right
          INX
          TXA
          SBC VDC_COL
          STA VDC_COL
          LDX #$1e
          JSR VDC_Write_Register_X
          LDX #$20
          LDA E_Beg+1
          AND #%00000111 ; $07
          ORA VDC_ATT_PAGE
          JSR VDC_Write_Register_X
          INX
          LDA E_Beg
          JSR VDC_Write_Register_X
          JSR VDC_Set_Attr_Address
          LDA VDC_COL
          LDX #$1e
          JSR VDC_Write_Register_X
          LDX VDC_ROW
          RTS

; **************************
  Clear_Window_Row_X ; $c4a5
; **************************

          LDY Margin_Left            ; start at left margin
          JSR Clear_Cont_Flag ; make this line single

; ************************
  Clear_Row_To_EOR ; $c4aa
; ************************

          JSR Set_Screen_Pointer_X
          BIT MODE_80
          BMI CRTE_20         ; -> 80 columns
          DEY                 ; pre increment loop
CRTE_10   INY
          LDA #' '
          STA (PNT),Y         ; store blank
          LDA E_Attribute
          STA (USER),Y        ; store color
          CPY Margin_Right
          BNE CRTE_10         ; -> loop
          RTS

; clear row in VDC 80 column

CRTE_20   STX VDC_ROW
          STY VDC_COL
          LDX #$18            ; COPY / vertical scrolling
          JSR VDC_Read_Register_X
          AND #%01111111     ; Clear COPY bit
          JSR VDC_Write_Register_X
          LDX #$12            ; Update address high
          CLC
          TYA                 ; column
          ADC PNT             ; + row address low
          PHA                 ; push
          STA VDC_UPDATE_LO
          LDA #0
          ADC PNT+1
          STA VDC_UPDATE_HI   ; VDC_UPDATE = PNT + Y
          JSR VDC_Write_Register_X
          INX
          PLA
          JSR VDC_Write_Register_X
          LDA #' '
          JSR VDC_Write_Data
          SEC
          LDA Margin_Right
          SBC VDC_COL         ; minus column
          PHA
          BEQ CRTE_30         ; -> at right margin
          TAX                 ; bytes to write
          SEC
          ADC VDC_UPDATE_LO
          STA VDC_UPDATE_LO
          LDA #0
          ADC VDC_UPDATE_HI
          STA VDC_UPDATE_HI   ; VDC_UPDATE = address of right margin
          TXA                 ; count
          JSR VDC_Fill_Char_A ; fill row with blanks

CRTE_30   LDX #$12            ; Update address high
          CLC
          TYA
          ADC USER
          PHA
          LDA #0
          ADC USER+1          ; write attribute address
          JSR VDC_Write_Register_X
          INX
          PLA
          JSR VDC_Write_Register_X
          LDA VDC_UPDATE_HI
          AND #%00000111 ; $07
          ORA VDC_ATT_PAGE
          STA VDC_UPDATE_HI
          LDA E_Attribute
          AND #%10001111 ; $8f
          JSR VDC_Write_Data  ; write attribute
          PLA
          BEQ CRTE_40
          JSR VDC_Fill_Char_A ; fill row with attribute
CRTE_40   LDX VDC_ROW      ; restore X
          LDY Margin_Right    ; restore Y
          RTS

VFCA_00   LDA #1

; ***********************
  VDC_Fill_Char_A ; $c53e
; ***********************

          LDX #$1e            ; word count
          JSR VDC_Write_Register_X
VFCA_10   BIT VDC_Register
          BPL VFCA_10
          LDX #$12            ; update high
          JSR VDC_Read_Register_X
          CMP VDC_UPDATE_HI
          BCC VFCA_00
          LDX #$13            ; update low
          JSR VDC_Read_Register_X
          CMP VDC_UPDATE_LO
          BCC VFCA_00
          RTS

; Keyboard matrix
; ===============

;-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;     | VIC Port $D02f  | CIA 1 - Port A - $DC00 keyboard column        |
;-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
; Row |  A  |  9  |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0  |
;-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;  0  | ALT | ESC | HLP |  1  |  BS |  +  |  9  |  7  |  5  |  3  | DEL |
;  1  |  0  |  +  |  8  | Arr |  *  |  P  |  I  |  Y  |  R  |  W  |  CR |
;  2  |  .  |  -  |  5  | CTL |  ;  |  L  |  J  |  G  |  D  |  A  | --> |
;  3  | CUP |  LF | TAB |  2  | HOM |  -  |  0  |  8  |  6  |  4  |  f7 |
;  4  | CDN |  CR |  2  | SPC | SHR |  .  |  M  |  B  |  C  |  Z  |  f1 |
;  5  | --> |  6  |  4  | CBM |  =  |  :  |  K  |  H  |  F  |  S  |  f3 |
;  6  | <-- |  9  |  7  |  Q  | Pnd |  @  |  O  |  U  |  T  |  E  |  f5 |
;  7  | NSC |  3  |  1  | STP |  /  |  ,  |  N  |  V  |  X  | SHL | CDN |
;-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+

; bits in SHFLAG
; --------------
; ....3...  ALT
; .....2..  Ctrl
; ......1.  CBM
; .......0  Shift (Left or Right)

; *********************
  Scan_Keyboard ; $c55d
; *********************

          LDA R8502
          AND #%01000000     ; extract bit 6 : ASCII/DIN
          EOR #%01000000     ; toggle  bit 6
          LSR A
          LSR A               ; bit 4 : 1 = DIN, 0 = ASCII
          STA SHFLAG          ; store in shift flag
          LDY #88             ; scan 88 keys (8 x 11 matrix)
          STY SFDX            ; key index
          LDA #0
          STA CIA1_KBD_COL    ; enable all columns
          STA VIC_KBD         ; enable VIC keyboard
          LDX CIA1_KBD_ROW    ; get keypress row
          CPX #$ff            ; any keys down ?
          BNE SKBD_10         ; -> handle keypress
          JMP REPE_25           ; -> exit scan routine
SKBD_10   TAY                 ; Y = 0
          LDA DECODE          ; (KEYTAB) := (DECODE)
          STA KEYTAB
          LDA DECODE+1
          STA KEYTAB+1
          LDA #$ff
          STA VIC_KBD
          ROL A               ; A = 1111 1110
SKBD_15   BIT SHFLAG          ; flag for Shift/Ctrl/CBM
          BMI SKBD_20         ; -> scan VIC port (col 8/9/A)
          STA CIA1_KBD_COL    ; use CIA column
          BPL SKBD_25         ; always

SKBD_20   STA VIC_KBD         ; use VIC column
SKBD_25   LDX #8              ; scan 8 rows per column
          PHA
SKBD_30   LDA CIA1_KBD_ROW    ; unclutter
          CMP CIA1_KBD_ROW
          BNE SKBD_30

SKBD_35   LSR A               ; test row bit
          BCS SKBD_50         ; -> key not pressed
          PHA                 ; push row value
          LDA (KEYTAB),Y
          CMP #8              ; ALT key
          BEQ SKBD_40
          CMP #5
          BCS SKBD_45         ; -> no special keys
          CMP #3
          BEQ SKBD_45         ; -> no special keys
SKBD_40   ORA SHFLAG          ; set flags for modifier keys
          STA SHFLAG
          .byte $2c ;BIT                 ; skip next instruction
SKBD_45   STY SFDX            ; key index
          PLA                 ; restore row value
SKBD_50   INY
          DEX
          BNE SKBD_35         ; -> loop row bits

          CPY #89
          BCS SKBD_55         ; -> finished
          PLA
          SEC
          ROL A
          BCS SKBD_15         ; -> handle next key
          STA CIA1_KBD_COL    ; select next column
          ROL SHFLAG
          SEC
          ROR SHFLAG
          ROL A
          BNE SKBD_15

SKBD_55   ASL SHFLAG
          LSR SHFLAG
          PLA
          LDA SFDX
          JMP (KEYVEC)        ; default: next statement

; *************************
  Edit_Use_Scancode ; $c5e1
; *************************

          CMP #$57            ; NO SCROLL key
          BNE SKBD_65
          BIT LOCKS           ; halted by Ctrl-S ?
          BVS SKBD_Ret        ; -> yes: no action
          LDA LSTHF           ; CBM-Shift delay ?
          BNE SKBD_Ret
          LDA #13             ; index for Ctrl-S
          EOR PAUSE
          STA PAUSE
          BVC SKBD_75         ; always

SKBD_65   LDA SHFLAG
          BEQ Edit_Repeat
          CMP #16             ; CAPS-LOCK/DIN ?
          BEQ SKBD_85         ; -> no
          CMP #8              ; ALT ?
          BEQ SKBD_90         ; -> no
          AND #7
          CMP #3              ; CBM or Shift ?
          BNE SKBD_80         ; -> yes
          LDA LOCKS
          BMI Edit_Repeat     ; -> Shiftr-CBM disabled
          LDA LSTHF           ; CBM-Shift delay ?
          BNE Edit_Repeat     ; -> decode key
          BIT MODE_80
          BPL SKBD_70         ; -> 40 column screen
          LDA E_Attribute
          EOR #$80
          STA E_Attribute
          JMP SKBD_75
SKBD_70   LDA VSH_TEXT
          EOR #2
          STA VSH_TEXT
SKBD_75   LDA #8
          STA LSTHF           ; set timer
          BNE Edit_Repeat          ; always

SKBD_80   ASL A
          CMP #8
          BCC SKBD_90         ; -> no Ctrl
          LDA #6              ; select Keytab_Control
          LDX SFDX
          CPX #13             ; key 'S' ?
          BNE SKBD_90         ; -> no
          BIT LOCKS
          BVS SKBD_90
          STX PAUSE           ; flag pause Ctrl-S
SKBD_Ret  RTS
SKBD_85   LDA #10             ; select Keytab_Capslock
SKBD_90   TAX
          LDA DECODE,X        ; set KEYRAB pointer
          STA KEYTAB
          LDA DECODE+1,X
          STA KEYTAB+1

; *******************
  Edit_Repeat ; $c651
; *******************

          LDY SFDX            ; key index
          LDA (KEYTAB),Y      ; key value
          TAX
          CPY LSTX            ; equal to last used index ?
          BEQ REPE_10         ; -> check repeat condition
          LDY #16
          STY DELAY           ; set initial delay
          BNE REPE_25         ; always

REPE_10   AND #$7f
          BIT RPTFLG
          BMI REPE_15         ; -> $80 = all keys repeat
          BVS UFK_20          ; -> $40 = no  keys repeat
          CMP #$7f            ; NO SCROLL ($ff)
          BEQ REPE_25         ; -> repeat not
          CMP #$14            ; DELETE / INSERT
          BEQ REPE_15         ; -> repeat
          CMP #' '            ; BLANK
          BEQ REPE_15         ; -> repeat
          CMP #RIGHT          ; cursor left / right
          BEQ REPE_15         ; -> repeat
          CMP #DOWN           ; cursor down / up
          BNE UFK_20          ; -> repeat not

; repeat key after initial delay time

REPE_15   LDY DELAY
          BEQ REPE_20         ; delay OK -> continue
          DEC DELAY
          BNE UFK_20          ; -> don't repeat while delaying

; repeat key after speed delay

REPE_20   DEC KOUNT
          BNE UFK_20          ; -> don't repeat too fast
          LDY #4
          STY KOUNT           ; set new speed counter
          LDY NDX             ; keys in buffer
          DEY
          BPL UFK_20          ; -> don't repeat if buffer is not empty

REPE_25   LSR LSTHF
          LDY SFDX
          STY LSTX            ; last index = current index
          CPX #$ff            ; NO SCROLL key ?
          BEQ UFK_20          ; -> finish
          LDA #0
          STA PAUSE           ; clear Ctrl-S, scroll lock
          TXA
          LDX SHFLAG
.if KEYBOARD == 255
          JMP (KEYCHK)
.else
          JMP Check_DIN
.endif

; *****************************
  Edit_Use_Function_Key ; $c6ad
; *****************************

          LDX #9
UFK_10    CMP FKey_Code,X
          BEQ UFK_30
          DEX
          BPL UFK_10
          LDX NDX
          CPX XMAX
          BCS UFK_20
          STA KEYD,X
          INX
          STX NDX
UFK_20    LDA #$7f
          STA CIA1_KBD_COL
          RTS
UFK_30    JMP UFK_40

          STA KYNDX           ; unused. replaced by patch
          LDA #0              ; startimg at UFK_40 ($cf00)
REPE_50   DEX                 ; *
          BMI REPE_55         ; *
          CLC                 ; *
          ADC PKYBUF,X        ; *
          BCC REPE_50         ; *
REPE_55   STA KEYIDX          ; *
          RTS                 ; *

; *****************
  FKey_Code ; $c6dd
; *****************

          .BYTE $85           ; f1   graphic
          .BYTE $89           ; f2   dload"
          .BYTe $86           ; f3   directory
          .BYTE $8a           ; f4   scnclr
          .BYTE $87           ; f5   dsave"
          .BYTE $8b           ; f6   run
          .BYTE $88           ; f7   list
          .BYTE $8c           ; f8   monitor
          .BYTE $83           ; RUN
          .BYTE $84           ; HELP

; ********************
  Blink_Cursor ; $c6e7
; ********************

          BIT MODE_80
          BMI BlCu_Ret        ; -> 80 column screen
          LDA BLNSW
          BNE BlCu_Ret        ; -> blinking off
          DEC BLNCT           ; blink counter
          BNE BlCu_Ret        ; -> no change yet
          LDA BLNON
          AND #$c0            ; blinking on, steady cursor
          CMP #$c0
          BEQ BlCu_Ret        ; -> nothing to do
          LDA #20
          STA BLNCT           ; restart blink timer
          LDY Cursor_Col
          LDX GDCOL
          LDA (PNT),Y         ; character under cursor
          BIT BLNON
          BMI BlCu_10         ; -> visible cursor phase
          STA GDBLN           ; save chracter under cursor
          JSR Set_Attribute_Pointer
          LDA (USER),Y        ; color under cursor
          STA GDCOL           ; save color under cursor
          LDX E_Attribute
          LDA GDBLN
BlCu_10   EOR #$80            ; toggle color
          JSR Edit_Display_AX
          LDA BLNON
          EOR #$80            ; toggle cursor blink phase
          STA BLNON
BlCu_Ret  RTS

; ******************
  Edit_Print ; $c72d
; ******************

          STA DATAX           ; save character to print
          PHA                 ; push A
          TXA
          PHA                 ; push X
          TYA
          PHA                 ; push Y
EdPr_10   LDA PAUSE
          BNE EdPr_10
          STA CRSW            ; 0 = keyboard input
          LDA #>Edit_Print_Exit-1
          PHA
          LDA #<Edit_Print_Exit-1
          PHA
          LDY Cursor_Col
          LDA DATAX
          CMP #CR
          BEQ EdPr_50         ; -> new line
          CMP #$8d            ; shift CR
          BEQ EdPr_50         ; -> new line
          LDX LSTCHR
          CPX #ESC
          BNE EdPr_20
          JMP Edit_Escape_Jump           ; ESC command
EdPr_20   TAX
          BPL EdPr_30
          JMP Edit_Jump_Shifted

EdPr_30   CMP #' '
          BCC Edit_Jump_Ctrl           ; control character
          CMP #$60
          BCC EdPr_40         ; normal character
          AND #%11011111
          .byte $2c ;BIT
EdPr_40   AND #%00111111
          JSR Edit_Toggle_Quote
          JMP PTS_10          ; print to screen

; print CR

EdPr_50   JSR Edit_Cursor_Last
          INX
          JSR Clear_Cont_Flag
          LDY Margin_Left
          STY Cursor_Col
          JSR Edit_Cursor_Down

; ***************************
  Edit_Attributes_Off ; $c77d
; ***************************

          LDA E_Attribute
          AND #%11001111 ; $cf
          STA E_Attribute
          LDA #0
          STA INSRT
          STA E_Reverse
          STA QTSW
          RTS

; *****************
  Ctrl_Code ; $c78c
; *****************

          .BYTE $02           ; Ctrl B
          .BYTE $07           ; Ctrl G
          .BYTE $09           ; TAB
          .BYTE $0a           ; Ctrl J
          .BYTE $0b           ; Ctrl K
          .BYTE $0c           ; Ctrl L
          .BYTE $0e           ; Ctrl N
          .BYTE $0f           ; Ctrl O
          .BYTE $11           ; Ctrl Q
          .BYTE $12           ; Ctrl R
          .BYTE $13           ; HOME
          .BYTE $14           ; DEL
          .BYTE $18           ; Ctrl X
          .BYTE $1d           ; Cursor Right

; *******************
  Ctrl_Action ; $c79a
; *******************

          .WORD Edit_Underline_On      - 1 ; Ctrl B Bold
          .WORD Ctrl_G_Bell            - 1
          .WORD Ctrl_I_Tab             - 1
          .WORD Ctrl_J_Linefeed        - 1
          .WORD Ctrl_K_Unlock_Charset  - 1
          .WORD Ctrl_L_Lock_Charset    - 1
          .WORD Edit_Charset_Text      - 1 ; Ctrl N Normal
          .WORD Edit_Blink_On          - 1 ; Ctrl O
          .WORD Ctrl_Q_Down            - 1
          .WORD Edit_Reverse_On        - 1 ; Ctrl R Reverse
          .WORD Edit_Home              - 1
          .WORD Edit_Delete            - 1
          .WORD Edit_Toggle_Tab        - 1
          .WORD Edit_Right             - 1

; **********************
  Edit_Jump_Ctrl ; $c7b6
; **********************

          JMP (CTLVEC)        ; default: next statement

; *********************
  Edit_Use_Ctrl ; $c7b9
; *********************

          CMP #ESC            ; Escape ?
          BEQ ICtr_80         ; -> no action
          LDX INSRT
          BNE ICtr_10         ; -> outstanding inserts
          CMP #DEL
          BEQ ICtr_20         ; -> Delete
          LDX QTSW
          BEQ ICtr_20         ; -> not in quotes
ICtr_10   LDX #0
          STX DATAX           ; ignore character
          JMP PTS_20
ICtr_20   LDX #13
ICtr_30   CMP Ctrl_Code,X
          BEQ ICtr_90         ; -> found code
          DEX
          BPL ICtr_30
ICtr_40   LDX #15
ICtr_50   CMP VIC_Color_Codes,X        ; search color codes
          BEQ ICtr_60
          DEX
          BPL ICtr_50
          RTS
ICtr_60   BIT MODE_80
          BMI ICtr_70
          STX E_Attribute
          RTS
ICtr_70   LDA E_Attribute
          AND #%11110000 ; $f0
          ORA VDC_Color_Codes,X
          STA E_Attribute
ICtr_80   RTS
ICtr_90   TXA
          ASL A
          TAX                 ; push address
          LDA Ctrl_Action+1,X
          PHA
          LDA Ctrl_Action,X
          PHA
          RTS                 ; jump via RTS

; *************************
  Edit_Jump_Shifted ; $c802
; *************************

          JMP (SHFVEC)        ; default: next statement

; **************************
  Edit_Print_Shifted ; $c805
; **************************

          AND #$7f            ; remove PETSCII shift bit
          CMP #' '
          BCC PrSh_20         ; -> control codes
          CMP #$7f
          BNE PrSh_10
          LDA #'^'            ; replace code $ff with $5e
PrSh_10   JMP Print_To_Screen

PrSh_20   LDX QTSW
          BEQ PrSh_40         ; -> not in quotemode
PrSh_30   ORA #%01000000     ; convert to display code
          JMP PTS_20

PrSh_40   CMP #DEL            ; INSERT ? (Shift DEL)
          BNE PrSh_50
          JMP Edit_Shift_Text

PrSh_50   LDX INSRT
          BNE PrSh_30         ; -> already in insert mode
          CMP #DOWN           ; Cursor UP ?
          BEQ Edit_Up
          CMP #RIGHT          ; Cursor LEFT ?
          BEQ Edit_Left
          CMP #14             ; graphics charset ? ($8e)
          BEQ EdCT_20
          CMP #REVERSE        ; Reverse off ? ($92)
          BNE PrSh_60
          JMP Edit_Reverse_Off

PrSh_60   CMP #C_ULINE        ; Underline off ? ($82)
          BNE PrSh_70
          JMP Edit_Underline_Off

PrSh_70   CMP #15             ; Blinking off ? ($8f)
          BNE PrSh_80
          JMP Edit_Blink_Off
PrSh_80   CMP #HOME           ; CLEAR ? ($93)
          BNE PrSh_90
          JMP Clear_Window
PrSh_90   ORA #$80            ; restore shift bit
          BNE ICtr_40         ; always

; ******************
  Edit_Right ; $c854
; ******************

          JSR Edit_Cursor_Right
          BCS Edit_Down
          RTS

; *******************
  Ctrl_Q_Down ; $c85a
; *******************

          JSR Edit_Cursor_Down

; *****************
  Edit_Down ; $c85d
; *****************

          JSR Is_Coupled_Row
          BCS EdDo_10
          SEC
          ROR CurLst_Row      ; flag coupled row
EdDo_10   CLC
EdDo_Ret  RTS

; ***************
  Edit_Up ; $c867
; ***************

          LDX Margin_Top
          CPX Cursor_Row
          BCS EdDo_Ret
EdUp_10   JSR Edit_Down
          DEC Cursor_Row
          JMP Set_Screen_Pointer

; *****************
  Edit_Left ; $c875
; *****************

          JSR Edit_Cursor_Left
          BCS EdDo_Ret
          BNE EdDo_10
          INC Cursor_Row
          BNE EdUp_10         ; always

; *************************
  Edit_Charset_Text ; $c880
; *************************

          BIT MODE_80
          BMI EdCT_10
          LDA VSH_TEXT
          ORA #%00000010 ; $02
          BNE EdCT_30         ; always

EdCT_10   LDA E_Attribute
          ORA #%10000000 ; $80
          STA E_Attribute
          RTS

EdCT_20   BIT MODE_80
          BMI EdCT_40
          LDA VSH_TEXT
          AND #%11111101 ; $fd
EdCT_30   STA VSH_TEXT
          RTS

EdCT_40   LDA E_Attribute
          AND #%01111111 ; $7f
          STA E_Attribute
          RTS

; *****************************
  Ctrl_K_Unlock_Charset ; $c8a6
; *****************************

          LDA #$80
          ORA LOCKS
          BMI LUCS_10

; ***************************
  Ctrl_L_Lock_Charset ; $c8ac
; ***************************

          LDA #$7f
          AND LOCKS
LUCS_10   STA LOCKS
          RTS

; *****************
  Edit_Home ; $c8b3
; *****************

          LDA LSTCHR
          CMP #HOME
          BNE EdHo_10
          JSR Set_Fullscreen  ; 2 x HOME sets fullsize window
EdHo_10   JMP Cursor_To_Window_Home

; ************************
  Edit_Reverse_Off ; $c8bf
; ************************

          LDA #0
          .byte $2c ;BIT

; ***********************
  Edit_Reverse_On ; $c8c2
; ***********************

          LDA #$80
          STA E_Reverse
          RTS

; *************************
  Edit_Underline_On ; $c8c7
; *************************

          LDA E_Attribute
          ORA #%00100000
          STA E_Attribute
          RTS

; **************************
  Edit_Underline_Off ; $c8ce
; **************************

          LDA E_Attribute
          AND #%11011111 ; $df
          STA E_Attribute
          RTS

; *********************
  Edit_Blink_On ; $c8d5
; *********************

          LDA E_Attribute
          ORA #%00010000
          STA E_Attribute
          RTS

; **********************
  Edit_Blink_Off ; $c8dc
; **********************

          LDA E_Attribute
          AND #%11101111 ; $ef
          STA E_Attribute
          RTS

; ***********************
  Edit_Shift_Text ; $c8e3
; ***********************

          JSR Edit_Save_Row_Col
          JSR Edit_Cursor_Last
          CPX E_Row           ; at last row ?
          BNE EdST_10         ; -> no
          CPY E_Col
EdST_10   BCC EdST_30
          JSR Edit_Cursor_Next
          BCS EdST_40
EdST_20   JSR Edit_Cursor_Left
          JSR Edit_Get_Char
          JSR Edit_Cursor_Right
          JSR Edit_Put_Char
          JSR Edit_Cursor_Left
          LDX Cursor_Row
          CPX E_Row
          BNE EdST_20
          CPY E_Col
          BNE EdST_20
          JSR Edit_Put_Blank
EdST_30   INC INSRT
          BNE EdST_40
          DEC INSRT
EdST_40   JMP EdDe_20

; *******************
  Edit_Delete ; $c91b
; *******************

          JSR Edit_Left
          JSR Edit_Save_Row_Col ; destination position
          BCS EdDe_20           ; -> nothing to delete
EdDe_10   CPY Margin_Right      ; at end of previous row ?
          BCC EdDe_30           ; -> no
          LDX Cursor_Row
          INX
          JSR Is_Coupled_Row_X
          BCS EdDe_30           ; -> yes
          JSR Edit_Put_Blank
EdDe_20   LDA E_Col
          STA Cursor_Col
          LDA E_Row
          STA Cursor_Row
          JMP Set_Screen_Pointer

EdDe_30   JSR Edit_Cursor_Right
          JSR Edit_Get_Char
          JSR Edit_Cursor_Left
          JSR Edit_Put_Char
          JSR Edit_Cursor_Right
          JMP EdDe_10

; ******************
  Ctrl_I_Tab ; $c94f
; ******************

          LDY Cursor_Col
ETab_10   INY
          CPY Margin_Right
          BCS ETab_20
          JSR Jc96c
          BEQ ETab_10
          .byte $2c ;BIT
ETab_20   LDY Margin_Right
          STY Cursor_Col
          RTS

; ***********************
  Edit_Toggle_Tab ; $c961
; ***********************

          LDY Cursor_Col
          JSR Jc96c
          EOR E_Beg
          STA TABMAP,X
          RTS

; *************
  Jc96c ; $c96c
; *************

          TYA
          AND #%00000111 ; $07
          TAX
          LDA Edit_Bit_Mask,X
          STA E_Beg
          TYA
          LSR A
          LSR A
          LSR A
          TAX
          LDA TABMAP,X
          BIT E_Beg
          RTS

; **************************
  Clear_All_Tabstops ; $c980
; **************************

          LDA #0
          .byte $2c ;BIT

; ****************************
  Set_Default_Tabstops ; $c983
; ****************************

          LDA #$80           ; set tab on every 8th. column
          LDX #9             ; use 10 bytes for 80 columns
STAB_10   STA TABMAP,X
          DEX
          BPL STAB_10
STAB_Ret  RTS

; *******************
  Ctrl_G_Bell ; $c98e
; *******************

          BIT BEEPER
          BMI STAB_Ret
          LDA #$15
          STA SID_Volume
          LDY #<CHARAC
          LDX #>CHARAC
          STY SID_Attack_1
          STX SID_Sustain_1
          LDA #$30
          STA SID_Freq_1+1
          LDA #$20
          STA SID_Control_1
          LDA #$21
          STA SID_Control_1
          RTS

; ***********************
  Ctrl_J_Linefeed ; $c9b1
; ***********************

          LDA Cursor_Col
          PHA
          JSR Edit_Cursor_Last
          JSR Edit_Cursor_Down
          PLA
          STA Cursor_Col
          RTS

; ************************
  Edit_Escape_Jump ; $c9be
; ************************

          JMP (ESCVEC)        ; default: next instruction

; **************************
  Edit_Escape_Switch ; $c9c1
; **************************

          CMP #ESC
          BNE EdES_10
          LSR DATAX           ; DATAX = CR (ESC >> 1)
          JMP Edit_Attributes_Off
EdES_10   AND #$7f
          SEC
          SBC #'@'            ; from ESC @
          CMP #$1b            ; to   ESC Z
          BCS EdES_Ret        ; -> out of range
          ASL A
          TAX
          LDA Edit_Escape_Case+1,X
          PHA
          LDA Edit_Escape_Case,X
          PHA
EdES_Ret  RTS

; ************************
  Edit_Escape_Case ; $c9de
; ************************

          .WORD Edit_Erase_EOS       - 1 ; ESC @
          .WORD Edit_Auto_Insert_On  - 1 ; ESC A Auto
          .WORD Edit_Set_Window_LR   - 1 ; ESC B Bottom
          .WORD Edit_Auto_Insert_Off - 1 ; ESC C
          .WORD Edit_Delete_Line     - 1 ; ESC D Delete
          .WORD Edit_Steady_Cursor   - 1 ; ESC E
          .WORD Edit_Blinking_Cursor - 1 ; ESC F Flickering
          .WORD Edit_Enable_Bell     - 1 ; ESC G
          .WORD Edit_Disable_Bell    - 1 ; ESC H
          .WORD Edit_Insert_Line     - 1 ; ESC I Insert
          .WORD Edit_Cursor_BOL      - 1 ; ESC J
          .WORD Edit_Cursor_EOL      - 1 ; ESC K
          .WORD Edit_Scroll_Unlock   - 1 ; ESC L
          .WORD Edit_Scroll_Lock     - 1 ; ESC M
          .WORD Edit_Inverse_Off     - 1 ; ESC N
          .WORD Edit_Attributes_Off  - 1 ; ESC O Off
          .WORD Edit_Erase_BOL       - 1 ; ESC P
          .WORD Edit_Erase_EOL       - 1 ; ESC Q
          .WORD Edit_Inverse_On      - 1 ; ESC R Reverse
          .WORD Edit_Cursor_Block    - 1 ; ESC S Steady
          .WORD Edit_Window_UL       - 1 ; ESC T Top
          .WORD Edit_Cursor_Line     - 1 ; ESC U Underline
          .WORD Edit_Scroll_Line_Up  - 1 ; ESC V
          .WORD Edit_Scroll_Line_Dn  - 1 ; ESC W
          .WORD Edit_Toggle_Screen   - 1 ; ESC X eXchange
          .WORD Set_Default_Tabstops - 1 ; ESC Y Yank
          .WORD Clear_All_Tabstops   - 1 ; ESC Z Zero

; **********************
  Edit_Window_UL ; $ca14
; **********************

          CLC
          .BYTE $24

; **************************
  Edit_Set_Window_LR ; $ca16
; **************************

          SEC
          LDX Cursor_Col
          LDA Cursor_Row

; **************************
  Edit_Window_Corner ; $ca1b
; **************************

          BCC SeFu_10

; ******************************
  Set_Lower_Right_Corner ; $ca1d
; ******************************

          STA Margin_Bottom
          STX Margin_Right
          JMP SeFu_20         ; clear concatenation flags

; **********************
  Set_Fullscreen ; $ca24
; **********************

          LDA LINES
          LDX COLUMNS
          JSR Set_Lower_Right_Corner
          LDA #0              ; home position top  margin
          TAX                 ; home position left margin
SeFu_10   STA Margin_Top
          STX Margin_Left
SeFu_20   LDA #0              ; clear concatenation flags
          LDX #4              ; 4 bytes for 25 rows
SeFu_30   STA BITABL-1,X
          DEX
          BNE SeFu_30
          RTS

; ************************
  Edit_Insert_Line ; $ca3d
; ************************

          JSR Edit_Scroll_Down
          JSR Cursor_To_Left_Margin
          INX
          JSR Is_Coupled_Row_X
          PHP
          JSR Toggle_Cont_Flag
          PLP
          BCS EdIL_Ret
          SEC
          ROR CurLst_Row
EdIL_Ret  RTS

; ************************
  Edit_Delete_Line ; $ca52
; ************************

          JSR Start_Of_Line
          LDA Margin_Top
          PHA
          LDA Cursor_Row
          STA Margin_Top
          LDA Scroll_Locked
          PHA
          LDA #$80
          STA Scroll_Locked
          JSR ScUp_20
          PLA
          STA Scroll_Locked
          LDA Margin_Top
          STA Cursor_Row
          PLA
          STA Margin_Top
          SEC
          ROR CurLst_Row
          JMP Cursor_To_Left_Margin

; **********************
  Edit_Erase_EOL ; $ca76
; **********************

          JSR Edit_Save_Row_Col
EdEE_10   JSR Clear_Row_To_EOR
          INC Cursor_Row
          JSR Set_Screen_Pointer
          LDY Margin_Left
          JSR Is_Coupled_Row
          BCS EdEE_10
EdEE_20   JMP EdDe_20

; **********************
  Edit_Erase_BOL ; $ca8b
; **********************

          JSR Edit_Save_Row_Col
EdEB_10   JSR Edit_Put_Blank
          CPY Margin_Left
          BNE EdEB_20
          JSR Is_Coupled_Row
          BCC EdEE_20
EdEB_20   JSR Edit_Cursor_Left
          BCC EdEB_10

; **********************
  Edit_Erase_EOS ; $caa2
; **********************

          JSR Edit_Save_Row_Col
EdEr_10   JSR Clear_Row_To_EOR
          INC Cursor_Row
          JSR Set_Screen_Pointer
          LDY Margin_Left
          JSR Is_Coupled_Row
          BCS EdEr_10
          LDA Cursor_Row
          CMP Margin_Bottom
          BCC EdEr_10
          BEQ EdEr_10
          JMP EdDe_20

; ***************************
  Edit_Scroll_Line_Up ; $cabc
; ***************************

          JSR Edit_Save_Row_Col
          TXA
          PHA
          JSR Edit_Scroll_Up
          PLA
          STA E_Row
          JMP EdDe_20

; ***************************
  Edit_Scroll_Line_Dn ; $caca
; ***************************

          JSR Edit_Save_Row_Col
          JSR Is_Coupled_Row
          BCS ESLD_10
          SEC
          ROR CurLst_Row
ESLD_10   LDA Margin_Top
          STA Cursor_Row
          JSR Edit_Scroll_Down
          JSR Clear_Cont_Flag
          JMP EdDe_20

; *************************
  Edit_Scroll_Unlock ; $cae2
; *************************

          LDA #0
          .byte $2c ;BIT

; ************************
  Edit_Scroll_Lock ; $cae5
; ************************

          LDA #$80
          STA Scroll_Locked
          RTS

; ****************************
  Edit_Auto_Insert_Off ; $caea
; ****************************

          LDA #0
          .byte $2c ;BIT

; ***************************
  Edit_Auto_Insert_On ; $caed
; ***************************

          LDA #$ff
          STA INSFLG
          RTS

; *************************
  Edit_Cursor_Block ; $caf2
; *************************

          BIT MODE_80
          BPL EdBC_Ret
          LDA CURMOD
          AND #%11100000 ; $e0
          JMP EdSC_10

; ************************
  Edit_Cursor_Line ; $cafe
; ************************

          BIT MODE_80
          BPL EdBC_Ret
          LDA CURMOD
          AND #%11100000 ; $e0
          ORA #%00000111 ; $07
          BNE EdSC_10

; **************************
  Edit_Steady_Cursor ; $cb0b
; **************************

          BIT MODE_80
          BPL EdSC_20
          LDA CURMOD
          AND #%00011111 ; $1f
EdSC_10   STA CURMOD
          JMP ECON_10
EdSC_20   LDA BLNON
          ORA #%01000000 ; $40
          BNE EdBC_20

; ****************************
  Edit_Blinking_Cursor ; $cb21
; ****************************

          BIT MODE_80
          BPL EdBC_10
          LDA CURMOD
          AND #%00011111 ; $1f
          ORA #%01100000 ; $60
          BNE EdSC_10
EdBC_10   LDA BLNON
          AND #%10111111 ; $bf
EdBC_20   STA BLNON
EdBC_Ret  RTS

; ************************
  Edit_Enable_Bell ; $cb37
; ***********************

          LDA #0
          .byte $2c ;BIT

; *************************
  Edit_Disable_Bell ; $cb3a
; *************************

          LDA #$80
          STA BEEPER
          RTS

; ***********************
  Edit_Inverse_On ; $cb3f
; ***********************

          LDX #$18
          JSR VDC_Read_Register_X
          ORA #%01000000
          BNE EdIO_10

; ************************
  Edit_Inverse_Off ; $cb48
; ************************

          LDX #$18
          JSR VDC_Read_Register_X
          AND #%10111111 ; $bf
EdIO_10   JMP VDC_Write_Register_X

; ***********************
  Edit_Cursor_EOL ; $cb48
; ***********************

          JSR Edit_Cursor_Last
          JMP Edit_Cursor_Next

; *********************
  Edit_Get_Char ; $cb58
; *********************

          LDY Cursor_Col      ; cursor column
          BIT MODE_80         ; screen mode
          BMI EGSC_10         ; -> 80 column screen
          LDA (USER),Y
          STA TCOLOR          ; TCOLOR = attribute
          LDA (PNT),Y         ; A      = character
          RTS

EGSC_10   JSR VDC_Set_Attr_Address
          JSR VDC_Read_RAM
          STA TCOLOR          ; TCOLOR = attribute
          JSR VDC_Set_Char_Address
          JSR VDC_Read_RAM    ; A      = character
          RTS

; **********************
  Is_Coupled_Row ; $cb74
; **********************

          LDX Cursor_Row            ; X = row

; ************************
  Is_Coupled_Row_X ; $cb76
; ************************

          JSR Cont_Flag_Bit_Pos
          AND BITABL,X
          CMP #1
          JMP CCF_20

; ************************
  Toggle_Cont_Flag ; $cb81
; ************************

          LDX Cursor_Row

; **************************
  Toggle_Cont_Flag_X ; $cb83
; **************************

          BCS Set_Cont_Flag

; ***********************
  Clear_Cont_Flag ; $cb85
; ***********************

          JSR Cont_Flag_Bit_Pos
          EOR #$ff
          AND BITABL,X
CCF_10    STA BITABL,X
CCF_20    LDX E_Beg
          RTS

; *********************
  Set_Cont_Flag ; $cb93
; *********************

          BIT Scroll_Locked
          BVS Is_Coupled_Row_X ; -> no coupled rows in scroll lock mode
          JSR Cont_Flag_Bit_Pos
          ORA BITABL,X
          BNE CCF_10

; *************************
  Cont_Flag_Bit_Pos ; $cb9f
; *************************

          STX E_Beg          ; save row
          TXA
          AND #7              ; row mod 8
          TAX                 ; X = bit number
          LDA Edit_Bit_Mask,X ; A = bit mask
          PHA                 ; push bit mask
          LDA E_Beg          ; A = roq
          LSR A               ; / 2
          LSR A               ; / 4
          LSR A               ; / 8
          TAX                 ; X = byte index
          PLA                 ; A = bit  index
          RTS

; ***********************
  Edit_Cursor_BOL ; $cbb1
; ***********************

          LDY Margin_Left
          STY Cursor_Col

; *********************
  Start_Of_Line ; $cbb5
; *********************

          JSR Is_Coupled_Row
          BCC SOL_10
          DEC Cursor_Row
          BPL Start_Of_Line
          INC Cursor_Row
SOL_10    JMP Set_Screen_Pointer

; ************************
  Edit_Cursor_Last ; $cbc3
; ************************

          INC Cursor_Row
          JSR Is_Coupled_Row
          BCS Edit_Cursor_Last
          DEC Cursor_Row
          JSR Set_Screen_Pointer
          LDY Margin_Right
          STY Cursor_Col      ; PNTR = right margin
EELR_10   JSR Edit_Get_Char
          LDX Cursor_Row
          CMP #' '
          BNE EELR_30
          CPY Margin_Left
          BNE EELR_20
          JSR Is_Coupled_Row
          BCC EELR_30
EELR_20   JSR Edit_Cursor_Left
          BCC EELR_10         ; -> cursor did move
EELR_30   STY Cursor_End      ; position of last non blank
          RTS

; *************************
  Edit_Cursor_Right ; $cbed
; *************************

          PHA
          LDY Cursor_Col
          CPY Margin_Right
          BCC EdCR_10
          JSR Edit_Cursor_Down
          LDY Margin_Left
          DEY
          SEC
EdCR_10   INY
          STY Cursor_Col
          PLA
          RTS

; ************************
  Edit_Cursor_Left ; $cc00
; ************************

          LDY Cursor_Col            ; Y = cursor column
          DEY                 ; --Y
          BMI EdCL_10         ; -> off screen
          CPY Margin_Left            ; compare with left margin
          BCS EdCL_20         ; -> OK
EdCL_10   LDY Margin_Top           ; Y = upper margin
          CPY Cursor_Row            ; compare with row
          BCS EdCL_Ret        ; -> cursor is at home position
          DEC Cursor_Row            ; up one row
          PHA                 ; save A
          JSR Set_Screen_Pointer
          PLA                 ; restore A
          LDY Margin_Right
EdCL_20   STY Cursor_Col            ; cursor column = wight margin
          CPY Margin_Right
          CLC                 ; success
EdCL_Ret  RTS

; *************************
  Edit_Save_Row_Col ; $cc1e
; *************************

          LDY Cursor_Col
          STY E_Col
          LDX Cursor_Row
          STX E_Row
          RTS

; **********************
  Edit_Put_Blank ; $cc27
; **********************

          LDA E_Attribute
          AND #%10001111 ; $8f
          TAX
          LDA #' '
          .byte $2c ;

; *************************
  Edit_Put_Char_Att ; $cc2f
; *************************

          LDX E_Attribute
          .byte $2c ;                 ; skip next statement

; *********************
  Edit_Put_Char ; $cc32
; *********************

          LDX TCOLOR

; ********************
  Edit_Display ; $cc34
; ********************

          TAY
          LDA #2
          STA BLNCT
          JSR Set_Attribute_Pointer
          TYA
          LDY Cursor_Col

; ***********************
  Edit_Display_AX ; $cc40
; ***********************

          BIT MODE_80
          BMI CTSR_80
          STA (PNT),Y
          TXA
          STA (USER),Y
          RTS

CTSR_80   PHA
          TXA
          PHA
          JSR VDC_Set_Attr_Address
          PLA
          JSR VDC_Write_Data
          JSR VDC_Set_Char_Address
          PLA
          JMP VDC_Write_Data

; ***********************
  Edit_Get_Window ; $cc5b
; ***********************

; Output: A = screen columns
;         X = window width  - 1
;         Y = window height - 1

          SEC
          LDA Margin_Bottom
          SBC Margin_Top
          TAY
          SEC
          LDA Margin_Right
          SBC Margin_Left
          TAX
          LDA COLUMNS
          RTS

; *****************
  Edit_Plot ; $cc6a
; *****************

; Get or set cursor position relative to window upper left corner

; Carry = 1: X = Row = Cursor_Row - Margin_Top
;            Y = Col = Cursor_Col - Margin Left

; Carry = 0: Cursor_Row = Margin_Top  + X
;            Cursor_Col = Margin_Left + Y
;            Screen_Pointer and cursor updated

          BCS EdPl_50         ; -> get position
          TXA
          ADC Margin_Top
          BCS EdPl_30
          CMP Margin_Bottom
          BEQ EdPl_10
          BCS EdPl_30
EdPl_10   PHA
          CLC
          TYA
          ADC Margin_Left
          BCS EdPl_20
          CMP Margin_Right
          BEQ EdPl_40
          BCC EdPl_40
EdPl_20   PLA
EdPl_30   RTS
EdPl_40   STA Cursor_Col
          STA CurLst_Col
          PLA
          STA Cursor_Row
          STA CurLst_Row
          JSR Set_Screen_Pointer
          JSR Edit_Cursor
EdPl_50   LDA Cursor_Row
          SBC Margin_Top
          TAX
          SEC
          LDA Cursor_Col
          SBC Margin_Left
          TAY
          CLC
          RTS

; *********************
  Edit_Set_FKey ; $cca2
; *********************

; Input : A = #INDEXA
;         X = key number (1-8)
;         Y = length of string assignment

          DEX                 ; key index (0-7)
          STX E_End
          STY E_Beg           ; text lnegth
          STA FETCH+8         ; #INDEXA ($24)
          TAY
          LDX BANK,Y          ; LDX #1 (INDEX)B  ($26) = ($02,$24)
          JSR K_GETCFG        ; LDA #$7f (Bank_Config_Table,X)
          STA E_Col           ; save bank
          LDX #10             ; find position after all 10 text entries
          JSR Edit_FText_Index
          STA E_Beg+1         ; total length so far
          LDX E_End           ; key index
          INX                 ; + 1
          JSR Edit_FText_Index
          STA E_End+1         ; length after current key
          LDX E_End           ; key index
          LDA E_Beg           ; new text length
          SEC
          SBC PKYBUF,X        ; old text length
          BEQ ESFK_40         ; -> just replace
          BCC ESFK_20         ; new < old -> shift down
          CLC                 ; new > old
          ADC E_Beg+1         ; A = (new-old) + total length
          BCS ESFK_Ret        ; -> overlow
          TAX                 ; X = new total length
          LDY E_Beg+1         ; Y = old total length
ESFK_10   CPY E_End+1         ; Y = length after current key ?
          BEQ ESFK_40         ; -> move finished
          DEY
          DEX
          LDA PKYDEF,Y        ; shift up
          STA PKYDEF,X
          BCS ESFK_10         ; always

ESFK_20   ADC E_End+1
          TAX
          LDY E_End+1
ESFK_30   CPY E_Beg+1
          BCS ESFK_40
          LDA PKYDEF,Y        ; shift down
          STA PKYDEF,X
          INY
          INX
          BCC ESFK_30         ; always

ESFK_40   LDX E_End           ; key index
          JSR Edit_FText_Index
          TAX                 ; text index
          LDY E_End           ; Y = key index
          LDA E_Beg           ; A = new text length
          STA PKYBUF,Y        ; store text length in table
          LDY #0              ; store new text from (INDEXA)
ESFK_50   DEC E_Beg           ; decrement text length
          BMI ESFK_60         ; -> finish
          STX E_Row           ; save X
          LDX E_Col           ; X = bank
          LDA FETCH+8         ; #INDEXA
          SEI
          JSR FETCH           ; replace with Get_INDEXA_1 !!!
          CLI
          LDX E_Row           ; restore X
          STA PKYDEF,X
          INX                 ; increment store index
          INY                 ; increment load  index
          BNE ESFK_50         ; always

ESFK_60   CLC                 ; C=0 OK
ESFK_Ret  RTS

; ************************
  Edit_FText_Index ; $cd20
; ************************

          LDA #0
          CLC
EGFI_10   DEX
          BMI EGFI_Ret
          ADC PKYBUF,X
          BCC EGFI_10
EGFI_Ret  RTS

; **************************
  Edit_Toggle_Screen ; $cd2c
; **************************

          STA LSTCHR

; ***************************
  Edit_Screen_Swapper ; $cd2e
; ***************************

; Toggle screen mode between 80 column VDC and 40 column VIC screen
; The zero page variables $e0 - $fa are swapped
; Also the TAB and Concatenation settings array $0354 - $0361
; Bit 7 of MODE_80 is toggled

          LDX #$1a
EdSS_10   LDY ZP_SW_COL,X
          LDA PNT,X
          STA ZP_SW_COL,X
          TYA
          STA PNT,X
          DEX
          BPL EdSS_10
          LDX #13             ; 10 for TABMAP and 4 for BITABL
EdSS_20   LDY SWPMAP,X
          LDA TABMAP,X
          STA SWPMAP,X
          TYA
          STA TABMAP,X
          DEX
          BPL EdSS_20
          LDA MODE_80
          EOR #%10000000 ; $80
          STA MODE_80
EdSS_Ret  RTS

; *******************
  Edit_Cursor ; $cd57
; *******************

          BIT MODE_80
          BPL EdSS_Ret
          LDX #14
          CLC
          LDA PNT
          ADC Cursor_Col
          PHA
          LDA PNT+1
          ADC #0
          JSR VDC_Write_Register_X
          INX
          PLA
          JMP VDC_Write_Register_X

; **********************
  Edit_Cursor_On ; $cd6f
; **********************

          BIT MODE_80         ; 80 or 40 column screen ?
          BPL ECON_20         ; -> 40 col

; cursor in 80 column screen

          JSR Set_Attribute_Pointer
          LDY Cursor_Col
          JSR VDC_Set_Attr_Address
          JSR VDC_Read_RAM
          STA VDC_ATT          ; save char under cursor
          AND #%11110000     ; invert char
          STA E_Beg+1
          JSR VDC_Set_Attr_Address
          LDA E_Attribute
          AND #%00001111     ; invert color
          ORA E_Beg+1
          JSR VDC_Write_Data
ECON_10   LDX #10
          LDA CURMOD
          JMP VDC_Write_Register_X

; cursor in 40 column screen

ECON_20   LDA #0
          STA BLNSW           ; 0 = blinking on
          RTS

; ***********************
  Edit_Cursor_Off ; $cd9f
; ***********************

          BIT MODE_80         ; 80 or 40 column screen ?
          BPL ECOF_10         ; -> 40 col

; cursor in 80 column screen

          JSR VDC_Set_Attr_Address
          LDA VDC_ATT         ; attribute under cursor
          JSR VDC_Write_Data  ; prepare to write
          LDX #10
          LDA #' '
          JMP VDC_Write_Register_X

; cursor in 40 column screen

ECOF_10   STA BLNSW           ; BLNSW != 0 : switch blinking off
          LDA BLNON           ; cursor blink on ?
          BPL ECOF_Ret        ; -> no, nothing to do
          AND #%01000000
          STA BLNON
          LDA GDBLN
          LDX GDCOL           ; cursor blink mode
          JSR Edit_Display
ECOF_Ret  RTS

; **********************
  VDC_Write_Data ; $cdca
; **********************

          LDX #$1f

; ****************************
  VDC_Write_Register_X ; $cdcc
; ****************************

          STX VDC_Register
VWRX_10   BIT VDC_Register
          BPL VWRX_10
          STA VDC_Data
          RTS

; ********************
  VDC_Read_RAM ; $cdd8
; ********************

          LDX #$1f

; ***************************
  VDC_Read_Register_X ; $cdda
; ***************************

          STX VDC_Register
VRRX_10   BIT VDC_Register
          BPL VRRX_10
          LDA VDC_Data
          RTS

; ****************************
  VDC_Set_Char_Address ; $cde6
; ****************************

          LDX #$12
          CLC
          TYA
          ADC PNT
          PHA
          LDA #0
          ADC PNT+1
          JSR VDC_Write_Register_X
          PLA
          INX
          JMP VDC_Write_Register_X

; ****************************
  VDC_Set_Attr_Address ; $cdf9
; ****************************

          LDX #18             ; VDC register 18
          CLC
          TYA
          ADC USER            ; USER + Y
          PHA
          LDA #0
          ADC USER+1
          JSR VDC_Write_Register_X
          PLA
          INX
          JMP VDC_Write_Register_X

; *************************
  Edit_Load_Chargen ; $ce0c
; *************************

          LDA #<VIC
          LDY #>VIC
          STA E_Beg
          STY E_Beg+1
          LDX #$12
          LDA #$20            ; Write chargen to $2000
          JSR VDC_Write_Register_X
          INX
          LDA #0
          JSR VDC_Write_Register_X
          LDY #0
EdLC_10   LDX #$0e            ; bank
          LDA #E_Beg
          JSR K_INDFET
          JSR VDC_Write_Data
          INY
          CPY #8              ; 8 bytes per character
          BCC EdLC_10
          LDA #0
EdLC_20   JSR VDC_Write_Data
          DEY
          BNE EdLC_20
          CLC
          LDA E_Beg
          ADC #8              ; position to next character
          STA E_Beg
          BCC EdLC_10
          INC E_Beg+1
          LDA E_Beg+1
          CMP #$e0            ; end of chargen ROM at $dfff
          BCC EdLC_10
          RTS

; ***********************
  VIC_Color_Codes ; $ce4c
; ***********************

          .BYTE $90           ; black
          .BYTE $05           ; white
          .BYTE $1c           ; red
          .BYTE $9f           ; green
          .BYTE $9c           ; violet
          .BYTE $1e           ; dark green
          .BYTE $1f           ; blue
          .BYTE $9e           ; yellow

          .BYTE $81           ; light brown
          .BYTE $95           ; brown
          .BYTE $96           ; rose
          .BYTE $97           ; dark grey
          .BYTE $98           ; grey
          .BYTE $99           ; light green
          .BYTE $9a           ; light blue
          .BYTe $9b           ; light grey

; ***********************
  VDC_Color_Codes ; $ce5c
; ***********************

          .BYTE $00           ; black
          .BYTE $0f           ; white
          .BYTE $08           ; red
          .BYTE $07           ; green
          .BYTE $0b           ; violet
          .BYTE $04           ; dark green
          .BYTE $02           ; blue
          .BYTE $0d           ; yellow

          .BYTE $0a           ; light brown
          .BYTE $0c           ; brown
          .BYTE $09           ; rose
          .BYTE $06           ; dark grey
          .BYTE $01           ; grey
          .BYTE $05           ; light green
          .BYTE $03           ; light blue
          .BYTe $0e           ; light grey

; *********************
  Edit_Bit_Mask ; $ce6c
; *********************

          .BYTE $80,$40,$20,$10,$08,$04,$02,$01

; *****************
  ZP_40_COL ; $ce74
; *****************

          .WORD VIC_TEXT      ; $e0  PNT
          .WORD VIC_COLOR_RAM ; $e2  USER
          .BYTE 24            ; $e4  Margin_Bottom
          .BYTE  0            ; $e5  Margin_Top
          .BYTE  0            ; $e6  Margin_Left
          .BYTE 39            ; $e7  Margin_Right
          .BYTE  0            ; $e8  CurLst_Row
          .BYTE  0            ; $e9  CurLst_Col
          .BYTE  0            ; $ea  Cursor_End
          .BYTE  0            ; $eb  Cursor_Row
          .BYTE  0            ; $ec  Cursor_Col
          .BYTE 24            ; $ed  LINES
          .BYTE 39            ; $ee  COLUMNS
          .BYTE  0            ; $ef  DATAX
          .BYTE  0            ; $f0  LSTCHR
          .BYTE 13            ; $f1  E_Attribute
          .BYTE 13            ; $f2  TCOLOR
          .BYTE  0            ; $f3  E_Reverse
          .BYTE  0            ; $f4  QTSW
          .BYTE  0            ; $f5  INSRT
          .BYTE  0            ; $f6  INSFLG
          .BYTE  0            ; $f7  LOCKS
          .BYTE  0            ; $f8  Scroll_Locked
          .BYTE  0            ; $f9  BEEPER


; *****************
  ZP_80_COL ; $ce8e
; *****************

          .WORD $0000         ; $e0  PNT
          .WORD $0800         ; $e2  USER
          .BYTE 24            ; $e4  Margin_Bottom
          .BYTE  0            ; $e5  Margin_Top
          .BYTE  0            ; $e6  Margin_Left
          .BYTE 79            ; $e7  Margin_Right
          .BYTE  0            ; $e8  CurLst_Row
          .BYTE  0            ; $e9  CurLst_Col
          .BYTE  0            ; $ea  Cursor_End
          .BYTE  0            ; $eb  Cursor_Row
          .BYTE  0            ; $ec  Cursor_Col
          .BYTE 24            ; $ed  LINES
          .BYTE 79            ; $ee  COLUMNS
          .BYTE  0            ; $ef  DATAX
          .BYTE  0            ; $f0  LSTCHR
          .BYTE  7            ; $f1  E_Attribute
          .BYTE  7            ; $f2  TCOLOR
          .BYTE  0            ; $f3  E_Reverse
          .BYTE  0            ; $f4  QTSW
          .BYTE  0            ; $f5  INSRT
          .BYTE  0            ; $f6  INSFLG
          .BYTE  0            ; $f7  LOCKS
          .BYTE  0            ; $f8  Scroll_Locked
          .BYTE  0            ; $f9  BEEPER

; ***********************
  Edit_Default_FK ; $cea8
; ***********************

;                f1  f2  f3  f4  f5  f6  f7  f8 RUN HELP
          .BYTE $07,$06,$0a,$07,$06,$04,$05,$08,$09,$05
          .TEXT "GRAPHIC"     ; f1
          .TEXT 'DLOAD"'     ; f2
          .TEXT "DIRECTORY\r" ; f3
          .TEXT "SCNCLR\r"    ; f4
          .TEXT 'DSAVE"'     ; f5
          .TEXT "RUN\r"       ; f6
          .TEXT "LIST\r"      ; f7
          .TEXT "MONITOR\r"   ; f8
          .TEXT "D",$cc,QUOTE,"*\rRUN\r" ; DLOAD"* and RUN
          .TEXT "HELP\r"

          .FILL $cf00-* ,$ff ;   11 bytes

; **************
  UFK_40 ; $cf00
; **************

; patch for Edit_Use_Function_Key

          LDA KYNDX
          BNE UFK_70
          LDA PKYBUF,X
          STA KYNDX
          LDA #0
          CLC
UFK_50    DEX
          BMI UFK_60
          ADC PKYBUF,X
          BCC UFK_50
UFK_60    STA KEYIDX
UFK_70    JMP UFK_20

          .FILL $cf80-* ,$ff ;  103 bytes

; ***********
  DMA ; $cf80
; ***********

          LDA MMU_RAMC
          PHA                 ; save RAM configuration
          EOR Bank_Config_Table,X
          AND #%00111111
          EOR Bank_Config_Table,X
          STA MMU_RAMC
          LDA Bank_Config_Table,X
          TAX
          PHP
          SEI
          JSR RAM_DMA
          PLP
          PLA                 ; restore RAM configuration
          STA MMU_RAMC
          RTS

          .FILL $cfc0-* ,$ff ;   34 bytes

          .TEXT "(C)1986 COMMODORE"
          .TEXT " ELECTRONICS, LTD."
          .TEXT " ALL RIGHTS RESERVED."
.if KEYBOARD == 0
          .BYTE $ff,$00,$f3,$91,$3b,$ea,$01,$4c
.endif
.if KEYBOARD == 2
          .BYTE $11,$02,$ff,$ff,$ff,$ff,$01,$ff
.endif
.if KEYBOARD == 3
          .BYTE $11,$03,$22,$AE,$44,$3A,$01,$F2
.endif
.if KEYBOARD == 4
          .BYTE $08,$04,$5B,$BC,$9E,$B6,$01,$2F
.endif
.if KEYBOARD == 5
          .BYTE $11,$05,$FF,$FF,$FF,$FF,$01,$FF
.endif
.if KEYBOARD == 6
          .BYTE $11,$06,$FF,$FF,$FF,$FF,$01,$FF
.endif
.if KEYBOARD == 255
          .BYTE $FF,$FF,$FF,$FF,$76,$8F,$01,$3C
.endif

; ***********
;  VIC ; $d000
; ***********

          .FILL $e000-* ,$ff
          
           * =  $e000

; ********************
  System_Reset ; $e000
; ********************

          LDX #$ff
          SEI
          TXS
          CLD
          LDA #0
          STA MMU_CR
          LDX #10
SyRe_10   LDA MMU_Reset_Table,X
          STA MMU_CONT,X
          DEX
          BPL SyRe_10
          STA INIT_STATUS
          JSR Init_Bank_Switching
          JSR Check_CBM
          JSR Test_Cartridge
          JSR IOINIT
          JSR Check_STOP_Key
          PHA
          BMI SyRe_20
          LDA #$a5
          CMP DEJAVU
          BEQ SyRe_30
SyRe_20   JSR RAMTAS
SyRe_30   JSR RESTOR
          JSR E_CINT
          PLA
          CLI
          BMI SyRe_40
          JMP BASIC_MONITOR
SyRe_40   CMP #$df
          BEQ SyRe_50
          JMP (RESET_VECTOR)
SyRe_50   JMP C64

; ***********************
  MMU_Reset_Table ; $e04b
; ***********************

          .BYTE $00 ; RAM 0 - BASIC - Kernal - I/O
          .BYTE $00 ; Config A
          .BYTE $00 ; Config B
          .BYTE $00 ; Config C
          .BYTE $00 ; Config D
          .BYTE $bf ; Mode      80 Col - C128 - 8502
          .BYTE $04 ; RAM       Bank 0 - lower common 1K
          .WORD $0000 ;     0 ; Zero  Page
          .WORD $0001 ;     1 ; Stack Page

; **************
  RESTOR ; $e056
; **************

          LDX #<vectss
          LDY #>vectss
          CLC

; **************
  VECTOR ; $e05b
; **************

; Input : (X/Y) = address of vector table (ROM or RAM)
;         C = 1 : copy values from IIRQ to (X/Y) table
;         C = 0 ; copy values from (X/Y) table to IIRQ

          STX MEMUSS
          STY MEMUSS+1
          LDY #$1f
VECT_10   LDA IIRQ,Y
          BCS VECT_20
          LDA (MEMUSS),Y
VECT_20   STA IIRQ,Y
          BCC VECT_30
          STA (MEMUSS),Y
VECT_30   DEY
          BPL VECT_10
          RTS

; **************
  vectss ; $e073
; **************

          .WORD IRQ_Normal    ; $0314 IIRQ
          .WORD Mon_Break     ; $0316 IBRK
          .WORD NMI_Normal    ; $0318 INMI
          .WORD OPEN          ; $031a IOPEN
          .WORD CLOSE         ; $031c ICLOSE
          .WORD CHKIN         ; $031e ICHKIN
          .WORD CKOUT         ; $0320 ICKOUT
          .WORD CLRCH         ; $0322 ICLRCH
          .WORD BASIN         ; $0324 IBASIN
          .WORD BSOUT         ; $0326 IBSOUT
          .WORD STOP          ; $0328 ISTOP
          .WORD GETIN         ; $032a KEYVEC
          .WORD CLALL         ; $032c ICLALL
          .WORD Mon_Command   ; $032e EXMON
          .WORD D_LOADSP      ; $0330 ILOAD
          .WORD D_SAVE        ; $0332 ISAVE

; clear zero page and initialize some pointer

; **************
  RAMTAS ; $e093
; **************

          LDA #0
          TAY
RAMT_10   STA BANK,Y          ; clear $02 - $ff
          INY
          BNE RAMT_10
          LDY #>T_Buffer
          STY TAPE1+1         ; (TAPE1) = T_Buffer
          STA TAPE1
          LDY #>R_Rece_Buffer
          STY RIBUF+1         ; (RIBUF) = R_Rece_Buffer
          STA RIBUF
          LDY #>R_Send_Buffer
          STY ROBUF+1         ; (ROBUF) = R_Send_Buffer
          STA ROBUF
          CLC
          LDY #>$ff00
          LDX #<$ff00
          JSR SET_MEM_TOP     ; (MEM_TOP) = $ff00
          LDY #>RAMBOT
          LDX #<RAMBOT
          JSR SET_MEM_BOT     ; (MEM_BOT) = $1c00
          LDY #>B_Cold_Start
          LDX #<B_Cold_Start
          STY RESET_VECTOR+1
          STX RESET_VECTOR
          LDA #$a5
          STA DEJAVU          ; set flag RAMTAS executed
          RTS

; ***************************
  Init_Bank_Switching ; $e0cd
; ***************************

; set MMU config register

          LDY #3
InBS_10   LDA insttb,Y
          STA MMU_CR

; copy NMI routine from ROM to common upper RAM

          LDX #$3f
InBS_20   LDA NMI,X
          STA NMI,X
          DEX
          BPL InBS_20
; copy interrupt vectors from ROM to common upper RAM

          LDX #5
InBS_30   LDA V_NMI,X
          STA V_NMI,X
          DEX
          BPL InBS_30
          DEY
          BPL InBS_10

; copy RAM access routines from ROM to lower common RAM

          LDX #$59
InBS_40   LDA ROM_FETCH,X
          STA FETCH,X
          DEX
          BPL InBS_40

; copy DMA routines from ROM to lower common RAM

          LDX #12
InBS_50   LDA ROM_DMA,X
          STA RAM_DMA,X
          DEX
          BPL InBS_50
          RTS

; MMU configuration
; -----------------

; xx......  RAM bank  00 = bank 0, 01 = bank 2
; ..xx....  KERNAL    00 = kernal $c000 - $ffff
; ....xx..  BASIC HI  00 = BASIC  $8000 - $bfff
; ......x.  BASIC LO   0 = BASIC  $4000 - $7fff
; .......x  I/O        0 = I/O    $d000 - $dfff

; **************
  insttb ; $e105
; **************

          .BYTE $00           ; RAM bank 0
          .BYTE $40           ; RAM bank 1
          .BYTE $80           ; RAM bank 2 (not installed)
          .BYTE $c0           ; RAM bank 3 (not installed)

; **************
  IOINIT ; $e109
; **************

          LDA #$7f
          STA CIA1_ICR
          STA CIA2_ICR
          STA CIA1_KBD_COL
          LDA #8
          STA CIA1_CRA
          STA CIA2_CRA
          STA CIA1_CRB
          STA CIA2_CRB
          LDX #0
          STX CIA1_DDRB
          STX CIA2_DDRB
          DEX
          STX CIA1_DDRA
          LDA #7
          STA CIA2_PRA
          LDA #$3f
          STA CIA2_DDRA
          LDA #$e3
          STA R8502
          LDA #$2f
          STA D8502
          LDX #$ff
IOIN_10   LDA VIC_Ctrl_1
          BPL IOIN_10
IOIN_20   LDA #8
          CMP VIC_RASTER
          BCC IOIN_30         ; -> PAL: PALNTS = $ff
          LDA VIC_Ctrl_1
          BMI IOIN_20
          INX                 ;   NTSC: PALNTS = $00
IOIN_30   STX PALNTS
          LDA #0
          JSR Init_RS232
          STA VSH_Ctrl_1
          STA IRQTMP+1
          STA SPRITES
          STA PAL_ADJ
          STA DFLTN
          LDA #3
          STA DFLTO
          LDX #$30
IOIN_40   LDA VIC_Init_Values,X
          STA VIC,X
          DEX
          BPL IOIN_40
          LDX #0
          JSR VDC_Program_X
          LDA VDC_Register
          AND #%00000111 ; $07
          BEQ IOIN_50
          LDX #VDC_Init_NTSC-VDC_Init_Values ; $3b
          JSR VDC_Program_X
IOIN_50   BIT PALNTS
          BPL IOIN_60
          LDX #VDC_Init_PAL-VDC_Init_Values ; $3e
          JSR VDC_Program_Mod
IOIN_60   LDA INIT_STATUS
          BMI IOIN_80
          JSR E_DLCHR
          LDA #$80
          ORA INIT_STATUS
          STA INIT_STATUS
          LDX #$ff
          LDY #$ff
IOIN_70   DEY
          BNE IOIN_70
          DEX
          BNE IOIN_70
IOIN_80   LDA #0
          LDX #$18
IOIN_90   STA SID_Freq_1,X
          DEX
          BPL IOIN_90

; *********************
  Test_Fast_IEC ; $e1b8
; *********************

          LDX #1              ; X = 1
          STX VIC_IRQ_ENA     ; enable raster interrupt only
          DEX                 ; X = 0
          STX Fast_IEC        ; default: not a fast device
          STX RS_Enable       ; disable RS232 interface
          DEX                 ; X = $ff
          STX CIA1_TBLO
          STX CIA1_TBHI       ; $ffff = 65 msec
          LDX #%00010001     ; ONE STOP
          STX CIA1_CRB
          JSR IEC_Fast_Input
          JSR IEC_Fast_Output
          JSR IEC_Fast_Input
          JMP IEC_Clock_Low

; *********************
  VDC_Program_X ; $e1dc
; *********************

          LDY VDC_Init_Values,X
          BMI VPX_10
          INX
          LDA VDC_Init_Values,X
          INX
          STY VDC_Register
          STA VDC_Data
          BPL VDC_Program_X
VPX_10    INX
          RTS

; *****************
  Check_CBM ; $e1f0
; *****************

          LDX #<$fff5
          LDY #>$fff5
          STX MEMUSS
          STY MEMUSS+1
          LDA #MEMUSS
          STA FETCH+8
          LDY #2
CCBM_10   LDX #$7f            ; RAM bank 1
          JSR FETCH
          CMP ROM_CBM,Y
          BNE SYSTEM
          DEY
          BPL CCBM_10
          LDX #<V_SYSTEM
          LDY #>V_SYSTEM
          STX MEMUSS
          STY MEMUSS+1
          LDY #1
CCBM_20   LDX #$7f
          JSR FETCH
          STA BANK,Y
          DEY
          BPL CCBM_20
          JMP (BANK)

; **************
  SYSTEM ; $e224
; **************

          LDA #$40 ; '@'
          STA MMU_CR
          LDA #<SYSTEM
          LDY #>SYSTEM
          STA V_SYSTEM
          STY V_SYSTEM+1
          LDX #3
SYST_10   LDA ROM_CBM-1,X
          STA V_LOCK-2,X
          DEX
          BNE SYST_10
          STX MMU_CR
          RTS

; **********************
  Test_Cartridge ; $e242
; **********************

          LDA MMU_MODE
          AND #%00110000 ; $30
          CMP #%00110000 ; $30
          BEQ TeCa_10         ; -> no C64 modules

; ***********
  C64 ; $e24b
; ***********

          LDA #$e3
          STA R8502
          LDA #$2f
          STA D8502
          LDX #8
C64_10    LDA ROM_GO64-1,X    ; copy reset code to RAM
          STA BANK-1,X
          DEX
          BNE C64_10
          STX VIC_SPEED       ; set to 1 MHz
          JMP BANK            ; jump to reset in C64 mode

; ****************
  ROM_GO64 ; $e263
; ****************

          LDA #$f7
          STA MMU_MODE
          JMP (V_RESET)

; search for ROM modules (cartridges) and call their
; initialization code if present

TeCa_10   LDX #3              ; 4 banks
          STX Module_Bank
          LDA #0
TeCa_20   STA Module_Flags,X  ; clear module flags
          DEX
          BPL TeCa_20         ; loop
          STA PTR_LO          ; ROM address low
TeCa_30   LDY #9
          LDX Module_Bank     ; module bank counter 3 -> 0
          LDA ROM_PAGES,X
          STA PTR_HI          ; ROM address high
          LDA ROM_BANK,X
          STA BANK            ; ROM bank
TeCa_40   LDX BANK
          LDA #PTR_LO
          JSR INDFET          ; LDA ROM,9 and ROM,8 and ROM,7
          CMP ROM_CBM-7,Y     ; check for "CBM" string
          BNE TeCa_50         ; -> no valid string
          DEY
          CPY #7              ; last index
          BCS TeCa_40         ; loop
          LDX BANK
          LDA #PTR_LO
          JSR INDFET          ; LDA ROM,6 (flags)
          LDX Module_Bank
          STA Module_Flags,X  ; store ROM flags
          CMP #1              ; init code present ?
          BNE TeCa_50         ; -> no
          LDA PTR_LO
          LDY PTR_HI
          STA PC_LO           ; PC := ROM address
          STY PC_HI
          JSR JSRFAR          ; call ROM initialization code
TeCa_50   DEC Module_Bank     ; next ROM module
          BPL TeCa_30
          RTS

; *****************
  ROM_PAGES ; $e2bc
; *****************

          .BYTE >$c000
          .BYTE >$8000
          .BYTE >$c000
          .BYTE >$8000

; ****************
  ROM_BANK ; $e2c0
; ****************

          .BYTE $04
          .BYTE $04
          .BYTE $08
          .BYTE $08

; ***************
  ROM_CBM ; $e2c4
; ***************

          .TEXT "CBM"         ; expansion ROM marker

; ***********************
  VIC_Init_Values ; $e2c7
; ***********************

          .BYTE $00           ; D000 X coordinate sprite 0
          .BYTE $00           ; D001 Y coordinate sprite 0
          .BYTE $00           ; D002 X coordinate sprite 1
          .BYTE $00           ; D003 Y coordinate sprite 1
          .BYTE $00           ; D004 X coordinate sprite 2
          .BYTE $00           ; D005 Y coordinate sprite 2
          .BYTE $00           ; D006 X coordinate sprite 3
          .BYTE $00           ; D007 Y coordinate sprite 3

          .BYTE $00           ; D008 X coordinate sprite 4
          .BYTE $00           ; D009 Y coordinate sprite 4
          .BYTE $00           ; D00A X coordinate sprite 5
          .BYTE $00           ; D00B Y coordinate sprite 5
          .BYTE $00           ; D00C X coordinate sprite 6
          .BYTE $00           ; D00D Y coordinate sprite 6
          .BYTE $00           ; D00E X coordinate sprite 7
          .BYTE $00           ; D00F Y coordinate sprite 7

          .BYTE $00           ; D010 MSBs of X coordinates
          .BYTE $1b           ; D011 Control register 1
          .BYTE $ff           ; D012 VIC_RASTER counter
          .BYTE $00           ; D013 Light pen X
          .BYTE $00           ; D014 Light pen Y
          .BYTE $00           ; D015 Sprite enabled
          .BYTE $08           ; D016 Control register 2
          .BYTE $00           ; D017 Sprite Y expansion

          .BYTE $14           ; D018 Memory control
          .BYTE $ff           ; D019 Interrupt register
          .BYTE $01           ; D01A Interrupt enabled
          .BYTE $00           ; D01B Sprite priority
          .BYTE $00           ; D01C Sprite multicolor
          .BYTE $00           ; D01D Sprite X expansion
          .BYTE $00           ; D01E Sprite sprite collision
          .BYTE $00           ; D01F Sprite data   collision

          .BYTE $0d           ; D020 Border color
          .BYTE $0b           ; D021 Background  color 0
          .BYTE $01           ; D022 Background  color 1
          .BYTE $02           ; D023 Background  color 2
          .BYTE $03           ; D024 Background  color 3
          .BYTE $01           ; D025 Sprite multicolor 0
          .BYTE $02           ; D026 Sprite multicolor 1
          .BYTE $00           ; D027 Sprite color 0

          .BYTE $01           ; D028 Sprite color 1
          .BYTE $02           ; D029 Sprite color 2
          .BYTE $03           ; D02A Sprite color 3
          .BYTE $04           ; D02B Sprite color 4
          .BYTE $05           ; D02C Sprite color 5
          .BYTE $06           ; D02D Sprite color 6
          .BYTE $07           ; D02E Sprite color 7
          .BYTE $ff           ; D02F Keyboard control

          .BYTE $fc           ; D030 Fast (2 MHz) or Slow (1 MHz)


; ***********************
  VDC_Init_Values ; $e2f8
; ***********************

          .BYTE $00,$7e       ; 00 total   columns (126)
          .BYTE $01,$50       ; 01 visible columns ( 80)
          .BYTE $02,$66       ; 02 horizonatl sync
          .BYTE $03,$49       ; 03 VSYNC / HSYNC
          .BYTE $04,$20       ; 04 total rows (32)
          .BYTE $05,$00       ; 05 rows adjust
          .BYTE $06,$19       ; 06 visible rows (25)
          .BYTE $07,$1d       ; 07 VSYNC position

          .BYTE $08,$00       ; 08 Interlace
          .BYTE $09,$07       ; 09 scanlines - 1 per character
          .BYTE $0a,$20       ; 0A cursor mode / start
          .BYTE $0b,$07       ; 0B cursor end
          .BYTE $0c,$00       ; 0C character RAM start high
          .BYTE $0d,$00       ; 0D character RAM start low
          .BYTE $0e,$00       ; 0E cursor position high
          .BYTE $0f,$00       ; 0F cursor position low

          .BYTE $14,$08       ; 14 attribute RAM start high
          .BYTE $15,$00       ; 15 attribute RAM start low
          .BYTE $17,$08       ; 17 scanlines - 1 per character

          .BYTE $18,$20       ; 18 block copy / blink frequency
          .BYTE $19,$40       ; 19 text / graphics mode
          .BYTE $1a,$f0       ; 1A foreground / background color
          .BYTE $1b,$00       ; 1B row step value
          .BYTE $1c,$20       ; 1C character generator page
          .BYTE $1d,$07       ; 1D underline count

          .BYTE $22,$7d       ; 22 left margin
          .BYTE $23,$64       ; 23 right margin
          .BYTE $24,$05       ; 24 refresh cycles

          .BYTE $16,$78       ; 16 character width
          .BYTE $ff           ; end of table marker

VDC_Init_NTSC

          .BYTE $19,$47       ; 19 text / graphics mode
          .BYTE $ff           ; end of table marker

VDC_Init_PAL

          .BYTE $04,$26       ; 04 total rows (38)
          .BYTE $07,$20       ; 07 VSYNC position
          .BYTE $ff           ; end of table marker

; ************
  TALK ; $e33b
; ************

          ORA #%01000000     ; $40 set TALK bit
          .byte $2c ;                 ; skip next instruction

; *************
  LISTN ; $e33e
; *************

          ORA #%00100000     ; $20 set LISTEN bit
          JSR RS232_Stop

; *******************
  Talk_Listen ; $e343
; *******************

          PHA                 ; push primary address
          BIT C3PO            ; test IEC buffer flag
          BPL TaLi_10         ; -> buffer empty
          SEC
          ROR R2D2            ; set
          JSR IEC_Send_Byte
          LSR C3PO
          LSR R2D2
TaLi_10   PLA                 ; pull primary address
          STA BSOUR
          JSR Disable_IRQ_and_Sprites
          JSR IEC_Data_Out_High
          LDA CIA2_PRA
          AND #%00001000     ; $08
          BNE TaLi_30
          JSR IEC_Fast_Output
          LDA #$ff
          STA CIA1_SDR        ; send $ff
          JSR IEC_Wait_Ready
          TXA
          LDX #$14
TaLi_20   DEX
          BNE TaLi_20
          TAX
TaLi_30   LDA CIA2_PRA
          ORA #%00001000 ; $08
          STA CIA2_PRA

; *************************
  IEC_Send_With_ATN ; $e37c
; *************************

          JSR Disable_IRQ_and_Sprites
          JSR IEC_Clock_Low
          JSR IEC_Data_Out_High
          TXA
          LDX #$b8            ; wait 1 millisecond
ISWA_10   DEX
          BNE ISWA_10
          TAX

; *********************
  IEC_Send_Byte ; $e38c
; *********************

          JSR Disable_IRQ_and_Sprites
          JSR IEC_Data_Out_High
          JSR IEC_Clock_Data_In
          BCC ISB_10          ; -> DATA IN high
          JMP ISB_75          ; -> device not present
ISB_10    BIT CIA1_ICR        ; reset IRQ flag
          JSR IEC_Clock_High
          BIT R2D2
          BPL ISB_25
ISB_15    JSR IEC_Clock_Data_In
          BCC ISB_15          ; wait for DATA IN low
ISB_20    JSR IEC_Clock_Data_In
          BCS ISB_20          ; wait for DATA IN high
ISB_25    LDA CIA2_PRA
          CMP CIA2_PRA
          BNE ISB_25          ; -> debounce
          PHA                 ; push
          LDA CIA1_ICR
          AND #%00001000     ; $08 test IRQ IEC port
          BEQ ISB_30          ; -> slow IEC device
          LDA #$c0            ; fast IEC and burst mode enabled
          STA Fast_IEC        ; fast IEC device
ISB_30    PLA
          BPL ISB_25          ; -> DATA IN high
          ORA #%00010000     ; $10 DATA OUT low
          STA CIA2_PRA
          AND #%00001000     ; $08 ATN out
          BNE ISB_35          ; -> ATN low
          BIT Fast_IEC
          BPL ISB_35          ; -> slow IEC

; fast IEC send

          JSR IEC_Fast_Output
          LDA BSOUR
          STA CIA1_SDR        ; store data in register
          JSR IEC_Wait_Ready  ; wait until sent
          JMP ISB_55          ; -> finish

; slow IEC send

ISB_35    LDA #8              ; send 8 bits
          STA CNTDN
ISB_40    LDA CIA2_PRA
          CMP CIA2_PRA
          BNE ISB_40            ; -> debounce
          ASL A                 ; DATA IN -> carry
          BCC ISB_70            ; -> error: timeout
          ROR BSOUR             ; next data bit -> carry
          BCS ISB_45
          JSR IEC_Data_Out_Low  ;    send '0' bit
          BNE ISB_50            ; always
ISB_45    JSR IEC_Data_Out_High ; -> send '1' bit
ISB_50    JSR IEC_Clock_High
          NOP                   ; wait 8 cycles
          NOP
          NOP
          NOP
          LDA CIA2_PRA
          AND #%11011111       ; $df DATA  OUT high
          ORA #%00010000       ; $10 CLOCK OUT low
          STA CIA2_PRA
          DEC CNTDN             ; next bit
          BNE ISB_40            ; loop

ISB_55    TXA
          PHA                 ; save X
          LDX #$22            ; timeout counter
ISB_60    JSR IEC_Clock_Data_In
          BCS ISB_65          ; -> wait for DATA IN
          PLA
          TAX                 ; restore X
          JMP Enable_IRQ_and_Sprites ; exit

ISB_65    DEX
          BNE ISB_60
          PLA
          TAX                 ; restore X
ISB_70    LDA #3              ; timeout
          .byte $2c ;BIT
ISB_75    LDA #$80            ; device not present

; *****************
  IEC_Error ; $e42a
; *****************

          PHA
          LDA Fast_IEC
          AND #%01111111     ; $7f clear fast IEC flag
          STA Fast_IEC
          PLA
          JSR SETST
          JSR Enable_IRQ_and_Sprites
          CLC
          JMP UNLSN_10

; *************
  ACPTR ; $e43e
; *************

          JSR Disable_IRQ_and_Sprites
          LDA #0
          STA CNTDN           ; retry counter
          BIT CIA1_ICR        ; reset IRQ's
          TXA
          PHA                 ; save X
          JSR IEC_Clock_High
ACPTR_10  JSR IEC_Clock_Data_In
          BPL ACPTR_10        ; wait for CLOCK IN high
ACPTR_15  LDX #13             ; wait max. 0.25 msec
          LDA CIA2_PRA
          AND #%11011111     ; $df DATA OUT high
          STA CIA2_PRA
ACPTR_20  LDA CIA2_PRA
          CMP CIA2_PRA
          BNE ACPTR_20        ; -> debounce
          ASL A               ; CLOCK IN -> bit 7
          BPL ACPTR_30        ; -> OK
          DEX
          BNE ACPTR_20        ; -> wait for CLOCK_IN
          LDA CNTDN
          BNE ACPTR_25        ; -> retry failed again
          JSR IEC_Data_Out_Low
          JSR IEC_Clock_High
          LDA #$40            ; EOF
          JSR SETST           ; set EOF flag
          INC CNTDN           ; set retry flag
          BNE ACPTR_15        ; always

ACPTR_25  PLA                 ; read failed
          TAX                 ; restore X
          LDA #2              ; timeout reading
          JMP IEC_Error

ACPTR_30  LDX #8 ; 8 bits to read
ACPTR_35  LDA CIA1_ICR
          AND #%00001000     ; $08 fast IEC ?
          BNE ACPTR_60        ; -> fast IEC device

; slow IEC read

ACPTR_40  LDA CIA2_PRA
          CMP CIA2_PRA
          BNE ACPTR_40        ; -> debounce
          ASL A               ; CLOCK IN -> bit 7
          BPL ACPTR_35        ; -> OK
ACPTR_45  ROR BSOUR1          ; store bit in BSOUR1
ACPTR_50  LDA CIA2_PRA
          CMP CIA2_PRA
          BNE ACPTR_50        ; -> debounce
          ASL A               ; CLOCK IN -> bit 7
          BMI ACPTR_50        ; -> wait for CLOCK IN high
          DEX
          BEQ ACPTR_65        ; -> all 8 bits read
ACPTR_55  LDA CIA2_PRA
          CMP CIA2_PRA
          BNE ACPTR_55        ; -> debounce
          ASL A               ; CLOCK IN -> bit 7
          BPL ACPTR_55        ; -> wait for CLOCK IN low
          BMI ACPTR_45        ; always

; fast IEC read

ACPTR_60  LDA CIA1_SDR        ; data register
          STA BSOUR1          ; received byte
          LDA #$c0            ; fast serial and burst mode enabled
          STA Fast_IEC        ; store flags

; fast & slow common code

ACPTR_65  PLA
          TAX                 ; restore X
          JSR IEC_Data_Out_Low
          BIT STATUS
          BVC ACPTR_70        ; -> branch on EOI = 0
          JSR IEC_CLOCK_DATA_OUT_High
ACPTR_70  JSR Enable_IRQ_and_Sprites
          LDA BSOUR1          ; return result in A
          CLC                 ; clear carry -> OK
          RTS

; *************
  SECND ; $e4d2
; *************

          STA BSOUR
          JSR IEC_Send_With_ATN

; ************************
  IEC_ATN_OUT_High ; $e4d7
; ************************

          LDA CIA2_PRA
          AND #%11110111     ; $f7 ATN OUT high
          STA CIA2_PRA
          RTS

; ************
  TKSA ; $e4e0
; ************

          STA BSOUR
          JSR IEC_Send_With_ATN
          BIT STATUS
          BMI UNLSN_10           ; branch on device not present

; *************************
  IEC_ATN_High_Exit ; $e4e9
; *************************

          JSR Disable_IRQ_and_Sprites
          JSR IEC_Data_Out_Low
          JSR IEC_ATN_OUT_High
          JSR IEC_Clock_High
IAHE_10   LDA CIA2_PRA
          CMP CIA2_PRA
          BNE IAHE_10
          ASL A
          BMI IAHE_10
          JMP Enable_IRQ_and_Sprites

; *************
  CIOUT ; $e503
; *************

          BIT C3PO            ; data in buffer ?
          BMI CIOUT_10        ; -> yes
          SEC
          ROR C3PO            ; set flag: data in buffer
          BNE CIOUT_20        ; always

CIOUT_10  PHA                 ; save new data byte
          JSR IEC_Send_Byte   ; send buffered byte
          PLA                 ; restore new data byte
CIOUT_20  STA BSOUR           ; store in buffer
          CLC                 ; OK
          RTS

; *************
  UNTLK ; $e515
; *************

          JSR Disable_IRQ_and_Sprites
          JSR IEC_Clock_Low
          LDA CIA2_PRA
          ORA #%00001000     ; $08
          STA CIA2_PRA
          LDA #$5f            ; UNTALK value
          .byte $2c ;BIT

; *************
  UNLSN ; $e526
; *************

          LDA #$3f            ; UNLISTEN value
          PHA
          LDA Fast_IEC
          AND #%01111111     ; $7f clear fast IEC flag
          STA Fast_IEC
          PLA
          JSR Talk_Listen
UNLSN_10  JSR IEC_ATN_OUT_High

; *******************************
  IEC_CLOCK_DATA_OUT_High ; $e538
; *******************************

          TXA
          LDX #10
ICDO_10   DEX
          BNE ICDO_10
          TAX
          JSR IEC_Clock_High
          JMP IEC_Data_Out_High

; **********************
  IEC_Clock_High ; $e545
; **********************

          LDA CIA2_PRA
          AND #%11101111 ; $ef
          STA CIA2_PRA
          RTS

; *********************
  IEC_Clock_Low ; $e54e
; *********************

          LDA CIA2_PRA
          ORA #%00010000 ; $10
          STA CIA2_PRA
          RTS

; *************************
  IEC_Data_Out_High ; $e557
; *************************

          LDA CIA2_PRA
          AND #%11011111 ; $df
          STA CIA2_PRA
          RTS

; ************************
  IEC_Data_Out_Low ; $e560
; ************************

          LDA CIA2_PRA
          ORA #%00100000 ; $20
          STA CIA2_PRA
          RTS

; **************************
  IEC_Clock_Data_In ; $e569
; **************************

          LDA CIA2_PRA
          CMP CIA2_PRA
          BNE IEC_Clock_Data_In
          ASL A
          RTS

; *******************************
  Disable_IRQ_and_Sprites ; $e573
; *******************************

          SEI

; ***********************
  Disable_Sprites ; $e574
; ***********************

          BIT SPRITES
          BMI DiSp_Ret
          BIT VSH_SPEED
          BMI DiSp_Ret
          LDA VIC_SPEED
          STA VSH_SPEED
          LDA VIC_SPR_ENA
          STA VSH_SPR_ENA
          LDA #0
          STA VIC_SPR_ENA
          STA VIC_SPEED
          LDA VSH_SPR_ENA
          BEQ DiSp_Ret
          TXA
          LDX #0
DiSp_10   DEX ; wait loop
          BNE DiSp_10
          TAX
DiSp_Ret  RTS

; ******************************
  Enable_IRQ_and_Sprites ; $e59f
; ******************************

          BIT SPRITES
          BMI EnSp_10
          BIT VSH_SPEED
          BPL EnSp_10
          LDA VSH_SPR_ENA
          STA VIC_SPR_ENA
          LDA VSH_SPEED
          STA VIC_SPEED
          LDA #0
          STA VSH_SPEED
EnSp_10   CLI
          RTS

; **********************
  IEC_Wait_Ready ; $e5bc
; **********************

          LDA CIA1_ICR
          AND #%00001000 ; $08
          BEQ IEC_Wait_Ready

; **********************
  IEC_Fast_Input ; $e5c3
; **********************

          LDA CIA1_CRA
          AND #%10000000 ; $80 save TOD flag
          ORA #%00001000 ; $08 set ONE SHOT flag
          STA CIA1_CRA
          LDA MMU_MODE
          AND #%11110111 ; $f7 fast serial direction input
          STA MMU_MODE
          RTS

; ***********************
  IEC_Fast_Output ; $e5d6
; ***********************

          LDA MMU_MODE
          ORA #%00001000     ; $08 Fast IEC direction output
          STA MMU_MODE
          LDA #$7f
          STA CIA1_ICR        ; disable IRQ's
          LDA #0
          STA CIA1_TAHI
          LDA #4
          STA CIA1_TALO       ; set timer A to 4 (PHI2)
          LDA CIA1_CRA
          AND #%10000000     ; $80
          ORA #%01010101     ; $55

; .1.. .... IEC port output mode
; ..0. .... timer A counts PHI2
; ...1 .... FORCE LOAD
; .... 0... continuos
; .... .1.. toggle
; .... ..0. PB6 normal
; .... ...1 start timer A

          STA CIA1_CRA
          BIT CIA1_ICR        ; reset IRQ flags
          RTS

; **************
  SPINIO ; $e5fb
; **************

          BCC IEC_Fast_Input
          BCS IEC_Fast_Output

; ***************
; RS232 interface
; ***************

; *******************
  RS_NMI_Send ; $e5ff
; *******************

          LDA RS_Count        ; # of data bits to send
          BEQ RS_Send_Next_Byte
          BMI RNS_90          ; -> send STOP bit
          LSR RS_Out          ; next bit to carry
          LDX #0              ; $00 for bit 0
          BCC RNS_10
          DEX                 ; $ff for bit 1
RNS_10    TXA
          EOR RS_Parity       ; update parity
          STA RS_Parity       ; store  parity
          DEC RS_Count
          BEQ RNS_30          ; -> parity check
RNS_20    TXA
          AND #%00000100     ; $04 bit 2 = transfer position
          STA RS_Next
          RTS

; 765. .... parity
; ..0. .... NO
; 001. .... ODD
; 011. .... EVEN
; 101. .... MARK
; 111. .... SPACE

RNS_30    LDA #%00100000     ; $20 ODD parity
          BIT RS_Command
          BEQ RNS_60          ; -> NO parity
          BMI RNS_80          ; -> MARK or SPACE parity
          BVS RNS_70          ; -> EVEN parity
          LDA RS_Parity
          BNE RNS_50
RNS_40    DEX
RNS_50    DEC RS_Count
          LDA RS_Control
          BPL RNS_20
          DEC RS_Count
          BNE RNS_20
RNS_60    INC RS_Count
          BNE RNS_40          ; always

RNS_70    LDA RS_Parity       ; EVEN parity
          BEQ RNS_50          ; -> is EVEN  -> send 0
          BNE RNS_40          ; -> is ODD   -> send 1

RNS_80    BVS RNS_50          ; -> is MARK  -> send 1
          BVC RNS_40          ; -> is SPACE -> send 0

RNS_90    INC RS_Count        ; RS_Count = 0
          LDX #$ff            ; -> send 1 STOP bit
          BNE RNS_20          ; always

; *************************
  RS_Send_Next_Byte ; $e64a
; *************************

          LDA RS_Command
          LSR A
          BCC RSNB_10         ; -> 3-wire communication
          BIT CIA2_PRB
          BPL RSNB_20         ; -> error: missing DSR
          BVC RSNB_30         ; -> error: missing CTS
RSNB_10   LDA #0
          STA RS_Parity
          STA RS_Next
          LDX RS_Bits
          STX RS_Count        ; initialize bit counter
          LDY RS_OBP_Beg
          CPY RS_OBP_End      ; compare buffer pointer
          BEQ RSNB_40         ; -> buffer is empty
          LDA (ROBUF),Y       ; fetch next byte from buffer
          STA RS_Out          ; store it into transmitter buffer
          INC RS_OBP_Beg      ; update buffer pointer
          RTS

RSNB_20   LDA #$40            ; missing DSR
          .byte $2c ;BIT
RSNB_30   LDA #16             ; missing CTS
          ORA RS_Status
          STA RS_Status       ; set error bit
RSNB_40   LDA #1              ; start TIMER A

; **************************
  Set_CIA2_Interrupt ; $e67f
; **************************

          STA CIA2_ICR
          EOR RS_Enable
          ORA #%10000000 ; $80
          STA RS_Enable
          STA CIA2_ICR
          RTS

; ***********************
  RS_Set_Databits ; $e68e
; ***********************

          LDX #9              ; databits + 1
          LDA #%00100000     ; check bit 5
          BIT RS_Control

; .00. .... 8 bits
; .01. .... 7 bits
; .10. .... 6 bits
; .11. .... 5 bits

          BEQ RSSD_10
          DEX                 ; X = 8
RSSD_10   BVC RSSD_Ret
          DEX
          DEX
RSSD_Ret  RTS

; **********************
  RS_NMI_Receive ; $e69d
; **********************

          LDX RSI_Start
          BNE RSNR_30         ; -> get start bit
          DEC RSI_Count
          BEQ RSNR_35         ; -> byte complete
          BMI RSNR_20         ; -> get stop bit
          LDA RSI_In_Bit
          EOR RSI_Parity
          STA RSI_Parity      ; update parity
          LSR RSI_In_Bit
          ROR RSI_Data        ; rotate into data byte
RSNR_10   RTS

RSNR_15   DEC RSI_Count
RSNR_20   LDA RSI_In_Bit      ; stop bit
          BEQ RSNR_70         ; -> BREAK or error
          LDA RS_Control
          ASL A               ; C=1 -> 2 stop bits
          LDA #1              ; # of stop bits
          ADC RSI_Count
          BNE RSNR_10         ; -> return

; setup for next receiption

RSNR_25   LDA #$90            ; IRQ enable & RS232
          STA CIA2_ICR
          ORA RS_Enable
          STA RS_Enable
          STA RSI_Start
          LDA #2
          JMP Set_CIA2_Interrupt

; get start bit

RSNR_30   LDA RSI_In_Bit
          BNE RSNR_25         ; -> no start bit: reinitialize
          STA RSI_Start
          LDA #1
          STA RSI_Parity
          RTS

; byte complete

RSNR_35   LDY RS_IBP_End
          INY
          CPY RS_IBP_Beg      ; compare buffer pointers
          BEQ RSNR_55         ; -> error: input buffer overflow
          STY RS_IBP_End
          DEY
          LDA RSI_Data        ; received byte
          LDX RS_Bits
RSNR_40   CPX #9
          BEQ RSNR_45         ; -> byte in correct position
          LSR A               ; bitlengths < 8 need more shifts
          INX
          BNE RSNR_40

RSNR_45   STA (RIBUF),Y       ; store received byte in buffer
          LDA #$20
          BIT RS_Command      ; test parity
          BEQ RSNR_15         ; -> NO parity
          BMI RSNR_10         ; -> fixed parity: ignore
          LDA RSI_In_Bit
          EOR RSI_Parity
          BEQ RSNR_50         ; -> check ODD parity
          BVS RSNR_10         ; -> EVEN parity -> OK
          .byte $2c ;BIT
RSNR_50   BVC RSNR_10         ; -> ODD parity -> OK
          LDA #1              ; error: parity
          .byte $2c ;BIT
RSNR_55   LDA #4              ; error: input buffer overflow
          .byte $2c ;BIT
RSNR_60   LDA #$80            ; error: BREAK
          .byte $2c ;BIT
RSNR_65   LDA #2              ; error: frame
          ORA RS_Status
          STA RS_Status
          JMP RSNR_25

RSNR_70   LDA RSI_Data        ; BREAK or frame error
          BNE RSNR_65
          BEQ RSNR_60

; ****************
  RS_CKOUT ; $e729
; ****************

          STA DFLTO           ; output channel = 2
          LDA RS_Command
          LSR A
          BCC RSDM_10         ; -> 3-wire handshake
          LDA #2
          BIT CIA2_PRB
          BPL RS_DSR_Missing
          BNE RSDM_10         ; always

RSCO_10   LDA RS_Enable
          AND #%00000010     ; $02 TIMER B
          BNE RSCO_10
RSCO_20   BIT CIA2_PRB
          BVS RSCO_20
          LDA CIA2_PRB
          ORA #%00000010 ; $02
          STA CIA2_PRB
RSCO_30   BIT CIA2_PRB
          BVS RSDM_10
          BMI RSCO_30

; **********************
  RS_DSR_Missing ; $e755
; **********************

          LDA #$40
          STA RS_Status
RSDM_10   CLC
          RTS

RSW_00    JSR RS_Start_Baud

; ****************
  RS_Write ; $e75f
; ****************

          LDY RS_OBP_End
          INY
          CPY RS_OBP_Beg      ; compare buffer pointer
          BEQ RSW_00          ; -> buffer full: wait
          STY RS_OBP_End
          DEY
          LDA PTR_LO
          STA (ROBUF),Y       ; store byte into send buffer

; *********************
  RS_Start_Baud ; $e770
; *********************

          LDA RS_Enable
          LSR A
          BCS RSSB_Ret        ; RS 232 output is active
          LDA #16
          STA CIA2_CRA        ;
          LDA RS_Timer_Lo
          STA CIA2_TALO
          LDA RS_Timer_Hi
          STA CIA2_TAHI
          LDA #$81
          JSR Set_CIA2_Interrupt
          JSR RS_Send_Next_Byte
          LDA #$11            ; clear RS232 received & TIMER A
          STA CIA2_CRA
RSSB_Ret  RTS

; ****************
  RS_CHKIN ; $e795
; ****************

          STA DFLTN           ; default input channel = 2
          LDA RS_Command
          LSR A
          BCC RSCI_40         ; -> 3-wire handshake
          AND #%00001000     ; $08
          BEQ RSCI_40         ; -> full duplex
          LDA #2
          BIT CIA2_PRB
          BPL RS_DSR_Missing
          BEQ RSCI_50         ; RTS missing
RSCI_10   LDA RS_Enable
          LSR A
          BCS RSCI_10         ; wait send completion
          LDA CIA2_PRB
          AND #%11111101     ; $fd RTS request to send
          STA CIA2_PRB
RSCI_20   LDA CIA2_PRB
          AND #%00000100     ; $04
          BEQ RSCI_20
RSCI_30   LDA #$90
          CLC
          JMP Set_CIA2_Interrupt

RSCI_40   LDA RS_Enable
          AND #%00010010 ; $12
          BEQ RSCI_30
RSCI_50   CLC
          RTS

; ***************
  RS_Read ; $e7ce
; ***************

          LDA RS_Status
          LDY RS_IBP_Beg
          CPY RS_IBP_End
          BEQ RSR_10          ; -> buffer empty
          AND #%11110111 ; $f7
          STA RS_Status
          LDA (RIBUF),Y       ; load byte from buffer
          INC RS_IBP_Beg
          RTS
RSR_10    ORA #%00001000 ; $08
          STA RS_Status
          LDA #0
          RTS

; ******************
  RS232_Stop ; $e7ec
; ******************

          PHA
          LDA RS_Enable
          BEQ RSS_20
RSS_10    LDA RS_Enable
          AND #%00000011 ; $03
          BNE RSS_10
          LDA #16
          STA CIA2_ICR
          LDA #0
          STA RS_Enable
RSS_20    PLA
          RTS

; *******************
  RS_NMI_Main ; $e805
; *******************

          TYA                 ; A = CIA2_ICR
          AND RS_Enable
          TAX
          AND #%00000001
          BEQ RSNM_30         ; -> IRQ TIMER B
          LDA CIA2_PRA
          AND #%11111011     ; $fb
          ORA RS_Next         ; next bit to send at pos 2
          STA CIA2_PRA        ; sed next bit
          LDA RS_Enable
          STA CIA2_ICR
          TXA
          AND #%00010010     ; RS232 input & TIMER B
          BEQ RSNM_20
          AND #%00000010     ; TIMER B
          BEQ RSNM_10         ; -> no TIMER B IRQ
          JSR RS_NMI_Get_Bit
          JMP RSNM_20
RSNM_10   JSR RS_NMI_Put_Bit
RSNM_20   JSR RS_NMI_Send
          JMP RSNM_50
RSNM_30   TXA
          AND #%00000010 ; $02
          BEQ RSNM_40
          JSR RS_NMI_Get_Bit
          JMP RSNM_50
RSNM_40   TXA
          AND #%00010000 ; $10
          BEQ RSNM_50
          JSR RS_NMI_Put_Bit
RSNM_50   LDA RS_Enable
          STA CIA2_ICR
          RTS

; ********************
  RS_Baud_NTSC ; $e850
; ********************

          .WORD $27c1 ; 10177    50   Baud  1.027.700
          .WORD $1a3e ;  6718    75   Baud  1.022.700
          .WORD $11c5 ;  4549   110   Baud  1.022.780
          .WORD $0e74 ;  3700   134.5 Baud  1.022.200
          .WORD $0ced ;  3309   150   Baud  1.022.700
          .WORD $0645 ;  1605   300   Baud  1.023.000
          .WORD $02f0 ;   752   600   Baud  1.022.400
          .WORD $0146 ;   326  1200   Baud  1.022.400
          .WORD $00b8 ;   184  1800   Baud  1.022.400
          .WORD $0071 ;   113  2400   Baud  1.022.400

; *******************
  RS_Baud_PAL ; $e864
; *******************

          .WORD $2619 ;  9753    50   Baud
          .WORD $1944 ;  6468    75   Baud
          .WORD $111a ;  4378   110   Baud
          .WORD $0de8 ;  3560   134.5 Baud
          .WORD $0c70 ;  3184   150   Baud
          .WORD $0606 ;  1542   300   Baud
          .WORD $02d1 ;   721   600   Baud
          .WORD $0137 ;   311  1200   Baud
          .WORD $00ae ;   174  1800   Baud
          .WORD $0069 ;   105  2400   Baud

; **********************
  RS_NMI_Get_Bit ; $e878
; **********************

          LDA CIA2_PRB
          AND #1
          STA RSI_In_Bit      ; received data bit
          LDA CIA2_TBLO       ; reprogram TIMER B latch
          SBC #40             ; B = B - 40 + baudtime
          ADC RS_Timer_Lo
          STA CIA2_TBLO
          LDA CIA2_TBHI
          ADC RS_Timer_Hi
          STA CIA2_TBHI
          LDA #$11
          STA CIA2_CRB        ; start TIMER B from latch
          LDA RS_Enable
          STA CIA2_ICR        ; enable TIMER interrupt
          LDA #$ff
          STA CIA2_TBLO       ; set TIMER B latch to maximum
          STA CIA2_TBHI
          JMP RS_NMI_Receive

; **********************
  RS_NMI_Put_Bit ; $e8a9
; **********************

          LDA RS_Baudrate     ; set baudrate
          STA CIA2_TBLO
          LDA RS_Baudrate+1
          STA CIA2_TBHI
          LDA #$11
          STA CIA2_CRB        ; start TIMER B from latch
          LDA #$12
          EOR RS_Enable
          STA RS_Enable
          LDA #$ff
          STA CIA2_TBLO       ; set TIMER B latch to maximum
          STA CIA2_TBHI
          LDX RS_Bits
          STX RSI_Count
          RTS

; *************
; TAPE routines
; *************

;   On Commodore computers, the streams consist of four kinds of symbols
;   that denote different kinds of low-to-high-to-low transitions on the
;   read or write signals of the Commodore tape interface.
;
;   1) A break in the communications, or a pulse with very long cycle time.
;
;   2) A short pulse, whose cycle time typically ranges from 296 to 424
;      microseconds, depending on the computer model.
;
;   3) A medium-length pulse, whose cycle time typically ranges from
;      440 to 576 microseconds, depending on the computer model.
;
;   4) A long pulse, whose cycle time typically ranges from 600 to 744
;      microseconds, depending on the computer model.
;
; The actual interpretation of the serial data takes a little more work to
; explain. The typical ROM tape loader (and the turbo loaders) will
; initialize a timer with a specified value and start it counting down. If
; either the tape data changes or the timer runs out, an IRQ will occur. The
; loader will determine which condition caused the IRQ. If the tape data
; changed before the timer ran out, we have a short pulse, or a "0" bit. If
; the timer ran out first, we have a long pulse, or a "1" bit. Doing this
; continuously and we decode the entire file.

; ************************
  TAPE_Find_Header ; $e8d0
; ************************

          LDA K_VERCK         ; get load/verify flag
          PHA                 ; save load/verify flag
          JSR TAPE_Read_Block
          PLA                 ; restore load/verify flag
          STA K_VERCK         ; save load/verify flag
          BCS TAFH_Ret        ; exit on error
          LDY #0
          LDA (TAPE1),Y       ; read first byte from tape buffer
          CMP #5              ; EOT (5) = End Of Tape
          BEQ TAFH_60         ; exit if end of the tape
          CMP #1              ; header of a relocatable BASIC program ?
          BEQ TAFH_10         ; branch if program file header
          CMP #3              ; header of a non relocatable program
          BEQ TAFH_10         ; branch if program file header
          CMP #4              ; header sequential data file
          BNE TAPE_Find_Header; continue search

TAFH_10   TAX                 ; X = header type
          BIT MSGFLG          ; get message mode flag
          BPL TAFH_50         ; exit if control messages off
          LDY #Msg_Found      ; $63 FOUND
          JSR System_Message

          LDY #5              ; index to tape filename
TAFH_20   LDA (TAPE1),Y       ; get filename char
          JSR K_BSOUT         ; print it
          INY
          CPY #21             ; length = 16 from Y=5 to 20
          BNE TAFH_20         ; loop

          LDA JIFFY_CLOCK+1   ; load medium byte of jiffy clock
          ADC #2              ; add 2 (2 * 256 / 60 sec = 8.5 sec)
TAFH_30   LDY STKEY           ; STOP key flag
          INY
          BNE TAFH_40         ; -> STKEY was not $ff : key pressed
          CMP JIFFY_CLOCK+1   ; waittime of 8.5 seconds reached ?
          BNE TAFH_30         ; -> stay in STOP key wait loop

TAFH_40   CPY #$f0            ; SPACE key ?
          BEQ TAPE_Find_Header; -> skip this file and continue
TAFH_50   CLC                 ; set OK flag
TAFH_60   DEY                 ; compensate INY: Y = STKEY or $ff
TAFH_Ret  RTS                 ; return

; *********************************
  TAPE_Write_Program_Header ; $e919
; *********************************

          STA PTR_LO          ; save header type
          JSR TAPE_XY_Check
          BCC TWPH_Ret        ; don't write to ZP or stack
          LDA STAH            ; push I/O start address
          PHA
          LDA STAL
          PHA
          LDA EAH             ; push tape end address
          PHA
          LDA EAL
          PHA
          LDY #$bf            ; 191 = index to header end
          LDA #' '
TWPH_10   STA (TAPE1),Y       ; blank buffer
          DEY
          BNE TWPH_10
          LDA PTR_LO          ; header type
          STA (TAPE1),Y       ; write to header 0
          INY
          LDA STAL            ; start address low
          STA (TAPE1),Y       ; write to header 1
          INY
          LDA STAH            ; start address high
          STA (TAPE1),Y       ; write to header 2
          INY
          LDA EAL             ; end address low
          STA (TAPE1),Y       ; write to header 3
          INY
          LDA EAH             ; end address high
          STA (TAPE1),Y       ; write to header 4
          INY
          STY PTR_HI          ; save index
          LDY #0
          STY PTR_LO          ; clear name index
TWPH_20   LDY PTR_LO          ; filename index
          CPY FNLEN           ; compare with file name length
          BEQ TWPH_30         ; exit loop if all done
          JSR Get_Filename_Char
          LDY PTR_HI          ; get buffer index
          STA (TAPE1),Y       ; save file name byte to buffer
          INC PTR_LO          ; increment file name index
          INC PTR_HI          ; increment tape buffer index
          BNE TWPH_20         ; loop, branch always
TWPH_30   JSR TAPE_SAL_EAL
          LDA #$69            ; set write lead cycle count
          STA RSI_Parity      ; save write lead cycle count
          JSR TAPE_Write
          TAY
          PLA
          STA EAL             ; restore load end address
          PLA
          STA EAH
          PLA
          STA STAL            ; restore load start address
          PLA
          STA STAH
          TYA
TWPH_Ret  RTS

; *********************
  TAPE_XY_Check ; $e980
; *********************

          LDX TAPE1
          LDY TAPE1+1
          CPY #2
          RTS

; ********************
  TAPE_SAL_EAL ; $e987
; ********************

          JSR TAPE_XY_Check
          TXA
          STA STAL            ; SAL = TAPE1
          CLC
          ADC #$c0
          STA EAL             ; EAL = TAPE1 + 192
          TYA
          STA STAH
          ADC #0
          STA EAH
          RTS

; **********************
  TAPE_Find_File ; $e99a
; **********************

          JSR TAPE_Find_Header
          BCS TAFF_Ret        ; -> end of tape: not found
          LDY #5              ; start of filename
          STY PTR_HI          ; buffered filename index
          LDY #0
          STY PTR_LO          ; fined filename index
TAFF_10   CPY FNLEN
          BEQ TAFF_20         ; -> OK found
          JSR Get_Filename_Char
          LDY PTR_HI
          CMP (TAPE1),Y
          BNE TAPE_Find_File  ; -> skip this file, try next one
          INC PTR_LO
          INC PTR_HI
          LDY PTR_LO
          BNE TAFF_10         ; always
TAFF_20   CLC                 ; success
TAFF_Ret  RTS

; **************************
  TAPE_Advance_BUFPT ; $e9be
; **************************

          JSR TAPE_XY_Check
          INC BUFPT
          LDY BUFPT
          CPY #$c0
          RTS

; **************************
  TAPE_Wait_for_Play ; $e9c8
; **************************

          JSR TAPE_Play_Key
          BEQ TAPK_10
          LDY #Msg_Play
TWFP_10   JSR System_Message
TWFP_20   JSR TAPE_Stop_Key
          JSR TAPE_Play_Key
          BNE TWFP_20
          LDY #Msg_OK
          JMP System_Message

; *********************
  TAPE_Play_Key ; $e9df
; *********************

          LDA #16
          BIT R8502
          BNE TAPK_10
          BIT R8502
TAPK_10   CLC
          RTS

; ****************************
  TAPE_Wait_For_Record ; $e9e9
; ****************************

          JSR TAPE_Play_Key
          BEQ TAPK_10
          LDY #Msg_Record
          BNE TWFP_10

; ***********************
  TAPE_Read_Block ; $e9f2
; ***********************

          LDA #0
          STA STATUS
          STA K_VERCK
          JSR TAPE_SAL_EAL

; *****************
  TAPE_Read ; $e9fb
; *****************

          JSR TAPE_Wait_for_Play
          BCS TAWB_10
          SEI
          LDA #0
          STA RSI_Data
          STA RS_Count
          STA CMP0
          STA PTR_LO
          STA PTR_HI
          STA DPSW
          LDA #$90            ; STA CIA1_IC
          LDX #14             ; Install TAPE_IRQ_Read as IRQ routine
          BNE TAPE_Setup_IRQ  ; always

; *************************
  TAPE_Write_Buffer ; $ea15
; *************************

          JSR TAPE_SAL_EAL

; **************************
  TAPE_Write_Program ; $ea18
; **************************

          LDA #$14
          STA RSI_Parity

; ******************
  TAPE_Write ; $ea1c
; ******************

          JSR TAPE_Wait_For_Record
TAWB_10   BCS TASK_10
          SEI
          LDA #$82
          LDX #8              ; Install TAPE_IRQ_Leader as IRQ routine

; **********************
  TAPE_Setup_IRQ ; $ea26
; **********************

          LDY #0
          STY VIC_IRQ_ENA
          DEY
          STY VIC_IRQ_REG
          STA CIA1_ICR
          LDA CIA1_CRA
          ORA #%00011001 ; $19
          STA CIA1_CRB
          AND #%10010001 ; $91
          STA CASTON
          JSR RS232_Stop
          LDA VIC_Ctrl_1
          TAY
          AND #%00010000 ; $10
          STA VSH_Ctrl_1
          TYA
          AND #%01101111 ; $6f
          STA VIC_Ctrl_1
          JSR Disable_Sprites
          LDA IIRQ            ; save old IRQ vector
          STA IRQTMP
          LDA IIRQ+1
          STA IRQTMP+1
          JSR TAPE_Switch_IRQ
          LDA #2
          STA FSBLK
          JSR TAPE_Init_Byte
          LDA R8502
          AND #%00011111 ; $1f
          STA R8502
          STA CAS1
          LDX #$ff            ; wait 0.3 sec for tape start
TASI_10   LDY #$ff
TASI_20   DEY
          BNE TASI_20
          DEX
          BNE TASI_10
          CLI
TASI_30   LDA IRQTMP+1
          CMP IIRQ+1
          CLC
          BEQ TASK_10
          JSR TAPE_Stop_Key
          JSR Check_STOP_Key
          JMP TASI_30         ; wait until tape I/O finished

; *********************
  TAPE_Stop_Key ; $ea8f
; ********************

          JSR K_STOP
          CLC
          BNE TASK_Ret
          JSR TAPE_Stop_IO
          SEC
          PLA                 ; remove return address
          PLA
TASK_10   LDA #0
          STA IRQTMP+1        ; flag STOP
TASK_Ret  RTS

; **********************
  TAPE_Set_Timer ; $eaa1
; **********************

          STX CMP1
          LDA CMP0
          ASL A
          ASL A
          CLC
          ADC CMP0
          CLC
          ADC CMP1
          STA CMP1
          LDA #0
          BIT CMP0
          BMI TASS_10
          ROL A
TASS_10   ASL CMP1
          ROL A
          ASL CMP1
          ROL A
          TAX
TASS_20   LDA CIA1_TBLO
          CMP #$16
          BCC TASS_20
          ADC CMP1
          STA CIA1_TALO
          TXA
          ADC CIA1_TBHI
          STA CIA1_TAHI
          LDA CASTON
          STA CIA1_CRA
          STA STUPID
          LDA CIA1_ICR
          AND #%00010000 ; $10
          BEQ TASS_30
          LDA #$ea
          PHA
          LDA #$e9
          PHA
          JMP TAPE_Sim_IRQ
TASS_30   CLI
          RTS

; *********************
  TAPE_IRQ_Read ; $eaeb
; *********************

          LDX CIA1_TBHI
          LDY #$ff
          TYA
          SBC CIA1_TBLO
          CPX CIA1_TBHI
          BNE TAPE_IRQ_Read
          STX CMP1
          TAX
          STY CIA1_TBLO
          STY CIA1_TBHI
          LDA #$19
          STA CIA1_CRB
          LDA CIA1_ICR
          STA KIKA26
          TYA
          SBC CMP1
          STX CMP1
          LSR A
          ROR CMP1
          LSR A
          ROR CMP1
          LDA CMP0
          CLC
          ADC #$3c
          CMP CMP1
          BCS TIR_22
          LDX DPSW
          BEQ TIR_10
          JMP TIR_50
TIR_10    LDX R2D2
          BMI TIR_12
          LDX #0
          ADC #$30
          ADC CMP0
          CMP CMP1
          BCS TIR_16
          INX
          ADC #$26
          ADC CMP0
          CMP CMP1
          BCS TIR_18
          ADC #$2c
          ADC CMP0
          CMP CMP1
          BCC TIR_14
TIR_12    JMP TIR_38
TIR_14    LDA RS_Count
          BEQ TIR_22
          STA RSI_Count
          BNE TIR_22
TIR_16    INC RSI_Start
          BCS TIR_20
TIR_18    DEC RSI_Start
TIR_20    SEC
          SBC #$13
          SBC CMP1
          ADC SVXT
          STA SVXT
          LDA BSOUR1
          EOR #%00000001 ; $01
          STA BSOUR1
          BEQ TIR_30
          STX DATA
TIR_22    LDA RS_Count
          BEQ TIR_28
          LDA KIKA26
          AND #%00000001 ; $01
          BNE TIR_24
          LDA STUPID
          BNE TIR_28
TIR_24    LDA #0
          STA BSOUR1
          STA STUPID
          LDA R2D2
          BPL TIR_36
          BMI TIR_12
TIR_26    LDX #$a6
          JSR TAPE_Set_Timer
          LDA PRTY
          BNE TIR_14
TIR_28    JMP IRQ_Exit
TIR_30    LDA SVXT
          BEQ TIR_34
          BMI TIR_32
          DEC CMP0
          .byte $2c ;BIT
TIR_32    INC CMP0
TIR_34    LDA #0
          STA SVXT
          CPX DATA
          BNE TIR_36
          TXA
          BNE TIR_14
          LDA RSI_Start
          BMI TIR_22
          CMP #16
          BCC TIR_22
          STA SYNO
          BCS TIR_22
TIR_36    TXA
          EOR PRTY
          STA PRTY
          LDA RS_Count
          BEQ TIR_28
          DEC R2D2
          BMI TIR_26
          LSR DATA
          ROR DRIVE
          LDX #$da
          JSR TAPE_Set_Timer
          JMP IRQ_Exit
TIR_38    LDA SYNO
          BEQ TIR_40
          LDA RS_Count
          BEQ TIR_42
TIR_40    LDA R2D2
          BMI TIR_42
          JMP TIR_18
TIR_42    LSR CMP1
          LDA #$93
          SEC
          SBC CMP1
          ADC CMP0
          ASL A
          TAX
          JSR TAPE_Set_Timer
          INC DPSW
          LDA RS_Count
          BNE TIR_44
          LDA SYNO
          BEQ TIR_48
          STA RSI_Count
          LDA #0
          STA SYNO
          LDA #$81
          STA CIA1_ICR
          STA RS_Count
TIR_44    LDA SYNO
          STA RS_Next
          BEQ TIR_46
          LDA #0
          STA RS_Count
          LDA #1
          STA CIA1_ICR
TIR_46    LDA DRIVE
          STA RS_Parity
          LDA RSI_Count
          ORA RSI_Start
          STA RS_Out
TIR_48    JMP IRQ_Exit
TIR_50    JSR TAPE_Init_Byte
          STA DPSW
          LDX #$da
          JSR TAPE_Set_Timer
          LDA FSBLK
          BEQ TIR_52
          STA RSI_In_Bit
TIR_52    LDA #15
          BIT RSI_Data
          BPL TIR_58
          LDA RS_Next
          BNE TIR_54
          LDX FSBLK
          DEX
          BNE TIR_56
          LDA #8
          JSR SETST
          BNE TIR_56
TIR_54    LDA #0
          STA RSI_Data
TIR_56    JMP IRQ_Exit
TIR_58    BVS TIR_66
          BNE TIR_62
          LDA RS_Next
          BNE TIR_56
          LDA RS_Out
          BNE TIR_56
          LDA RSI_In_Bit
          LSR A
          LDA RS_Parity
          BMI TIR_60
          BCC TIR_64
          CLC
TIR_60    BCS TIR_64
          AND #%00001111 ; $0f
          STA RSI_Data
TIR_62    DEC RSI_Data
          BNE TIR_56
          LDA #$40 ; '@'
          STA RSI_Data
          JSR STAL_To_SAL
          LDA #0
          STA RSI_Parity
          BEQ TIR_56
TIR_64    LDA #$80
          STA RSI_Data
          BNE TIR_56
TIR_66    LDA RS_Next
          BEQ TIR_68
          LDA #4
          JSR SETST
          LDA #0
          JMP TIR_86
TIR_68    JSR Check_IO_End
          BCC TIR_70
          JMP TIR_84
TIR_70    LDX RSI_In_Bit
          DEX
          BEQ TIR_74
          LDA K_VERCK
          BEQ TIR_72
          LDY #0
          JSR LDA_IND_SAL
          CMP RS_Parity
          BEQ TIR_72
          LDA #1
          STA RS_Out
TIR_72    LDA RS_Out
          BEQ TIR_80
          LDX #$3d ; '='
          CPX PTR_LO
          BCC TIR_78
          LDX PTR_LO
          LDA SAH
          STA STACK+1,X
          LDA SAL
          STA STACK,X
          INX
          INX
          STX PTR_LO
          JMP TIR_80
TIR_74    LDX PTR_HI
          CPX PTR_LO
          BEQ TIR_82
          LDA SAL
          CMP STACK,X
          BNE TIR_82
          LDA SAH
          CMP STACK+1,X
          BNE TIR_82
          INC PTR_HI
          INC PTR_HI
          LDA K_VERCK
          BEQ TIR_76
          LDY #0
          JSR LDA_IND_SAL
          CMP RS_Parity
          BEQ TIR_82
          INY
          STY RS_Out
TIR_76    LDA RS_Out
          BEQ TIR_80
TIR_78    LDA #16
          JSR SETST
          BNE TIR_82
TIR_80    LDA K_VERCK
          BNE TIR_82
          TAY
          LDA RS_Parity
          JSR STA_IND_SAL
TIR_82    JSR Inc_SAL_Word
          BNE TIR_94
TIR_84    LDA #$80
TIR_86    STA RSI_Data
          SEI
          LDX #1
          STX CIA1_ICR
          LDX CIA1_ICR
          LDX FSBLK
          DEX
          BMI TIR_88
          STX FSBLK
TIR_88    DEC RSI_In_Bit
          BEQ TIR_90
          LDA PTR_LO
          BNE TIR_94
          STA FSBLK
          BEQ TIR_94
TIR_90    JSR TAPE_Stop_IO
          JSR STAL_To_SAL
          LDY #0
          STY RSI_Parity
TIR_92    JSR LDA_IND_SAL
          EOR RSI_Parity
          STA RSI_Parity
          JSR Inc_SAL_Word
          JSR Check_IO_End
          BCC TIR_92
          LDA RSI_Parity
          EOR RS_Parity
          BEQ TIR_94
          LDA #$20 ; ' '
          JSR SETST
TIR_94    JMP IRQ_Exit

; *******************
  STAL_To_SAL ; $ed51
; *******************

          LDA STAH
          STA SAH
          LDA STAL
          STA SAL
          RTS

; **********************
  TAPE_Init_Byte ; $ed5a
; **********************

          LDA #8
          STA R2D2
          LDA #0
          STA BSOUR1
          STA RSI_Count
          STA PRTY
          STA RSI_Start
          RTS

; **********************
  TAPE_Write_Bit ; $ed69
; **********************

          LDA RS_Parity
          LSR A
          LDA #$60
          BCC TAPE_Write_A

; ********************
  TAPE_Write_1 ; $ed70
; ********************

          LDA #$b0

; ********************
  TAPE_Write_A ; $ed72
; ********************

          LDX #0

; *********************
  TAPE_Write_AX ; $ed74
; *********************

          STA CIA1_TBLO
          STX CIA1_TBHI
          LDA CIA1_ICR
          LDA #$19
          STA CIA1_CRB
          LDA R8502
          EOR #%00001000 ; $08
          STA R8502
          AND #%00001000 ; $08
          RTS

TAIW_00   SEC
          ROR RS_Out
          BMI TAIW_20

; **********************
  TAPE_IRQ_Write ; $ed90
; **********************

          LDA RSI_Count
          BNE TAIW_10
          LDA #16
          LDX #1
          JSR TAPE_Write_AX
          BNE TAIW_20
          INC RSI_Count
          LDA RS_Out
          BPL TAIW_20
          JMP TAIW_60
TAIW_10   LDA RSI_Start
          BNE TAIW_15
          JSR TAPE_Write_1
          BNE TAIW_20
          INC RSI_Start
          BNE TAIW_20
TAIW_15   JSR TAPE_Write_Bit
          BNE TAIW_20
          LDA BSOUR1
          EOR #1
          STA BSOUR1
          BEQ TAIW_25
          LDA RS_Parity
          EOR #1
          STA RS_Parity
          AND #1
          EOR PRTY
          STA PRTY
TAIW_20   JMP IRQ_Exit
TAIW_25   LSR RS_Parity
          DEC R2D2
          LDA R2D2
          BEQ TAIW_50
          BPL TAIW_20
TAIW_30   JSR TAPE_Init_Byte
          CLI
          LDA CNTDN
          BEQ TAIW_40
          LDX #0
          STX DATA
          DEC CNTDN
          LDX FSBLK
          CPX #2
          BNE TAIW_35
          ORA #$80
TAIW_35   STA RS_Parity
          BNE TAIW_20
TAIW_40   JSR Check_IO_End
          BCC TAIW_45
          BNE TAIW_00
          INC SAH
          LDA DATA
          STA RS_Parity
          BCS TAIW_20
TAIW_45   LDY #0
          JSR LDA_IND_SAL
          STA RS_Parity
          EOR DATA
          STA DATA
          JSR Inc_SAL_Word
          BNE TAIW_20
TAIW_50   LDA PRTY
          EOR #1
          STA RS_Parity
TAIW_55   JMP IRQ_Exit
TAIW_60   DEC FSBLK
          BNE TAIW_65
          JSR TAPE_Stop_Motor
TAIW_65   LDA #$50
          STA RSI_In_Bit
          LDX #8              ; switch IRQ to TAPE_IRQ_Leader
          SEI
          JSR TAPE_Switch_IRQ
          BNE TAIW_55         ; always

; ***********************
  TAPE_IRQ_Leader ; $ee2e
; ***********************

          LDA #$78            ; set time constant low byte for bit = leader
          JSR TAPE_Write_A
          BNE TAIW_55         ; if tape bit high restore registers and exit IRQ
          DEC RSI_In_Bit      ; decrement cycle count
          BNE TAIW_55         ; if not all done restore registers and exit IRQ
          JSR TAPE_Init_Byte
          DEC RSI_Parity      ; decrement cassette leader count
          BPL TAIW_55         ; -> exit IRQ
          LDX #10             ; switch IRQ to TAPE_IRQ_Write
          JSR TAPE_Switch_IRQ
          CLI                 ; enable interrupts
          INC RSI_Parity      ; clear cassette leader counter, was -1
          LDA FSBLK           ; get cassette block count
          BEQ TSIO_30         ; if all done restore everything and exit IRQ
          JSR STAL_To_SAL
          LDX #9              ; set 9 synchronisation bytes
          STX CNTDN           ; save cassette synchronization byte count
          STX RS_Out
          BNE TAIW_30         ; go do next tape byte, branch always

; ********************
  TAPE_Stop_IO ; $ee57
; ********************

          PHP                 ; save status
          SEI                 ; disable interrupts
          LDA VIC_Ctrl_1
          ORA VSH_Ctrl_1
          AND #%01111111     ; disable all interrupts
          STA VIC_Ctrl_1
          BIT SPRITES
          BMI TSIO_10         ; -> don't change sprite enable flag
          BIT VSH_SPEED
          BPL TSIO_10         ; -> sprites are on alreay
          LDA VSH_SPR_ENA
          STA VIC_SPR_ENA     ; restore sprite enable flag
          LDA VSH_SPEED
          STA VIC_SPEED       ; restore speed
          LDA #0
          STA VSH_SPEED       ; clear shadow register
TSIO_10   JSR TAPE_Stop_Motor
          JSR Test_Fast_IEC   ; reset IEC attributes
          LDA IRQTMP+1        ; restore IRQ vector
          BEQ TSIO_20
          STA IIRQ+1
          LDA IRQTMP
          STA IIRQ
TSIO_20   PLP                 ; restore status
          RTS

TSIO_30   JSR TAPE_Stop_IO
          JMP IRQ_Exit

; ***********************
  TAPE_Switch_IRQ ; $ee9b
; ***********************

          LDA TAPE_IRQ_Table-8,X  ; get tape IRQ vector low byte
          STA IIRQ                ; set IRQ vector low byte
          LDA TAPE_IRQ_Table-7,X  ; get tape IRQ vector high byte
          STA IIRQ+1              ; set IRQ vector high byte
          RTS

; **********************
  TAPE_IRQ_Table ; $eea8
; **********************

          .WORD TAPE_IRQ_Leader   ; write tape leader
          .WORD TAPE_IRQ_Write    ; write data byte
          .WORD IRQ_Normal        ; default IRQ
          .WORD TAPE_IRQ_Read     ; read data byte

; ***********************
  TAPE_Stop_Motor ; $eeb0
; ***********************

          LDA R8502
          ORA #%00100000     ;  cassette motor off
          STA R8502
          RTS

; ********************
  Check_IO_End ; $eeb7
; ********************

          SEC
          LDA SAL             ; get buffer address low byte
          SBC EAL             ; subtract buffer end low byte
          LDA SAH             ; get buffer address high byte
          SBC EAH             ; subtract buffer end high byte
          RTS                 ; C=1 if SAL/H >= EAL/H

; ********************
  Inc_SAL_Word ; $eec1
; ********************

          INC SAL
          BNE ISW_Ret
          INC SAH
ISW_Ret   RTS

; ********************
  TAPE_Sim_IRQ ; $eec8
; ********************

          PHP
          PLA
          AND #%11101111     ; $ef set IRQ/BRK bit to IRQ
          PHA
          JMP IRQ

; *************************
  TAPE_Switch_Sense ; $eed0
; *************************

          LDA R8502
          AND #%00010000     ; $10
          BEQ TSS_10          ; -> key pressed
          LDY #0
          STY CAS1            ; motor flag = 0
          LDA R8502
          ORA #%00100000     ; $20 bit5 = 1 : motor off
          BNE TSS_20          ; always
TSS_10    LDA CAS1            ; test motor flag
          BNE TSS_Ret         ; -> motor is already on
          LDA R8502
          AND #%11011111     ; $df bit5 = 0 : motor on
TSS_20    STA R8502           ; motor on or off
TSS_Ret   RTS

; *************
  GETIN ; $eeeb
; *************

          LDA DFLTN           ; get input channel
          BNE GETIN_10        ; -> not keyboard
          LDA NDX             ; keys in buffer
          ORA KYNDX           ; keys in function key buffer
          BEQ GETIN_30        ; -> no keys
          SEI
          JMP E_GETKEY        ; fetch byte from buffer or function key

GETIN_10  CMP #2              ; input channel = RS232 ?
          BNE BASIN_20           ; -> no
GETIN_20  STY XSAV            ; save Y
          JSR RS_Read         ; fetch byte from RS232 input buffer
          LDY XSAV            ; restore Y
GETIN_30  CLC                 ; operation OK
          RTS

; *************
  BASIN ; $ef06
; *************

          LDA DFLTN           ; current input channel
          BNE BASIN_20        ; -> is not keyvoard
          LDA Cursor_Col
          STA CurLst_Col      ; last cursor column
          LDA Cursor_Row
          STA CurLst_Row      ; last cursor row
BASIN_10  JMP E_GETSCR        ; get character from screen at cursor position

BASIN_20  CMP #3              ; input channel = screen ?
          BNE BASIN_30        ; -> no
          JSR Set_CRSW        ; patch: set CRSW and save Cursor_Row
          LDA Margin_Right
          STA Cursor_End      ; define end of line
          BCS BASIN_10        ; branch always (CMP #3)

BASIN_30  BCS IEC_BASIN           ; -> channel > 3 : IEC device
          CMP #2              ; RS232 interface ?
          BEQ RS232_BASIN           ; -> read from RS232 input buffer
          STX XSAV            ; save X
          JSR TAPE_BASIN      ; get character from TAPE buffer
          BCS BASIN_60        ; -> return on error
          PHA                 ; push char
          JSR TAPE_BASIN      ; get next character from buffer
          BCS BASIN_50        ; -> return on error
          BNE BASIN_40        ; -> unget character
          LDA #$40            ; set bit6 = EOF
          JSR SETST           ; mark EOF status
BASIN_40  DEC BUFPT           ; unget character
          LDX XSAV            ; restore X
          PLA                 ; restore read character
          RTS                 ; return
BASIN_50  TAX                 ; X = read character
          PLA                 ; clean stack
          TXA                 ; A = read character
BASIN_60  LDX XSAV            ; restore X
          RTS                 ; return

; ******************
  TAPE_BASIN ; $ef48
; ******************

          JSR TAPE_Advance_BUFPT
          BNE TABA_10         ; -> not at end : get character
          JSR TAPE_Read_Block ; read next block into buffer
          BCS TABA_Ret        ; -> exit on error
          LDA #0
          STA BUFPT           ; reset buffer pointer
          BEQ TAPE_BASIN      ; -> branch always

TABA_10   LDA (TAPE1),Y       ; get character from TAPE buffer
          CLC                 ; OK flag
TABA_Ret  RTS                 ; return

; *****************
  IEC_BASIN ; $ef5c
; *****************

          LDA STATUS          ; check I/O status
          BNE IEBA_10         ; -> cannot read
          JMP ACPTR           ; -> read from IEC device
IEBA_10   LDA #CR             ; return CR if not able to read
IEBA_20   CLC                 ; OK flag
IEBA_Ret  RTS

; *******************
  RS232_BASIN ; $ef67
; *******************

          JSR GETIN_20        ; get character from RS232 buffer
          BCS IEBA_20         ; exit on error
          CMP #0
          BNE IEBA_Ret        ; -> not NULL
          LDA RS_Status
          AND #%01100000     ; $60 check DSR signal (bit 6)
          BNE IEBA_10         ; -> no DSR : load CR and exit
          BEQ RS232_BASIN     ; -> DSR signal : try again

; *************
  BSOUT ; $ef79
; *************

          PHA                 ; save character
          LDA DFLTO
          CMP #3
          BNE BSOUT_10
          PLA                 ; restore character
          JMP E_PRINT         ; print to screen (3)

BSOUT_10  BCC BSOUT_20        ; -> to tape (1) or RS232 (2)
          PLA
          JMP CIOUT           ; output to IEC device (> 3)

BSOUT_20  LSR A               ; C=1 for tape, C=0 for RS232
          PLA                 ; restore output byte

; ************************
  TAPE_RS232_BSOUT ; $ef8c
; ************************

          STA PTR_LO          ; save character
          TXA
          PHA                 ; save X
          TYA
          PHA                 ; save Y
          BCC BSOUT_70        ; -> RS232 output
          JSR TAPE_Advance_BUFPT
          BNE BSOUT_30        ; if not iat end store byte and exit
          JSR TAPE_Write_Buffer
          BCS BSOUT_50        ; -> error
          LDA #2              ; set data block type
          LDY #0
          STA (TAPE1),Y       ; save type to buffer
          INY
          STY BUFPT           ; save tape buffer index
BSOUT_30  LDA PTR_LO          ; restore character
          STA (TAPE1),Y       ; store to buffer
BSOUT_40  CLC                 ; flag no error
BSOUT_50  PLA
          TAY                 ; pull Y
          PLA
          TAX                 ; pull X
          LDA PTR_LO          ; restore output character
          BCC BSOUT_60        ; -> exit if OK
          LDA #0              ; A=0 for error return
BSOUT_60  RTS
BSOUT_70  JSR RS_Write        ; write character to RS232 buffer
          JMP BSOUT_40        ; -> exit

; ************
  OPEN ; $efbd
; ************

          LDX LA              ; logical address
          JSR Lookup_X          ; look up entry in file tables
          BEQ OPEN_30         ; -> error: already open
          LDX LDTND           ; # of open files
          CPX #10             ; compare with upper limit 10
          BCS OPEN_20         ; -> error: too many open files
          INC LDTND           ; increment # of open files
          LDA LA              ; logical address
          STA LAT,X           ; table of LA's
          LDA SA              ; secondary address
          ORA #%01100000     ; OR with $60
          STA SA              ; store it
          STA SAT,X           ; table of SA's
          LDA FA              ; first address (device/unit)
          STA FAT,X           ; table of FA's
          BEQ OPEN_10         ; -> open keyboard: no further action
          CMP #2              ; RS232 device ?
          BEQ RS_OPEN         ; -> open RS232 channel
          BCC TAPE_OPEN       ; -> device = 1 (tape)
          CMP #3              ; screen device ?
          BEQ OPEN_10         ; -> open screen: no further action
          JSR IEC_OPEN        ; device >= 4: open IEC device
OPEN_10   CLC                 ; flag: OK
          RTS                 ; return
OPEN_20   JMP Too_Many_Files           ; error
OPEN_30   JMP File_Open_Err           ; error

; *****************
  TAPE_OPEN ; $eff6
; *****************

          JSR TAPE_XY_Check
          BCS TAOP_10
          JMP Illegal_Device_Number           ; -> illeagl device number
TAOP_10   LDA SA
          AND #%00001111     ; $0f
          BNE TAOP_40         ; -> open for write
          JSR TAPE_Wait_for_Play
          BCS TAOP_Ret        ; -> error
          JSR Searching       ; display SEARCHING
          LDA FNLEN           ; filename length
          BEQ TAOP_30         ; -> not specified: find any file
          JSR TAPE_Find_File  ; look for named file
          BCC TAOP_50         ; -> found
          BEQ TAOP_Ret        ; -> forced STOP
TAOP_20   JMP File_Not_Found
TAOP_30   JSR TAPE_Find_Header
          BCC TAOP_50         ; -> found
          BEQ TAOP_Ret        ; -> forced STOP
          BCS TAOP_20         ; always

TAOP_40   JSR TAPE_Wait_For_Record
          BCS TAOP_Ret        ; -> error
          LDA #4              ; -> header type: 1st. block of data
          JSR TAPE_Write_Program_Header
TAOP_50   LDA #$bf            ; 191 = last buffer index
          LDY SA
          CPY #$60            ; SA = 60 ?
          BEQ TAOP_60         ; -> PRG file
          LDY #0              ; 1st. buffer index
          LDA #2              ; type 2: data block
          STA (TAPE1),Y       ; store header info
          TYA                 ; A = index
TAOP_60   STA BUFPT           ; save buffer index
          CLC                 ; flag OK
TAOP_Ret  RTS                 ; return

; ***************
  RS_OPEN ; $f040
; ***************

          JSR RS_Init_CIA
          STY RS_Status       ; Y = 0
RSOP_10   CPY FNLEN
          BEQ RSOP_20
          JSR Get_Filename_Char
          STA RS_Control,Y    ; get RS232 parameter
          INY
          CPY #4
          BNE RSOP_10
RSOP_20   JSR RS_Set_Databits
          STX RS_Bits
          LDA RS_Control
          AND #%00001111     ; $0f
          BEQ RSOP_50         ; -> user baudrate
          ASL A
          TAX                 ; index to baudrate table
          LDA PALNTS          ; check PAL or NTSC
          BNE RSOP_30         ; -> use PAL  values
          LDY RS_Baud_NTSC-1,X
          LDA RS_Baud_NTSC-2,X
          JMP RSOP_40
RSOP_30   LDY RS_Baud_PAL-1,X
          LDA RS_Baud_PAL-2,X
RSOP_40   STY RS_Baudrate+1
          STA RS_Baudrate
RSOP_50   LDA RS_Baudrate     ; X/Y = baudrate * 2
          ASL A
          TAX
          LDA RS_Baudrate+1
          ROL A
          TAY
          TXA
          ADC #$c8            ; add 200
          STA RS_Timer_Lo
          TYA
          ADC #0
          STA RS_Timer_Hi     ; timer = baudrate * 2 + 200
          LDA RS_Command
          LSR A
          BCC RSOP_60         ; -> 3 wire handshake
          LDA CIA2_PRB
          BMI RSOP_60         ; -> DSR set
          JSR RS_DSR_Missing
          CLC
RSOP_60   LDA RS_IBP_End      ; sync buffer pointer (buffer empty)
          STA RS_IBP_Beg
          LDA RS_OBP_End
          STA RS_OBP_Beg
          RTS

; *******************
  RS_Init_CIA ; $f0b0
; *******************

          LDA #$7f            ; enable interrupts
          STA CIA2_ICR
          LDA #6              ; set DTR & RTS to output
          STA CIA2_DDRB
          STA CIA2_PRB
          LDA #4              ; set DTR & RTS to high
          ORA CIA2_PRA
          STA CIA2_PRA
          LDY #0              ; disable all RS interrupts
          STY RS_Enable
          RTS

; ****************
  IEC_OPEN ; $f0cb
; ****************

          LDA SA
          BMI IEOP_10         ; -> no SA set
          LDY FNLEN
          BNE IEOP_20         ; -> filename given
IEOP_10   CLC                 ; clear carry for OK
          RTS
IEOP_20   LDA #0
          STA STATUS          ; clear status bits
          LDA FA
          JSR LISTN           ; IEC listen
          BIT STATUS
          BMI IEOP_30         ; -> device not present
          LDA SA
          ORA #%11110000     ; $f0
          JSR SECND           ; send SA
          LDA STATUS
          BPL IEOP_40         ; -> OK
IEOP_30   PLA                 ; remove return address
          PLA                 ; jump to error routine
          JMP Device_Not_Present
IEOP_40
          LDA FNLEN           ; redundant: was already
          BEQ IEOP_60         ; checked at entry
          LDY #0
IEOP_50   JSR Get_Filename_Char
          JSR CIOUT           ; send filename
          INY
          CPY FNLEN
          BNE IEOP_50         ; loop
IEOP_60   JMP IEC_Unlisten           ; UNLSN CLC and RTS
          .FILL $f106-* ,0

; *************
  CHKIN ; $f106
; *************

          JSR Lookup_X
          BNE CHKERR_4        ; -> FILE NOT OPEN
          JSR Get_LASAFA
          BEQ CHKIN_10        ; -> input from keyboard
          CMP #3
          BEQ CHKIN_10        ; -> input from screen
          BCS CHKIN_20        ; -> input from IEC
          CMP #2
          BNE IEC_CHKIN       ; -> input from IEC
          JMP RS_CHKIN        ; -> input from RS232

; *****************
  IEC_CHKIN ; $f11d
; *****************

          LDX SA
          CPX #$60            ; SA for LOAD ?
          BNE CHKERR_2
CHKIN_10  STA DFLTN           ; set unit for input
          CLC                 ; flag OK
          RTS

CHKIN_20  TAX                 ; device / unit
          JSR TALK
          BIT STATUS
          BMI CHKERR_1
          LDA SA
          BPL CHKIN_30
          JSR IEC_ATN_High_Exit
          BPL CHKIN_40
CHKIN_30  JSR TKSA
CHKIN_40  TXA
          BIT STATUS
          BPL CHKIN_10

CHKERR_1  JMP Device_Not_Present
CHKERR_2  JMP Not_Input_File
CHKERR_3  JMP Not_Output_File
CHKERR_4  JMP File_Not_Open

; *************
  CKOUT ; $f14c
; *************

          JSR Lookup_X
          BNE CHKERR_4        ; -> FILE NOT OPEN
          JSR Get_LASAFA
          BEQ CHKERR_3        ; -> cannot output to keyboard
          CMP #3
          BEQ CKOUT_20        ; -> output to screen
          BCS IEC_CKOUT
          CMP #2
          BNE CKOUT_10
          JMP RS_CKOUT        ; -> output to RS232

CKOUT_10  LDX SA
          CPX #$60            ; -> SA for LOAD ?
          BEQ CHKERR_3        ; -> cannot use LOAD SA for output
CKOUT_20  STA DFLTO           ; -> select output device
CKOUT_30  CLC                 ; -> flag OK
          RTS

; *****************
  IEC_CKOUT ; $f16d
; *****************

          TAX                 ; X = unit
          JSR LISTN           ; LISTEN
          BIT STATUS
          BMI CHKERR_1        ; -> device not present
          LDA SA
          BPL CKOUT_40
          JSR IEC_ATN_OUT_High
          BNE CKOUT_50
CKOUT_40  JSR SECND
CKOUT_50  TXA
          BIT STATUS
          BPL CKOUT_20        ; -> OK
          BMI CHKERR_1        ; always

; *************
  CLOSE ; $f188
; *************

          ROR SVXT
          JSR Lookup_A
          BNE CKOUT_30        ; -> not found: return
          JSR Get_LASAFA
          TXA
          PHA                 ; push table index
          LDA FA
          BEQ CLOSE_50        ; -> close keyboard channel
          CMP #3
          BEQ CLOSE_50        ; -> close screen channel
          BCS CLOSE_30        ; -> close IEC device
          CMP #2
          BNE CLOSE_10        ; -> close TAPE channel
          PLA
          JSR Remove_Filehandle
          JMP RS_Init_CIA

CLOSE_10  LDA SA
          AND #$0f
          BEQ CLOSE_50        ; -> close input file
          JSR TAPE_XY_Check
          LDA #0
          SEC
          JSR TAPE_RS232_BSOUT
          JSR TAPE_Write_Buffer
          BCC CLOSE_20
          PLA
          LDA #0
          RTS

CLOSE_20  LDA SA
          CMP #$62
          BNE CLOSE_50
          LDA #5              ; write EOT marker
          JSR TAPE_Write_Program_Header
          JMP CLOSE_50
CLOSE_30  BIT SVXT
          BPL CLOSE_40
          LDA FA
          CMP #8
          BCC CLOSE_40        ; -> not a disc device
          LDA SA
          AND #%00001111 ; $0f
          CMP #15
          BEQ CLOSE_50        ; command channel
CLOSE_40  JSR IEC_Close
CLOSE_50  PLA

; *************************
  Remove_Filehandle ; $f1e5
; *************************

          TAX
          DEC LDTND
          CPX LDTND
          BEQ ReFi_10
          LDY LDTND
          LDA LAT,Y
          STA LAT,X
          LDA FAT,Y
          STA FAT,X
          LDA SAT,Y
          STA SAT,X
ReFi_10   CLC
          RTS

; ****************
  Lookup_X ; $f202
; ****************

          LDA #0
          STA STATUS
          TXA

; ****************
  Lookup_A ; $f207
; ****************

          LDX LDTND
LoUp_10   DEX
          BMI LoUp_Ret
          CMP LAT,X
          BNE LoUp_10
LoUp_Ret  RTS

; ******************
  Get_LASAFA ; $f212
; ******************

          LDA LAT,X
          STA LA
          LDA SAT,X
          STA SA
          LDA FAT,X
          STA FA
          RTS

; *************
  CLALL ; $f222
; *************

          LDA #0
          STA LDTND           ; clear file open table

; *************
  CLRCH ; $f226
; *************

          LDX #3
          CPX DFLTO
          BCS CLRCH_10
          JSR UNLSN           ; UNLISTEN if IEC device
CLRCH_10  CPX DFLTN
          BCS CLRCH_20
          JSR UNTLK           ; UNTALK if IEC device
CLRCH_20  STX DFLTO
          LDA #0
          STA DFLTN
          RTS

; **************
  CLOALL ; $f23d
; **************

; Close all channels of device (A)

          STA FA              ; closing device
          CMP DFLTO           ; active output device ?
          BNE CLOA_10         ; -> no
          LDA #3
          STA DFLTO           ; reset active output
          .byte $2c ;BIT
CLOA_10   CMP DFLTN           ; active input device ?
          BNE CLOA_20         ; -> no
          LDA #0
          STA DFLTN           ; reset active input
CLOA_20   LDA FA
          LDX LDTND           ; # of open channels
CLOA_30   DEX
          BMI CLOA_Ret        ; -> done
          CMP FAT,X           ; device to close ?
          BNE CLOA_30         ; -> no
          LDA LAT,X
          JSR K_CLOSE         ; -> close this channel
          BCC CLOA_20         ; loop if OK
CLOA_Ret  RTS

; ****************
  LOAD_AXY ; $f265
; ****************

; Input:  A = LOAD (0) or VERIFY (1)
;         X = load address low
;         Y = load address high

          STX MEMUSS
          STY MEMUSS+1

; ******************
  LOADSP_MEM ; $f269
; ******************

          JMP (ILOAD)         ; default -> D_LOADSP

; ****************
  D_LOADSP ; $f26c
; ****************

          STA K_VERCK         ; verify flag
          LDA #0
          STA STATUS          ; clear status
          LDA FA
          CMP #4
          BCS LOAD_10         ; -> IEC  load
          JMP TAPE_LOAD       ; -> TAPE load
LOAD_10   LDA Fast_IEC
          AND #%10111110     ; $be clear burst mode bit 6
          STA Fast_IEC        ; should be $bf ?
          LDX SA
          STX PTR_LO          ; save SA
          LDY FNLEN
          BNE LOAD_20         ; -> filename given
          JMP Err_Missing_File_Name
LOAD_20   STY PTR_HI          ; save FNLEN
          JSR Searching
          JSR BURST_LOAD      ; try burst load
          BCS LOAD_30         ; -> continue with slow load
          JMP LOAD_Done       ; -> finish

; device doesn't support burst mode or "$" directory load

LOAD_30   LDY PTR_HI          ; saved   FNLEN
          STY FNLEN           ; restore FNLEN
          LDA #$60            ; special value for LOAD protocol
          STA SA
          JSR IEC_OPEN        ; open file for LOAD
          LDA FA
          JSR TALK            ; talk
          LDA SA
          JSR TKSA            ; talk secondary
          JSR ACPTR           ; Load address low
          STA EAL
          JSR ACPTR           ; Load address high
          STA EAH
          LDA STATUS
          LSR A
          LSR A               ; C = bit 6 EOI
          BCS Err_File_Not_Found
          LDA PTR_LO          ; saved SA
          BNE LOAD_40         ; -> use load address from file
          LDA MEMUSS
          STA EAL             ; overwrite load address
          LDA MEMUSS+1
          STA EAH
LOAD_40   JSR EA_to_SA        ; copy EA to SA
LOAD_50   LDA #$fd
          AND STATUS          ; clear bit 1 (time out read)
          STA STATUS
          JSR K_STOP          ; STOP key pressed ?
          BEQ Stop_Load       ; -> close file and stop loading
          JSR ACPTR           ; read next byte
          TAX                 ; save it in X
          LDA STATUS
          LSR A
          LSR A
          BCS LOAD_50         ; -> time out: try again
          TXA                 ; A = read byte
          LDY K_VERCK         ; verify flag
          BEQ LOAD_60         ; -> loading
          STA RS_Parity       ; store read byte
          LDY #0
          JSR LDA_IND_EAL
          CMP RS_Parity       ; verify
          BEQ LOAD_70         ; -> OK
          LDA #16             ; bit 4: set verify error
          JSR SETST
          BNE LOAD_70         ; always
LOAD_60   JSR STA_IND_EAL     ; store read byte
LOAD_70   INC EAL             ; increment load address
          BNE LOAD_80
          INC EAH
          LDA EAH             ; check for memory overflow $ff00
          CMP #$ff
          BEQ Err_Break_IO
LOAD_80   BIT STATUS          ; check bit 6 EOI
          BVC LOAD_50         ; -> loop
          JSR UNTLK           ; start exit procedure
          JSR IEC_Close
          JMP LOAD_Done

Err_File_Not_Found
          JMP File_Not_Found

Err_Missing_File_Name
          JMP Missing_File_Name

Err_Illegal_Device_Number
          JMP Illegal_Device_Number

Err_Break_IO
          JMP Break_IO

Stop_Load JMP Err_IEC_Close

; *****************
  TAPE_LOAD ; $f326
; *****************

          CMP #1              ; check device = 1
          BNE Err_Illegal_Device_Number
          JSR TAPE_XY_Check
          BCC Err_Illegal_Device_Number
          JSR TAPE_Wait_for_Play
          BCS LOAD_Ret        ; time out
          JSR Searching
TALO_10   LDA FNLEN
          BEQ TALO_20         ; -> load next file
          JSR TAPE_Find_File
          BCC TALO_30         ; -> found
          BEQ LOAD_Ret        ; -> STOP key
          BCS Err_File_Not_Found
TALO_20   JSR TAPE_Find_Header
          BEQ LOAD_Ret        ; -> STOP key
          BCS Err_File_Not_Found
TALO_30   SEC
          LDA STATUS
          AND #%00010000     ; $10 bit 4: verify error
          BNE LOAD_Ret
          CPX #1              ; 1 = BASIC program
          BEQ TALO_50         ; -> load BASIC program
          CPX #3              ; 3 = binary program
          BNE TALO_10         ; not a program -> search again
TALO_40   LDY #1
          LDA (TAPE1),Y       ; byte 1: load address low
          STA MEMUSS
          INY
          LDA (TAPE1),Y       ; byte 2: load address high
          STA MEMUSS+1
          BCS TALO_60
TALO_50   LDA SA
          BNE TALO_40         ; SA != 0 -> absolute load
TALO_60   LDY #3
          LDA (TAPE1),Y       ; byte 3: end address low
          LDY #1
          SBC (TAPE1),Y
          TAX
          LDY #4
          LDA (TAPE1),Y       ; byte 4: end address high
          LDY #2
          SBC (TAPE1),Y
          TAY                 ; X/Y = file length
          CLC
          TXA
          ADC MEMUSS          ; check if file fits into memory
          STA EAL
          TYA
          ADC MEMUSS+1
          STA EAH
          CMP #$ff
          BEQ Err_Break_IO
          LDA MEMUSS          ; set start address
          STA STAL
          LDA MEMUSS+1
          STA STAH
          JSR Loading_Verifying
          JSR TAPE_Read       ; start tape load
          .BYTE $24
LOAD_Done CLC
          LDX EAL
          LDY EAH
LOAD_Ret  RTS

; ******************
  BURST_LOAD ; $f3a1
; ******************

          LDY #0
          JSR Get_Filename_Char
          CMP #'$'            ; directory load ?
          BEQ LOAD_Ret        ; -> return for slow load C=1
          LDX FA
          LDY #15
          LDA #0
          JSR SETLFS          ; OPEN 0,U,15
          STA FNLEN           ; no filename
          JSR K_OPEN          ; open command channel
          LDX LA
          JSR K_CKOUT         ; select command channel
          BCC BULO_10         ; -> OK
          JSR BULO_Close   ; C=1: error
          PLA                 ; remove return address
          PLA
          JMP Device_Not_Present
BULO_10   LDY #3              ; send "U0" $1f
BULO_15   LDA Burst_Load_Command-1,Y
          JSR K_BSOUT
          DEY
          BNE BULO_15
BULO_20   JSR Get_Filename_Char
          JSR K_BSOUT         ; send filename
          INY
          CPY PTR_HI          ; FNLEN
          BNE BULO_20
          JSR K_CLRCH
          BIT Fast_IEC        ; burst mode enabled ?
          BVS BULO_25         ; -> yes
          JSR BULO_Close
          SEC                 ; Set error flag
          RTS
BULO_25   LDA PTR_HI
          STA FNLEN           ; restore Filename length
          SEI
          JSR IEC_Clock_High
          JSR IEC_Fast_Input
          BIT CIA1_ICR
          JSR Toggle_CLOCK_OUT
          JSR Read_Burst_Byte   ; burst status byte
          CMP #2              ; 2 = file not found
          BNE BULO_30         ; -> file found
          JSR BULO_Close
          PLA
          PLA
          JMP File_Not_Found
BULO_30   PHA                 ; Push transfer status
          CMP #$1f            ; burst status = EOI ?
          BNE BULO_35
          JSR Toggle_CLOCK_OUT
          JSR Read_Burst_Byte   ; bytes following status byte
          STA CNTDN
          JMP BULO_40
BULO_35   CMP #2              ; burst status OK ? ( < 2 )
          BCC BULO_40         ; -> OK
          PLA
          BCS BULO_Err           ; -> always
BULO_40   JSR Loading_Verifying
          JSR Toggle_CLOCK_OUT
          JSR Read_Burst_Byte
          STA EAL             ; Load address low
          JSR Toggle_CLOCK_OUT
          JSR Read_Burst_Byte
          STA EAH             ; Load address high
          LDX PTR_LO          ; SA
          BNE BULO_45         ; -> SA != 0 -> use address from file
          LDA MEMUSS          ; Overwrite load address
          LDX MEMUSS+1
          STA EAL
          STX EAH
BULO_45   LDA EAL
          LDX EAH
          STA SAL
          STX SAH
          PLA                 ; Pull burst status
          CMP #$1f            ; burst status = EOI ?
          BEQ BULO_65         ; ->
          JSR Toggle_CLOCK_OUT
          LDA #$fc            ; Length of 1st. data block = 252
          STA CNTDN
BULO_50   JSR Check_STOP_Key
          JSR K_STOP
          BEQ BULO_Stop
          JSR Read_Burst_Block  ; read block in burst mode
          BCS BULO_Break
          JSR Read_Burst_Byte   ; read burst status
          CMP #2
          BCC BULO_55         ; -> OK
          CMP #$1f            ; EOI ?
          BEQ BULO_60         ; -> finish
          BNE BULO_Err           ; -> error

BULO_55   JSR Toggle_CLOCK_OUT
          LDA #$fe            ; Next data block = 254 bytes
          STA CNTDN
          BNE BULO_50         ; loop always

BULO_60   JSR Toggle_CLOCK_OUT
          JSR Read_Burst_Byte
          STA CNTDN           ; Length of last data block
BULO_65   JSR Toggle_CLOCK_OUT
          JSR Read_Burst_Block
          BCS BULO_Break
          LDA #$40            ; bit 6 = EOI
          JSR SETST

; ******************
  BULO_Close ; $f48c
; ******************

          JSR IEC_Clock_High
          CLI
          LDA LA
          SEC
          JSR K_CLOSE
          CLC
          RTS

; *****************
  BULO_Err  ; $f498
; *****************

          LDA #2              ; bit 1 = TIME OUT READ
          JSR SETST
          JSR BULO_Close
          PLA                 ; remove BURST_LOAD return address
          PLA
          LDA #$29            ; FILE READ ERROR
          SEC                 ; error flag
          RTS                 ; return from LOADSP

; *****************
  BULO_Stop ; $f4a6
; *****************

          JSR BULO_Close
          LDA #0
          STA SA
          PLA
          PLA
          JMP Err_IEC_Close

; ******************
  BULO_Break ; $f4b2
; ******************

          JSR BULO_Close
          PLA
          PLA
          JMP Break_IO

; ***********************
  Read_Burst_Byte ; $f4ba
; ***********************

          LDA #8              ; bit 3 = ISDR
RBB_10    BIT CIA1_ICR
          BEQ RBB_10          ; wait for interrupt ISDR
          LDA CIA1_SDR        ; A = data byte
          RTS

; ************************
  Read_Burst_Block ; $f4c5
; ************************

          LDA #8              ; bit 3 = ISDR
RBBl_10   BIT CIA1_ICR
          BEQ RBBl_10         ; wait for interrupt ISDR

          LDY CIA1_SDR        ; Y = data byte
          LDA CIA2_PRA
          EOR #%00010000     ; $10 toggle CLOCK OUT
          STA CIA2_PRA
          TYA                 ; A = data byte
          LDY K_VERCK         ; LOAD (0) or VERIFY (1) ?
          BEQ RBBl_20         ; -> LOAD
          STA RS_Parity       ; store read byte
          LDY #0
          JSR LDA_IND_EAL     ; load memory byte
          CMP RS_Parity       ; verify
          BEQ RBBl_30         ; -> OK
          LDA #16             ; Veriyfy error
          JSR SETST
          BNE RBBl_30         ; always
RBBl_20   JSR STA_IND_EAL     ; store read byte
RBBl_30   INC EAL             ; increment load address
          BNE RBBl_40
          INC EAH
          LDA EAH
          CMP #$ff            ; Do not load to page $ff
          BEQ RBBl_Ret        ; -> exit with C=1 (error)
RBBl_40   DEC CNTDN           ; decrement burst count down
          BNE Read_Burst_Block
          CLC
RBBl_Ret  RTS

; ************************
  Toggle_CLOCK_OUT ; $f503
; ************************

          LDA CIA2_PRA
          EOR #%00010000
          STA CIA2_PRA
          RTS

; **************************
  Burst_Load_Command ; $f50c
; **************************

          .BYTE $1f           ; "U0" + CHR$(31)
          .TEXT "0U"          ; used reverse

; *****************
  Searching ; $f50f
; *****************

          LDA MSGFLG
          BPL OuFi_Ret
          LDY #Msg_Searching
          JSR System_Message
          LDA FNLEN
          BEQ OuFi_Ret
          LDY #Msg_For
          JSR System_Message

; **********************
  Ouput_Filename ; $f521
; **********************

          LDY FNLEN
          BEQ OuFi_Ret
          LDY #0
OuFi_10   JSR Get_Filename_Char
          JSR K_BSOUT
          INY
          CPY FNLEN
          BNE OuFi_10
OuFi_Ret  RTS

; *************************
  Loading_Verifying ; $f533
; *************************

          LDY #Msg_Loading
          LDA K_VERCK
          BEQ LoVe_10
          LDY #Msg_Verifying
LoVe_10   JMP System_Message_Cond

; **************
  SAVESP ; $f53e
; **************

; Input: A = ZP address which holds the start address
;        X = end address low
;        Y = end address high

          STX EAL
          STY EAH
          TAX
          LDA 0,X
          STA STAL
          LDA 1,X
          STA STAH
          JMP (ISAVE)         ; default = D_SAVE

; **************
  D_SAVE ; $f54e
; **************

          LDA FA
          CMP #1
          BEQ TAPE_SAVE       ; save to tape
          CMP #4
          BCS DSAV_30         ; save to IEC

DSAV_10   JMP Illegal_Device_Number
DSAV_20   JMP Missing_File_Name
          JMP File_Not_Found

DSAV_30   LDY FNLEN
          BEQ DSAV_20
          LDA #$61            ; SA for saving
          STA SA
          JSR IEC_OPEN
          JSR Saving          ; print saving filename
          LDA FA
          JSR LISTN
          LDA SA
          JSR SECND
          LDY #0
          JSR STAL_To_SAL
          JSR CIOUT           ; write start address low
          LDA SAH
          JSR CIOUT           ; write start address high
DSAV_40   JSR Check_IO_End
          BCS DSAV_50         ; -> finish
          JSR LDA_IND_SAL     ; load data byte from memory
          JSR CIOUT           ; write data byte
          JSR K_STOP          ; check STOP key
          BEQ Err_IEC_Close
          JSR Inc_SAL_Word    ; increment address SAL/SAH
          BNE DSAV_40         ; loop always
DSAV_50   JSR UNLSN

; *****************
  IEC_Close ; $f59e
; *****************

          BIT SA
          BMI IEC_Ret
          LDA FA
          JSR LISTN
          LDA SA
          AND #%11101111     ; $ef
          ORA #%11100000     ; $e0
          JSR SECND

; ********************
  IEC_Unlisten ; $f5b0
; ********************

          JSR UNLSN
IEC_Ret   CLC
          RTS

; *********************
  Err_IEC_Close ; $f5b5
; *********************

          JSR IEC_Close
          LDA #0
          SEC
          RTS

; **************
  Saving ; $f5bc
; **************

          LDA MSGFLG
          BPL TASA_Ret
          LDY #Msg_Saving
          JSR System_Message
          JMP Ouput_Filename

; ******************
  TAPE_SAVE  ; $f5c8
; ******************

          JSR TAPE_XY_Check   ; setup buffer
          BCC DSAV_10         ; -> error
          JSR TAPE_Wait_For_Record
          BCS TASA_Ret        ; -> timed out
          JSR Saving
          LDX #3              ; header type for binary
          LDA SA
          AND #1
          BNE TASA_10
          LDX #1              ; header type for BASIC program
TASA_10   TXA
          JSR TAPE_Write_Program_Header
          BCS TASA_Ret        ; -> error
          JSR TAPE_Write_Program
          BCS TASA_Ret        ; -> error
          LDA SA
          AND #2
          BEQ TASA_20
          LDA #5
          JSR TAPE_Write_Program_Header
          .BYTE $24           ; skip next byte
TASA_20   CLC
TASA_Ret  RTS

; *************
  UDTIM ; $f5f8
; *************

          INC JIFFY_CLOCK+2   ; increment 24 bit jiffy clock
          BNE UDTIM_10
          INC JIFFY_CLOCK+1
          BNE UDTIM_10
          INC JIFFY_CLOCK
UDTIM_10  SEC                 ; timer - $4f1a01 (24 * 60 * 60 * 60 + 1)
          LDA JIFFY_CLOCK+2
          SBC #1
          LDA JIFFY_CLOCK+1
          SBC #$1a
          LDA JIFFY_CLOCK
          SBC #$4f
          BCC UDTIM_20        ; -> no overflow (24 hours)
          LDX #0              ; reset timer
          STX JIFFY_CLOCK
          STX JIFFY_CLOCK+1
          STX JIFFY_CLOCK+2
UDTIM_20  LDA JIFFY_COUNTDOWN
          BNE UDTIM_40
          LDA JIFFY_COUNTDOWN+1
          BNE UDTIM_30
          DEC JIFFY_COUNTDOWN+2
UDTIM_30  DEC JIFFY_COUNTDOWN+1
UDTIM_40  DEC JIFFY_COUNTDOWN
          BIT PALNTS          ; check PAL NTSC flag
          BPL Check_STOP_Key  ; -> NTSC
          DEC PAL_ADJ
          BPL Check_STOP_Key  ; -> no PAL adjustment this time
          LDA #5
          STA PAL_ADJ         ; reset PAL adjustment counter
          BNE UDTIM           ; -> run once more for PAL adjustment

; **********************
  Check_STOP_Key ; $f63d
; **********************

          LDA CIA1_KBD_ROW
          CMP CIA1_KBD_ROW
          BNE Check_STOP_Key
          TAX
          BMI Bf65b
          LDX #$bd
          STX CIA1_KBD_COL
Bf64d     LDX CIA1_KBD_ROW
          CPX CIA1_KBD_ROW
          BNE Bf64d
          STA CIA1_KBD_COL
          INX
          BNE Bf65d
Bf65b     STA STKEY
Bf65d     RTS

; *************
  RDTIM ; $f65e
; *************

          SEI
          LDA JIFFY_CLOCK+2
          LDX JIFFY_CLOCK+1
          LDY JIFFY_CLOCK

; **************
  SETTIM ; $f665
; **************

          SEI
          STA JIFFY_CLOCK+2
          STX JIFFY_CLOCK+1
          STY JIFFY_CLOCK
          CLI
          RTS

; ************
  STOP ; $f66e
; ************

          LDA STKEY
          CMP #$7f
          BNE STOP_Ret
          PHP
          JSR K_CLRCH         ; clear channels
          STA NDX             ; empty keyboard buffer
          PLP
STOP_Ret  RTS

; **********************
  Too_Many_Files ; $f67c
; **********************

          LDA #1
          .byte $2c ;BIT

; *********************
  File_Open_Err ; $f67f
; *********************

          LDA #2
          .byte $2c ;BIT

; *********************
  File_Not_Open ; $f682
; *********************

          LDA #3
          .byte $2c ;BIT

; **********************
  File_Not_Found ; $f685
; **********************

          LDA #4
          .byte $2c ;BIT

; **************************
  Device_Not_Present ; $f688
; **************************

          LDA #5
          .byte $2c ;BIT

; **********************
  Not_Input_File ; $f68b
; **********************

          LDA #6
          .byte $2c ;BIT

; ***********************
  Not_Output_File ; $f68e
; ***********************

          LDA #7
          .byte $2c ;BIT

; *************************
  Missing_File_Name ; $f691
; *************************

          LDA #8
          .byte $2c ;BIT

; *****************************
  Illegal_Device_Number ; $f694
; *****************************

          LDA #9
          .byte $2c ;BIT

; ****************
  Break_IO ; $f697
; ****************

          LDA #16
          PHA
          JSR K_CLRCH
          LDY #Msg_Error
          BIT MSGFLG
          BVC Break_Ret
          JSR System_Message
          PLA
          PHA
          ORA #'0'            ; convert error # to ASCII
          JSR K_BSOUT
Break_Ret PLA
          SEC
          RTS

; *********************
  Message_Table ; $f6b0
; *********************

  Msg_Error     = * - Message_Table
          .SHIFT "\rI/O ERROR #" ;^
  Msg_Searching = * - Message_Table
          .SHIFT "\rSEARCHING " ;^
  Msg_For       = * - Message_Table
          .SHIFT "FOR " ;^
  Msg_Play      = * - Message_Table
          .SHIFT "\rPRESS PLAY ON TAPE" ;^
  Msg_Record    = * - Message_Table
          .SHIFT "PRESS RECORD & PLAY ON TAPE" ;^
  Msg_Loading   = * - Message_Table
          .SHIFT "\rLOADING" ;^
  Msg_Saving    = * - Message_Table
          .SHIFT "\rSAVING " ;^
  Msg_Verifying = * - Message_Table
          .SHIFT "\rVERIFYING" ;^
  Msg_Found     = * - Message_Table
          .SHIFT "\rFOUND " ;^
  Msg_OK        = * - Message_Table
          .SHIFT "\rOK\r" ;^

; ***************************
  System_Message_Cond ; $f71e
; ***************************

          BIT MSGFLG
          BPL SyMe_10

; **********************
  System_Message ; $f722
; **********************

          LDA Message_Table,Y
          PHP
          AND #%01111111 ; $7f
          JSR K_BSOUT
          INY
          PLP
          BPL System_Message
SyMe_10   CLC
          RTS

; **************
  SETNAM ; $f731
; **************

          STA FNLEN
          STX FNADR
          STY FNADR+1
          RTS

; **************
  SETLFS ; $f738
; **************

          STA LA
          STX FA
          STY SA
          RTS

; **************
  SETBNK ; $f73f
; **************

          STA BA
          STX FNBANK
          RTS

; **************
  READST ; $f744
; **************

          LDA FA
          CMP #2              ; RS232 active ?
          BNE REAST_10        ; -> no, read common status
          LDA RS_Status
          PHA
          LDA #0
          STA RS_Status       ; clear RS232 status after reading
          PLA
          RTS
REAST_10  LDA STATUS

; *************
  SETST ; $f757
; *************

          ORA STATUS
          STA STATUS
          RTS

; **************
  SETMSG ; $f75c
; **************

          STA MSGFLG
          RTS

; **************
  SETTMO ; $f75f
; **************

          STA TIMOUT
          RTS

; **************
  MEMTOP ; $f763
; **************

; Input:  C=0 set new MEM_TOP from (X/Y)
;         C=1 read    MEM_TOP to   (X/Y)

          BCC SET_MEM_TOP
          LDX MEM_TOP
          LDY MEM_TOP+1

; *******************
  SET_MEM_TOP ; $f76b
; *******************

          STX MEM_TOP
          STY MEM_TOP+1
          RTS

; **************
  MEMBOT ; $f772
; **************

; Input:  C=0 set new MEM_BOT from (X/Y)
;         C=1 read    MEM_BOT to   (X/Y)

          BCC SET_MEM_BOT
          LDX MEM_BOT
          LDY MEM_BOT+1

; *******************
  SET_MEM_BOT ; $f77a
; *******************

          STX MEM_BOT
          STY MEM_BOT+1
          RTS

; **************
  IOBASE ; $f781
; **************

          LDX #<VIC
          LDY #>VIC
          RTS

; **************
  LKUPSA ; $f786
; **************

; Lookup secondary address (Y) in table of open files
; Input:  Y = secondary address to look for
; Output: C=1: not found
;         C=0: found A=LA, X=FA, Y=SA

          TYA                 ; A = address
          LDX LDTND           ; X = # of open files
LKSA_10   DEX
          BMI LKSA_30         ; -> not found
          CMP SAT,X
          BNE LKSA_10
LKSA_20   JSR Get_LASAFA
          TAX                 ; X = FA
          LDA LA
          LDY SA
          CLC                 ; C=0 : found
          RTS
LKSA_30   SEC                 ; C=1 : not found
          RTS

; **************
  LKUPLA ; $f79d
; **************

; Lookup logical address (A) in table of open files
; Input:  A = logical address to look for

          TAX
          JSR Lookup_X
          BEQ LKSA_20         ; -> found
          BNE LKSA_30         ; -> not found

; dead code (replaced by DMA at $cf80)

          LDA Bank_Config_Table,X
          AND #%11111110 ; $fe
          TAX
          JMP RAM_DMA

; *************************
  Get_Filename_Char ; $f7ae
; *************************

          STX FN_SAVE_X
          LDX FNBANK
          LDA #FNADR
          JSR INDFET
          LDX FN_SAVE_X
          RTS

; *******************
  STA_IND_SAL ; $f7bc
; *******************

          LDX #SAL
          .byte $2c ;BIT

; *******************
  STA_IND_EAL ; $f7bf
; *******************

          LDX #EAL
          STX STASH+10
          LDX BA
          JMP INDSTA

; *******************
  LDA_IND_EAL ; $f7c9
; *******************

          LDA #EAL
          .byte $2c ;BIT

; *******************
  LDA_IND_SAL ; $f7cc
; *******************

          LDA #SAL
          LDX BA

; **************
  INDFET ; $f7d0
; **************

          STA FETCH+8
          LDA Bank_Config_Table,X
          TAX
          JMP FETCH

; **************
  INDSTA ; $f7da
; **************

          PHA
          LDA Bank_Config_Table,X
          TAX
          PLA
          JMP STASH

; **************
  INDCMP ; $f7e3
; **************

          PHA
          LDA Bank_Config_Table,X
          TAX
          PLA
          JMP CMPARE

; **************
  GETCFG ; $f7ec
; **************

          LDA Bank_Config_Table,X
          RTS

; *************************
  Bank_Config_Table ; $f7f0
; *************************

; MMU configuration bytes

; xx.. .... RAM bank
; ..xx .... $c000 - $cfff
; .... xx.. $8000 - $bfff
; .... ..x. $4000 - $7fff
; .... ...x $d000 - $dfff

          .BYTE %00111111    ; $3f RAM 0
          .BYTE %01111111    ; $7f RAM 1
          .BYTE %10111111    ; $bf RAM 2
          .BYTE %11111111    ; $ff RAM 3

          .BYTE %00010110    ; $16 internal ROM, RAM 0, I/O
          .BYTE %01010110    ; $56 internal ROM, RAM 1, I/O
          .BYTE %10010110    ; $96 internal ROM, RAM 2, I/O
          .BYTE %11010110    ; $d6 internal ROM, RAM 3, I/O

          .BYTE %00101010    ; $2a external ROM, RAM 0, I/O
          .BYTE %01101010    ; $2a external ROM, RAM 1, I/O
          .BYTE %10101010    ; $2a external ROM, RAM 2, I/O
          .BYTE %11101010    ; $2a external ROM, RAM 3, I/O

          .BYTE %00000110    ; $06 kernal, int.  ROM, RAM 0, I/O
          .BYTE %00001010    ; $0a kernal, ext.  ROM, RAM 0, I/O
          .BYTE %00000001    ; $01 kernal, BASIC ROM, RAM 0, CHAR
          .BYTE %00000000    ; $00 kernal, BASIC ROM, RAM 0, I/O

; *****************
  ROM_FETCH ; $f800
; *****************

          LDA MMU_CR
          STX MMU_CR
          TAX
          LDA ($ff),Y         ; dummy address
          STX MMU_CR
          RTS

; *****************
  ROM_STASH ; $f80d
; *****************

          PHA
          LDA MMU_CR
          STX MMU_CR
          TAX
          PLA
          STA ($ff),Y         ; dummy address
          STX MMU_CR
          RTS

; ******************
  ROM_CMPARE ; $f81c
; ******************

          PHA
          LDA MMU_CR
          STX MMU_CR
          TAX
          PLA
          CMP ($ff),Y         ; dummy address
          STX MMU_CR
          RTS

; ******************
  ROM_JSRFAR ; $f82b
; ******************

          JSR JMPFAR
          STA A_REG
          STX X_REG
          STY Y_REG
          PHP
          PLA
          STA S_REG
          TSX
          STX CHARAC
          LDA #0
          STA MMU_CR
          RTS

; ******************
  ROM_JMPFAR ; $f841
; ******************

          LDX #0
JMPF_10   LDA PC_HI,X
          PHA
          INX
          CPX #3
          BCC JMPF_10
          LDX BANK
          JSR K_GETCFG
          STA MMU_CR
          LDA A_REG
          LDX X_REG
          LDY Y_REG
          RTI

; ***************
  ROM_DMA ; $f85a
; ***************

; this routine is copied to and executed at RAM_DMA = $03f0

          LDX MMU_CR
          STY DMA_CMD
          STA MMU_CR
          STX MMU_CR
          RTS

; ***************
  PHOENIX ; $f867
; ***************

; check 4 ROM module configurations and call their
; initialization routine if appropiate

          SEI
          LDX #3
          STX Module_Bank
PHOE_10   LDX Module_Bank
          LDA Module_Flags,X
          BEQ PHOE_20
          LDY #0
          LDA ROM_PAGES,X
          STA PC_HI
          STY PC_LO
          LDA ROM_BANK,X
          STA BANK
          JSR JSRFAR
PHOE_20   DEC Module_Bank
          BPL PHOE_10
          CLI
          LDX #8              ; default unit
          LDA #'0'            ; default drive

; ************
  BOOT ; $f890
; ************

; Boot from 1st. sector of floppy disk

; Input:  A = drive
;         X = unit

          STA DRIVE           ; ASCII, typically '0'
          STX FA              ; default 8
          TXA                 ; X = unit / device
          JSR CLOALL          ; close all channels of boot device
          LDX #0
          STX PTR_HI
          STX STAH            ; sector = 0
          INX
          STX STAL            ; track  = 1
BOOT_10   INY                 ; delay loop for 0.3 sec
          BNE BOOT_10
          INX
          BNE BOOT_10

          LDX #12            ; copy block read command to stack bottom
BOOT_15   LDA BootComm,X
          STA STACK,X
          DEX
          BPL BOOT_15

          LDA DRIVE
          STA STACK+6         ; insert drive #
          LDA #0
          LDX #15             ; kernal, BASIC ROM, RAM 0, I/O
          JSR SETBNK          ; boot to MMU config 15
          LDA #1
          LDX #<InitDrive
          LDY #>InitDrive
          JSR SETNAM          ; prepare initialization command "I"
          LDA #0
          LDY #15
          LDX FA
          JSR SETLFS          ; specify commandchannel
          JSR K_OPEN          ; send "I" on command channel
          BCS BOOT_20         ; -> branch on error
          LDA #1
          LDX #<Hash
          LDY #>Hash
          JSR SETNAM          ; prepare open buffer command "#"
          LDA #13
          TAY
          LDX FA
          JSR SETLFS          ; prepare open parameter 13,unit,13
          JSR K_OPEN          ; open channel to floppy buffer
          BCC BOOT_25         ; -> branch if OK
BOOT_20   JMP BOOT_Exit
BOOT_25   LDA #<T_Buffer
          LDY #>T_Buffer
          STA SAL
          STY SAH             ; SAL/SAH = tape buffer
          JSR IEC_Read_Block  ; read boot sector to T_Buffer
          LDX #0
BOOT_30   LDA T_Buffer,X      ; look for "CBM" in first 3 bytes
          CMP ROM_CBM,X
          BNE BOOT_20         ; -> no "CBM" signature: exit
          INX
          CPX #3
          BCC BOOT_30         ; loop
          JSR PRIMM           ; OK, print "BOOTING "
          .TEXT "\rBOOTING ",0

BOOT_35   LDA T_Buffer,X      ; copy start and end address
          STA SAL-3,X         ; X (3..6) -> SAL,SAH,EAL,EAH
          INX
          CPX #7
          BCC BOOT_35
BOOT_40   LDA T_Buffer,X      ; print boot sector message
          BEQ BOOT_45         ; starting at byte 7
          JSR K_BSOUT
          INX
          BNE BOOT_40

BOOT_45   STX PTR_LO          ; save index to buffer
          JSR PRIMM
          .TEXT "...\r",0

          LDA EAL
          STA BA
BOOT_50   LDA EAH
          BEQ BOOT_55         ; -> must not boot to ZP
          DEC EAH
          JSR Read_Next_Block
          INC SAH             ; load address += 256
          BNE BOOT_50         ; loop

BOOT_55   JSR BOOT_Exit       ; close channels
          LDX PTR_LO          ; X = buffer index
          .byte $2c ;BIT                 ; skip next statement

BOOT_60   INC PTR_HI          ; count skipped bytes
          INX
          LDA T_Buffer,X
          BNE BOOT_60         ; skip buffer content until zero

          INX
          STX PC_LO           ; save end index
          LDX PTR_LO          ; X = start index
          LDA #':'
          STA T_Buffer,X      ; store ':'
          DEX
          LDA DRIVE
          STA T_Buffer,X      ; precede command with drive and ':'
          STX PTR_LO          ; update start index
          LDX PTR_HI          ; filename length
          BEQ BOOT_65         ; -> nothing to load
          INX
          INX
          TXA                 ; length plus 2 (drive and :)
          LDX PTR_LO
          LDY #11
          JSR SETNAM          ; prepare filename
          LDA #0
          TAX
          JSR SETBNK
          LDA #0
          JSR LOADSP_MEM      ; load file
BOOT_65   LDA #>T_Buffer
          STA PC_HI
          LDA #15
          STA BANK
          JSR JSRFAR          ; call boot sector address
          CLC
          RTS

; *****************
  BOOT_Exit ; $f98b
; *****************

          PHP                 ; save status
          PHA                 ; save A
          JSR K_CLRCH
          LDA #13
          CLC
          JSR K_CLOSE         ; close floppy buffer channel
          LDX #0
          JSR K_CKOUT         ; command channel
          BCS BOEx_10
          LDA #'U'
          JSR K_BSOUT
          LDA #'I'
          JSR K_BSOUT         ; send "UI" (reset floppy drive)
BOEx_10   JSR K_CLRCH
          LDA #0
          SEC
          JSR K_CLOSE         ; close command channel
          PLA
          PLP
          RTS

; ***********************
  Read_Next_Block ; $f9b3
; ***********************

; This routine modifies the read track/sector command for the
; next block by increasing sector or track
; This routine assumes a 1541/1571/4040 formatted floppy disk
; and will give correct results only in the first zone with
; sector counts of 21 sectors per track.
; On other drives, eg. 1581 it will work only in the first
; 21 sectors of track 1.

          LDX STAH            ; sector
          INX                 ; next sector
          CPX #21             ; sector range:  0-20
          BCC NeBl_10
          LDX #0              ; set sector to tero
          INC STAL            ; increment track
NeBl_10   STX STAH            ; update sector
          TXA
          JSR Format_Byte     ; format sector
          STA STACK
          STX STACK+1         ; update sector in command string
          LDA STAL
          JSR Format_Byte     ; format track
          STA STACK+3
          STX STACK+4         ; update track in command string

; **********************
  IEC_Read_Block ; $f9d5
; **********************

          LDX #0
          JSR K_CKOUT         ; command channel
          LDX #12
ReBl_10   LDA STACK,X         ; send U1 block read command
          JSR K_BSOUT
          DEX
          BPL ReBl_10
          JSR K_CLRCH
          LDX #13
          JSR K_CHKIN         ; floppy buffer channel
          LDY #0
ReBl_20   JSR K_BASIN         ; read from floppy buffer
          JSR STA_IND_SAL     ; store to memory
          INY
          BNE ReBl_20         ; loop until 256 bytes are read
          JMP K_CLRCH

; *******************
  Format_Byte ; $f9fb
; *******************

; Input : A = binary number
; Output: A = ones digit
;         X = tens digit

          LDX #'0'
          SEC
FoBy_10   SBC #10
          BCC FoBy_20
          INX
          BCS FoBy_10
FoBy_20   ADC #'0'+10
          RTS

BootComm  .TEXT "00 10 0 31:1U" ; U1:13 0 01 00 (1st. sector)
InitDrive .TEXT "I"
Hash      .TEXT "#"

; *************
  PRIMM ; $fa17
; *************

          PHA
          TXA
          PHA
          TYA
          PHA
          LDY #0
PRIMM_10  TSX
          INC STACK+4,X       ; return address low
          BNE PRIMM_20
          INC STACK+5,X       ; return address high
PRIMM_20  LDA STACK+4,X
          STA IMPARM
          LDA STACK+5,X
          STA IMPARM+1
          LDA (IMPARM),Y
          BEQ PRIMM_30
          JSR K_BSOUT
          BCC PRIMM_10
PRIMM_30  PLA
          TAY
          PLA
          TAX
          PLA
          RTS                 ; 41 bytes

; ******************
  NMI_Normal ; $fa40
; ******************

          CLD                 ; clear decimal flag
          LDA #$7f
          STA CIA2_ICR
          LDY CIA2_ICR
          BMI NMI_10          ; -> RS232 interrupt
          JSR Check_STOP_Key
          JSR K_STOP
          BNE NMI_10          ; -> no STOP key pressed
          JSR RESTOR          ; STOP RESTORE action
          JSR IOINIT
          JSR E_CINT
          JMP (RESET_VECTOR)

NMI_10    JSR RS_NMI_Main
          JMP IRQ_Exit

; ******************
  IRQ_Normal ; $fa65
; ******************

          CLD                 ; clear decimal flag
          JSR E_RASTER        ; check for raster interrupt
          BCC IRQN_10         ;
          JSR UDTIM           ; update clock
          JSR TAPE_Switch_Sense
          LDA CIA1_ICR        ; clear IRQ flags
          LDA INIT_STATUS
          LSR A
          BCC IRQN_10
          JSR B_BASIC_IRQ     ; perform BASIC tasks
IRQN_10   JMP IRQ_Exit

; *********************
  Keytab_Normal ; $fa80
; *********************

          .BYTE $14,$0d,$1d,$88 ; 00  DEL  CR   Down F7
          .BYTE $85,$86,$87,$11 ; 04  F1   F3   F5   Right
          .BYTE '3','W','A','4' ; 08  3    W    A    4
          .BYTE 'Z','S','E',$01 ; 0C  Z    S    E    LShift
          .BYTE '5','R','D','6' ; 10  5    R    D    6
          .BYTE 'C','F','T','X' ; 14  C    F    T    X
          .BYTE '7','Y','G','8' ; 18  7    Y    G    8
          .BYTE 'B','H','U','V' ; 1C  B    H    U    V
          .BYTE '9','I','J','0' ; 20  9    I    J    0
          .BYTE 'M','K','O','N' ; 24  M    K    O    N
          .BYTE '+','P','L','-' ; 28  +    P    L    -
          .BYTE '.',':','@',',' ; 2C  .    :    @    ,
          .BYTE $5c,'*',';',$13 ; 30  pnd  *    ;    HOME
          .BYTE $01,'=','^','/' ; 34  RShi =    ^    /
          .BYTE '1','_',$04,'2' ; 38  1    _    Ctrl 2
          .BYTE ' ',$02,'Q',$03 ; 3C  SPC       Q    STOP
          .BYTE $84,'8','5',$09 ; 40  HELP K8   K5   TAB
          .BYTE '2','4','7','1' ; 44  K2   K4   K7   K1
          .BYTE $1b,'+','-',$0a ; 48  ESC  K+   K-   LF
          .BYTE $0d,'6','9','3' ; 4C  Entr K6   K9   K3
          .BYTE $08,'0','.',$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Down Left Righ NOSCRL
          .BYTE $ff             ; 58

; **********************
  Keytab_Shifted ; $fad9
; **********************

          .BYTE $94,$8d,$9d,$8c ; 00  INST ShCR Up   F8
          .BYTE $89,$8a,$8b,$91 ; 04  F2   F4   F6   Left
          .BYTE '#',$d7,$c1,'$' ; 08  #    W    A    $
          .BYTE $da,$d3,$c5,$01 ; 0C  Z    S    E    LShift
          .BYTE '%',$d2,$c4,'&' ; 10  %    R    D    &
          .BYTE $c3,$c6,$d4,$d8 ; 14  C    F    T    X
          .BYTE $27,$d9,$c7,'(' ; 18  Apo  Y    G    (
          .BYTE $c2,$c8,$d5,$d6 ; 1C  B    H    U    V
          .BYTE ')',$c9,$ca,'0' ; 20  )    I    J    0
          .BYTE $cd,$cb,$cf,$ce ; 24  M    K    O    N
          .BYTE $db,$d0,$cc,$dd ; 28  +    P    L    -
          .BYTE '>','[',$ba,'<' ; 2C  >    [    @    <
          .BYTE $a9,$c0,']',$93 ; 30  pnd  *    ]    CLR
          .BYTE $01,'=',$de,'?' ; 34  RShi =    ^    ?
          .BYTE '!','_',$04,$22 ; 38  !    _    Ctrl Quote
          .BYTE $a0,$02,$d1,$83 ; 3C  SPC       Q    RUN
          .BYTE $84,'8','5',$18 ; 40  HELP K8   K5   TAB
          .BYTE '2','4','7','1' ; 44  K2   K4   K7   K1
          .BYTE $1b,'+','-',$0a ; 48  ESC  K+   K-   LF
          .BYTE $8d,'6','9','3' ; 4C  Entr K6   K9   K3
          .BYTE $08,'0','.',$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Righ Left Down NOSCRL
          .BYTE $ff             ; 58

; ******************
  Keytab_CBM ; $fb32
; ******************

          .BYTE $94,$8d,$9d,$8c ; 00  INST ShCR Up   F8
          .BYTE $89,$8a,$8b,$91 ; 04  F2   F4   F6   Left
          .BYTE $96,$b3,$b0,$97 ; 08  #    W    A    $
          .BYTE $ad,$ae,$b1,$01 ; 0C  Z    S    E    LShift
          .BYTE $98,$b2,$ac,$99 ; 10  %    R    D    &
          .BYTE $bc,$bb,$a3,$bd ; 14  C    F    T    X
          .BYTE $9a,$b7,$a5,$9b ; 18  Apo  Y    G    (
          .BYTE $bf,$b4,$b8,$be ; 1C  B    H    U    V
          .BYTE $29,$a2,$b5,$30 ; 20  )    I    J    0
          .BYTE $a7,$a1,$b9,$aa ; 24  M    K    O    N
          .BYTE $a6,$af,$b6,$dc ; 28  +    P    L    -
          .BYTE '>','[',$a4,'<' ; 2C  >    [    @    <
          .BYTE $a8,$df,$5d,$93 ; 30  pnd  *    ]    CLR
          .BYTE $01,'=',$de,'?' ; 34  RShi =    ^    ?
          .BYTE $81,$5f,$04,$95 ; 38  !    _    Ctrl Quote
          .BYTE $a0,$02,$ab,$03 ; 3C  SPC       Q    STOP
          .BYTE $84,'8','5',$18 ; 40  HELP K8   K5   TAB
          .BYTE '2','4','7','1' ; 44  K2   K4   K7   K1
          .BYTE $1b,'+','-',$0a ; 48  ESC  K+   K-   LF
          .BYTE $8d,'6','9','3' ; 4C  Entr K6   K9   K3
          .BYTE $08,'0','.',$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Righ Left Down NOSCRL
          .BYTE $ff             ; 58

; **********************
  Keytab_Control ; $fb8b
; **********************

          .BYTE $ff,$ff,$ff,$ff ; 00  INST ShCR Up   F8
          .BYTE $ff,$ff,$ff,$ff ; 04  F2   F4   F6   Left
          .BYTE $1c,$17,$01,$9f ; 08  #    W    A    $
          .BYTE $1a,$13,$05,$ff ; 0C  Z    S    E    LShift
          .BYTE $9c,$12,$04,$1e ; 10  %    R    D    &
          .BYTE $03,$06,$14,$18 ; 14  C    F    T    X
          .BYTE $1f,$19,$07,$9e ; 18  Apo  Y    G    (
          .BYTE $02,$08,$15,$16 ; 1C  B    H    U    V
          .BYTE $12,$09,$0a,$92 ; 20  )    I    J    0
          .BYTE $0d,$0b,$0f,$0e ; 24  M    K    O    N
          .BYTE $ff,$10,$0c,$ff ; 28  +    P    L    -
          .BYTE $ff,$1b,$00,$ff ; 2C  >    [    @    <
          .BYTE $1c,$ff,$1d,$ff ; 30  pnd  *    ]    CLR
          .BYTE $ff,$1f,$1e,$ff ; 34  RShi =    ^    ?
          .BYTE $90,$06,$ff,$05 ; 38  !    _    Ctrl Quote
          .BYTE $ff,$ff,$11,$ff ; 3C  SPC       Q    STOP
          .BYTE $84,$38,$35,$18 ; 40  HELP K8   K5   TAB
          .BYTE $32,$34,$37,$31 ; 44  K2   K4   K7   K1
          .BYTE $1b,$2b,$2d,$0a ; 48  ESC  K+   K-   LF
          .BYTE $8d,$36,$39,$33 ; 4C  Entr K6   K9   K3
          .BYTE $08,$30,$2e,$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Righ Left Down NOSCRL
          .BYTE $ff             ; 58

; ***********************
  Keytab_Capslock ; $fbe4
; ***********************

          .BYTE $14,$0d,$1d,$88 ; 00  INST ShCR Up   F8
          .BYTE $85,$86,$87,$11 ; 04  F2   F4   F6   Left
          .BYTE $33,$d7,$c1,$34 ; 08  #    W    A    $
          .BYTE $da,$d3,$c5,$01 ; 0C  Z    S    E    LShift
          .BYTE $35,$d2,$c4,$36 ; 10  %    R    D    &
          .BYTE $c3,$c6,$d4,$d8 ; 14  C    F    T    X
          .BYTE $37,$d9,$c7,$38 ; 18  Apo  Y    G    (
          .BYTE $c2,$c8,$d5,$d6 ; 1C  B    H    U    V
          .BYTE $39,$c9,$ca,$30 ; 20  )    I    J    0
          .BYTE $cd,$cb,$cf,$ce ; 24  M    K    O    N
          .BYTE $2b,$d0,$cc,$2d ; 28  +    P    L    -
          .BYTE $2e,$3a,$40,$2c ; 2C  >    [    @    <
          .BYTE $5c,$2a,$3b,$13 ; 30  pnd  *    ]    CLR
          .BYTE $01,$3d,$5e,$2f ; 34  RShi =    ^    ?
          .BYTE $31,$5f,$04,$32 ; 38  !    _    Ctrl Quote
          .BYTE $20,$02,$d1,$03 ; 3C  SPC       Q    STOP
          .BYTE $84,$38,$35,$09 ; 40  HELP K8   K5   TAB
          .BYTE $32,$34,$37,$31 ; 44  K2   K4   K7   K1
          .BYTE $1b,$2b,$2d,$0a ; 48  ESC  K+   K-   LF
          .BYTE $0d,$36,$39,$33 ; 4C  Entr K6   K9   K3
          .BYTE $08,$30,$2e,$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Righ Left Down NOSCRL
          .BYTE $ff,$ff,$ff,$ff ; 58

; ****************
  Set_CRSW ; $fc40
; ****************

          ORA CRSW
          STA CRSW
          LDA Cursor_Row
          STA LINTMP
          RTS

; ****************
  EA_to_SA ; $fc4a
; ****************

          LDA EAL
          LDY EAH
          STA SAL
          STY SAH
          JMP Loading_Verifying

; ******************
  Init_RS232 ; $fc55
; ******************

          STA VSH_SPEED
          STA RS_Command
          STA RS_Baudrate
          STA RS_Baudrate+1
          LDX #6
          STX RS_Control
          RTS

; ***********************
  VDC_Program_Mod ; $fc67
; ***********************

          LDY #0
          LDA #$7f
          STY VDC_Register
          STA VDC_Data
          JMP VDC_Program_X

          .BYTE $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

.if KEYBOARD != 255
; **********************
  Edit_Patch_DIN ; $fc80
; **********************

          STA DINFLAG
          STA SID_Volume
          RTS

; ***********************
  K_Scan_Keyboard ; $fc87
; ***********************

          BIT DINFLAG
          BMI KEY_40          ; -> ASCII keyboard
          LDA SHFLAG
          AND #%00010000     ; $10
          BEQ KEY_10          ; -> No CAPS lock
          LDA DECODE+1
          CMP #>DIN_Normal
          BEQ KEY_40
          LDA #<DIN_Key_Tables
          LDY #>DIN_Key_Tables
          BNE KEY_20          ; always

KEY_10    LDA DECODE+1
          CMP #>Keytab_Normal
          BEQ KEY_40
          LDA #<ASCII_Key_Tables
          LDY #>ASCII_Key_Tables

KEY_20    STA KEYTAB
          STY KEYTAB+1
          LDY #11
KEY_30    LDA (KEYTAB),Y      ; update table vectors
          STA DECODE,Y
          DEY
          BPL KEY_30
          INY
          STY DINFLAG         ; DINFLAG = 0
          PHP
          SEI
          JSR Edit_Load_Chargen
          PLP
          RTS
KEY_40    JMP Scan_Keyboard

; *****************
  Check_DIN ; $fcc6
; *****************

          LDX DECODE+1
          CPX #>DIN_Normal
          BNE CDIN_90         ; -> US keyboard mode
          LDX DINFLAG
          BMI CDIN_90         ; -> already in DIN mode
          BEQ CDIN_30         ; -> last key was not an accented key
          LDY Accent_Index,X  ; Y = # of diacritics to check
          DEX                 ; X = 0,1,2 for accent key
CDIN_10   DEY                 ; Y = 2,6,11
          PHA                 ; push A
          TYA                 ; A = 2,6,11
          CMP Accent_Index,X  ; compare with prevoius index
          PLA                 ; pull A
          BCC CDIN_20         ; -> exit comparison loop
          CMP Accent_Vocals-1,Y ; compare with allowed chars
          BNE CDIN_10         ; -> no match: loop

          LDA Accent_Codes-1,Y      ; load diacritic character
CDIN_20   PHA
          AND #%01111111     ; $7f
          CMP #' '            ; blank ?
          PLA
          BCC CDIN_60         ; -> not printable

CDIN_30   LDX #5              ; check for accents and circumflex
CDIN_40   CMP Accent_Key-1,X
          BEQ CDIN_50         ; found accent acute, grave or circumflec
          DEX
          BNE CDIN_40
CDIN_50   STX DINFLAG         ; store accent index or zero
          CPX #0
          BEQ CDIN_90         ; -> no accent key
          TAY                 ; Y = key
          BIT INSFLG          ; insert flag ?
          BMI CDIN_60         ; -> branch on auto insert
          BIT MODE_80
          BPL CDIN_70         ; -> branch on 40 column mode
          LDX #10
          JSR VDC_Read_Register_X
          AND #%01000000     ; $40
          BNE CDIN_80         ; -> cursor is blinking
CDIN_60   RTS
CDIN_70   LDA BLNSW
          BNE CDIN_60
CDIN_80   TYA
          ORA #%01000000     ; $40
          AND #%01111111     ; $7f
          JMP Edit_Put_Char_Att
CDIN_90   LDX SHFLAG
          LDY LSTX
          JMP (KEYCHK)        ; -> Edit_Use_Function_Key

; ******************
  DIN_Normal ; $fd29
; ******************

.if KEYBOARD == 0
          .BYTE $14,$0d,$1d,$88 ; 00  DEL  CR   Down F7
          .BYTE $85,$86,$87,$11 ; 04  F1   F3   F5   Right
          .BYTE '3','W','A','4' ; 08  3    W    A    4
          .BYTE 'Y','S','E',$01 ; 0C [Y]   S    E    LShift
          .BYTE '5','R','D','6' ; 10  5    R    D    6
          .BYTE 'C','F','T','X' ; 14  C    F    T    X
          .BYTE '7','Z','G','8' ; 18  7   [Z]   G    8
          .BYTE 'B','H','U','V' ; 1C  B    H    U    V
          .BYTE '9','I','J','0' ; 20  9    I    J    0
          .BYTE 'M','K','O','N' ; 24  M    K    O    N
          .BYTE $be,'P','L',$af ; 28 [sz]  P    L   [Acc]
          .BYTE '.',$bc,$bd,',' ; 2C  .   [oe] [ue]  ,
          .BYTE '[','+',$bb,$13 ; 30  [    +   [ae]  HOME
          .BYTE $01,'#',']','-' ; 34  RShi[#]   ]   [-]
          .BYTE '1','<',$04,'2' ; 38  1   [<]   Ctrl 2
          .BYTE ' ',$02,'Q',$03 ; 3C  SPC       Q    STOP
          .BYTE $84,'8','5',$09 ; 40  HELP K8   K5   TAB
          .BYTE '2','4','7','1' ; 44  K2   K4   K7   K1
          .BYTE $1b,'+','-',$0a ; 48  ESC  K+   K-   LF
          .BYTE $0d,'6','9','3' ; 4C  Entr K6   K9   K3
          .BYTE $08,'0','.',$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Down Left Righ NOSCRL
          .BYTE $ff             ; 58
.endif
.if KEYBOARD == 2
         .BYTE $14,$0d,$1d,$88
         .BYTE $85,$86,$87,$11
         .BYTE '"','Z','Q',$27
         .BYTE 'W','S','E',$01
         .BYTE '(','R','D',$b0
         .BYTE 'C','F','T','X'
         .BYTE $b2,'Y','G','!'
         .BYTE 'B','H','U','V'
         .BYTE $df,'I','J',$b1
         .BYTE ',','K','O','N'
         .BYTE ')','P','L','-'
         .BYTE ':','M',$ae,';'
         .BYTE '@','$',$b5,$13
         .BYTE $01,'^','*','='
         .BYTE '&','<',$04,$bf
         .BYTE ' ',$02,'A',$03
         .BYTE $84,'8','5',$09
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $0d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 3
         .BYTE $14,$0d,$1d,$88
         .BYTE $85,$86,$87,$11
         .BYTE '3','W','A','4'
         .BYTE 'Y','S','E',$01
         .BYTE '5','R','D','6'
         .BYTE 'C','F','T','X'
         .BYTE '7','Z','G','8'
         .BYTE 'B','H','U','V'
         .BYTE '9','I','J','0'
         .BYTE 'M','K','O','N'
         .BYTE $27,'P','L',$ae
         .BYTE '.',$bc,$bd,','
         .BYTE ']',$af,$bb,$13
         .BYTE $01,'$','[','-'
         .BYTE '1','<',$04,'2'
         .BYTE ' ',$02,'Q',$03
         .BYTE $84,'8','5',$09
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $0d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 4
         .BYTE $14,$0d,$1d,$88
         .BYTE $85,$86,$87,$11
         .BYTE '3','W','A','4'
         .BYTE 'Z','S','E',$01
         .BYTE '5','R','D','6'
         .BYTE 'C','F','T','X'
         .BYTE '7','Y','G','8'
         .BYTE 'B','H','U','V'
         .BYTE '9','I','J','0'
         .BYTE 'M','K','O','N'
         .BYTE '-','P','L','='
         .BYTE '.',$5c,']',','
         .BYTE ':','@','[',$13
         .BYTE $01,';','^','/'
         .BYTE '1',$5f,$04,'2'
         .BYTE ' ',$02,'Q',$03
         .BYTE $84,'8','5',$09
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $0d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 5
         .BYTE $14,$0d,$1d,$88
         .BYTE $85,$86,$87,$11
         .BYTE '3','W','A','4'
         .BYTE 'Z','S','E',$01
         .BYTE '5','R','D','6'
         .BYTE 'C','F','T','X'
         .BYTE '7','Y','G','8'
         .BYTE 'B','H','U','V'
         .BYTE '9','I','J','0'
         .BYTE 'M','K','O','N'
         .BYTE '+','P','L','-'
         .BYTE '.',$5c,']',','
         .BYTE ':','*','[',$13
         .BYTE $01,'=','^','/'
         .BYTE '1',$5f,$04,'2'
         .BYTE ' ',$02,'Q',$03
         .BYTE $84,'8','5',$09
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $0d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 6
         .BYTE $14,$0d,$1d,$88
         .BYTE $85,$86,$87,$11
         .BYTE '"','Z','A',$27
         .BYTE 'W','S','E',$01
         .BYTE '(','R','D',$5f
         .BYTE 'C','F','T','X'
         .BYTE $b2,'Y','G','&'
         .BYTE 'B','H','U','V'
         .BYTE $df,'I','J',$b1
         .BYTE ',','K','O','N'
         .BYTE ')','P','L','-'
         .BYTE ':','M',$b3,';'
         .BYTE '@','$',$b5,$13
         .BYTE $01,'^','*',$b4
         .BYTE $ac,'<',$04,$bf
         .BYTE ' ',$02,'Q',$03
         .BYTE $84,'8','5',$09
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $0d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif

; *****************
  DIN_Shift ; $fd82
; *****************

.if KEYBOARD == 0
          .BYTE $94,$8d,$9d,$8c ; 00  INST ShCR Up   F8
          .BYTE $89,$8a,$8b,$91 ; 04  F2   F4   F6   Left
          .BYTE $40,$d7,$c1,$24 ; 08  #    W    A    $
          .BYTE $d9,$d3,$c5,$01 ; 0C [Y]   S    E    LShift
          .BYTE $25,$d2,$c4,$26 ; 10  %    R    D    &
          .BYTE $c3,$c6,$d4,$d8 ; 14  C    F    T    X
          .BYTE $2f,$da,$c7,$28 ; 18  Apo [Z]   G    (
          .BYTE $c2,$c8,$d5,$d6 ; 1C  B    H    U    V
          .BYTE $29,$c9,$ca,$3d ; 20  )    I    J    0
          .BYTE $cd,$cb,$cf,$ce ; 24  M    K    O    N
          .BYTE '?',$d0,$cc,$c0 ; 28 [?]   P    L   [Acc]
          .BYTE ':',$dc,$dd,';' ; 2C [:]  [OE] [UE] [;]
          .BYTE $5e,$2a,$db,$93 ; 30  pnd  *   [AE]  CLR
          .BYTE $01,$27,$5c,'_' ; 34  RShi[']   Pnd [_]
          .BYTE '!','>',$04,$22 ; 38  !   [>]   Ctrl Quote
          .BYTE $a0,$02,$d1,$83 ; 3C  SPC       Q    RUN
          .BYTE $84,$38,$35,$18 ; 40  HELP K8   K5   TAB
          .BYTE '2','4','7','1' ; 44  K2   K4   K7   K1
          .BYTE $1b,'+','-',$0a ; 48  ESC  K+   K-   LF
          .BYTE $8d,'6','9','3' ; 4C  Entr K6   K9   K3
          .BYTE $08,'0','.',$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Righ Left Down NOSCRL
          .BYTE $ff             ; 58
.endif
.if KEYBOARD == 2
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE '3',$da,$d1,'4'
         .BYTE $d7,$d3,$c5,$01
         .BYTE '5',$d2,$c4,'6'
         .BYTE $c3,$c6,$d4,$d8
         .BYTE '7',$d9,$c7,'8'
         .BYTE $c2,$c8,$d5,$d6
         .BYTE '9',$c9,$ca,'0'
         .BYTE '?',$cb,$cf,$ce
         .BYTE $dd,$d0,$cc,$5f
         .BYTE '/',$cd,$af,'.'
         .BYTE '#','[','%',$93
         .BYTE $01,$5c,']','+'
         .BYTE '1','>',$04,'2'
         .BYTE $a0,$02,$c1,$83
         .BYTE $84,$a9,$ab,$18
         .BYTE $a3,$a5,$a8,$a2
         .BYTE $1b,$a1,'-',$0a
         .BYTE $8d,$a7,$aa,$a4
         .BYTE $08,$a6,$de,$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 3
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE '*',$d7,$c1,$df
         .BYTE $d9,$d3,$c5,$01
         .BYTE '%',$d2,$c4,'&'
         .BYTE $c3,$c6,$d4,$d8
         .BYTE '/',$da,$c7,'('
         .BYTE $c2,$c8,$d5,$d6
         .BYTE ')',$c9,$ca,'='
         .BYTE $cd,$cb,$cf,$ce
         .BYTE '?',$d0,$cc,$c0
         .BYTE ':',$bf,$b2,';'
         .BYTE '^','!',$b1,$93
         .BYTE $01,'@','#',$5f
         .BYTE '+','>',$04,'"'
         .BYTE $a0,$02,$d1,$83
         .BYTE $84,$a9,$ab,$18
         .BYTE $a3,$a5,$a8,$a2
         .BYTE $1b,$a1,$dd,$0a
         .BYTE $8d,$a7,$aa,$a4
         .BYTE $08,$a6,$de,$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 4
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE '#',$d7,$c1,'$'
         .BYTE $da,$d3,$c5,$01
         .BYTE '%',$d2,$c4,'&'
         .BYTE $c3,$c6,$d4,$d8
         .BYTE $27,$d9,$c7,'('
         .BYTE $c2,$c8,$d5,$d6
         .BYTE ')',$c9,$ca,'0'
         .BYTE $cd,$cb,$cf,$ce
         .BYTE $db,$d0,$cc,$dd
         .BYTE '>',$dc,$dd,'<'
         .BYTE '*',$c0,$db,$93
         .BYTE $01,'+',$de,'?'
         .BYTE '!',$5f,$04,'"'
         .BYTE $a0,$02,$d1,$83
         .BYTE $84,'8','5',$18
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $8d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 5
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE '#',$d7,$c1,'$'
         .BYTE $da,$d3,$c5,$01
         .BYTE '%',$d2,$c4,'&'
         .BYTE $c3,$c6,$d4,$d8
         .BYTE $27,$d9,$c7,'('
         .BYTE $c2,$c8,$d5,$d6
         .BYTE ')',$c9,$ca,'0'
         .BYTE $cd,$cb,$cf,$ce
         .BYTE $db,$d0,$cc,$dd
         .BYTE '>',$dc,$dd,'<'
         .BYTE ';',$c0,$db,$93
         .BYTE $01,'@',$de,'?'
         .BYTE '!',$5f,$04,'"'
         .BYTE $a0,$02,$d1,$83
         .BYTE $84,'8','5',$18
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $8d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 6
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE '3',$da,$c1,'4'
         .BYTE $d7,$d3,$c5,$01
         .BYTE '5',$d2,$c4,'6'
         .BYTE $c3,$c6,$d4,$d8
         .BYTE '7',$d9,$c7,'8'
         .BYTE $c2,$c8,$d5,$d6
         .BYTE '9',$c9,$ca,'0'
         .BYTE '?',$cb,$cf,$ce
         .BYTE $dd,$d0,$cc,'+'
         .BYTE '/',$cd,'=','.'
         .BYTE '#','[','%',$93
         .BYTE $01,$5c,']','!'
         .BYTE '1','>',$04,'2'
         .BYTE $a0,$02,$d1,$83
         .BYTE $84,$a9,$ab,$18
         .BYTE $a3,$a5,$a8,$a2
         .BYTE $1b,$a1,'-',$0a
         .BYTE $8d,$a7,$aa,$a4
         .BYTE $08,$a6,$de,$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif

; ***************
  DIN_CBM ; $fddb
; ***************

.if KEYBOARD == 0
          .BYTE $94,$8d,$9d,$8c ; 00  INST ShCR Up   F8
          .BYTE $89,$8a,$8b,$91 ; 04  F2   F4   F6   Left
          .BYTE $96,$a7,$a8,$97 ; 08  #   [W]  [A]   $
          .BYTE $a2,$aa,$a3,$01 ; 0C [Z]  [S]  [E]   LShift
          .BYTE $98,$a9,$c4,$99 ; 10  %   [R]  [D]   &
          .BYTE $c5,$d3,$ce,$a4 ; 14 [C]  [F]  [T]  [X]
          .BYTE $9a,$c2,$df,$9b ; 18  Apo [Y]  [G]   (
          .BYTE $a1,$c9,$d6,$d7 ; 1C [B]  [H]  [U]  [V]
          .BYTE $d1,$c3,$d5,$c1 ; 20 [)]  [I]  [J]  [0]
          .BYTE $cb,$da,$d8,$cd ; 24 [M]  [K]  [O]  [N]
          .BYTE $ab,$d9,$c8,$bf ; 28 [+]  [P]  [L]  [-]
          .BYTE $ba,$ca,$b0,$ac ; 2C  >    [    @    <
          .BYTE $ad,$a6,$db,$93 ; 30  pnd  *    ]    CLR
          .BYTE $01,$dd,$de,$b9 ; 34  RShi =    ^    ?
          .BYTE $81,$b1,$04,$95 ; 38  !    _    Ctrl Quote
          .BYTE $a0,$02,$a5,$03 ; 3C  SPC       Q    STOP
          .BYTE $84,$38,$35,$18 ; 40  HELP K8   K5   TAB
          .BYTE $32,$34,$37,$31 ; 44  K2   K4   K7   K1
          .BYTE $1b,$2b,$2d,$0a ; 48  ESC  K+   K-   LF
          .BYTE $8d,$36,$39,$33 ; 4C  Entr K6   K9   K3
          .BYTE $08,$30,$2e,$91 ; 50  ALT  K0   K.   Up
          .BYTE $11,$9d,$1d,$ff ; 54  Righ Left Down NOSCRL
          .BYTE $ff             ; 58
.endif
.if KEYBOARD == 2
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE $96,$da,$d1,$97
         .BYTE $d7,$d3,$c5,$01
         .BYTE $98,$d2,$c4,$99
         .BYTE $c3,$c6,$d4,$d8
         .BYTE $9a,$d9,$c7,$9b
         .BYTE $c2,$c8,$d5,$d6
         .BYTE ')',$c9,$ca,'0'
         .BYTE '?',$cb,$cf,$ce
         .BYTE $dd,$d0,$cc,$5f
         .BYTE '/',$cd,$af,'.'
         .BYTE '#','[','%',$93
         .BYTE $01,$5c,']','+'
         .BYTE $81,'<',$04,$95
         .BYTE $a0,$02,$c1,$03
         .BYTE $84,$a9,$ab,$18
         .BYTE $a3,$a5,$a8,$a2
         .BYTE $1b,$a1,'-',$0a
         .BYTE $8d,$a7,$aa,$a4
         .BYTE $08,$a6,$de,$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 3
          .BYTE $94,$8d,$9d,$8c
          .BYTE $89,$8a,$8b,$91
          .BYTE $96,$d7,$c1,$97
          .BYTE $d9,$d3,$c5,$01
          .BYTE $98,$d2,$c4,$99
          .BYTE $c3,$c6,$d4,$d8
          .BYTE $9a,$da,$c7,$9b
          .BYTE $c2,$c8,$d5,$d6
          .BYTE ')',$c9,$ca,'='
          .BYTE $cd,$cb,$cf,$ce
          .BYTE $5c,$d0,$cc,$ad
          .BYTE ':',$bf,$b2,';'
          .BYTE $ac,'!',$b1,$93
          .BYTE $01,'@','#',$5f
          .BYTE $81,'>',$04,$95
          .BYTE $a0,$02,$d1,$03
          .BYTE $84,$a9,$ab,$18
          .BYTE $a3,$a5,$a8,$a2
          .BYTE $1b,$a1,$dd,$0a
          .BYTE $8d,$a7,$aa,$a4
          .BYTE $08,$a6,$de,$91
          .BYTE $11,$9d,$1d,$ff
          .BYTE $ff
.endif
.if KEYBOARD == 4
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE $96,$b3,$b0,$97
         .BYTE $ad,$ae,$b1,$01
         .BYTE $98,$b2,$ac,$99
         .BYTE $bc,$bb,$a3,$bd
         .BYTE $9a,$b7,$a5,$9b
         .BYTE $bf,$b4,$b8,$be
         .BYTE ')',$a2,$b5,'0'
         .BYTE $a7,$a1,$b9,$aa
         .BYTE $a6,$af,$b6,$dc
         .BYTE '>',$dc,$a4,'<'
         .BYTE $a8,$df,$db,$93
         .BYTE $01,'+',$de,'?'
         .BYTE $81,$5f,$04,$95
         .BYTE $a0,$02,$ab,$03
         .BYTE $84,'8','5',$18
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $8d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 5
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE $96,$b3,$b0,$97
         .BYTE $ad,$ae,$b1,$01
         .BYTE $98,$b2,$ac,$99
         .BYTE $bc,$bb,$a3,$bd
         .BYTE $9a,$b7,$a5,$9b
         .BYTE $bf,$b4,$b8,$be
         .BYTE ')',$a2,$b5,'0'
         .BYTE $a7,$a1,$b9,$aa
         .BYTE $a6,$af,$b6,$dc
         .BYTE '>',$ba,$a4,'<'
         .BYTE $a8,$df,$a9,$93
         .BYTE $01,'@',$de,'?'
         .BYTE $81,$5f,$04,$95
         .BYTE $a0,$02,$ab,$03
         .BYTE $84,'8','5',$18
         .BYTE '2','4','7','1'
         .BYTE $1b,'+','-',$0a
         .BYTE $8d,'6','9','3'
         .BYTE $08,'0','.',$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif
.if KEYBOARD == 6
         .BYTE $94,$8d,$9d,$8c
         .BYTE $89,$8a,$8b,$91
         .BYTE $96,$da,$c1,$97
         .BYTE $d7,$d3,$c5,$01
         .BYTE $98,$d2,$ac,$99
         .BYTE $c3,$c6,$d4,$d8
         .BYTE $9a,$d9,$c7,$9b
         .BYTE $c2,$c8,$d5,$d6
         .BYTE $df,$c9,$ca,'0'
         .BYTE '?',$cb,$cf,$ce
         .BYTE $dd,$d0,$cc,'+'
         .BYTE '/',$cd,'=','.'
         .BYTE '#','[','%',$93
         .BYTE $01,$1c,']','!'
         .BYTE $81,'>',$04,$95
         .BYTE $a0,$02,$d1,$03
         .BYTE $84,$a9,$ab,$18
         .BYTE $a3,$a5,$a8,$a2
         .BYTE $1b,$a1,'-',$0a
         .BYTE $8d,$a7,$aa,$a4
         .BYTE $08,$a6,$de,$91
         .BYTE $11,$9d,$1d,$ff
         .BYTE $ff
.endif

; **********************
  DIN_Key_Tables ; $fe34
; **********************

          .WORD DIN_Normal
          .WORD DIN_Shift
          .WORD DIN_CBM
          .WORD Keytab_Control
          .WORD DIN_Normal
          .WORD DIN_Normal

; ******************
  Accent_Key ; $fe40
; ******************

.if KEYBOARD == 0
          .BYTE $af           ; accent acute       A
          .BYTE $c0           ; accent grave       A E U
          .BYTE $bf           ; accent circumflex  A E I O U

          .FILL 2 ,0
.endif
.if (KEYBOARD == 2) || (KEYBOARD == 3) || (KEYBOARD == 6)
          .BYTE $ad
          .BYTE $c0
          .BYTE $ae
          .BYTE $af

          .BYTE $00
.endif
.if (KEYBOARD == 4) || (KEYBOARD == 5)
          .FILL 5 ,$ff
.endif

; *******************
  Accent_Index ; $fe45
; *******************

.if KEYBOARD == 0
          .BYTE  1            ; index to acute      table
          .BYTE  3            ; index to grave      table
          .BYTE  7            ; index to circumflex table
          .BYTE 12
          .BYTE 12
          .BYTE 12
.endif
.if KEYBOARD == 2
          .BYTE  1            ; index to acute      table
          .BYTE  2            ; index to grave      table
          .BYTE  7            ; index to circumflex table
          .BYTE 12
          .BYTE 17
          .BYTE 17
.endif
.if (KEYBOARD == 3) || (KEYBOARD == 6)
          .BYTE  1            ; index to acute      table
          .BYTE  2            ; index to grave      table
          .BYTE  7            ; index to circumflex table
          .BYTE 12
          .BYTE 14
          .BYTE 15
.endif
.if (KEYBOARD == 4) || (KEYBOARD == 5)
          .FILL 6 ,$ff
.endif

; *********************
  Accent_Vocals ; $fe4b
; *********************

.if KEYBOARD == 0
          .BYTE 'E'    ,$c0   ; vocals with acute
          .TEXT "AEU"  ,$af   ; vocals with grave
          .TEXT "AEIOU"       ; vocals with circumflex

          .FILL 16 ,$ff
.endif
.if KEYBOARD == 2
          .BYTE $45,$41,$45,$49,$4F,$55,$41,$45,$49,$4F,$55,$41,$45,$49,$4F,$55
          .FILL 11 ,$ff
.endif
.if (KEYBOARD == 3) || (KEYBOARD == 6)
          .BYTE $45,$41,$45,$55,$4F,$49,$41,$45,$49,$4F,$55,$45,$49
          .FILL 14 ,$ff
.endif
.if (KEYBOARD == 4) || (KEYBOARD == 5)
          .FILL 27 ,$ff
.endif


; ********************
  Accent_Codes ; $fe66
; ********************

.if KEYBOARD == 0
          .BYTE $ac           ; e acute
          .BYTE $bf
          .BYTE $b2           ; a grave
          .BYTE $ae           ; e grave
          .BYTE $b3           ; u grave
          .BYTE $bf
          .BYTE $b4           ; a circumflex
          .BYTE $b5           ; e circumflex
          .BYTE $b6           ; i circumflex
          .BYTE $b7           ; o circumflex
          .BYTE $b8           ; u circumflex

          .FILL 16 ,$ff
.endif
.if KEYBOARD == 2
          .BYTE $BF,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$DB,$DC,$BC,$BD
          .FILL 11 ,$ff
.endif
.if (KEYBOARD == 3) || (KEYBOARD == 6)
          .BYTE $BF,$B1,$B2,$B5,$B4,$B3,$B6,$B7,$B8,$B9,$BA,$DB,$DC
          .FILL 14 ,$ff
.endif
.if (KEYBOARD == 4) || (KEYBOARD == 5)
          .FILL 27 ,$ff
.endif

; ********************
  DIN_or_ASCII ; $fe81
; ********************

          LDA R8502
          AND #%01000000     ; $40 extract bit 6
          EOR #%01000000     ; $40 flip    bit 6
          LSR A
          LSR A               ; shift DIN bit to bit 4
          STA SHFLAG          ; store flag
          RTS
.endif
          .FILL $ff00-* ,$ff ;  116 bytes

MMU_CR    .BYTE $ff
MMU_LCRA  .BYTE $ff
MMU_LCRB  .BYTE $ff
MMU_LCRC  .BYTE $ff
MMU_LCRD  .BYTE $ff

; Following code is present in all bank configurations

; ***********
  NMI ; $ff05
; ***********

          SEI
          PHA
          TXA
          PHA
          TYA
          PHA
          LDA MMU_CR
          PHA
          LDA #0
          STA MMU_CR
          JMP (INMI)

; ***********
  IRQ ; $ff17
; ***********

          PHA                 ; push A
          TXA
          PHA                 ; push X
          TYA
          PHA                 ; push Y
          LDA MMU_CR
          PHA                 ; push bank
          LDA #0
          STA MMU_CR          ; switch to system bank
          TSX
          LDA STACK+5,X       ; get IRQ flags
          AND #%00010000     ; test BRK flag
          BEQ IRQ_10          ; -> no BRK : jump to normal IRQ
          JMP (IBRK)
IRQ_10    JMP (IIRQ)
IRQ_Exit  PLA                 ; pull bank
          STA MMU_CR
          PLA                 ; pull Y
          TAY
          PLA                 ; pull X
          TAX
          PLA                 ; pull A
          RTI

; *************
  RESET ; $ff3d
; *************

          LDA #0
          STA MMU_CR
          JMP System_Reset

          .WORD $ffff ;     1
K_SPINIO  JMP SPINIO
K_CLOALL  JMP CLOALL
K_C64     JMP C64
K_DMA     JMP DMA
K_BOOT    JMP BOOT
K_PHOENIX JMP PHOENIX
K_LKUPLA  JMP LKUPLA
K_LKUPSA  JMP LKUPSA
K_SWAPPER JMP E_SWAPPER
K_DLCHR   JMP E_DLCHR
K_PFKEY   JMP E_PFKEY
K_SETBNK  JMP SETBNK
K_GETCFG  JMP GETCFG
K_JSRFAR  JMP JSRFAR
K_JMPFAR  JMP JMPFAR
K_INDFET  JMP INDFET
K_INDSTA  JMP INDSTA
K_INDCMP  JMP INDCMP
K_PRIMM   JMP PRIMM
K_VERSION .BYTE $01
K_CINT    JMP E_CINT
K_IOINIT  JMP IOINIT
K_RAMTAS  JMP RAMTAS
K_RESTOR  JMP RESTOR
K_VECTOR  JMP VECTOR
K_SETMSG  JMP SETMSG
K_SECND   JMP SECND
K_TKSA    JMP TKSA
K_MEMTOP  JMP MEMTOP
K_MEMBOT  JMP MEMBOT
K_KEY     JMP E_KEY
K_SETTMO  JMP SETTMO
K_ACPTR   JMP ACPTR
K_CIOUT   JMP CIOUT
K_UNTLK   JMP UNTLK
K_UNLSN   JMP UNLSN
K_LISTN   JMP LISTN
K_TALK    JMP TALK
K_READST  JMP READST
K_SETLFS  JMP SETLFS
K_SETNAM  JMP SETNAM
K_OPEN    JMP (IOPEN)
K_CLOSE   JMP (ICLOSE)
K_CHKIN   JMP (ICHKIN)
K_CKOUT   JMP (ICKOUT)
K_CLRCH   JMP (ICLRCH)
K_BASIN   JMP (IBASIN)
K_BSOUT   JMP (IBSOUT)
K_LOADSP  JMP LOAD_AXY
K_SAVESP  JMP SAVESP
K_SETTIM  JMP SETTIM
K_RDTIM   JMP RDTIM
K_STOP    JMP (ISTOP)
K_GETIN   JMP (IGETIN)
K_CLALL   JMP (ICLALL)
K_UDTIM   JMP UDTIM
K_SCRORG  JMP E_SCRORG
K_PLOT    JMP E_PLOT
K_IOBASE  JMP IOBASE
V_LOCK    .WORD $ffff ;     1
V_SYSTEM  .WORD SYSTEM
V_NMI     .WORD NMI
V_RESET   .WORD RESET
V_IRQ     .WORD IRQ
