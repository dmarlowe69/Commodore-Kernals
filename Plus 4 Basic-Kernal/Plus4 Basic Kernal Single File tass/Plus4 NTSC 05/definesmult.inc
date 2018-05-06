;
;defines.inc
;
.weak
COMPILECOMPUTER = 0
plus4pal  = 0
plus4ntsc = 0
plus4beta = 0
.endweak

COMPUTER_UNKNOWN=0

PLUS4_GENERAL=COMPUTER_UNKNOWN + $10

PLUS4_BETA_0119=PLUS4_GENERAL + 1
PLUS4_BETA_0203=PLUS4_GENERAL + 2
PLUS4_01=PLUS4_GENERAL + 11
PLUS4_02=PLUS4_GENERAL + 12
PLUS4_03=PLUS4_GENERAL + 13
PLUS4_04=PLUS4_GENERAL + 14
PLUS4_05=PLUS4_GENERAL + 15

.if (plus4pal && plus4ntsc) != 0
        .error "You cannot define plus4pal and plus4ntsc"
.fi

.if plus4beta && ( plus4pal || plus4ntsc ) == 0
        .error "You must either specify plus4beta, or an plus4pal or plus4ntsc."
.endif

.if plus4beta != 0
IS_NTSC=0
IS_PAL=1

.if plus4beta == 0119
COMPILECOMPUTER=PLUS4_BETA_0119
FILLER_FD00=$00
CONST_E447_T1PIPE=$02C7
CONST_E452_T1PIPE=$00AF
CONST_E45D_T1PIPE=$0162
ROM_CHECKSUM=$EC
ROM_VERSION=$01
VERSION_INFO_D800=$1601
FILLER_FF40=$50
LF338_NTSC=$40
.elsif plus4beta == 0203
COMPILECOMPUTER=PLUS4_BETA_0203
FILLER_FD00=$00
CONST_E447_T1PIPE=$02C7
CONST_E452_T1PIPE=$00AF
CONST_E45D_T1PIPE=$0162
ROM_CHECKSUM=$EC
ROM_VERSION=$01
VERSION_INFO_D800=$2401
FILLER_FF40=$50
LF338_NTSC=$40
.else
 .error "You must specify plus4beta"
.fi
.fi

.if plus4pal != 0
IS_NTSC=0
IS_PAL=1

.if plus4pal == 01
COMPILECOMPUTER=PLUS4_01
FILLER_FD00=$00
CONST_E447_T1PIPE=$02C7
CONST_E452_T1PIPE=$00AF
CONST_E45D_T1PIPE=$0162
ROM_CHECKSUM=$F4
ROM_VERSION=$81
VERSION_INFO_D800=$1702
FILLER_FF40=$40
LF338_NTSC=$00
.elsif plus4pal == 02
 .error "plus4pal == 2 is unknown"
.elsif plus4pal == 03
COMPILECOMPUTER=PLUS4_03
FILLER_FD00=$00
CONST_E447_T1PIPE=$034E
CONST_E452_T1PIPE=$00D0
CONST_E45D_T1PIPE=$01A4
ROM_CHECKSUM=$F1
ROM_VERSION=$83
VERSION_INFO_D800=$0405
FILLER_FF40=$FF
LF338_NTSC=$00
.elsif plus4pal == 04
COMPILECOMPUTER=PLUS4_04
FILLER_FD00=$00
CONST_E447_T1PIPE=$034E
CONST_E452_T1PIPE=$00D0
CONST_E45D_T1PIPE=$01A4
ROM_CHECKSUM=$2A
ROM_VERSION=$84
VERSION_INFO_D800=$0506
FILLER_FF40=$FF
LF338_NTSC=$00
.elsif plus4pal == 05
COMPILECOMPUTER=PLUS4_05
FILLER_FD00=$00
CONST_E447_T1PIPE=$034E
CONST_E452_T1PIPE=$00D0
CONST_E45D_T1PIPE=$01A4
ROM_CHECKSUM=$5E
ROM_VERSION=$85
VERSION_INFO_D800=$0908
FILLER_FF40=$FF
LF338_NTSC=$00
.else
 .error "You must specify plus4pal <= 5"
.fi
.fi

.if plus4ntsc != 0
IS_NTSC=1
IS_PAL=0
.fi

.if plus4ntsc == 01
        .error "plus4ntsc == 1 is unknown"
.elsif plus4ntsc == 02
        .error "plus4ntsc == 2 is unknown"
.elsif plus4ntsc == 03
        .error "plus4ntsc == 3 is unknown"
.elsif plus4ntsc == 04
COMPILECOMPUTER=PLUS4_04
FILLER_FD00=$00
CONST_E447_T1PIPE=$034E
CONST_E452_T1PIPE=$00D0
CONST_E45D_T1PIPE=$01A4
ROM_CHECKSUM=$90
ROM_VERSION=$04
VERSION_INFO_D800=$0506
FILLER_FF40=$FF
LF338_NTSC=$40
.elsif plus4ntsc == 05
COMPILECOMPUTER=PLUS4_05
FILLER_FD00=$FF
CONST_E447_T1PIPE=$034E
CONST_E452_T1PIPE=$00D0
CONST_E45D_T1PIPE=$01A4
ROM_CHECKSUM=$C4
ROM_VERSION=$05
VERSION_INFO_D800=$0908
FILLER_FF40=$FF
LF338_NTSC=$40
.else
 .error "You must specify plus4ntsc <= 5"
.fi

;.if 0
;VIC20_GENERAL=COMPUTER_UNKNOWN + $10
;VIC20_02=VIC20_GENERAL + 2
;VIC20_06=VIC20_GENERAL + 6
;VIC20_07=VIC20_GENERAL + 7

;C64_GENERAL=VIC20_GENERAL + $20
;C64_01=C64_GENERAL + 1
;C64_02=C64_GENERAL + 2
;C64_03=C64_GENERAL + 3
;C64_SX64=C64_GENERAL + 4
;C64_4064=C64_GENERAL + 5
;C64_GS=C64_GENERAL + 6

;.ifdef vic20
;COMPILECOMPUTER=VIC20_GENERAL + vic20
;.elseif .defined(c64)
;        .if c64 = 4064
;COMPILECOMPUTER=C64_4064
;        .else
;COMPILECOMPUTER=C64_GENERAL + c64
;        .endif
;.endif

;.ifdef sx64
;COMPILECOMPUTER=C64_SX64
;c64 = sx64
;.endif

;.ifdef c64gs
;COMPILECOMPUTER=C64_GS
;c64 = c64gs
;.endif

.if COMPILECOMPUTER == 0
COMPILECOMPUTER=COMPUTER_UNKNOWN
.fi

;.macro FillCount count,filler
;        .repeat count
;                .ifblank filler
;                        .byte DRIVEFILLER
;                .else
;                        .byte filler
;                .endif
;        .endrep
;.endmacro

;.macro FillUntil address,filler
;        FillCount address-*,filler
;.endmacro

;.macro FillNOP count
;        FillCount count,$EA
;.endmacro

.if 0
IEEE_LISTEN    = $20    ; on ATN, with primary address
IEEE_TALK      = $40    ; on ATN, with primary address
IEEE_OPEN      = $60    ; on ATN, with secondary address
IEEE_CLOSE     = $E0    ; on ATN, with primary address
IEEE_SECONDARY = $F0    ; on ATN, with secondary address

IEEE_LOAD      = IEEE_OPEN + 0
IEEE_SAVE      = IEEE_OPEN + 1

IEEE_UNLISTEN = IEEE_LISTEN + $1F
IEEE_UNTALK   = IEEE_TALK   + $1F

STATUS_IEC_DEVICE_NOT_PRESENT        = $80
STATUS_IEC_EOI                       = $40
STATUS_IEC_TIMEOUT_READ              = $02
STATUS_IEC_TIMEOUT_WRITE             = $01

STATUS_VERIFY                        = $10

STATUS_TAPE_EOT                      = $80
STATUS_TAPE_EOF                      = $40 ; not on LOAD and VERIFY
STATUS_TAPE_CHKSUM_ERR               = $20
STATUS_TAPE_UNRECOVERABLE_READ_ERROR = $10
STATUS_TAPE_LONG_BLOCK               = $08
STATUS_TAPE_SHORT_BLOCK              = $04

.fi
