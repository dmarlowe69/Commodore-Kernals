;
;plus4.a65.full
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
.fi

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
;        .fi
;.fi

;.ifdef sx64
;COMPILECOMPUTER=C64_SX64
;c64 = sx64
;.fi

;.ifdef c64gs
;COMPILECOMPUTER=C64_GS
;c64 = c64gs
;.fi

.if COMPILECOMPUTER == 0
COMPILECOMPUTER=COMPUTER_UNKNOWN
.fi

;.macro FillCount count,filler
;        .repeat count
;                .ifblank filler
;                        .byte DRIVEFILLER
;                .else
;                        .byte filler
;                .fi
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

;        .setcpu "6502"

;        .segment "BASIC35"

PDIR            := $0000
PORT            := $0001
SRCHTK          := $0002
ZPVEC1          := $0003
ZPVEC2          := $0005
CHARAC          := $0007
ENDCHR          := $0008
TRMPOS          := $0009
VERCK           := $000A
COUNT           := $000B
DIMFLG          := $000C
VALTYP          := $000D
INTFLG          := $000E
DORES           := $000F
SUBFLG          := $0010
INPFLG          := $0011
TANSGN          := $0012
CHANNL          := $0013
LINNUM          := $0014
TEMPPT          := $0016
LASTPT          := $0017
TEMPST          := $0019
INDEX1          := $0022
INDEX2          := $0024
RESH0           := $0026
TXTTAB          := $002B
VARTAB          := $002D
ARYTAB          := $002F
STREND          := $0031
FRETOP          := $0033
FRESPC          := $0035
MEMSIZ          := $0037
CHRLIN          := $0039
TXTPTR          := $003B
FNDPNT          := $003D
DATLIN          := $003F
DATPTR          := $0041
INPPTR          := $0043
VARNAM          := $0045
VARPNT          := $0047
FORPNT          := $0049
OPPTR           := $004B
OPMASK          := $004D
DEFPNT          := $004E
DSCPNT          := $0050
HELPER          := $0053
JMPER           := $0054
TEMPF1          := $0057
FACEXP          := $0061
FACH0           := $0062
FACSGN          := $0066
SGNFLG          := $0067
BITS            := $0068
ARGEXP          := $0069
ARGH0           := $006A
ARGSGN          := $006E
ARISGN          := $006F
FACOV           := $0070
FBUFPT          := $0071
AUTINC          := $0073
MVDFLG          := $0075
KEYNUM          := $0076
DSDESC          := $0079
TOS             := $007C
TMPTON          := $007E
VOICNO          := $0080
RUNMOD          := $0081
POINT           := $0082
GRAPHM          := $0083
COLSEL          := $0084
MC1             := $0085
FG              := $0086
SCXMAX          := $0087
SCYMAX          := $0088
LTFLAG          := $0089
RTFLAG          := $008A
STOPNB          := $008B
GRAPNT          := $008C
VTEMP1          := $008E
VTEMP2          := $008F
STATUS          := $0090
STKEY           := $0091
VERFCK          := $0093
C3P0            := $0094
BSOUR           := $0095
RSAV            := $0096
LDTND           := $0097
DFLTN           := $0098
DFLTO           := $0099
MSGFLG          := $009A
SAL             := $009B
EAL             := $009D
T1              := $009F
T2              := $00A1
TIME            := $00A3
R2D2            := $00A6
TPBYTE          := $00A7
BSOUR1          := $00A8
FPVERR          := $00A9
DCOUNT          := $00AA
FNLEN           := $00AB
LA              := $00AC
SA              := $00AD
FA              := $00AE
FNADR           := $00AF
ERRSUM          := $00B1
STAL            := $00B2
MEMUSS          := $00B4
TAPEBS          := $00B6
TMP2            := $00B8
WRBASE          := $00BA
IMPARM          := $00BC
FETPTR          := $00BE
SEDSAL          := $00C0
RVS             := $00C2
INDX            := $00C3
LSXP            := $00C4
SFDX            := $00C6
CRSW            := $00C7
PNT             := $00C8
PNTR            := $00CA
QTSW            := $00CB
SEDT1           := $00CC
TBLX            := $00CD
DATAX           := $00CE
INSRT           := $00CF
CIRSEG          := $00E9
USER            := $00EA
KEYTAB          := $00EC
NDX             := $00EF
STPFLG          := $00F0
T0              := $00F1
CHRPTR          := $00F3
BUFEND          := $00F4
CHKSUM          := $00F5
LENGTH          := $00F6
PASS            := $00F7
TYPE            := $00F8
USEKDY          := $00F9
XSTOP           := $00FA
CURBNK          := $00FB
XON             := $00FC
XOFF            := $00FD
SEDT2           := $00FE
LOFBUF          := $00FF
FBUFFER         := $0100
SAVEA           := $0110
SAVEY           := $0111
COLKEY          := $0113
SYSSTK          := $0124
BUF             := $0200
OLDLIN          := $0259
OLDTXT          := $025B
XCNT            := $025D
FNBUFR          := $025E
DOSF1L          := $026E
DOSDS1          := $026F
DOSF1A          := $0270
DOSF2L          := $0272
DOSDS2          := $0273
DOSF2A          := $0274
DOSLA           := $0276
DOSFA           := $0277
DOSSA           := $0278
DODDID          := $0279
DIDCHK          := $027B
DOSSTR          := $027C
DOSSPC          := $027D
YABS            := $0287
XSGN            := $0289
YSGN            := $028B
FCT1            := $028D
FCT2            := $028F
XPOS            := $02AD
YPO             := $02AF
XDEST           := $02B1
YDEST           := $02B3
XABS            := $02B5
ERRVAL          := $02C1
LESSER          := $02C3
ANGSGN          := $02C5
SINVAL          := $02C6
COSVAL          := $02C8
ANGCNT          := $02CA
BNR             := $02CD
ENR             := $02CE
DOLR            := $02CF
FLAG            := $02D0
SWE             := $02D1
USGN            := $02D2
UEXP            := $02D3
VN              := $02D4
CHSN            := $02D5
VF              := $02D6
NF              := $02D7
POSP            := $02D8
FESP            := $02D9
ETOF            := $02DA
CFORM           := $02DB
SNO             := $02DC
BLFD            := $02DD
BEGFD           := $02DE
LFOR            := $02DF
ENDFD           := $02E0
CHRPAG          := $02E4
BITCNT          := $02E5
SCALEM          := $02E6
WIDTH           := $02E7
FILFLG          := $02E8
BITMSK          := $02E9
NUMCNT          := $02EA
TRCFLG          := $02EB
T3              := $02EC
T4              := $02ED
VTEMP3          := $02EF
VTEMP4          := $02F0
VTEMP5          := $02F1
ADRAY1          := $02F2
ADRAY2          := $02F4
BNKVEC          := $02FE
lIERROR         := $0300
lIMAIN          := $0302
lICRNCH         := $0304
lIQPLOP         := $0306
lIGONE          := $0308
lIEVAL          := $030A
lIESCLK         := $030C
lIESCPR         := $030E
lIESCEX         := $0310
lITIME          := $0312
lICINV          := $0314
lICBINV         := $0316
lIOPEN          := $0318
lICLOSE         := $031A
lICHKIN         := $031C
lICHKOUT        := $031E
lICLRCHN        := $0320
lICHRIN         := $0322
lICHROUT        := $0324
lISTOP          := $0326
lIGETIN         := $0328
lICLALL         := $032A
lIUSRCMD        := $032C
lILOAD          := $032E
lISAVE          := $0330
lTAPBUF         := $0332
L0333           := $0333
WRLEN           := $03F3
RDCNT           := $03F5
ESTAKL          := $0437
ESTAKH          := $0455
CHRGET          := $0473
CHRGOT          := $0479
QNUM            := $0485
INDSUB          := $0494
ZERO            := $04A2
INDTXT          := $04A5
INDIN1          := $04B0
INDIN2          := $04BB
INDST1          := $04C6
INDLOW          := $04D1
INDFMO          := $04DC
PUFILL          := $04E7
PUCOMA          := $04E8
PUDOT           := $04E9
PUMONY          := $04EA
TMPDES          := $04EB
ERRNUM          := $04EF
ERRLIN          := $04F0
TRAPNO          := $04F2
TMPTRP          := $04F4
ERRTXT          := $04F5
OLDSTK          := $04F7
TMPTXT          := $04F8
TMPLIN          := $04FA
MTIMLO          := $04FC
MTIMHI          := $04FE
lIUSRPOK        := $0500
lIUSRADD        := $0501
RNDX            := $0503
DEJAVU          := $0508
LAT             := $0509
FAT             := $0513
SAT             := $051D
KEYD            := $0527
MEMSTR          := $0531
MSIZ            := $0533
TIMOUT          := $0535
FILEND          := $0536
CTALLY          := $0537
CBUFVA          := $0538
TPTR            := $0539
FLTYPE          := $053A
COLOR           := $053B
FLASH           := $053C
HIBASE          := $053E
XMAX            := $053F
RPTFLG          := $0540
KOUNT           := $0541
DELAY           := $0542
SHFLAG          := $0543
LSTSHF          := $0544
KEYLOG          := $0545
MODE            := $0547
AUTODN          := $0548
ROLFLG          := $054A
FORMAT          := $054B
MSAL            := $054C
WRAP            := $054F
TMPC            := $0550
DIFF            := $0551
PCH             := $0552
PCL             := $0553
FLGS            := $0554
ACC             := $0555
XR              := $0556
YR              := $0557
SP              := $0558
INVL            := $0559
INVH            := $055A
CMPFLG          := $055B
BAD             := $055C
KYNDX           := $055D
KEYIDX          := $055E
KEYBUF          := $055F
PKYBUF          := $0567
KDATA           := $05E7
KDYCMD          := $05E8
KDYNUM          := $05E9
KDYPRS          := $05EA
PAT             := $05EC
LNGJMP          := $05F0
FETARG          := $05F2
FETXRG          := $05F3
FETSRG          := $05F4
AREA            := $05F5
APECH           := $065E
STKTOP          := $06EC
WROUT           := $07B0
PARITY          := $07B1
TT1             := $07B2
TT3             := $07B3
RDBITS          := $07B5
ERRSP           := $07B6
FPERRS          := $07B7
DSAMP1          := $07B8
DSAMP2          := $07BA
ZCELL           := $07BC
SRECOV          := $07BE
DRECOV          := $07BF
TRSAVE          := $07C0
RDETMP          := $07C4
LDRSCN          := $07C5
CDERRM          := $07C6
VSAVE           := $07C7
T1PIPE          := $07C8
ENEXT           := $07CC
UOUTQ           := $07CD
UOUTFG          := $07CE
SOUTQ           := $07CF
SOUNFG          := $07D0
INQFPT          := $07D1
INQRPT          := $07D2
INQCNT          := $07D3
ASTAT           := $07D4
AINTMP          := $07D5
ALSTOP          := $07D6
ARSTOP          := $07D7
APRES           := $07D8
KLUDES          := $07D9
SCBOT           := $07E5
SCTOP           := $07E6
SCLF            := $07E7
SCRT            := $07E8
SCRDIS          := $07E9
INSFL           := $07EA
LSTCH           := $07EB
LOGSCR          := $07EC
TCOLOR          := $07ED
BITABL          := $07EE
SAREG           := $07F2
SXREG           := $07F3
SYREG           := $07F4
SPREG           := $07F5
LSTX            := $07F6
STPDSB          := $07F7
RAMROM          := $07F8
COLSW           := $07F9
FFRMSK          := $07FA
VMBMSK          := $07FB
LSEM            := $07FC
PALCNT          := $07FD
UNUSED          := $07FE
TEDATR          := $0800
VICSCN          := $0C00
BASBGN          := $1000
TEDATRHI        := $1800
TEDSCNHI        := $1C00
GRBASE          := $2000

 * = $8000 ; .org    $8000

L8000:  jmp     L8019

L8003:  jmp     L800A

L8006:  .byte   $00

L8007:  .TEXT   "CBM"

L800A:  jsr     kCLRCHN
        jsr     L8AD8
        sta     CHANNL
        jsr     LC7C9
        cli
L8016:  jmp     L867E

L8019:  jsr     L8117
        jsr     L802E
        jsr     L80C2
        jsr     LFCF4
        ldx     #$FB
        txs
        bne     L8016
L802A:  .addr   L9871
        .addr   L9471
L802E:  lda     #$4C
        sta     JMPER
        sta     lIUSRPOK
        lda     #$1C
        ldy     #$99
        sta     lIUSRADD
        sty     $0502
        ldx     #$03
L8041:  lda     L802A,x
        sta     ADRAY1,x
        dex
        bpl     L8041
        ldx     #$32
L804C:  lda     L8122,x
        sta     $0472,x
        dex
        bne     L804C
        stx     BITS
        stx     CHANNL
        stx     $18
        stx     TRCFLG
.if COMPILECOMPUTER < PLUS4_01
        stx     MVDFLG
        stx     AUTINC
        stx     $74
        stx     WIDTH
        stx     SCALEM
        stx     FILFLG
.fi
        stx     BASBGN
.if COMPILECOMPUTER >= PLUS4_01
        txa
        ldx     #$03
L8064:  sta     $72,x
        sta     BITCNT,x
        dex
        bne     L8064
        nop
        stx     RNDX
.fi
        inx
        stx     $01FD
        stx     $01FC
        ldx     COLOR
        stx     FG
        ldx     #$36
        stx     MC1
        ldx     #$19
        stx     TEMPPT
        ldx     #$01
        ldy     #$10
        stx     TXTTAB
        sty     $2C
        ldx     #$05
        stx     INDEX1
        lda     #$D0
        sta     CHRPAG
        ldx     #$02
L8097:  lda     $0532,x
        sta     $36,x
        sta     $32,x
        dex
        bne     L8097
L80A1:  ldy     #$00
L80A3:  lda     L8147,y
        sta     INDTXT,x
        inx
        iny
        cpy     #$0B
        bcc     L80A3
        ldy     INDEX1
        lda     L80BC,y
        sta     $049F,x
        dec     INDEX1
        bpl     L80A1
        rts

L80BC:  .byte   $64,$5F,$6F,$24,$22,$3B
L80C2:  lda     TXTTAB
        ldy     $2C
        jsr     L8923
        jsr     LFF4F
        .byte   $93,$0D
        .TEXT   " COMMODORE BASIC V3.5 "


        .byte   $00
        lda     MEMSIZ
        sec
        sbc     TXTTAB
        tax
        lda     $38
        sbc     $2C
        jsr     LA45F
        jsr     LFF4F
        .TEXT   " BYTES FREE"

        .byte   $0D,$00
        jmp     L8A7B

L8105:  .addr   IERROR
        .addr   IMAIN
        .addr   ICRNCH
        .addr   IQPLOP
        .addr   IGONE
        .addr   IEVAL
        .addr   IBASIC1
        .addr   IBASIC2
        .addr   IBASIC3
L8117:  ldx     #$11
L8119:  lda     L8105,x
        sta     lIERROR,x
        dex
        bpl     L8119
L8122:  rts

L8123:  inc     TXTPTR
        bne     L8129
        inc     $3C
L8129:  sei
        sta     TEDROMSEL
        ldy     #$00
        lda     (TXTPTR),y
        sta     TEDRAMSEL
        cli
        cmp     #$3A
        bcs     L8143
        cmp     #$20
        beq     L8123
        sec
        sbc     #$30
        sec
        sbc     #$D0
L8143:  rts

        sta     $049C
L8147:  sei
        sta     TEDROMSEL
        lda     (PDIR),y
        sta     TEDRAMSEL
        cli
        rts

        .byte   $00,$00,$00
L8155:  lda     #$43
        bne     L818B
L8159:  lda     #$4E
        bne     L818B
L815D:  lda     #$14
        bne     L818B
L8161:  lda     #$47
        bne     L818B
L8165:  lda     #$4E
        bne     L818B
L8169:  lda     #$5C
        bne     L818B
L816D:  lda     #$5F
        bne     L818B
L8171:  lda     #$3D
        bne     L818B
L8175:  lda     #$57
        bne     L818B
L8179:  lda     #$59
        bne     L818B
L817D:  lda     #$62
        bne     L818B
L8181:  lda     #$50
        bne     L818B
L8185:  lda     #$6C
        bne     L818B
L8189:  lda     #$5A
L818B:  jmp     INDSUB

        .TEXT   "EN"
        .byte   $C4
        .TEXT   "FO"
        .byte   $D2
        .TEXT   "NEX"
        .byte   $D4
        .TEXT   "DAT"
        .byte   $C1
        .TEXT   "INPUT"
        .byte   $A3
        .TEXT   "INPU"
        .byte   $D4
        .TEXT   "DI"
        .byte   $CD
        .TEXT   "REA"
        .byte   $C4
        .TEXT   "LE"
        .byte   $D4
        .TEXT   "GOT"
        .byte   $CF
        .TEXT   "RU"
        .byte   $CE
        .TEXT   "I"
        .byte   $C6
        .TEXT   "RESTOR"
        .byte   $C5
        .TEXT   "GOSU"
        .byte   $C2
        .TEXT   "RETUR"
        .byte   $CE
        .TEXT   "RE"
        .byte   $CD
        .TEXT   "STO"
        .byte   $D0
        .TEXT   "O"
        .byte   $CE
        .TEXT   "WAI"
        .byte   $D4
        .TEXT   "LOA"
        .byte   $C4
        .TEXT   "SAV"
        .byte   $C5
        .TEXT   "VERIF"
        .byte   $D9
        .TEXT   "DE"
        .byte   $C6
        .TEXT   "POK"
        .byte   $C5
        .TEXT   "PRINT"
        .byte   $A3
        .TEXT   "PRIN"
        .byte   $D4
        .TEXT   "CON"
        .byte   $D4
        .TEXT   "LIS"
        .byte   $D4
        .TEXT   "CL"
        .byte   $D2
        .TEXT   "CM"
        .byte   $C4
        .TEXT   "SY"
        .byte   $D3
        .TEXT   "OPE"
        .byte   $CE
        .TEXT   "CLOS"
        .byte   $C5
        .TEXT   "GE"
        .byte   $D4
        .TEXT   "NE"
        .byte   $D7
        .TEXT   "TAB"
        .byte   $A8
        .TEXT   "T"
        .byte   $CF
        .TEXT   "F"
        .byte   $CE
        .TEXT   "SPC"
        .byte   $A8
        .TEXT   "THE"
        .byte   $CE
        .TEXT   "NO"
        .byte   $D4
        .TEXT   "STE"
        .byte   $D0,$AB,$AD,$AA,$AF,$DE
        .TEXT   "AN"
        .byte   $C4
        .TEXT   "O"
        .byte   $D2,$BE,$BD,$BC
        .TEXT   "SG"
        .byte   $CE
        .TEXT   "IN"
        .byte   $D4
        .TEXT   "AB"
        .byte   $D3
        .TEXT   "US"
        .byte   $D2
        .TEXT   "FR"
        .byte   $C5
        .TEXT   "PO"
        .byte   $D3
        .TEXT   "SQ"
        .byte   $D2
        .TEXT   "RN"
        .byte   $C4
        .TEXT   "LO"
        .byte   $C7
        .TEXT   "EX"
        .byte   $D0
        .TEXT   "CO"
        .byte   $D3
        .TEXT   "SI"
        .byte   $CE
        .TEXT   "TA"
        .byte   $CE
        .TEXT   "AT"
        .byte   $CE
        .TEXT   "PEE"
        .byte   $CB
        .TEXT   "LE"
        .byte   $CE
        .TEXT   "STR"
        .byte   $A4
        .TEXT   "VA"
        .byte   $CC
        .TEXT   "AS"
        .byte   $C3
        .TEXT   "CHR"
        .byte   $A4
        .TEXT   "LEFT"
        .byte   $A4
        .TEXT   "RIGHT"
        .byte   $A4
        .TEXT   "MID"
        .byte   $A4
        .TEXT   "G"
        .byte   $CF
        .TEXT   "RG"
        .byte   $D2
        .TEXT   "RCL"
        .byte   $D2
        .TEXT   "RLU"
        .byte   $CD
        .TEXT   "JO"
        .byte   $D9
        .TEXT   "RDO"
        .byte   $D4
        .TEXT   "DE"
        .byte   $C3
        .TEXT   "HEX"
        .byte   $A4
        .TEXT   "ERR"
        .byte   $A4
        .TEXT   "INST"
        .byte   $D2
        .TEXT   "ELS"
        .byte   $C5
        .TEXT   "RESUM"
        .byte   $C5
        .TEXT   "TRA"
        .byte   $D0
        .TEXT   "TRO"
        .byte   $CE
        .TEXT   "TROF"
        .byte   $C6
        .TEXT   "SOUN"
        .byte   $C4
        .TEXT   "VO"
        .byte   $CC
        .TEXT   "AUT"
        .byte   $CF
        .TEXT   "PUDE"
        .byte   $C6
        .TEXT   "GRAPHI"
        .byte   $C3
        .TEXT   "PAIN"
        .byte   $D4
        .TEXT   "CHA"
        .byte   $D2
        .TEXT   "BO"
        .byte   $D8
        .TEXT   "CIRCL"
        .byte   $C5
        .TEXT   "GSHAP"
        .byte   $C5
        .TEXT   "SSHAP"
        .byte   $C5
        .TEXT   "DRA"
        .byte   $D7
        .TEXT   "LOCAT"
        .byte   $C5
        .TEXT   "COLO"
        .byte   $D2
        .TEXT   "SCNCL"
        .byte   $D2
        .TEXT   "SCAL"
        .byte   $C5
        .TEXT   "HEL"
        .byte   $D0
        .TEXT   "D"
        .byte   $CF
        .TEXT   "LOO"
        .byte   $D0
        .TEXT   "EXI"
        .byte   $D4
        .TEXT   "DIRECTOR"
        .byte   $D9
        .TEXT   "DSAV"
        .byte   $C5
        .TEXT   "DLOA"
        .byte   $C4
        .TEXT   "HEADE"
        .byte   $D2
        .TEXT   "SCRATC"
        .byte   $C8
        .TEXT   "COLLEC"
        .byte   $D4
        .TEXT   "COP"
        .byte   $D9
        .TEXT   "RENAM"
        .byte   $C5
        .TEXT   "BACKU"
        .byte   $D0
        .TEXT   "DELET"
        .byte   $C5
        .TEXT   "RENUMBE"
        .byte   $D2
        .TEXT   "KE"
        .byte   $D9
        .TEXT   "MONITO"
        .byte   $D2
        .TEXT   "USIN"
        .byte   $C7
        .TEXT   "UNTI"
        .byte   $CC
        .TEXT   "WHIL"
        .byte   $C5,$00
L8383:  .word   L8CDA-1,LADCA-1,L9294-1,L8DB0-1
        .word   L90EE-1,L9108-1,L969B-1,L914F-1
        .word   L8E7C-1,L8D4D-1,L8BBC-1,L8DE1-1
        .word   L8C9A-1,L8D2C-1,L8D83-1,L8E0B-1
        .word   L8CD8-1,L8E1B-1,L9E6A-1,LA7F3-1
        .word   LA7DE-1,LA7F0-1,L9A9D-1,L9E12-1
        .word   L8FE0-1,L9000-1,L8D03-1,L8AFF-1
        .word   L8A98-1,L8FE6-1,LA7B5-1,LA84D-1
        .word   LA85A-1,L90B8-1,L8A79-1,L8E0B-1
        .word   LB440-1,LB42B-1,LB652-1,LB655-1
        .word   LB849-1,LB8BD-1,LB6CD-1,LB544-1
        .word   LC5C3-1,LB8D1-1,LB9D4-1,LBAE2-1
        .word   LC01E-1,LBD35-1,LBE29-1,LC4D9-1
        .word   LC50F-1,LC51A-1,LC567-1,LC5B8-1
        .word   LB6E8-1,LB557-1,LB603-1,LB5AC-1
        .word   LC8BC-1,LC941-1,LC951-1,LC968-1
        .word   LC99C-1,LC9CC-1,LC9DA-1,LC9F4-1
        .word   LCA00-1,LAE5A-1,LAB8F-1,LB729-1
        .word   kMLMONITOR-1

L8415:  .word   LA2BE,LA358,LA2DD
        .word   lIUSRPOK,L9A62,L9A7D,LA5E4
        .word   LA707,LA01E,LA660,LAA70
        .word   LAA77,LAAC0,LAB1A,L9DFA
        .word   L9D61,L9B66,L9D93,L9D70
        .word   L9CBB,L9CCF,L9D03,L9D15
        .word   LBF79,LBF85,LBF87,LBFC1
        .word   LBFFD,L9E1B,LB507,LB4BE

L8453:  .byte   $79
L8454:  .word   L9E9E-1
        .byte   $79
        .word   L9E87-1
        .byte   $7B
        .word   LA07B-1
        .byte   $7B
        .word   LA197-1
        .byte   $7F
        .word   LA5EE-1
        .byte   $50
        .word   L95FB-1
        .byte   $46
        .word   L95F8-1
        .byte   $7D
        .word   LA627-1
        .byte   $5A
        .word   L9465-1
        .byte   $64
        .word   L9628-1

        .TEXT   "TOO MANY FILE"

        .byte   $D3
        .TEXT   "FILE OPE"
        .byte   $CE
        .TEXT   "FILE NOT OPE"

        .byte   $CE
        .TEXT   "FILE NOT FOUN"

        .byte   $C4
        .TEXT   "DEVICE NOT PRESEN"


        .byte   $D4
        .TEXT   "NOT INPUT FIL"

        .byte   $C5
        .TEXT   "NOT OUTPUT FIL"

        .byte   $C5
        .TEXT   "MISSING FILE NAM"

        .byte   $C5
.if COMPILECOMPUTER == PLUS4_BETA_0203
        .TEXT   "IHLEGAL DEVICE NUMBE"
.else
        .TEXT   "ILLEGAL DEVICE NUMBE"
.fi


        .byte   $D2
        .TEXT   "NEXT WITHOUT FO"

        .byte   $D2
        .TEXT   "SYNTA"
        .byte   $D8
        .TEXT   "RETURN WITHOUT GOSU"


        .byte   $C2
        .TEXT   "OUT OF DAT"

        .byte   $C1
        .TEXT   "ILLEGAL QUANTIT"

        .byte   $D9
        .TEXT   "OVERFLO"
        .byte   $D7
        .TEXT   "OUT OF MEMOR"

        .byte   $D9
        .TEXT   "UNDEF'D STATEMEN"

        .byte   $D4
        .TEXT   "BAD SUBSCRIP"

        .byte   $D4
        .TEXT   "REDIM'D ARRA"

        .byte   $D9
        .TEXT   "DIVISION BY ZER"

        .byte   $CF
        .TEXT   "ILLEGAL DIREC"

        .byte   $D4
        .TEXT   "TYPE MISMATC"

        .byte   $C8
        .TEXT   "STRING TOO LON"

        .byte   $C7
        .TEXT   "FILE DAT"
        .byte   $C1
        .TEXT   "FORMULA TOO COMPLE"


        .byte   $D8
        .TEXT   "CAN'T CONTINU"

        .byte   $C5
        .TEXT   "UNDEF'D FUNCTIO"

        .byte   $CE
        .TEXT   "VERIF"
        .byte   $D9
        .TEXT   "LOA"
        .byte   $C4
        .TEXT   "BREAK"
        .byte   $00,$A0
        .TEXT   "CAN'T RESUM"

        .byte   $C5
        .TEXT   "LOOP NOT FOUN"

        .byte   $C4
        .TEXT   "LOOP WITHOUT D"

        .byte   $CF
        .TEXT   "DIRECT MODE ONL"

        .byte   $D9
        .TEXT   "NO GRAPHICS ARE"

        .byte   $C1
        .TEXT   "BAD DIS"
        .byte   $CB
L8653:  tax
        ldy     #$00
        lda     #$71
        sta     INDEX2
        lda     #$84
        sta     $25
L865E:  dex
        bmi     L867D
L8661:  lda     (INDEX2),y
        pha
        inc     INDEX2
        bne     L866A
        inc     $25
L866A:  pla
        bpl     L8661
        bmi     L865E
L866F:  jsr     LFF4F
        .byte   $0D,$0A
        .TEXT   "READY."
        .byte   $0D,$0A,$00
L867D:  rts

L867E:  ldx     #$80
        .byte   $2C
L8681:  ldx     #$10
L8683:  jmp     (lIERROR)

IERROR: txa
        bmi     L8703
        stx     ERRNUM
        bit     RUNMOD
        bpl     L86C5
        ldy     #$01
L8692:  lda     CHRLIN,y
        sta     ERRLIN,y
        lda     OLDTXT,y
        sta     ERRTXT,y
        dey
        bpl     L8692
        cpx     #$11
        beq     L86C5
        ldy     $04F3
        iny
        beq     L86C5
        dey
        sty     $15
        sty     TMPTRP
        ldy     TRAPNO
        sty     LINNUM
        ldx     #$FF
        stx     $04F3
        ldx     OLDSTK
        txs
        jsr     L8D69
        jmp     L8BDC

L86C5:  dex
        txa
        pha
        lda     #$00
        sta     GRAPHM
        jsr     LC7C9
        pla
        jsr     L8653
        jsr     kCLRCHN
        lda     #$00
        sta     CHANNL
        jsr     L903E
        jsr     L90B0
        ldy     #$00
L86E2:  lda     (INDEX2),y
        pha
        and     #$7F
        jsr     L90B2
        iny
        pla
        bpl     L86E2
        jsr     L8AD8
        jsr     LFF4F
        .TEXT   " ERROR"
        .byte   $00
L86FB:  ldy     $3A
        iny
        beq     L8703
        jsr     LA453
L8703:  jsr     L866F
        lda     #$80
        jsr     kSETMSF
        lda     #$00
        sta     RUNMOD
L870F:  jmp     (lIMAIN)

IMAIN:
.if COMPILECOMPUTER >= PLUS4_01
        ldx     #$FF
        stx     $3A
.fi
        jsr     L885A
        stx     TXTPTR
        sty     $3C
        jsr     CHRGET
        tax
L8721:  beq     L870F
.if COMPILECOMPUTER < PLUS4_01
        ldx     #$FF
        stx     $3A
.fi
        bcc     L872E
        jsr     L8953
        jsr     CHRGOT
        jmp     L8BD9

L872E:  jsr     L8E3E
        jsr     L8953
        sty     COUNT
        jsr     L8A3D
        bcc     L8785
        ldy     #$01
        jsr     INDLOW
        sta     $23
        lda     VARTAB
        sta     INDEX1
        lda     $60
        sta     $25
        dey
        jsr     INDLOW
        clc
        sbc     $5F
        eor     #$FF
        clc
        adc     VARTAB
        sta     VARTAB
        sta     INDEX2
        lda     $2E
        adc     #$FF
        sta     $2E
        sbc     $60
        tax
        sec
        lda     $5F
        sbc     VARTAB
        tay
        bcs     L876E
        inx
        dec     $25
L876E:  clc
        adc     INDEX1
        bcc     L8776
        dec     $23
        clc
L8776:  jsr     INDIN1
        sta     (INDEX2),y
        iny
        bne     L8776
        inc     $23
        inc     $25
        dex
        bne     L8776
L8785:  jsr     L8A9A
        jsr     L8818
        ldy     #$00
        jsr     INDTXT
        beq     L8721
        clc
        lda     VARTAB
        ldy     $2E
        sta     $5A
        sty     $5B
        adc     COUNT
        bcc     L87A0
        iny
L87A0:  clc
        adc     #$04
        bcc     L87A6
        iny
L87A6:  sta     $58
        sty     $59
        jsr     L88C0
        ldy     #$00
        lda     #$01
        sta     ($5F),y
        iny
        sta     ($5F),y
        iny
        lda     LINNUM
        sta     ($5F),y
        lda     $15
        iny
        sta     ($5F),y
        iny
        tya
        clc
        adc     $5F
        sta     $5F
        bcc     L87CB
        inc     $60
L87CB:  lda     STREND
        ldy     $32
        sta     VARTAB
        sty     $2E
        ldy     COUNT
        dey
L87D6:  jsr     INDTXT
        sta     ($5F),y
        dey
        bpl     L87D6
        jsr     L8818
        jsr     L8A93
        lda     AUTINC
        ora     $74
        beq     L8815
        lda     LINNUM
        clc
        adc     AUTINC
        sta     $63
        lda     $15
        adc     $74
        sta     FACH0
        ldx     #$90
        sec
        jsr     LA2CE
        jsr     LA46F
        ldx     #$00
L8802:  lda     $0101,x
        beq     L880D
        sta     KEYD,x
        inx
        bne     L8802
L880D:  lda     #$1D
        sta     KEYD,x
        inx
        stx     NDX
L8815:  jmp     L870F

L8818:  lda     TXTTAB
        ldy     $2C
        sta     INDEX1
        sty     $23
        clc
L8821:  ldy     #$00
        jsr     INDIN1
        bne     L882E
        iny
        jsr     INDIN1
        beq     L8859
L882E:  ldy     #$04
L8830:  iny
        jsr     INDIN1
        bne     L8830
        iny
        tya
        adc     INDEX1
        tax
        ldy     #$00
        sta     (INDEX1),y
        tya
        adc     $23
        iny
        sta     (INDEX1),y
        stx     INDEX1
        sta     $23
        bcc     L8821
L884B:  clc
        lda     INDEX1
        ldy     $23
        adc     #$02
        bcc     L8855
        iny
L8855:  sta     VARTAB
        sty     $2E
L8859:  rts

L885A:  ldx     #$00
L885C:  jsr     LA791
        cmp     #$0D
        beq     L886E
        sta     BUF,x
        inx
        cpx     #$59
        bcc     L885C
        jmp     LCC4C

L886E:  jmp     L9031

L8871:  jsr     LA760
L8874:  lda     FNDPNT
        cmp     #$B0
        bne     L8880
        lda     $3E
        cmp     #$07
        beq     L88BD
L8880:  ldy     #$00
        lda     SRCHTK
        cmp     #$81
        bne     L88A3
        cmp     (FNDPNT),y
        bne     L88BF
        ldy     #$02
        lda     $4A
        cmp     #$FF
        beq     L88BF
        cmp     (FNDPNT),y
        bne     L889F
        dey
        lda     FORPNT
        cmp     (FNDPNT),y
        beq     L88BF
L889F:  ldx     #$12
        bne     L88B1
L88A3:  lda     (FNDPNT),y
        cmp     SRCHTK
        beq     L88BF
        ldx     #$12
        cmp     #$81
        beq     L88B1
        ldx     #$05
L88B1:  txa
        clc
        adc     FNDPNT
        sta     FNDPNT
        bcc     L8874
        inc     $3E
        bne     L8874
L88BD:  ldy     #$01
L88BF:  rts

L88C0:  jsr     L8923
        sta     STREND
        sty     $32
        sec
        lda     $5A
        sbc     $5F
        sta     INDEX1
        tay
        lda     $5B
        sbc     $60
        tax
        inx
        tya
        beq     L88FD
        lda     $5A
        sec
        sbc     INDEX1
        sta     $5A
        bcs     L88E4
        dec     $5B
        sec
L88E4:  lda     $58
        sbc     INDEX1
        sta     $58
        bcs     L88F5
        dec     $59
        bcc     L88F5
L88F0:  jsr     L8189
        sta     ($58),y
L88F5:  dey
        bne     L88F0
        jsr     L8189
        sta     ($58),y
L88FD:  dec     $5B
        dec     $59
        dex
        bne     L88F5
        rts

L8905:  sty     SYREG
        sec
        lda     TOS
        sbc     SYREG
        sta     TOS
        lda     $7D
        sbc     #$00
        sta     $7D
        cmp     #$06
        bcc     L8950
        bne     L8922
        lda     TOS
        cmp     #$EC
        bcc     L8950
L8922:  rts

L8923:  cpy     $34
        bcc     L894F
        bne     L892D
        cmp     FRETOP
        bcc     L894F
L892D:  pha
        ldx     #$09
        tya
L8931:  pha
        lda     TEMPF1,x
        dex
        bpl     L8931
        jsr     LA954
        ldx     #$F7
L893C:  pla
        sta     FACEXP,x
        inx
        bmi     L893C
        pla
        tay
        pla
        cpy     $34
        bcc     L894F
        bne     L8950
        cmp     FRETOP
        bcs     L8950
L894F:  rts

L8950:  jmp     L8681

L8953:  jmp     (lICRNCH)

ICRNCH: lda     TXTPTR
        pha
        lda     $3C
        pha
L895C:  jsr     CHRGOT
        jmp     L8965

L8962:  jsr     CHRGET
L8965:  bcc     L8962
        jmp     (lIESCLK)

IBASIC1:bcc     L89D4
        cmp     #$00
        beq     L89C5
        cmp     #$3A
        beq     L8962
        cmp     #$3F
        bne     L897C
        lda     #$99
        bne     L89AA
L897C:  cmp     #$80
        bcc     L898B
        cmp     #$FF
        beq     L8962
        ldy     #$01
        jsr     L89EA
        beq     L895C
L898B:  cmp     #$22
        bne     L899C
L898F:  jsr     CHRGET
        cmp     #$00
        beq     L89C5
        cmp     #$22
        beq     L8962
        bne     L898F
L899C:  jsr     L8A03
        bcc     L8962
        cpy     #$00
        beq     L89A8
        jsr     L89EA
L89A8:  lda     COUNT
L89AA:  ldy     #$00
        sta     (TXTPTR),y
        cmp     #$8F
        beq     L89BF
        cmp     #$83
        bne     L8962
        jsr     CHRGET
        jsr     L8DB0
        jmp     L895C

L89BF:  jsr     CHRGET
        jsr     L8E0B
L89C5:  ldx     TXTPTR
        pla
        sta     $3C
        pla
        sta     TXTPTR
        sec
        txa
        sbc     TXTPTR
        tay
        iny
        rts

L89D4:  pha
        dey
        dey
        jsr     L89EA
        ldy     #$00
        lda     #$FE
        sta     (TXTPTR),y
        iny
        pla
        sta     (TXTPTR),y
        jsr     CHRGET
        jmp     L8962

L89EA:  clc
        tya
        adc     TXTPTR
        sta     INDEX1
        lda     $3C
        adc     #$00
        sta     $23
        ldy     #$00
L89F8:  jsr     INDIN1
        sta     (TXTPTR),y
        iny
        cmp     #$00
        bne     L89F8
        rts

L8A03:  lda     #$81
        ldy     #$8E
        sta     $23
        sty     INDEX1
        ldy     #$00
        sty     COUNT
        dey
L8A10:  iny
L8A11:  jsr     INDTXT
        sec
        sbc     (INDEX1),y
        beq     L8A10
        cmp     #$80
        beq     L8A38
L8A1D:  lda     (INDEX1),y
        bmi     L8A24
        iny
        bne     L8A1D
L8A24:  iny
        inc     COUNT
        clc
        tya
        adc     INDEX1
        sta     INDEX1
        bcc     L8A31
        inc     $23
L8A31:  clc
        ldy     #$00
        lda     (INDEX1),y
        bne     L8A11
L8A38:  ora     COUNT
        sta     COUNT
        rts

L8A3D:  lda     TXTTAB
        ldx     $2C
L8A41:  ldy     #$01
        sta     $5F
        stx     $60
        jsr     INDLOW
        beq     L8A77
        iny
        iny
        jsr     INDLOW
        sta     $78
        lda     $15
        cmp     $78
        bcc     L8A78
        beq     L8A5E
        dey
        bne     L8A6C
L8A5E:  dey
        jsr     INDLOW
        sta     $78
        lda     LINNUM
        cmp     $78
        bcc     L8A78
        beq     L8A78
L8A6C:  dey
        jsr     INDLOW
        tax
        dey
        jsr     INDLOW
        bcs     L8A41
L8A77:  clc
L8A78:  rts

L8A79:  bne     L8A78
L8A7B:  lda     #$00
        tay
        sta     (TXTTAB),y
        iny
        sta     (TXTTAB),y
        sta     TRCFLG
        lda     TXTTAB
        clc
        adc     #$02
        sta     VARTAB
        lda     $2C
        adc     #$00
        sta     $2E
L8A93:  jsr     L8AF1
        lda     #$00
L8A98:  bne     L8AEC
L8A9A:  jsr     kCLALL
        ldy     #$00
        sty     DSDESC
        dey
        sty     $04F3
        sty     ERRLIN
        sty     $04F1
        sty     ERRNUM
        lda     MEMSIZ
        ldy     $38
        sta     FRETOP
        sty     $34
        lda     #$B0
        ldy     #$07
        sta     TOS
        sty     $7D
        lda     VARTAB
        ldy     $2E
        sta     ARYTAB
        sty     $30
        sta     STREND
        sty     $32
        ldx     #$03
L8ACC:  lda     L8AED,x
        sta     PUFILL,x
        dex
        bpl     L8ACC
L8AD5:  jsr     L8CB1
L8AD8:  ldx     #$19
        stx     TEMPPT
        pla
        tay
        pla
        ldx     #$FA
        txs
        pha
        tya
        pha
        lda     #$00
        sta     $025C
        sta     SUBFLG
L8AEC:  rts

L8AED:  .TEXT   " ,.$"
L8AF1:  clc
        lda     TXTTAB
        adc     #$FF
        sta     TXTPTR
        lda     $2C
        adc     #$FF
        sta     $3C
        rts

L8AFF:  jsr     LAECA
L8B02:  ldy     #$01
        jsr     INDLOW
        bne     L8B0F
        dey
        jsr     INDLOW
        beq     L8B3D
L8B0F:  jsr     L8CC0
        jsr     L903E
        ldy     #$02
        jsr     INDLOW
        tax
        iny
        jsr     INDLOW
        cmp     $15
        bne     L8B27
        cpx     LINNUM
        beq     L8B29
L8B27:  bcs     L8B3D
L8B29:  jsr     L8B40
        ldy     #$00
        jsr     INDLOW
        tax
        iny
        jsr     INDLOW
        stx     $5F
        sta     $60
        jmp     L8B02

L8B3D:  jmp     L903E

L8B40:  ldy     #$03
        sty     FORPNT
        sty     DORES
        jsr     LA45F
        lda     #$20
L8B4B:  ldy     FORPNT
        and     #$7F
L8B4F:  jsr     L90B2
        cmp     #$22
        bne     L8B5C
        lda     DORES
        eor     #$FF
        sta     DORES
L8B5C:  iny
        beq     L8B3D
        bit     HELPER
        bpl     L8B66
        jsr     LB70C
L8B66:  jsr     INDLOW
        beq     L8BBB
        jmp     (lIQPLOP)

IQPLOP: bpl     L8B4F
        cmp     #$FF
        beq     L8B4F
        bit     DORES
        bmi     L8B4F
        cmp     #$FE
        bne     L8B93
        iny
        jsr     INDLOW
        beq     L8B8E
        sty     FORPNT
        sec
        jmp     (lIESCPR)

IBASIC2:bcs     L8B4F
        ldy     #$00
        beq     L8BB2
L8B8E:  dey
        lda     #$FE
        bne     L8B4F
L8B93:  tax
        sty     FORPNT
        ldy     #$81
        sty     $23
        ldy     #$8E
        sty     INDEX1
        ldy     #$00
L8BA0:  dex
        bpl     L8BB2
L8BA3:  lda     (INDEX1),y
        pha
        inc     INDEX1
        bne     L8BAC
        inc     $23
L8BAC:  pla
        bpl     L8BA3
        bmi     L8BA0
L8BB1:  iny
L8BB2:  lda     (INDEX1),y
        bmi     L8B4B
        jsr     L90B2
        bne     L8BB1
L8BBB:  rts

L8BBC:  bne     L8BC4
        jsr     L8D20
        jmp     L8A93

L8BC4:  jsr     L8A9A
        jsr     CHRGOT
        jsr     L8D4D
        jsr     L8D20
        jmp     L8BDC

L8BD3:  jmp     (lIGONE)

IGONE:  jsr     CHRGET
L8BD9:  jsr     L8C25
L8BDC:  jsr     L8CC0
        bit     RUNMOD
        bpl     L8BEA
        jsr     L8C1A
        tsx
        stx     OLDSTK
L8BEA:  ldy     #$00
        jsr     INDTXT
        beq     L8BF4
        jmp     L8C93

L8BF4:  bit     RUNMOD
        bpl     L8C17
        ldy     #$02
        jsr     INDTXT
        beq     L8C17
        iny
        jsr     INDTXT
        sta     CHRLIN
        iny
        jsr     INDTXT
        sta     $3A
        tya
        clc
        adc     TXTPTR
        sta     TXTPTR
        bcc     L8BD3
        inc     $3C
        bne     L8BD3
L8C17:  jmp     L867E

L8C1A:  lda     TXTPTR
        ldy     $3C
        sta     OLDTXT
        sty     $025C
L8C24:  rts

L8C25:  beq     L8C24
        bit     TRCFLG
        bpl     L8C3F
        bit     RUNMOD
        bpl     L8C3F
        pha
        lda     #$5B
        jsr     L90B2
        jsr     LA45B
        lda     #$5D
        jsr     L90B2
        pla
L8C3F:  cmp     #$FE
        beq     L8C82
        cmp     #$CB
        beq     L8C74
        cmp     #$CA
        beq     L8C6B
        cmp     #$FB
        bcs     L8C8D
        cmp     #$A3
        bcc     L8C59
        cmp     #$D5
        bcc     L8C8D
        sbc     #$32
L8C59:  sec
        sbc     #$80
        bcc     L8C90
        asl     a
        tay
        lda     L8383+1,y
        pha
        lda     L8383,y
        pha
        jmp     CHRGET

L8C6B:  lda     #$B6
        pha
        lda     #$5A
        pha
L8C71:  jmp     CHRGET

L8C74:  jsr     CHRGET
        cmp     #$A4
        bne     L8C8D
        jsr     CHRGET
        jmp     L8D4D

.if COMPILECOMPUTER >= PLUS4_BETA_0203
        .byte   $00
.else
        .byte   $37
.fi
L8C82:  jsr     CHRGET
        beq     L8C8D
        sec
        jmp     (lIESCEX)

IBASIC3:bcc     L8C71
L8C8D:  jmp     L94A1

L8C90:  jmp     L8E7C

L8C93:  cmp     #$3A
        bne     L8C8D
        jmp     L8BD3

L8C9A:  beq     L8CB1
        jsr     L9DE1
        sty     LINNUM
        sta     $15
        jsr     L8A3D
        bcs     L8CAB
        jmp     L8D8F

L8CAB:  lda     $5F
        ldy     $60
        bcs     L8CB6
L8CB1:  sec
        lda     TXTTAB
        ldy     $2C
L8CB6:  sbc     #$01
        bcs     L8CBB
        dey
L8CBB:  sta     DATPTR
        sty     $42
L8CBF:  rts

L8CC0:  jsr     kSTOP
        bne     L8CBF
        php
        ldy     $04F3
        iny
        beq     L8CD7
L8CCC:  jsr     kSTOP
        beq     L8CCC
        plp
        ldx     #$1E
        jmp     L8683

L8CD7:  plp
L8CD8:  bcs     L8CDB
L8CDA:  clc
L8CDB:  bne     L8CBF
        bit     RUNMOD
        bpl     L8CEE
        jsr     L8C1A
        lda     CHRLIN
        ldy     $3A
        sta     OLDLIN
        sty     $025A
L8CEE:  pla
        pla
        bcc     L8D00
        jsr     LFF4F
        .byte   $0D,$0A
        .TEXT   "BREAK"
        .byte   $00
        jmp     L86FB

L8D00:  jmp     L867E

L8D03:  bne     L8CBF
        ldx     #$1A
        ldy     $025C
        bne     L8D0F
        jmp     L8683

L8D0F:  lda     OLDTXT
        sta     TXTPTR
        sty     $3C
        lda     OLDLIN
        ldy     $025A
        sta     CHRLIN
        sty     $3A
L8D20:  lda     #$80
        sta     RUNMOD
        asl     a
        sta     AUTINC
        sta     $74
        jmp     kSETMSF

L8D2C:  ldy     #$05
        jsr     L8905
        dey
        lda     $3C
        sta     (TOS),y
        dey
        lda     TXTPTR
        sta     (TOS),y
        dey
        lda     $3A
        sta     (TOS),y
        dey
        lda     CHRLIN
        sta     (TOS),y
        dey
        lda     #$8D
        sta     (TOS),y
        jsr     CHRGOT
L8D4D:  jsr     L8E3E
        jsr     L8DC1
        sec
        lda     CHRLIN
        sbc     LINNUM
        lda     $3A
        sbc     $15
        bcs     L8D69
        tya
        sec
        adc     TXTPTR
        ldx     $3C
        bcc     L8D6D
        inx
        bcs     L8D6D
L8D69:  lda     TXTTAB
        ldx     $2C
L8D6D:  jsr     L8A41
        bcc     L8D8F
        lda     $5F
        sbc     #$01
        sta     TXTPTR
        lda     $60
        sbc     #$00
        sta     $3C
        bit     RUNMOD
        bpl     L8D20
        rts

L8D83:  lda     #$8D
        sta     SRCHTK
        jsr     L8871
        beq     L8D94
        ldx     #$0C
        .byte   $2C
L8D8F:  ldx     #$11
        jmp     L8683

L8D94:  jsr     LA769
        ldy     #$05
        jsr     LA772
        dey
        lda     (FNDPNT),y
        sta     $3C
        dey
        lda     (FNDPNT),y
        sta     TXTPTR
        dey
        lda     (FNDPNT),y
        jsr     LCD7F
        lda     (FNDPNT),y
        sta     CHRLIN
L8DB0:  jsr     L8DBE
L8DB3:  tya
        clc
        adc     TXTPTR
        sta     TXTPTR
        bcc     L8DBD
        inc     $3C
L8DBD:  rts

L8DBE:  ldx     #$3A
        .byte   $2C
L8DC1:  ldx     #$00
        stx     CHARAC
        ldy     #$00
        sty     ENDCHR
L8DC9:  lda     ENDCHR
        ldx     CHARAC
        sta     CHARAC
        stx     ENDCHR
L8DD1:  jsr     INDTXT
        beq     L8DBD
        cmp     ENDCHR
        beq     L8DBD
        iny
        cmp     #$22
        bne     L8DD1
        beq     L8DC9
L8DE1:  jsr     L932C
        jsr     CHRGOT
        cmp     #$89
        beq     L8DF0
        lda     #$A7
        jsr     L9493
L8DF0:  lda     FACEXP
        bne     L8E10
L8DF4:  jsr     L8DB0
        ldy     #$00
        jsr     INDTXT
        beq     L8E0B
        jsr     CHRGET
        cmp     #$D5
        bne     L8DF4
        jsr     CHRGET
        jmp     L8E10

L8E0B:  jsr     L8DC1
        beq     L8DB3
L8E10:  jsr     CHRGOT
        bcs     L8E18
        jmp     L8D4D

L8E18:  jmp     L8C25

L8E1B:  jsr     L9D84
        pha
        cmp     #$8D
        beq     L8E2A
L8E23:  cmp     #$89
        beq     L8E2A
        jmp     L94A1

L8E2A:  dec     $65
        bne     L8E32
        pla
        jmp     L8C3F

L8E32:  jsr     CHRGET
        jsr     L8E3E
        cmp     #$2C
        beq     L8E2A
        pla
L8E3D:  rts

L8E3E:  ldx     #$00
        stx     ENDCHR
        stx     LINNUM
        stx     $15
L8E46:  bcs     L8E3D
        inc     ENDCHR
        sbc     #$2F
        sta     CHARAC
        lda     $15
        sta     INDEX1
        cmp     #$19
        bcs     L8E23
        lda     LINNUM
        asl     a
        rol     INDEX1
        asl     a
        rol     INDEX1
        adc     LINNUM
        sta     LINNUM
        lda     INDEX1
        adc     $15
        sta     $15
        asl     LINNUM
        rol     $15
        lda     LINNUM
        adc     CHARAC
        sta     LINNUM
        bcc     L8E76
        inc     $15
L8E76:  jsr     CHRGET
        jmp     L8E46

L8E7C:  jsr     L96A5
        sta     FORPNT
        sty     $4A
        lda     #$B2
        jsr     L9493
        lda     INTFLG
        pha
        lda     VALTYP
        pha
        jsr     L932C
        pla
        rol     a
        jsr     L931B
        bne     L8EB0
        pla
L8E99:  bpl     L8EAD
        jsr     LA2A0
        jsr     L9886
        ldy     #$00
        lda     $64
        sta     (FORPNT),y
        iny
        lda     $65
        sta     (FORPNT),y
        rts

L8EAD:  jmp     LA255

L8EB0:  pla
L8EB1:  ldy     $4A
        cpy     #$04
        bne     L8F29
        jsr     L9C4E
        cmp     #$06
        bne     L8EFC
        ldy     #$00
        sty     FACEXP
        sty     FACSGN
L8EC4:  sty     FBUFPT
        jsr     L8EF4
        jsr     LA162
        inc     FBUFPT
        ldy     FBUFPT
        jsr     L8EF4
        jsr     LA291
        tax
        beq     L8EDE
        inx
        txa
        jsr     LA16D
L8EDE:  ldy     FBUFPT
        iny
        cpy     #$06
        bne     L8EC4
        jsr     LA162
        jsr     LA327
        ldx     $64
        ldy     $63
        lda     $65
        jmp     kSETTIM

L8EF4:  jsr     INDIN1
        jsr     QNUM
        bcc     L8EFF
L8EFC:  jmp     L991C

L8EFF:  sbc     #$2F
        jmp     LA40A

L8F04:  pla
        iny
L8F06:  cmp     $34
        bcc     L8F22
        bne     L8F14
        dey
        jsr     INDFMO
        cmp     FRETOP
        bcc     L8F22
L8F14:  ldy     $65
        cpy     $2E
        bcc     L8F22
        bne     L8F40
        lda     $64
        cmp     VARTAB
        bcs     L8F40
L8F22:  lda     $64
        ldy     $65
        jmp     L8F5E

L8F29:  ldy     #$02
        jsr     INDFMO
        cmp     $7B
        bne     L8F06
        pha
        dey
        jsr     INDFMO
        cmp     $7A
        bne     L8F04
        lda     DSDESC
        beq     L8F04
        pla
L8F40:  ldy     #$00
        jsr     INDFMO
        jsr     L9B54
        lda     DSCPNT
        ldy     $51
        sta     ARISGN
        sty     FACOV
        jsr     L9C1B
        lda     ARISGN
        ldy     FACOV
        jsr     L9CAA
        lda     #$61
        ldy     #$00
L8F5E:  sta     DSCPNT
        sty     $51
        sta     INDEX1
        sty     $23
        jsr     L9CAA
        jsr     L8F9C
        bcc     L8F79
        ldy     #$00
        lda     FORPNT
        sta     (INDEX1),y
        iny
        lda     $4A
        sta     (INDEX1),y
L8F79:  lda     FORPNT
        sta     INDEX1
        lda     $4A
        sta     $23
        jsr     L8F9C
        bcc     L8F8F
        dey
        lda     #$FF
        sta     (INDEX1),y
        dey
        txa
        sta     (INDEX1),y
L8F8F:  ldy     #$02
L8F91:  lda     #$50
        jsr     INDSUB
        sta     (FORPNT),y
        dey
        bpl     L8F91
        rts

L8F9C:  ldy     #$00
        jsr     INDIN1
        pha
        beq     L8FDD
        iny
        jsr     INDIN1
        tax
        iny
        jsr     INDIN1
        cmp     $38
        bcc     L8FB7
        bne     L8FDD
        cpx     MEMSIZ
        bcs     L8FDD
L8FB7:  jsr     INDIN1
        cmp     $34
        bcc     L8FDD
        bne     L8FC4
        cpx     FRETOP
        bcc     L8FDD
L8FC4:  cmp     $7B
        bne     L8FCC
        cpx     $7A
        beq     L8FDD
L8FCC:  stx     INDEX1
        sta     $23
        pla
        tax
        clc
        adc     INDEX1
        sta     INDEX1
        bcc     L8FDB
        inc     $23
L8FDB:  sec
        rts

L8FDD:  pla
        clc
        rts

L8FE0:  jsr     L8FE6
        jmp     L90FE

L8FE6:  jsr     L9D84
        beq     L8FF0
        lda     #$2C
        jsr     L9493
L8FF0:  php
        stx     CHANNL
        jsr     LA797
        plp
        jmp     L9000

L8FFA:  jsr     L908B
L8FFD:  jsr     CHRGOT
L9000:  beq     L903E
        cmp     #$FB
        bne     L9009
        jmp     LAEF7

L9009:  beq     L904E
        cmp     #$A3
        beq     L905F
        cmp     #$A6
        clc
        beq     L905F
        cmp     #$2C
        beq     L904F
        cmp     #$3B
        beq     L907A
        jsr     L932C
        bit     VALTYP
        bmi     L8FFA
        jsr     LA46F
        jsr     L9B74
        jsr     L908B
        jsr     L90A6
        bne     L8FFD
L9031:  lda     #$00
        sta     BUF,x
        ldx     #$FF
        ldy     #$01
        lda     CHANNL
        bne     L904E
L903E:  lda     #$0D
        jsr     L90B2
        bit     CHANNL
        bpl     L904C
        lda     #$0A
        jsr     L90B2
L904C:  eor     #$FF
L904E:  rts

L904F:  sec
        jsr     kPLOT
        tya
        sec
L9055:  sbc     #$0A
        bcs     L9055
        eor     #$FF
        adc     #$01
        bne     L9075
L905F:  php
        sec
        jsr     kPLOT
        sty     TRMPOS
        jsr     L9D81
        cmp     #$29
        bne     L9080
        plp
        bcc     L9076
        txa
        sbc     TRMPOS
        bcc     L907A
L9075:  tax
L9076:  inx
L9077:  dex
        bne     L9083
L907A:  jsr     CHRGET
        jmp     L9009

L9080:  jmp     L94A1

L9083:  jsr     L90A6
        bne     L9077
L9088:  jsr     L9B74
L908B:  jsr     L9C4E
        tax
        ldy     #$00
        inx
L9092:  dex
        beq     L904E
        jsr     INDIN1
        jsr     L90B2
        iny
        cmp     #$0D
        bne     L9092
        jsr     L904C
        jmp     L9092

L90A6:  lda     CHANNL
        beq     L90AD
L90AA:  lda     #$20
        .byte   $2C
L90AD:  lda     #$1D
        .byte   $2C
L90B0:  lda     #$3F
L90B2:  jsr     LA78B
        and     #$FF
        rts

L90B8:  jsr     L9A86
        sta     VOICNO
        cmp     #$23
        beq     L90CB
        cmp     #$F9
        bne     L90DB
        jsr     CHRGET
        jmp     L90DB

L90CB:  jsr     CHRGET
        jsr     L9D84
        lda     #$2C
        jsr     L9493
        stx     CHANNL
        jsr     LA7A6
L90DB:  ldx     #$01
        ldy     #$02
        lda     #$00
        sta     $0201
        lda     #$40
        jsr     L9158
        ldx     CHANNL
        bne     L9100
        rts

L90EE:  jsr     L9D84
        lda     #$2C
        jsr     L9493
        stx     CHANNL
        jsr     LA7A6
        jsr     L9117
L90FE:  lda     CHANNL
L9100:  jsr     kCLRCHN
        ldx     #$00
        stx     CHANNL
        rts

L9108:  cmp     #$22
        bne     L9117
        jsr     L944E
        lda     #$3B
        jsr     L9493
        jsr     L908B
L9117:  jsr     L9A86
        lda     #$2C
        sta     $01FF
L911F:  jsr     L9142
        lda     CHANNL
        beq     L9133
        jsr     kREADST
        and     #$02
        beq     L9133
        jsr     L90FE
        jmp     L8DB0

L9133:  lda     BUF
        bne     L9156
        lda     CHANNL
        bne     L911F
        jsr     L8DBE
        jmp     L8DB3

L9142:  lda     CHANNL
        bne     L914C
        jsr     L90B0
        jsr     L90AA
L914C:  jmp     L885A

L914F:  ldx     DATPTR
        ldy     $42
        lda     #$98
        .byte   $2C
L9156:  lda     #$00
L9158:  sta     INPFLG
        stx     INPPTR
        sty     $44
L915E:  jsr     L96A5
        sta     FORPNT
        sty     $4A
        ldx     #$01
L9167:  lda     TXTPTR,x
        sta     OPPTR,x
        lda     INPPTR,x
        sta     TXTPTR,x
        dex
        bpl     L9167
        jsr     CHRGOT
        bne     L91A8
        bit     INPFLG
        bvc     L9195
        lda     VOICNO
        cmp     #$F9
        bne     L9189
L9181:  jsr     LA7AF
        tax
        beq     L9181
        bne     L918C
L9189:  jsr     LA7AF
L918C:  sta     BUF
        ldx     #$FF
        ldy     #$01
        bne     L91A4
L9195:  bpl     L919A
        jmp     L9240

L919A:  lda     CHANNL
        bne     L91A1
        jsr     L90B0
L91A1:  jsr     L9142
L91A4:  stx     TXTPTR
        sty     $3C
L91A8:  jsr     CHRGET
        bit     VALTYP
        bpl     L91E0
        bit     INPFLG
        bvc     L91BC
        inx
        stx     TXTPTR
        lda     #$00
        sta     CHARAC
        beq     L91C8
L91BC:  sta     CHARAC
        cmp     #$22
        beq     L91C9
        lda     #$3A
        sta     CHARAC
        lda     #$2C
L91C8:  clc
L91C9:  sta     ENDCHR
        lda     TXTPTR
        ldy     $3C
        adc     #$00
        bcc     L91D4
        iny
L91D4:  jsr     L9B7A
        jsr     L9DC6
        jsr     L8EB1
        jmp     L91E8

L91E0:  jsr     LA37F
        lda     INTFLG
        jsr     L8E99
L91E8:  jsr     CHRGOT
        beq     L9228
        cmp     #$2C
        beq     L9228
        lda     INPFLG
        beq     L91FF
        bmi     L91FB
        ldx     CHANNL
        bne     L9203
L91FB:  ldx     #$16
        bne     L9205
L91FF:  lda     CHANNL
        beq     L9208
L9203:  ldx     #$18
L9205:  jmp     L8683

L9208:  jsr     LFF4F
        .TEXT   "?REDO FROM START"

        .byte   $0D,$00
        lda     OLDTXT
        ldy     $025C
        sta     TXTPTR
        sty     $3C
        rts

L9228:  ldx     #$01
L922A:  lda     TXTPTR,x
        sta     INPPTR,x
        lda     OPPTR,x
        sta     TXTPTR,x
        dex
        bpl     L922A
        jsr     CHRGOT
        beq     L926A
        jsr     L9491
        jmp     L915E

L9240:  jsr     L8DBE
        iny
        tax
        bne     L925C
        ldx     #$0D
        iny
        jsr     INDTXT
        beq     L92BB
        iny
        jsr     INDTXT
        sta     DATLIN
        iny
        jsr     INDTXT
        iny
        sta     $40
L925C:  jsr     L8DB3
        jsr     CHRGOT
        tax
        cpx     #$83
        bne     L9240
        jmp     L91A8

L926A:  lda     INPPTR
        ldy     $44
        ldx     INPFLG
        bpl     L9275
        jmp     L8CBB

L9275:  ldy     #$00
        jsr     L8155
        beq     L9293
        lda     CHANNL
        bne     L9293
        jsr     LFF4F
        .TEXT   "?EXTRA IGNORED"

        .byte   $0D,$00
L9293:  rts

L9294:  bne     L92A9
        ldy     #$FF
        bne     L92AE
L929A:  ldy     #$12
        jsr     LA772
        jsr     CHRGOT
        cmp     #$2C
        bne     L9313
        jsr     CHRGET
L92A9:  jsr     L96A5
        sta     FORPNT
L92AE:  sty     $4A
        ldy     #$81
        sty     SRCHTK
        jsr     L8871
        beq     L92BE
        ldx     #$0A
L92BB:  jmp     L8683

L92BE:  jsr     LA769
        lda     FNDPNT
        clc
        adc     #$03
        ldy     $3E
        bcc     L92CB
        iny
L92CB:  jsr     LA21F
        ldy     #$08
        lda     (FNDPNT),y
        sta     FACSGN
        ldy     #$01
        lda     (FNDPNT),y
        pha
        tax
        iny
        lda     (FNDPNT),y
        pha
        tay
        txa
        jsr     L9E9B
        pla
        tay
        pla
        tax
        jsr     LA259
        lda     FNDPNT
        clc
        adc     #$09
        ldy     $3E
        bcc     L92F4
        iny
L92F4:  jsr     LA2E0
        ldy     #$08
        sec
        sbc     (FNDPNT),y
        beq     L929A
        ldy     #$11
        lda     (FNDPNT),y
        sta     TXTPTR
        dey
        lda     (FNDPNT),y
        sta     $3C
        dey
        lda     (FNDPNT),y
        sta     $3A
        dey
        lda     (FNDPNT),y
        sta     CHRLIN
L9313:  rts

L9314:  jsr     L932C
L9317:  clc
        bcc     L931B
L931A:  sec
L931B:  bit     VALTYP
        bmi     L9322
        bcs     L9324
L9321:  rts

L9322:  bcs     L9321
L9324:  ldx     #$16
        .byte   $2C
L9327:  ldx     #$19
        jmp     L8683

L932C:  ldx     TXTPTR
        bne     L9332
        dec     $3C
L9332:  dec     TXTPTR
        ldx     #$00
        .byte   $24
L9337:  pha
        txa
        pha
        tsx
        cpx     #$28
        bcc     L9327
        jsr     L9414
        lda     #$00
        sta     OPMASK
L9346:  jsr     CHRGOT
L9349:  sec
        sbc     #$B1
        bcc     L9365
        cmp     #$03
        bcs     L9365
        cmp     #$01
        rol     a
        eor     #$01
        eor     OPMASK
        cmp     OPMASK
        bcc     L93BE
        sta     OPMASK
        jsr     CHRGET
        jmp     L9349

L9365:  ldx     OPMASK
        bne     L9395
        bcs     L93E9
        adc     #$07
        bcc     L93E9
        adc     VALTYP
        bne     L9376
        jmp     L9BDA

L9376:  adc     #$FF
        sta     INDEX1
        asl     a
        adc     INDEX1
        tay
L937E:  pla
        cmp     L8453,y
        bcs     L93EE
        jsr     L9317
L9387:  pha
L9388:  jsr     L93AE
        pla
        ldy     OPPTR
        bpl     L93A7
        tax
        beq     L93EC
        bne     L93F7
L9395:  lsr     VALTYP
        txa
        rol     a
        ldx     TXTPTR
        bne     L939F
        dec     $3C
L939F:  dec     TXTPTR
        ldy     #$1B
        sta     OPMASK
        bne     L937E
L93A7:  cmp     L8453,y
        bcs     L93F7
        bcc     L9387
L93AE:  lda     L8454+1,y
        pha
        lda     L8454,y
        pha
        jsr     L93C1
        lda     OPMASK
        jmp     L9337

L93BE:  jmp     L94A1

L93C1:  lda     FACSGN
        ldx     L8453,y
        tay
        clc
        pla
        adc     #$01
        sta     INDEX1
        pla
        adc     #$00
        sta     $23
        tya
        pha
        jsr     LA2A0
        lda     $65
        pha
        lda     $64
        pha
        lda     $63
        pha
        lda     FACH0
        pha
        lda     FACEXP
        pha
        jmp     (INDEX1)

L93E9:  ldy     #$FF
        pla
L93EC:  beq     L9411
L93EE:  cmp     #$64
        beq     L93F5
        jsr     L9317
L93F5:  sty     OPPTR
L93F7:  pla
        lsr     a
        sta     TANSGN
        pla
        sta     ARGEXP
        pla
        sta     ARGH0
        pla
        sta     $6B
        pla
        sta     $6C
        pla
        sta     $6D
        pla
        sta     ARGSGN
        eor     FACSGN
        sta     ARISGN
L9411:  lda     FACEXP
        rts

L9414:  jmp     (lIEVAL)

IEVAL:  lda     #$00
        sta     VALTYP
L941B:  jsr     CHRGET
        bcs     L9423
L9420:  jmp     LA37F

L9423:  jsr     L973A
        bcc     L942B
        jmp     L94AD

L942B:  cmp     #$FF
        bne     L943E
        lda     #$39
        ldy     #$94
        jsr     LA221
        jmp     CHRGET

        .byte   $82,$49,$0F,$DA,$A1
L943E:  cmp     #$2E
        beq     L9420
        cmp     #$AB
        beq     L94A6
        cmp     #$AA
        beq     L941B
        cmp     #$22
        bne     L945D
L944E:  lda     TXTPTR
        ldy     $3C
        adc     #$00
        bcc     L9457
        iny
L9457:  jsr     L9B74
        jmp     L9DC6

L945D:  cmp     #$A8
        bne     L9477
        ldy     #$18
        bne     L94A8
L9465:  jsr     L9886
        lda     $65
        eor     #$FF
        tay
        lda     $64
        eor     #$FF
L9471:  jsr     L9A92
        jmp     LA2C9

L9477:  cmp     #$A5
        bne     L947E
        jmp     L9ADE

L947E:  cmp     #$B4
        bcc     L9485
        jmp     L9599

L9485:  jsr     L948E
        jsr     L932C
L948B:  lda     #$29
        .byte   $2C
L948E:  lda     #$28
        .byte   $2C
L9491:  lda     #$2C
L9493:  ldy     #$00
        sta     $78
        jsr     INDTXT
        cmp     $78
        bne     L94A1
        jmp     CHRGET

L94A1:  ldx     #$0B
        jmp     L8683

L94A6:  ldy     #$15
L94A8:  pla
        pla
        jmp     L9388

L94AD:  jsr     L96A5
        sta     $64
        sty     $65
        ldx     VARNAM
        ldy     $46
        lda     VALTYP
        beq     L9501
        lda     #$00
        sta     FACOV
        cpx     #$54
        bne     L94E8
        cpy     #$C9
        bne     L953E
        lda     $64
        cmp     #$A2
        bne     L953E
        lda     $65
        cmp     #$04
        bne     L953E
        jsr     L9531
        sty     $5E
        dey
        sty     FBUFPT
        ldy     #$06
        sty     $5D
        ldy     #$24
        jsr     LA4FA
        jmp     L9B70

L94E8:  cpx     #$44
        bne     L953E
        cpy     #$D3
        bne     L953E
        jsr     L94FA
        lda     $7A
        ldy     $7B
        jmp     L9B74

L94FA:  lda     DSDESC
        bne     L953E
        jmp     LCCCF

L9501:  bit     INTFLG
        bpl     L9514
        ldy     #$00
        jsr     INDFMO
        tax
        iny
        jsr     INDFMO
        tay
        txa
        jmp     L9471

L9514:  lda     $65
        cmp     #$04
        bne     L9592
        lda     $64
        cmp     #$A2
        bne     L9592
        cpx     #$54
        bne     L953F
        cpy     #$49
        bne     L9592
        jsr     L9531
        tya
        ldx     #$A0
        jmp     LA2D4

L9531:  jsr     kRDTIM
        stx     $64
        sty     $63
        sta     $65
        ldy     #$00
        sty     FACH0
L953E:  rts

L953F:  cpx     #$53
        bne     L954D
        cpy     #$54
        bne     L9592
        jsr     kREADST
        jmp     LA2C1

L954D:  cpx     #$44
        bne     L9577
        cpy     #$53
        bne     L9592
        jsr     L94FA
        ldy     #$00
        lda     #$7A
        jsr     INDSUB
        and     #$0F
        asl     a
        sta     DORES
        asl     a
        asl     a
        adc     DORES
        sta     DORES
        iny
        lda     #$7A
        jsr     INDSUB
        and     #$0F
        adc     DORES
        jmp     LA2C1

L9577:  cpx     #$45
        bne     L9592
        cpy     #$52
        beq     L958C
        cpy     #$4C
        bne     L9592
        lda     $04F1
        ldy     ERRLIN
        jmp     L9A76

L958C:  lda     ERRNUM
        jmp     LA2C1

L9592:  lda     $64
        ldy     $65
        jmp     LA21F

L9599:  cmp     #$D5
        bcs     L95F5
        cmp     #$CB
        bcc     L95A3
        sbc     #$01
L95A3:  pha
        tax
        jsr     CHRGET
        cpx     #$D3
        beq     L95B4
        cpx     #$CB
        bcs     L95D9
        cpx     #$C8
        bcc     L95D9
L95B4:  jsr     L948E
        jsr     L932C
        jsr     L9491
        jsr     L931A
        pla
        cmp     #$D3
        beq     L95F2
        tax
        lda     $65
        pha
        lda     $64
        pha
        txa
        pha
        jsr     L9D84
        pla
        tay
        txa
        pha
        tya
        jmp     L95DD

L95D9:  jsr     L9485
        pla
L95DD:  sec
        sbc     #$B4
        asl     a
        tay
        lda     L8415+1,y
        sta     $56
        lda     L8415,y
        sta     $55
        jsr     JMPER
        jmp     L9317

L95F2:  jmp     LB386

L95F5:  jmp     L94A1

L95F8:  ldy     #$FF
L95FA:  .byte   $2C
L95FB:  ldy     #$00
        sty     COUNT
        jsr     L9886
        lda     $64
        eor     COUNT
        sta     CHARAC
        lda     $65
        eor     COUNT
        sta     ENDCHR
        jsr     LA281
        jsr     L9886
        lda     $65
        eor     COUNT
        and     ENDCHR
        eor     COUNT
        tay
        lda     $64
        eor     COUNT
        and     CHARAC
        eor     COUNT
        jmp     L9471

L9628:  jsr     L931B
        bcs     L9640
        lda     ARGSGN
        ora     #$7F
        and     ARGH0
        sta     ARGH0
        lda     #$69
        ldy     #$00
        jsr     LA2E0
        tax
        jmp     L9673

L9640:  lda     #$00
        sta     VALTYP
        dec     OPMASK
        jsr     L9C4E
        sta     FACEXP
        stx     FACH0
        sty     $63
        lda     $6C
        ldy     $6D
        jsr     L9C52
        stx     $6C
        sty     $6D
        tax
        sec
        sbc     FACEXP
        beq     L9668
        lda     #$01
        bcc     L9668
        ldx     FACEXP
        lda     #$FF
L9668:  sta     FACSGN
        ldy     #$FF
        inx
L966D:  iny
        dex
        bne     L9678
        ldx     FACSGN
L9673:  bmi     L968C
        clc
        bcc     L968C
L9678:  jsr     L8185
        pha
        jsr     L817D
        sta     $78
        pla
        cmp     $78
        beq     L966D
        ldx     #$FF
        bcs     L968C
        ldx     #$01
L968C:  inx
        txa
        rol     a
        and     TANSGN
        beq     L9695
        lda     #$FF
L9695:  jmp     LA2C1

L9698:  jsr     L9491
L969B:  tax
        jsr     L96AA
        jsr     CHRGOT
        bne     L9698
        rts

L96A5:  ldx     #$00
        jsr     CHRGOT
L96AA:  stx     DIMFLG
L96AC:  sta     VARNAM
        jsr     CHRGOT
        jsr     L973A
        bcs     L96B9
L96B6:  jmp     L94A1

L96B9:  ldx     #$00
        stx     VALTYP
        stx     INTFLG
        jsr     CHRGET
        bcc     L96C9
        jsr     L973A
        bcc     L96D4
L96C9:  tax
L96CA:  jsr     CHRGET
        bcc     L96CA
        jsr     L973A
        bcs     L96CA
L96D4:  cmp     #$24
        bne     L96DE
        lda     #$FF
        sta     VALTYP
        bne     L96EE
L96DE:  cmp     #$25
        bne     L96F5
        lda     SUBFLG
        bne     L96B6
        lda     #$80
        sta     INTFLG
        ora     VARNAM
        sta     VARNAM
L96EE:  txa
        ora     #$80
        tax
        jsr     CHRGET
L96F5:  stx     $46
        sec
        ora     SUBFLG
        sbc     #$28
        bne     L9701
        jmp     L989B

L9701:  ldy     #$00
        sty     SUBFLG
        lda     VARTAB
        ldx     $2E
L9709:  stx     $60
L970B:  sta     $5F
        cpx     $30
        bne     L9715
        cmp     ARYTAB
        beq     L9744
L9715:  jsr     INDLOW
        sta     $78
        lda     VARNAM
        cmp     $78
        bne     L9730
        iny
        jsr     INDLOW
        sta     $78
        lda     $46
        cmp     $78
        bne     L972F
        jmp     L984C

L972F:  dey
L9730:  clc
        lda     $5F
        adc     #$07
        bcc     L970B
        inx
        bne     L9709
L973A:  cmp     #$41
        bcc     L9743
        sbc     #$5B
        sec
        sbc     #$A5
L9743:  rts

L9744:  pla
        pha
        cmp     #$AF
        bne     L9774
L974A:  lda     #$A2
        ldy     #$04
        rts

L974F:  cpy     #$C9
        beq     L974A
        cpy     #$49
        bne     L9788
        beq     L9771
L9759:  cpy     #$D3
        beq     L9771
        cpy     #$53
        bne     L9788
        beq     L9771
L9763:  cpy     #$54
        bne     L9788
        beq     L9771
L9769:  cpy     #$52
        beq     L9771
        cpy     #$4C
        bne     L9788
L9771:  jmp     L94A1

L9774:  lda     VARNAM
        ldy     $46
        cmp     #$54
        beq     L974F
        cmp     #$53
        beq     L9763
        cmp     #$45
        beq     L9769
        cmp     #$44
        beq     L9759
L9788:  lda     ARYTAB
        ldy     $30
        sta     $5F
        sty     $60
        lda     STREND
        ldy     $32
        sta     $5A
        sty     $5B
        clc
        adc     #$07
        bcc     L979E
        iny
L979E:  sta     $58
        sty     $59
        jsr     L88C0
        lda     $58
        ldy     $59
        iny
        sta     ARYTAB
        sty     $30
        sta     $58
        sty     $59
L97B2:  lda     $58
        ldx     $59
L97B6:  cpx     $32
        bne     L97C0
        cmp     STREND
        bne     L97C0
        beq     L9838
L97C0:  sta     INDEX1
        stx     $23
        ldy     #$00
        jsr     INDIN1
        tax
        iny
        jsr     INDIN1
        php
        iny
        jsr     INDIN1
        adc     $58
        sta     $58
        iny
        jsr     INDIN1
        adc     $59
        sta     $59
        plp
        bpl     L97B2
        txa
        bmi     L97B2
        iny
        jsr     INDIN1
        ldy     #$00
        asl     a
        adc     #$05
        adc     INDEX1
        sta     INDEX1
        bcc     L97F6
        inc     $23
L97F6:  ldx     $23
        cpx     $59
        bne     L9800
        cmp     $58
        beq     L97B6
L9800:  ldy     #$00
        jsr     INDIN1
        beq     L982B
        sta     $78
        iny
        jsr     INDIN1
        clc
        adc     $78
        sta     $5A
        iny
        jsr     INDIN1
        adc     #$00
        sta     $5B
        ldy     #$00
        jsr     L8189
        adc     #$07
        sta     ($5A),y
        iny
        jsr     L8189
        adc     #$00
        sta     ($5A),y
L982B:  lda     #$03
        clc
        adc     INDEX1
        sta     INDEX1
        bcc     L97F6
        inc     $23
        bne     L97F6
L9838:  ldy     #$00
        lda     VARNAM
        sta     ($5F),y
        iny
        lda     $46
        sta     ($5F),y
        lda     #$00
L9845:  iny
        sta     ($5F),y
        cpy     #$06
        bne     L9845
L984C:  lda     $5F
        clc
        adc     #$02
        ldy     $60
        bcc     L9856
        iny
L9856:  sta     VARPNT
        sty     $48
        rts

L985B:  lda     COUNT
        asl     a
        adc     #$05
        adc     $5F
        ldy     $60
        bcc     L9867
        iny
L9867:  sta     $58
        sty     $59
        rts

        .byte   $90,$80,$00,$00,$00
L9871:  jsr     L9886
        lda     $64
        ldy     $65
        rts

L9879:  jsr     CHRGET
        jsr     L932C
L987F:  jsr     L9317
        lda     FACSGN
        bmi     L9893
L9886:  lda     FACEXP
        cmp     #$90
        bcc     L9898
        lda     #$6C
        ldy     #$98
        jsr     LA2E0
L9893:  bne     L9898
        jmp     L991C

L9898:  jmp     LA327

L989B:  lda     DIMFLG
        ora     INTFLG
        pha
        lda     VALTYP
        pha
        ldy     #$00
L98A5:  tya
        pha
        lda     $46
        pha
        lda     VARNAM
        pha
        jsr     L9879
        pla
        sta     VARNAM
        pla
        sta     $46
        pla
        tay
        tsx
        lda     $0102,x
        pha
        lda     $0101,x
        pha
        lda     $64
        sta     $0102,x
        lda     $65
        sta     $0101,x
        iny
        sty     COUNT
        jsr     CHRGOT
        ldy     COUNT
        cmp     #$2C
        beq     L98A5
        jsr     L948B
        pla
        sta     VALTYP
        pla
        sta     INTFLG
        and     #$7F
        sta     DIMFLG
        ldx     ARYTAB
        lda     $30
L98E8:  stx     $5F
        sta     $60
        cmp     $32
        bne     L98F4
        cpx     STREND
        beq     L993A
L98F4:  ldy     #$00
        jsr     INDLOW
        iny
        cmp     VARNAM
        bne     L9909
        jsr     INDLOW
        sta     $78
        lda     $46
        cmp     $78
        beq     L9921
L9909:  iny
        jsr     INDLOW
        clc
        adc     $5F
        tax
        iny
        jsr     INDLOW
        adc     $60
        bcc     L98E8
L9919:  ldx     #$12
        .byte   $2C
L991C:  ldx     #$0E
L991E:  jmp     L8683

L9921:  ldx     #$13
        lda     DIMFLG
        bne     L991E
        jsr     L985B
        ldy     #$04
        jsr     INDLOW
        sta     $78
        lda     COUNT
        cmp     $78
        bne     L9919
        jmp     L99C3

L993A:  jsr     L985B
        jsr     L8923
        ldy     #$00
        sty     $72
        ldx     #$05
        lda     VARNAM
        sta     ($5F),y
        bpl     L994D
        dex
L994D:  iny
        lda     $46
        sta     ($5F),y
        bpl     L9956
        dex
        dex
L9956:  stx     FBUFPT
        lda     COUNT
        iny
        iny
        iny
        sta     ($5F),y
L995F:  ldx     #$0B
        lda     #$00
        bit     DIMFLG
        bvc     L996F
        pla
        clc
        adc     #$01
        tax
        pla
        adc     #$00
L996F:  iny
        sta     ($5F),y
        iny
        txa
        sta     ($5F),y
        jsr     L9A2F
        stx     FBUFPT
        sta     $72
        ldy     INDEX1
        dec     COUNT
        bne     L995F
        adc     $59
        bcs     L99EE
        sta     $59
        tay
        txa
        adc     $58
        bcc     L9992
        iny
        beq     L99EE
L9992:  jsr     L8923
        sta     STREND
        sty     $32
        lda     #$00
        inc     $72
        ldy     FBUFPT
        beq     L99A6
L99A1:  dey
        sta     ($58),y
        bne     L99A1
L99A6:  dec     $59
        dec     $72
        bne     L99A1
        inc     $59
        sec
        lda     STREND
        sbc     $5F
        ldy     #$02
        sta     ($5F),y
        lda     $32
        iny
        sbc     $60
        sta     ($5F),y
        lda     DIMFLG
        bne     L9A2E
        iny
L99C3:  jsr     INDLOW
        sta     COUNT
        lda     #$00
        sta     FBUFPT
L99CC:  sta     $72
        iny
        pla
        tax
        sta     $64
        jsr     INDLOW
        sta     $78
        pla
        sta     $65
        cmp     $78
        bcc     L99F1
        bne     L99EB
        iny
        jsr     INDLOW
        sta     $78
        cpx     $78
        bcc     L99F2
L99EB:  jmp     L9919

L99EE:  jmp     L8681

L99F1:  iny
L99F2:  lda     $72
        ora     FBUFPT
        clc
        beq     L9A03
        jsr     L9A2F
        txa
        adc     $64
        tax
        tya
        ldy     INDEX1
L9A03:  adc     $65
        stx     FBUFPT
        dec     COUNT
        bne     L99CC
        sta     $72
        ldx     #$05
        lda     VARNAM
        bpl     L9A14
        dex
L9A14:  lda     $46
        bpl     L9A1A
        dex
        dex
L9A1A:  stx     $28
        lda     #$00
        jsr     L9A3A
        txa
        adc     $58
        sta     VARPNT
        tya
        adc     $59
        sta     $48
        tay
        lda     VARPNT
L9A2E:  rts

L9A2F:  sty     INDEX1
        jsr     INDLOW
        sta     $28
        dey
        jsr     INDLOW
L9A3A:  sta     $29
        lda     #$10
        sta     $5D
        ldx     #$00
        ldy     #$00
L9A44:  txa
        asl     a
        tax
        tya
        rol     a
        tay
        bcs     L99EE
        asl     FBUFPT
        rol     $72
        bcc     L9A5D
        clc
        txa
        adc     $28
        tax
        tya
        adc     $29
        tay
        bcs     L99EE
L9A5D:  dec     $5D
        bne     L9A44
        rts

L9A62:  lda     VALTYP
        beq     L9A69
        jsr     L9C4E
L9A69:  jsr     LA954
        sec
        lda     FRETOP
        sbc     STREND
        tay
        lda     $34
        sbc     $32
L9A76:  jsr     L9A92
        sec
        jmp     LA2CE

L9A7D:  sec
        jsr     kPLOT
L9A81:  lda     #$00
        jmp     L9471

L9A86:  bit     RUNMOD
        bmi     L9A2E
        ldx     #$15
        .byte   $2C
L9A8D:  ldx     #$1B
        jmp     L8683

L9A92:  ldx     #$00
        stx     VALTYP
        sta     FACH0
        sty     $63
        ldx     #$90
        rts

L9A9D:  jsr     L9ACB
        jsr     L9A86
        jsr     L948E
        lda     #$80
        sta     SUBFLG
        jsr     L96A5
        jsr     L9317
        jsr     L948B
        lda     #$B2
        jsr     L9493
        pha
        lda     $48
        pha
        lda     VARPNT
        pha
        lda     $3C
        pha
        lda     TXTPTR
        pha
        jsr     L8DB0
        jmp     L9B3E

L9ACB:  lda     #$A5
        jsr     L9493
        ora     #$80
        sta     SUBFLG
        jsr     L96AC
        sta     DEFPNT
        sty     $4F
        jmp     L9317

L9ADE:  jsr     L9ACB
        lda     $4F
        pha
        lda     DEFPNT
        pha
        jsr     L9485
        jsr     L9317
        pla
        sta     DEFPNT
        pla
        sta     $4F
        ldy     #$02
        jsr     L8159
        sta     VARPNT
        tax
        iny
        jsr     L8159
        beq     L9A8D
        sta     $48
        iny
L9B04:  jsr     L8161
        pha
        dey
        bpl     L9B04
        ldy     $48
        jsr     LA259
        lda     $3C
        pha
        lda     TXTPTR
        pha
        jsr     L8159
        sta     TXTPTR
        iny
        jsr     L8159
        sta     $3C
        lda     $48
        pha
        lda     VARPNT
        pha
        jsr     L9314
        pla
        sta     DEFPNT
        pla
        sta     $4F
        jsr     CHRGOT
        beq     L9B38
        jmp     L94A1

L9B38:  pla
        sta     TXTPTR
        pla
        sta     $3C
L9B3E:  ldy     #$00
        pla
        sta     (DEFPNT),y
        pla
        iny
        sta     (DEFPNT),y
        pla
        iny
        sta     (DEFPNT),y
        pla
        iny
        sta     (DEFPNT),y
        pla
        iny
        sta     (DEFPNT),y
        rts

L9B54:  ldx     $64
        ldy     $65
        stx     DSCPNT
        sty     $51
L9B5C:  jsr     LA906
        stx     FACH0
        sty     $63
        sta     FACEXP
        rts

L9B66:  jsr     L9317
        ldy     #$00
        jsr     LA471
        pla
        pla
L9B70:  lda     #$FF
        ldy     #$00
L9B74:  ldx     #$22
        stx     CHARAC
        stx     ENDCHR
L9B7A:  sta     ARISGN
        sty     FACOV
        sta     FACH0
        sty     $63
        ldy     #$FF
L9B84:  iny
        jsr     INDST1
        beq     L9B96
        cmp     CHARAC
        beq     L9B92
        cmp     ENDCHR
        bne     L9B84
L9B92:  cmp     #$22
        beq     L9B97
L9B96:  clc
L9B97:  sty     FACEXP
        tya
        adc     ARISGN
        sta     FBUFPT
        ldx     FACOV
        bcc     L9BA3
        inx
L9BA3:  stx     $72
        tya
        jsr     L9B54
        ldx     ARISGN
        ldy     FACOV
        jsr     L9C2C
L9BB0:  ldx     TEMPPT
        cpx     #$22
        bne     L9BBB
        ldx     #$19
        jmp     L8683

L9BBB:  lda     FACEXP
        sta     PDIR,x
        lda     FACH0
        sta     PORT,x
        lda     $63
        sta     SRCHTK,x
        ldy     #$00
        stx     $64
        sty     $65
        sty     FACOV
        dey
        sty     VALTYP
        stx     LASTPT
        inx
        inx
        inx
        stx     TEMPPT
        rts

L9BDA:  lda     $65
        pha
        lda     $64
        pha
        jsr     L9414
        jsr     L931A
        pla
        sta     ARISGN
        pla
        sta     FACOV
        ldy     #$00
        jsr     INDST1
        sta     $78
        jsr     INDFMO
        clc
        adc     $78
        bcc     L9BFE
        jmp     LCC4C

L9BFE:  jsr     L9B54
        jsr     L9C1B
        lda     DSCPNT
        ldy     $51
        jsr     L9C52
        jsr     L9C30
        lda     ARISGN
        ldy     FACOV
        jsr     L9C52
        jsr     L9BB0
        jmp     L9346

L9C1B:  ldy     #$00
        jsr     INDST1
        pha
        iny
        jsr     INDST1
        tax
        iny
        jsr     INDST1
        tay
        pla
L9C2C:  stx     INDEX1
        sty     $23
L9C30:  tay
        beq     L9C3E
        pha
L9C34:  dey
        jsr     INDIN1
        sta     (FRESPC),y
        tya
        bne     L9C34
        pla
L9C3E:  clc
        adc     FRESPC
        sta     FRESPC
        bcc     L9C47
        inc     $36
L9C47:  rts

L9C48:  jsr     L932C
L9C4B:  jsr     L931A
L9C4E:  lda     $64
        ldy     $65
L9C52:  sta     INDEX1
        sty     $23
        jsr     L9CAA
        bne     L9C94
        jsr     L8F9C
        bcc     L9C94
        dey
        lda     #$FF
        sta     (INDEX1),y
        dey
        txa
        sta     (INDEX1),y
        pha
        eor     #$FF
        sec
        adc     INDEX1
        ldy     $23
        bcs     L9C74
        dey
L9C74:  sta     INDEX1
        sty     $23
        tax
        pla
        cpy     $34
        bne     L9CBA
        cpx     FRETOP
        bne     L9CBA
        pha
        sec
        adc     FRETOP
        sta     FRETOP
        bcc     L9C8C
        inc     $34
L9C8C:  inc     FRETOP
        bne     L9C92
        inc     $34
L9C92:  pla
        rts

L9C94:  ldy     #$00
        jsr     INDIN1
        pha
        iny
        jsr     INDIN1
        tax
        iny
        jsr     INDIN1
        tay
        stx     INDEX1
        sty     $23
        pla
        rts

L9CAA:  cpy     $18
        bne     L9CBA
        cmp     LASTPT
        bne     L9CBA
        sta     TEMPPT
        sbc     #$03
        sta     LASTPT
        ldy     #$00
L9CBA:  rts

L9CBB:  jsr     L9D87
        txa
        pha
        lda     #$01
        jsr     L9B5C
        pla
        ldy     #$00
        sta     (FACH0),y
L9CCA:  pla
        pla
        jmp     L9BB0

L9CCF:  jsr     L9D46
        pha
        jsr     L8181
        sta     $78
        pla
        cmp     $78
        tya
L9CDC:  bcc     L9CE3
        jsr     L8181
        tax
        tya
L9CE3:  pha
L9CE4:  txa
L9CE5:  pha
        jsr     L9B5C
        lda     DSCPNT
        ldy     $51
        jsr     L9C52
        pla
        tay
        pla
        clc
        adc     INDEX1
        sta     INDEX1
        bcc     L9CFC
        inc     $23
L9CFC:  tya
        jsr     L9C30
        jmp     L9BB0

L9D03:  jsr     L9D46
        pha
        jsr     L8181
        sta     $78
        pla
        clc
        sbc     $78
        eor     #$FF
        jmp     L9CDC

L9D15:  lda     #$FF
        sta     $65
        jsr     CHRGOT
        cmp     #$29
        beq     L9D26
        jsr     L9491
        jsr     L9D84
L9D26:  jsr     L9D46
        beq     L9D7E
        dex
        txa
        pha
        ldx     #$00
        pha
        jsr     L8181
        sta     $78
        pla
        clc
        sbc     $78
        bcs     L9CE4
        eor     #$FF
        cmp     $65
        bcc     L9CE5
        lda     $65
        bcs     L9CE5
L9D46:  jsr     L948B
        pla
        tay
        pla
        sta     $55
        pla
        pla
        pla
        tax
        pla
        sta     DSCPNT
        pla
        sta     $51
        lda     $55
        pha
        tya
        pha
        ldy     #$00
        txa
        rts

L9D61:  jsr     L9D67
        jmp     L9A81

L9D67:  jsr     L9C4B
        ldx     #$00
        stx     VALTYP
        tay
        rts

L9D70:  jsr     L9D67
        beq     L9D7B
        ldy     #$00
        jsr     INDIN1
        tay
L9D7B:  jmp     L9A81

L9D7E:  jmp     L991C

L9D81:  jsr     CHRGET
L9D84:  jsr     L9314
L9D87:  jsr     L987F
        ldx     $64
        bne     L9D7E
        ldx     $65
        jmp     CHRGOT

L9D93:  jsr     L9D67
        beq     L9DCF
        ldx     TXTPTR
        ldy     $3C
        stx     FBUFPT
        sty     $72
        ldx     INDEX1
        stx     TXTPTR
        clc
        adc     INDEX1
        sta     INDEX2
        ldx     $23
        stx     $3C
        bcc     L9DB0
        inx
L9DB0:  stx     $25
        ldy     #$00
        jsr     INDIN2
        pha
        tya
        sta     (INDEX2),y
        jsr     CHRGOT
        jsr     LA37F
        pla
        ldy     #$00
        sta     (INDEX2),y
L9DC6:  ldx     FBUFPT
        ldy     $72
        stx     TXTPTR
        sty     $3C
        rts

L9DCF:  jmp     L9F2B

L9DD2:  jsr     L9314
        jsr     L9DE4
L9DD8:  jsr     L9491
        jmp     L9D84

L9DDE:  jsr     L9491
L9DE1:  jsr     L9314
L9DE4:  lda     FACSGN
        bmi     L9D7E
L9DE8:  lda     FACEXP
        cmp     #$91
        bcs     L9D7E
        jsr     LA327
        lda     $64
        ldy     $65
        sty     LINNUM
        sta     $15
        rts

L9DFA:  lda     $15
        pha
        lda     LINNUM
        pha
        jsr     L9DE4
        ldy     #$00
        jsr     L815D
        tay
        pla
        sta     LINNUM
        pla
        sta     $15
        jmp     L9A81

L9E12:  jsr     L9DD2
        txa
        ldy     #$00
        sta     (LINNUM),y
        rts

L9E1B:  jsr     L9D67
        sta     INDEX2
        ldy     #$00
        sty     $25
        sty     FBUFPT
        sty     $72
L9E28:  cpy     INDEX2
        beq     L9E60
        jsr     INDIN1
        iny
        cmp     #$20
        beq     L9E28
        inc     $25
        ldx     $25
        cpx     #$05
        beq     L9E67
        cmp     #$30
        bcc     L9E67
        cmp     #$3A
        bcc     L9E4E
        cmp     #$41
        bcc     L9E67
        cmp     #$47
        bcs     L9E67
        sbc     #$07
L9E4E:  sbc     #$2F
        asl     a
        asl     a
        asl     a
        asl     a
        ldx     #$04
L9E56:  asl     a
        rol     FBUFPT
        rol     $72
        dex
        bne     L9E56
        beq     L9E28
L9E60:  ldy     FBUFPT
        lda     $72
        jmp     L9A76

L9E67:  jmp     L991C

L9E6A:  jsr     L9DD2
        stx     FORPNT
        ldx     #$00
        jsr     CHRGOT
        beq     L9E79
        jsr     L9DD8
L9E79:  stx     $4A
        ldy     #$00
L9E7D:  jsr     L815D
        eor     $4A
        and     FORPNT
        beq     L9E7D
L9E86:  rts

L9E87:  lda     FACSGN
        eor     #$FF
        sta     FACSGN
        eor     ARGSGN
        sta     ARISGN
        lda     FACEXP
        jmp     L9E9E

L9E96:  jsr     L9FCD
        bcc     L9ED7
L9E9B:  jsr     LA107
L9E9E:  bne     L9EA3
        jmp     LA281

L9EA3:  ldx     FACOV
        stx     $56
        ldx     #$69
        lda     ARGEXP
L9EAB:  tay
        beq     L9E86
        sec
        sbc     FACEXP
        beq     L9ED7
        bcc     L9EC7
        sty     FACEXP
        ldy     ARGSGN
        sty     FACSGN
        eor     #$FF
        adc     #$00
        ldy     #$00
        sty     $56
        ldx     #$61
        bne     L9ECB
L9EC7:  ldy     #$00
        sty     FACOV
L9ECB:  cmp     #$F9
        bmi     L9E96
        tay
        lda     FACOV
        lsr     PORT,x
        jsr     L9FE4
L9ED7:  bit     ARISGN
        bpl     L9F32
        ldy     #$61
        cpx     #$69
        beq     L9EE3
        ldy     #$69
L9EE3:  sec
        eor     #$FF
        adc     $56
        sta     FACOV
        lda     $04,y
        sbc     $04,x
        sta     $65
        lda     ZPVEC1,y
        sbc     ZPVEC1,x
        sta     $64
        lda     SRCHTK,y
        sbc     SRCHTK,x
        sta     $63
        lda     PORT,y
        sbc     PORT,x
        sta     FACH0
L9F06:  bcs     L9F0B
        jsr     L9F7B
L9F0B:  ldy     #$00
        tya
        clc
L9F0F:  ldx     FACH0
        bne     L9F5D
        ldx     $63
        stx     FACH0
        ldx     $64
        stx     $63
        ldx     $65
        stx     $64
        ldx     FACOV
        stx     $65
        sty     FACOV
        adc     #$08
        cmp     #$20
        bne     L9F0F
L9F2B:  lda     #$00
L9F2D:  sta     FACEXP
L9F2F:  sta     FACSGN
        rts

L9F32:  adc     $56
        sta     FACOV
        lda     $65
        adc     $6D
        sta     $65
        lda     $64
        adc     $6C
        sta     $64
        lda     $63
        adc     $6B
        sta     $63
        lda     FACH0
        adc     ARGH0
        sta     FACH0
        jmp     L9F6A

L9F51:  adc     #$01
        asl     FACOV
        rol     $65
        rol     $64
        rol     $63
        rol     FACH0
L9F5D:  bpl     L9F51
        sec
        sbc     FACEXP
        bcs     L9F2B
        eor     #$FF
        adc     #$01
        sta     FACEXP
L9F6A:  bcc     L9F7A
L9F6C:  inc     FACEXP
        beq     L9FB2
        ror     FACH0
        ror     $63
        ror     $64
        ror     $65
        ror     FACOV
L9F7A:  rts

L9F7B:  lda     FACSGN
        eor     #$FF
        sta     FACSGN
L9F81:  lda     FACH0
        eor     #$FF
        sta     FACH0
        lda     $63
        eor     #$FF
        sta     $63
        lda     $64
        eor     #$FF
        sta     $64
        lda     $65
        eor     #$FF
        sta     $65
        lda     FACOV
        eor     #$FF
        sta     FACOV
        inc     FACOV
        bne     L9FB1
L9FA3:  inc     $65
        bne     L9FB1
        inc     $64
        bne     L9FB1
        inc     $63
        bne     L9FB1
        inc     FACH0
L9FB1:  rts

L9FB2:  ldx     #$0F
        jmp     L8683

L9FB7:  ldx     #$25
L9FB9:  ldy     $04,x
        sty     FACOV
        ldy     ZPVEC1,x
        sty     $04,x
        ldy     SRCHTK,x
        sty     ZPVEC1,x
        ldy     PORT,x
        sty     SRCHTK,x
        ldy     BITS
        sty     PORT,x
L9FCD:  adc     #$08
        bmi     L9FB9
        beq     L9FB9
        sbc     #$08
        tay
        lda     FACOV
        bcs     L9FEE
L9FDA:  asl     PORT,x
        bcc     L9FE0
        inc     PORT,x
L9FE0:  ror     PORT,x
        ror     PORT,x
L9FE4:  ror     SRCHTK,x
        ror     ZPVEC1,x
        ror     $04,x
        ror     a
        iny
        bne     L9FDA
L9FEE:  clc
        rts

L9FF0:  .byte   $81,$00,$00,$00,$00
L9FF5:  .byte   $03
L9FF6:  .byte   $7F,$5E,$56,$CB,$79
L9FFB:  .byte   $80,$13,$9B,$0B,$64
LA000:  .byte   $80,$76,$38,$93,$16
LA005:  .byte   $82,$38,$AA,$3B,$20
LA00A:  .byte   $80,$35,$04,$F3,$34
LA00F:  .byte   $81,$35,$04,$F3,$34
LA014:  .byte   $80,$80,$00,$00,$00
LA019:  .byte   $80,$31,$72,$17,$F8
LA01E:  jsr     LA2B0
        beq     LA025
        bpl     LA028
LA025:  jmp     L991C

LA028:  lda     FACEXP
        sbc     #$7F
        pha
        lda     #$80
        sta     FACEXP
        lda     #$0A
        ldy     #$A0
        jsr     LA066
        lda     #$0F
        ldy     #$A0
        jsr     LA072
        lda     #$F0
        ldy     #$9F
        jsr     LA06C
        lda     #$F5
        ldy     #$9F
        jsr     LA6B3
        lda     #$14
        ldy     #$A0
        jsr     LA066
        pla
        jsr     LA40A
        lda     #$19
        ldy     #$A0
LA05C:  jsr     LA0DC
        jmp     LA07B

LA062:  lda     #$A3
        ldy     #$A5
LA066:  jsr     LA0DC
        jmp     L9E9E

LA06C:  jsr     LA0DC
        jmp     L9E87

LA072:  jsr     LA0DC
        jmp     LA197

LA078:  jsr     LA107
LA07B:  bne     LA080
        jmp     LA0DB

LA080:  jsr     LA137
        lda     #$00
        sta     RESH0
        sta     $27
        sta     $28
        sta     $29
        lda     FACOV
        jsr     LA0A9
        lda     $65
        jsr     LA0A9
        lda     $64
        jsr     LA0A9
        lda     $63
        jsr     LA0A9
        lda     FACH0
        jsr     LA0AE
        jmp     LA20C

LA0A9:  bne     LA0AE
        jmp     L9FB7

LA0AE:  lsr     a
        ora     #$80
LA0B1:  tay
        bcc     LA0CD
        clc
        lda     $29
        adc     $6D
        sta     $29
        lda     $28
        adc     $6C
        sta     $28
        lda     $27
        adc     $6B
        sta     $27
        lda     RESH0
        adc     ARGH0
        sta     RESH0
LA0CD:  ror     RESH0
        ror     $27
        ror     $28
        ror     $29
        ror     FACOV
        tya
        lsr     a
        bne     LA0B1
LA0DB:  rts

LA0DC:  sta     INDEX1
        sty     $23
        ldy     #$04
        lda     (INDEX1),y
        sta     $6D
        dey
        lda     (INDEX1),y
        sta     $6C
        dey
        lda     (INDEX1),y
        sta     $6B
        dey
        lda     (INDEX1),y
        sta     ARGSGN
        eor     FACSGN
        sta     ARISGN
        lda     ARGSGN
        ora     #$80
        sta     ARGH0
        dey
        lda     (INDEX1),y
        sta     ARGEXP
        lda     FACEXP
        rts

LA107:  sta     INDEX1
        sty     $23
        ldy     #$04
        jsr     INDIN1
        sta     $6D
        dey
        jsr     INDIN1
        sta     $6C
        dey
        jsr     INDIN1
        sta     $6B
        dey
        jsr     INDIN1
        sta     ARGSGN
        eor     FACSGN
        sta     ARISGN
        lda     ARGSGN
        ora     #$80
        sta     ARGH0
        dey
        jsr     INDIN1
        sta     ARGEXP
        lda     FACEXP
        rts

LA137:  lda     ARGEXP
LA139:  beq     LA15A
        clc
        adc     FACEXP
        bcc     LA144
        bmi     LA15F
        clc
        .byte   $2C
LA144:  bpl     LA15A
        adc     #$80
        sta     FACEXP
        bne     LA14F
        jmp     L9F2F

LA14F:  lda     ARISGN
        sta     FACSGN
        rts

LA154:  lda     FACSGN
        eor     #$FF
        bmi     LA15F
LA15A:  pla
        pla
        jmp     L9F2B

LA15F:  jmp     L9FB2

LA162:  jsr     LA291
        tax
        beq     LA178
        clc
        adc     #$02
        bcs     LA15F
LA16D:  ldx     #$00
        stx     ARISGN
        jsr     L9EAB
        inc     FACEXP
        beq     LA15F
LA178:  rts

        .byte   $84,$20,$00,$00,$00
LA17E:  ldx     #$14
        jmp     L8683

LA183:  jsr     LA291
        lda     #$79
        ldy     #$A1
        ldx     #$00
LA18C:  stx     ARISGN
        jsr     LA221
        jmp     LA197

LA194:  jsr     LA107
LA197:  beq     LA17E
        jsr     LA2A0
        lda     #$00
        sec
        sbc     FACEXP
        sta     FACEXP
        jsr     LA137
        inc     FACEXP
        beq     LA15F
        ldx     #$FC
        lda     #$01
LA1AE:  ldy     ARGH0
        cpy     FACH0
        bne     LA1C4
        ldy     $6B
        cpy     $63
        bne     LA1C4
        ldy     $6C
        cpy     $64
        bne     LA1C4
        ldy     $6D
        cpy     $65
LA1C4:  php
        rol     a
        bcc     LA1D1
        inx
        sta     $29,x
        beq     LA1FF
        bpl     LA203
        lda     #$01
LA1D1:  plp
        bcs     LA1E2
LA1D4:  asl     $6D
        rol     $6C
        rol     $6B
        rol     ARGH0
        bcs     LA1C4
        bmi     LA1AE
        bpl     LA1C4
LA1E2:  tay
        lda     $6D
        sbc     $65
        sta     $6D
        lda     $6C
        sbc     $64
        sta     $6C
        lda     $6B
        sbc     $63
        sta     $6B
        lda     ARGH0
        sbc     FACH0
        sta     ARGH0
        tya
        jmp     LA1D4

LA1FF:  lda     #$40
        bne     LA1D1
LA203:  asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        sta     FACOV
        plp
LA20C:  lda     RESH0
        sta     FACH0
        lda     $27
        sta     $63
        lda     $28
        sta     $64
        lda     $29
        sta     $65
        jmp     L9F0B

LA21F:  clc
        .byte   $24
LA221:  sec
        sta     INDEX1
        sty     $23
        ldy     #$04
        jsr     LA320
        sta     $65
        dey
        jsr     LA320
        sta     $64
        dey
        jsr     LA320
        sta     $63
        dey
        jsr     LA320
        sta     FACSGN
        ora     #$80
        sta     FACH0
        dey
        jsr     LA320
        sta     FACEXP
        sty     FACOV
        rts

LA24C:  ldx     #$5C
        .byte   $2C
LA24F:  ldx     #$57
        ldy     #$00
        beq     LA259
LA255:  ldx     FORPNT
        ldy     $4A
LA259:  jsr     LA2A0
        stx     INDEX1
        sty     $23
        ldy     #$04
        lda     $65
        sta     (INDEX1),y
        dey
        lda     $64
        sta     (INDEX1),y
        dey
        lda     $63
        sta     (INDEX1),y
        dey
        lda     FACSGN
        ora     #$7F
        and     FACH0
        sta     (INDEX1),y
        dey
        lda     FACEXP
        sta     (INDEX1),y
        sty     FACOV
        rts

LA281:  lda     ARGSGN
LA283:  sta     FACSGN
        ldx     #$05
LA287:  lda     BITS,x
        sta     $60,x
        dex
        bne     LA287
        stx     FACOV
        rts

LA291:  jsr     LA2A0
LA294:  ldx     #$06
LA296:  lda     $60,x
        sta     BITS,x
        dex
        bne     LA296
        stx     FACOV
LA29F:  rts

LA2A0:  lda     FACEXP
        beq     LA29F
        asl     FACOV
        bcc     LA29F
LA2A8:  jsr     L9FA3
        bne     LA29F
        jmp     L9F6C

LA2B0:  lda     FACEXP
        beq     LA2BD
LA2B4:  lda     FACSGN
LA2B6:  rol     a
        lda     #$FF
        bcs     LA2BD
        lda     #$01
LA2BD:  rts

LA2BE:  jsr     LA2B0
LA2C1:  sta     FACH0
        lda     #$00
        sta     $63
        ldx     #$88
LA2C9:  lda     FACH0
        eor     #$FF
        rol     a
LA2CE:  lda     #$00
        sta     $65
        sta     $64
LA2D4:  stx     FACEXP
        sta     FACOV
        sta     FACSGN
        jmp     L9F06

LA2DD:  lsr     FACSGN
        rts

LA2E0:  sta     INDEX2
        sty     $25
        ldy     #$00
        lda     (INDEX2),y
        iny
        tax
        beq     LA2B0
        lda     (INDEX2),y
        eor     FACSGN
        bmi     LA2B4
        cpx     FACEXP
        bne     LA317
        lda     (INDEX2),y
        ora     #$80
        cmp     FACH0
        bne     LA317
        iny
        lda     (INDEX2),y
        cmp     $63
        bne     LA317
        iny
        lda     (INDEX2),y
        cmp     $64
        bne     LA317
        iny
        lda     #$7F
        cmp     FACOV
        lda     (INDEX2),y
        sbc     $65
        beq     LA346
LA317:  lda     FACSGN
        bcc     LA31D
        eor     #$FF
LA31D:  jmp     LA2B6

LA320:  lda     (INDEX1),y
        bcs     LA346
        jmp     INDIN1

LA327:  lda     FACEXP
        beq     LA375
        sec
        sbc     #$A0
        bit     FACSGN
        bpl     LA33B
        tax
        lda     #$FF
        sta     BITS
        jsr     L9F81
        txa
LA33B:  ldx     #$61
        cmp     #$F9
        bpl     LA347
        jsr     L9FCD
        sty     BITS
LA346:  rts

LA347:  tay
        lda     FACSGN
        and     #$80
        lsr     FACH0
        ora     FACH0
        sta     FACH0
        jsr     L9FE4
        sty     BITS
        rts

LA358:  lda     FACEXP
        cmp     #$A0
        bcs     LA37E
        jsr     LA327
        sty     FACOV
        lda     FACSGN
        sty     FACSGN
        eor     #$80
        rol     a
        lda     #$A0
        sta     FACEXP
        lda     $65
        sta     CHARAC
        jmp     L9F06

LA375:  sta     FACH0
        sta     $63
        sta     $64
        sta     $65
        tay
LA37E:  rts

LA37F:  ldy     #$00
        ldx     #$0A
LA383:  sty     $5D,x
        dex
        bpl     LA383
        bcc     LA399
        cmp     #$2D
        bne     LA392
        stx     SGNFLG
        beq     LA396
LA392:  cmp     #$2B
        bne     LA39B
LA396:  jsr     CHRGET
LA399:  bcc     LA3F6
LA39B:  cmp     #$2E
        beq     LA3CD
        cmp     #$45
        bne     LA3D3
        jsr     CHRGET
        bcc     LA3BF
        cmp     #$AB
        beq     LA3BA
        cmp     #$2D
        beq     LA3BA
        cmp     #$AA
        beq     LA3BC
        cmp     #$2B
        beq     LA3BC
        bne     LA3C1
LA3BA:  ror     $60
LA3BC:  jsr     CHRGET
LA3BF:  bcc     LA41D
LA3C1:  bit     $60
        bpl     LA3D3
        lda     #$00
        sec
        sbc     $5E
        jmp     LA3D5

LA3CD:  ror     $5F
        bit     $5F
        bvc     LA396
LA3D3:  lda     $5E
LA3D5:  sec
        sbc     $5D
        sta     $5E
        beq     LA3EE
        bpl     LA3E7
LA3DE:  jsr     LA183
        inc     $5E
        bne     LA3DE
        beq     LA3EE
LA3E7:  jsr     LA162
        dec     $5E
        bne     LA3E7
LA3EE:  lda     SGNFLG
        bmi     LA3F3
        rts

LA3F3:  jmp     LA627

LA3F6:  pha
        bit     $5F
        bpl     LA3FD
        inc     $5D
LA3FD:  jsr     LA162
        pla
        sec
        sbc     #$30
        jsr     LA40A
        jmp     LA396

LA40A:  pha
        jsr     LA291
        pla
        jsr     LA2C1
        lda     ARGSGN
        eor     FACSGN
        sta     ARISGN
        ldx     FACEXP
        jmp     L9E9E

LA41D:  lda     $5E
        cmp     #$0A
        bcc     LA42C
        lda     #$64
        bit     $60
        bmi     LA43F
        jmp     L9FB2

LA42C:  asl     a
        asl     a
        clc
        adc     $5E
        asl     a
        clc
        ldy     #$00
        sta     $78
        jsr     INDTXT
        adc     $78
        sec
        sbc     #$30
LA43F:  sta     $5E
        jmp     LA3BC

LA444:  .byte   $9B,$3E,$BC,$1F,$FD
LA449:  .byte   $9E,$6E,$6B,$27,$FD
LA44E:  .byte   $9E,$6E,$6B,$28,$00
LA453:  jsr     LFF4F
        .TEXT   " IN "
        .byte   $00
LA45B:  lda     $3A
        ldx     CHRLIN
LA45F:  sta     FACH0
        stx     $63
        ldx     #$90
        sec
        jsr     LA2CE
        jsr     LA471
        jmp     L9088

LA46F:  ldy     #$01
LA471:  lda     #$20
        bit     FACSGN
        bpl     LA479
        lda     #$2D
LA479:  sta     LOFBUF,y
        sta     FACSGN
        sty     FBUFPT
        iny
        lda     #$30
        ldx     FACEXP
        bne     LA48A
        jmp     LA596

LA48A:  lda     #$00
        cpx     #$80
        beq     LA492
        bcs     LA49B
LA492:  lda     #$4E
        ldy     #$A4
        jsr     LA05C
        lda     #$F7
LA49B:  sta     $5D
LA49D:  lda     #$49
        ldy     #$A4
        jsr     LA2E0
        beq     LA4C4
        bpl     LA4BA
LA4A8:  lda     #$44
        ldy     #$A4
        jsr     LA2E0
        beq     LA4B3
        bpl     LA4C1
LA4B3:  jsr     LA162
        dec     $5D
        bne     LA4A8
LA4BA:  jsr     LA183
        inc     $5D
        bne     LA49D
LA4C1:  jsr     LA062
LA4C4:  jsr     LA327
        ldx     #$01
        lda     $5D
        clc
        adc     #$0A
        bmi     LA4D9
        cmp     #$0B
        bcs     LA4DA
        adc     #$FF
        tax
        lda     #$02
LA4D9:  sec
LA4DA:  sbc     #$02
        sta     $5E
        stx     $5D
        txa
        beq     LA4E5
        bpl     LA4F8
LA4E5:  ldy     FBUFPT
        lda     #$2E
        iny
        sta     LOFBUF,y
        txa
        beq     LA4F6
        lda     #$30
        iny
        sta     LOFBUF,y
LA4F6:  sty     FBUFPT
LA4F8:  ldy     #$00
LA4FA:  ldx     #$80
LA4FC:  lda     $65
        clc
        adc     LA5AB,y
        sta     $65
        lda     $64
        adc     LA5AA,y
        sta     $64
        lda     $63
        adc     LA5A9,y
        sta     $63
        lda     FACH0
        adc     LA5A8,y
        sta     FACH0
        inx
        bcs     LA520
        bpl     LA4FC
        bmi     LA522
LA520:  bmi     LA4FC
LA522:  txa
        bcc     LA529
        eor     #$FF
        adc     #$0A
LA529:  adc     #$2F
        iny
        iny
        iny
        iny
        sty     VARPNT
        ldy     FBUFPT
        iny
        tax
        and     #$7F
        sta     LOFBUF,y
        dec     $5D
        bne     LA544
        lda     #$2E
        iny
        sta     LOFBUF,y
LA544:  sty     FBUFPT
        ldy     VARPNT
        txa
        eor     #$FF
        and     #$80
        tax
        cpy     #$24
        beq     LA556
        cpy     #$3C
        bne     LA4FC
LA556:  ldy     FBUFPT
LA558:  lda     LOFBUF,y
        dey
        cmp     #$30
        beq     LA558
        cmp     #$2E
        beq     LA565
        iny
LA565:  lda     #$2B
        ldx     $5E
        beq     LA599
        bpl     LA575
        lda     #$00
        sec
        sbc     $5E
        tax
        lda     #$2D
LA575:  sta     $0101,y
        lda     #$45
        sta     FBUFFER,y
        txa
        ldx     #$2F
        sec
LA581:  inx
        sbc     #$0A
        bcs     LA581
        adc     #$3A
        sta     $0103,y
        txa
        sta     $0102,y
        lda     #$00
        sta     $0104,y
        beq     LA59E
LA596:  sta     LOFBUF,y
LA599:  lda     #$00
        sta     FBUFFER,y
LA59E:  lda     #$00
        ldy     #$01
        rts

LA5A3:  .byte   $80,$00,$00,$00,$00
LA5A8:  .byte   $FA
LA5A9:  .byte   $0A
LA5AA:  .byte   $1F
LA5AB:  .byte   $00
LA5AC:  .byte   $00,$98,$96,$80
LA5B0:  .byte   $FF,$F0,$BD,$C0
LA5B4:  .byte   $00,$01,$86,$A0
LA5B8:  .byte   $FF,$FF,$D8,$F0
LA5BC:  .byte   $00,$00,$03,$E8
LA5C0:  .byte   $FF,$FF,$FF,$9C
LA5C4:  .byte   $00,$00,$00,$0A
LA5C8:  .byte   $FF,$FF,$FF,$FF
LA5CC:  .byte   $FF,$DF,$0A,$80
LA5D0:  .byte   $00,$03,$4B,$C0
LA5D4:  .byte   $FF,$FF,$73,$60
LA5D8:  .byte   $00,$00,$0E,$10
LA5DC:  .byte   $FF,$FF,$FD,$A8
LA5E0:  .byte   $00,$00,$00,$3C
LA5E4:  jsr     LA291
        lda     #$A3
        ldy     #$A5
        jsr     LA221
LA5EE:  beq     LA660
        lda     ARGEXP
        bne     LA5F7
        jmp     L9F2D

LA5F7:  ldx     #$4E
        ldy     #$00
        jsr     LA259
        lda     ARGSGN
        bpl     LA611
        jsr     LA358
        lda     #$4E
        ldy     #$00
        jsr     LA2E0
        bne     LA611
        tya
        ldy     CHARAC
LA611:  jsr     LA283
        tya
        pha
        jsr     LA01E
        lda     #$4E
        ldy     #$00
        jsr     LA078
        jsr     LA660
        pla
        lsr     a
        bcc     LA631
LA627:  lda     FACEXP
        beq     LA631
        lda     FACSGN
        eor     #$FF
        sta     FACSGN
LA631:  rts

LA632:  .byte   $81,$38,$AA,$3B,$29
LA637:  .byte   $07
LA638:  .byte   $71,$34,$58,$3E,$56
LA63D:  .byte   $74,$16,$7E,$B3,$1B
LA642:  .byte   $77,$2F,$EE,$E3,$85
LA647:  .byte   $7A,$1D,$84,$1C,$2A
LA64C:  .byte   $7C,$63,$59,$58,$0A
LA651:  .byte   $7E,$75,$FD,$E7,$C6
LA656:  .byte   $80,$31,$72,$18,$10
LA65B:  .byte   $81,$00,$00,$00,$00
LA660:  lda     #$32
        ldy     #$A6
        jsr     LA05C
        lda     FACOV
        adc     #$50
        bcc     LA670
        jsr     LA2A8
LA670:  sta     $56
        jsr     LA294
        lda     FACEXP
        cmp     #$88
        bcc     LA67E
LA67B:  jsr     LA154
LA67E:  jsr     LA358
        lda     CHARAC
        clc
        adc     #$81
        beq     LA67B
        sec
        sbc     #$01
        pha
        ldx     #$05
LA68E:  lda     ARGEXP,x
        ldy     FACEXP,x
        sta     FACEXP,x
        sty     ARGEXP,x
        dex
        bpl     LA68E
        lda     $56
        sta     FACOV
        jsr     L9E87
        jsr     LA627
        lda     #$37
        ldy     #$A6
        jsr     LA6C9
        lda     #$00
        sta     ARISGN
        pla
        jsr     LA139
        rts

LA6B3:  sta     FBUFPT
        sty     $72
        jsr     LA24F
        lda     #$57
        jsr     LA078
        jsr     LA6CD
        lda     #$57
        ldy     #$00
        jmp     LA078

LA6C9:  sta     FBUFPT
        sty     $72
LA6CD:  jsr     LA24C
        lda     (FBUFPT),y
        sta     SGNFLG
        ldy     FBUFPT
        iny
        tya
        bne     LA6DC
        inc     $72
LA6DC:  sta     FBUFPT
        ldy     $72
LA6E0:  jsr     LA05C
        lda     FBUFPT
        ldy     $72
        clc
        adc     #$05
        bcc     LA6ED
        iny
LA6ED:  sta     FBUFPT
        sty     $72
        jsr     LA066
        lda     #$5C
        ldy     #$00
        dec     SGNFLG
        bne     LA6E0
        rts

LA6FD:  .byte   $98,$35,$44,$7A,$00
LA702:  .byte   $68,$28,$B1,$46,$00
LA707:  jsr     LA2B0
        bmi     LA73A
        bne     LA725
        lda     TEDT1RL
        sta     FACH0
        lda     TEDT1RH
        sta     $64
        lda     TEDT2L
        sta     $63
        lda     TEDT2H
        sta     $65
        jmp     LA74A

LA725:  lda     #$03
        ldy     #$05
        jsr     LA221
        lda     #$FD
        ldy     #$A6
        jsr     LA05C
        lda     #$02
        ldy     #$A7
        jsr     LA066
LA73A:  ldx     $65
        lda     FACH0
        sta     $65
        stx     FACH0
        ldx     $63
        lda     $64
        sta     $63
        stx     $64
LA74A:  lda     #$00
        sta     FACSGN
        lda     FACEXP
        sta     FACOV
        lda     #$80
        sta     FACEXP
        jsr     L9F0B
        ldx     #$03
        ldy     #$05
LA75D:  jmp     LA259

LA760:  lda     TOS
        sta     FNDPNT
        lda     $7D
        sta     $3E
        rts

LA769:  lda     FNDPNT
        sta     TOS
        lda     $3E
        sta     $7D
        rts

LA772:  tya
        clc
        adc     TOS
        sta     TOS
        bcc     LA77C
        inc     $7D
LA77C:  rts

LA77D:  tax
        bne     LA782
        ldx     #$1E
LA782:  jmp     L8683

LA785:  jsr     kOPEN
        bcs     LA77D
        rts

LA78B:  jsr     kCHROUT
        bcs     LA77D
        rts

LA791:  jsr     kCHRIN
        bcs     LA77D
        rts

LA797:  pha
        jsr     kCHKOUT
        jsr     LA8F8
        tax
        pla
        bcc     LA7A5
        txa
        bcs     LA77D
LA7A5:  rts

LA7A6:  jsr     kCHKIN
        jsr     LA8F8
        bcs     LA77D
        rts

LA7AF:  jsr     kGETIN
        bcs     LA77D
        rts

LA7B5:  jsr     L9DE1
        lda     #$A7
        pha
        lda     #$CE
        pha
        lda     SPREG
        pha
        lda     SAREG
        ldx     SXREG
        ldy     SYREG
        plp
        jmp     (LINNUM)

        php
        sta     SAREG
        stx     SXREG
        sty     SYREG
        pla
        sta     SPREG
        rts

LA7DE:  jsr     LA86B
LA7E1:  ldx     VARTAB
        ldy     $2E
        lda     #$2B
        jsr     kSAVE
        jsr     LA8F8
        bcs     LA77D
        rts

LA7F0:  lda     #$01
        .byte   $2C
LA7F3:  lda     #$00
        sta     VERCK
        jsr     LA86B
LA7FA:  lda     VERCK
        ldx     TXTTAB
        ldy     $2C
        jsr     kLOAD
        php
        jsr     LA8F8
        plp
        bcs     LA868
        lda     VERCK
        beq     LA824
        ldx     #$1C
        jsr     kREADST
        and     #$10
        bne     LA82D
        bit     RUNMOD
        bmi     LA823
        jsr     LFF4F
        .byte   $0D
        .TEXT   "OK"
        .byte   $0D,$00
LA823:  rts

LA824:  jsr     kREADST
        and     #$BF
        beq     LA830
        ldx     #$1D
LA82D:  jmp     L8683

LA830:  bit     RUNMOD
        bmi     LA844
        stx     VARTAB
        sty     $2E
        jsr     L866F
        jsr     L8818
        jsr     L8A93
        jmp     L870F

LA844:  jsr     L8AF1
        jsr     L8818
        jmp     L8AD5

LA84D:  jsr     LA8B0
        clc
        jsr     LA785
        jsr     LA8F8
        bcs     LA868
        rts

LA85A:  jsr     LA8B0
        lda     FORPNT
        clc
        jsr     kCLOSE
        jsr     LA8F8
        bcc     LA823
LA868:  jmp     LA77D

LA86B:  lda     #$00
        jsr     kSETNAM
        ldx     #$01
        ldy     #$00
        jsr     kSETLFS
        jsr     LA89D
        jsr     LA8EE
        jsr     LA89D
        jsr     LA897
        ldy     #$00
        stx     FORPNT
        jsr     kSETLFS
        jsr     LA89D
        jsr     LA897
        txa
        tay
        ldx     FORPNT
        jmp     kSETLFS

LA897:  jsr     LA8A5
        jmp     L9D84

LA89D:  jsr     CHRGOT
        bne     LA8A4
        pla
        pla
LA8A4:  rts

LA8A5:  jsr     L9491
LA8A8:  jsr     CHRGOT
        bne     LA8A4
        jmp     L94A1

LA8B0:  lda     #$00
        jsr     kSETNAM
        jsr     LA8A8
        jsr     L9D84
        stx     FORPNT
        txa
        ldx     #$01
        ldy     #$00
        jsr     kSETLFS
        jsr     LA89D
        jsr     LA897
        stx     $4A
        ldy     #$00
        lda     FORPNT
        cpx     #$03
        bcc     LA8D6
        dey
LA8D6:  jsr     kSETLFS
        jsr     LA89D
        jsr     LA897
        txa
        tay
        ldx     $4A
        lda     FORPNT
        jsr     kSETLFS
        jsr     LA89D
        jsr     LA8A5
LA8EE:  jsr     L9C48
        ldx     INDEX1
        ldy     $23
        jmp     kSETNAM

LA8F8:  php
        pha
        lda     FA
        cmp     #$04
        bcc     LA903
        jsr     LCD57
LA903:  pla
        plp
        rts

LA906:  lsr     DORES
LA908:  tax
        beq     LA943
        pha
        lda     FRETOP
        sec
        sbc     #$02
        ldy     $34
        bcs     LA916
        dey
LA916:  sta     INDEX1
        sty     $23
        txa
        eor     #$FF
        sec
        adc     INDEX1
        bcs     LA923
        dey
LA923:  cpy     $32
        bcc     LA944
        bne     LA92D
        cmp     STREND
        bcc     LA944
LA92D:  sta     FRESPC
        sty     $36
        ldy     #$01
        lda     #$FF
        sta     (INDEX1),y
        dey
        pla
        sta     (INDEX1),y
        ldx     FRESPC
        ldy     $36
        stx     FRETOP
        sty     $34
LA943:  rts

LA944:  lda     DORES
        bmi     LA951
        jsr     LA954
        sec
        ror     DORES
        pla
        bne     LA908
LA951:  jmp     L8681

LA954:  ldx     TEMPPT
LA956:  cpx     #$19
        beq     LA96A
        jsr     LAA57
        beq     LA956
        txa
        ldy     #$00
        sta     ($5C),y
        tya
        iny
        sta     ($5C),y
        bne     LA956
LA96A:  ldy     #$00
        sty     $58
        ldx     MEMSIZ
        ldy     $38
        stx     $5F
        stx     DEFPNT
        stx     FRESPC
        sty     $60
        sty     $4F
        sty     $36
        txa
LA97F:  jsr     LA9EA
        bne     LA990
LA984:  dey
        jsr     L8165
        jsr     LAA39
        sec
        ror     $58
        bne     LA97F
LA990:  bit     $58
        bpl     LA9D6
        ldx     #$00
        stx     $58
        lda     #$02
LA99A:  ldy     #$01
        jsr     L8165
        sta     ($5F),y
        dey
        jsr     L8165
        sta     ($5F),y
        jsr     INDIN1
        tax
        jsr     LAA48
        sta     FRESPC
        sty     $36
        txa
        jsr     LAA39
        txa
        tay
LA9B8:  dey
        jsr     L8165
        sta     ($5F),y
        dex
        bne     LA9B8
        ldy     #$02
LA9C3:  lda     $5E,y
        sta     (INDEX1),y
        dey
        bne     LA9C3
        lda     DEFPNT
        ldy     $4F
        jsr     LA9EA
        beq     LA984
        bne     LA99A
LA9D6:  ldy     #$00
        jsr     INDIN1
        tax
        jsr     LAA48
        sta     FRESPC
        sty     $36
        txa
        jsr     LAA39
        jmp     LA97F

LA9EA:  cpy     $34
        bcc     LAA18
        bne     LA9F6
        cmp     FRETOP
        beq     LAA18
        bcc     LAA18
LA9F6:  bit     $58
        bmi     LA9FF
        lda     #$02
        jsr     LAA48
LA9FF:  lda     #$02
        jsr     LAA39
        ldy     #$01
        jsr     L8165
        cmp     #$FF
        bne     LAA0E
        rts

LAA0E:  jsr     L8165
        sta     INDEX1,y
        dey
        bpl     LAA0E
        rts

LAA18:  ldx     TEMPPT
LAA1A:  cpx     #$19
        beq     LAA2E
        jsr     LAA57
        beq     LAA1A
        ldy     #$00
        sta     ($5C),y
        iny
        lda     #$FF
        sta     ($5C),y
        bne     LAA1A
LAA2E:  pla
        pla
        lda     FRESPC
        ldy     $36
        sta     FRETOP
        sty     $34
        rts

LAA39:  eor     #$FF
        sec
        adc     DEFPNT
        ldy     $4F
        bcs     LAA43
        dey
LAA43:  sta     DEFPNT
        sty     $4F
        rts

LAA48:  eor     #$FF
        sec
        adc     $5F
        ldy     $60
        bcs     LAA52
        dey
LAA52:  sta     $5F
        sty     $60
        rts

LAA57:  dex
        lda     PDIR,x
        sta     $5D
        dex
        lda     PDIR,x
        sta     $5C
        dex
        lda     PDIR,x
        pha
        clc
        adc     $5C
        sta     $5C
        bcc     LAA6E
        inc     $5D
LAA6E:  pla
        rts

LAA70:  lda     #$EC
        ldy     #$AA
        jsr     LA066
LAA77:  jsr     LA291
        lda     #$F1
        ldy     #$AA
        ldx     ARGSGN
        jsr     LA18C
        jsr     LA291
        jsr     LA358
        lda     #$00
        sta     ARISGN
        jsr     L9E87
        lda     #$F6
        ldy     #$AA
        jsr     LA06C
        lda     FACSGN
        pha
        bpl     LAAA9
        jsr     LA062
        lda     FACSGN
        bmi     LAAAC
        lda     TANSGN
        eor     #$FF
        sta     TANSGN
LAAA9:  jsr     LA627
LAAAC:  lda     #$F6
        ldy     #$AA
        jsr     LA066
        pla
        bpl     LAAB9
        jsr     LA627
LAAB9:  lda     #$FB
        ldy     #$AA
        jmp     LA6B3

LAAC0:  jsr     LA24F
        lda     #$00
        sta     TANSGN
        jsr     LAA77
        ldx     #$4E
        ldy     #$00
        jsr     LA75D
        lda     #$57
        ldy     #$00
        jsr     LA221
        lda     #$00
        sta     FACSGN
        lda     TANSGN
        jsr     LAAE8
        lda     #$4E
        ldy     #$00
        jmp     LA194

LAAE8:  pha
        jmp     LAAA9

LAAEC:  .byte   $81,$49,$0F,$DA,$A2
LAAF1:  .byte   $83,$49,$0F,$DA,$A2
LAAF6:  .byte   $7F,$00,$00,$00,$00
LAAFB:  .byte   $05
LAAFC:  .byte   $84,$E6,$1A,$2D,$1B
LAB01:  .byte   $86,$28,$07,$FB,$F8
LAB06:  .byte   $87,$99,$68,$89,$01
LAB0B:  .byte   $87,$23,$35,$DF,$E1
LAB10:  .byte   $86,$A5,$5D,$E7,$28
LAB15:  .byte   $83,$49,$0F,$DA,$A2
LAB1A:  lda     FACSGN
        pha
        bpl     LAB22
        jsr     LA627
LAB22:  lda     FACEXP
        pha
        cmp     #$81
        bcc     LAB30
        lda     #$F0
        ldy     #$9F
        jsr     LA072
LAB30:  lda     #$4A
        ldy     #$AB
        jsr     LA6B3
        pla
        cmp     #$81
        bcc     LAB43
        lda     #$EC
        ldy     #$AA
        jsr     LA06C
LAB43:  pla
        bpl     LAB49
        jmp     LA627

LAB49:  rts

LAB4A:  .byte   $0B
LAB4B:  .byte   $76,$B3,$83,$BD,$D3
LAB50:  .byte   $79,$1E,$F4,$A6,$F5
LAB55:  .byte   $7B,$83,$FC,$B0,$10
LAB5A:  .byte   $7C,$0C,$1F,$67,$CA
LAB5F:  .byte   $7C,$DE,$53,$CB,$C1
LAB64:  .byte   $7D,$14,$64,$70,$4C
LAB69:  .byte   $7D,$B7,$EA,$51,$7A
LAB6E:  .byte   $7D,$63,$30,$88,$7E
LAB73:  .byte   $7E,$92,$44,$99,$3A
LAB78:  .byte   $7E,$4C,$CC,$91,$C7
LAB7D:  .byte   $7F,$AA,$AA,$AA,$13
LAB82:  .byte   $81,$00,$00,$00
LAB86:  .byte   $00
LAB87:  .byte   $89,$8A,$8D,$A7,$8C,$D6,$D7,$D5
LAB8F:  jsr     LB6DE
        lda     #$00
        ldx     #$0A
        stx     ZPVEC1
        sta     $04
        stx     ZPVEC2
        sta     $06
        sta     $5A
        sta     $5B
        jsr     CHRGOT
        beq     LAC0D
        jsr     L8E3E
        lda     ENDCHR
        beq     LABB6
        lda     LINNUM
        ldx     $15
        sta     ZPVEC1
        stx     $04
LABB6:  jsr     CHRGOT
        beq     LAC0D
        jsr     L9491
        jsr     L8E3E
        lda     ENDCHR
        beq     LABD5
        lda     LINNUM
        ldx     $15
        sta     ZPVEC2
        stx     $06
        bne     LABD5
        tax
        bne     LABD5
LABD2:  jmp     L991C

LABD5:  jsr     CHRGOT
        beq     LAC0D
        jsr     L9491
        jsr     L8E3E
        lda     LINNUM
        ldx     $15
        sta     $5A
        stx     $5B
        jsr     L8A3D
        lda     $5F
        ldx     $60
        sta     $58
        stx     $59
        lda     ZPVEC1
        ldx     $04
        sta     LINNUM
        stx     $15
        jsr     L8A3D
        lda     $60
        sec
        sbc     $59
        bcc     LABD2
        bne     LAC0D
        lda     $5F
        sbc     $58
        bcc     LABD2
LAC0D:  jsr     L8AF1
LAC10:  jsr     LAD86
        jsr     LAD86
        bne     LAC55
        jsr     LAD59
LAC1B:  jsr     LAD86
        jsr     LAD86
        bne     LAC26
        jmp     LAEB3

LAC26:  jsr     LAD86
        sta     LINNUM
        iny
        jsr     INDTXT
        sec
        sbc     $5B
        bcc     LAC4D
        bne     LAC3C
        lda     LINNUM
        sbc     $5A
        bcc     LAC4D
LAC3C:  lda     FACH0
        sta     (TXTPTR),y
        dey
        lda     $63
        sta     (TXTPTR),y
        jsr     LAD86
        jsr     LAD73
        beq     LAC1B
LAC4D:  jsr     LAD86
        jsr     LAD80
        beq     LAC1B
LAC55:  jsr     LAD86
        jsr     LAD86
LAC5B:  jsr     LAD86
LAC5E:  cmp     #$22
        bne     LAC6D
LAC62:  jsr     LAD86
        beq     LAC10
        cmp     #$22
        bne     LAC62
        beq     LAC5B
LAC6D:  tax
        beq     LAC10
        bpl     LAC5B
        ldx     #$08
LAC74:  cmp     LAB86,x
        beq     LAC89
        dex
        bne     LAC74
        cmp     #$CB
        bne     LAC5B
        jsr     CHRGET
        beq     LAC10
        cmp     #$A4
        bne     LAC5B
LAC89:  lda     TXTPTR
        sta     OLDLIN
        lda     $3C
        sta     $025A
        jsr     CHRGET
        bcs     LAC5E
        jsr     L8E3E
        jsr     LACEE
        lda     OLDLIN
        sta     TXTPTR
        lda     $025A
        sta     $3C
        ldy     #$00
        ldx     #$00
LACAC:  lda     $0101,x
        beq     LACCD
        pha
        jsr     CHRGET
        bcc     LACC5
.if COMPILECOMPUTER >= PLUS4_BETA_0203
        jsr     LAD42
        inc     $6C
        jsr     LADBB
        inc     VARTAB
        bne     LACC5
        inc     $2E
.else
        jsr     LAD33
.fi
LACC5:  pla
        ldy     #$00
        sta     (TXTPTR),y
        inx
        bne     LACAC
LACCD:  jsr     CHRGET
        bcs     LACE7
LACD2:  jsr     LAD42
        dec     $6C
        jsr     LADA2
        lda     VARTAB
        bne     LACE0
        dec     $2E
LACE0:  dec     VARTAB
        jsr     CHRGOT
        bcc     LACD2
LACE7:  cmp     #$2C
        beq     LAC89
        jmp     LAC5E

LACEE:  jsr     LAD59
LACF1:  jsr     LAD86
        bne     LAD03
        jsr     LAD86
        bne     LAD06
        lda     #$FF
        sta     FACH0
        sta     $63
        bmi     LAD2D
LAD03:  jsr     LAD86
LAD06:  jsr     LAD86
        sta     $58
        cmp     LINNUM
        bne     LAD36
        jsr     LAD86
        sta     $59
        cmp     $15
        bne     LAD3B
        sec
        sbc     $5B
        bcc     LAD25
        bne     LAD2D
        lda     LINNUM
        sbc     $5A
        bcs     LAD2D
LAD25:  lda     LINNUM
        sta     $63
        lda     $15
        sta     FACH0
LAD2D:  ldx     #$90
        sec
        jsr     LA2CE
        jmp     LA46F

LAD36:  jsr     LAD86
.if COMPILECOMPUTER >= PLUS4_BETA_0203
        sta     $59
.fi
LAD3B:  jsr     LAD64
        beq     LACF1
.if COMPILECOMPUTER == PLUS4_BETA_0119
LAD33:  jsr     LAD42
        inc     $6c
        jsr     LADBB
        inc     VARTAB
        bne     LAD41
        inc     $2E
LAD41:  rts

.elsif COMPILECOMPUTER >= PLUS4_01
        .byte   $D9,$EA
.else
        .byte   $EA,$C3
.fi
LAD42:  lda     TXTPTR
        sta     INDEX1
        lda     $3C
        sta     $23
        lda     VARTAB
        sta     INDEX2
        lda     $2E
        sta     $25
        ldy     #$00
        sty     COUNT
        sty     $6C
        rts

LAD59:  lda     ZPVEC1
        sta     $63
        lda     $04
        sta     FACH0
        jmp     L8AF1

LAD64:  lda     $59
        sec
        sbc     $5B
        bcc     LAD80
        bne     LAD73
        lda     $58
        sbc     $5A
        bcc     LAD80
LAD73:  lda     $63
        clc
        adc     ZPVEC2
        sta     $63
        lda     FACH0
        adc     $06
        sta     FACH0
LAD80:  jsr     LAD86
        bne     LAD80
        rts

LAD86:  ldy     #$00
        inc     TXTPTR
        bne     LAD8E
        inc     $3C
LAD8E:  jmp     INDTXT

LAD91:  lda     INDEX1
        cmp     INDEX2
        bne     LAD9B
        lda     $23
        cmp     $25
LAD9B:  rts

LAD9C:  inc     INDEX1
        bne     LADA2
        inc     $23
LADA2:  ldy     COUNT
        iny
        jsr     INDIN1
        ldy     $6C
        iny
        sta     (INDEX1),y
        jsr     LAD91
        bne     LAD9C
        rts

LADB3:  lda     INDEX2
        bne     LADB9
        dec     $25
LADB9:  dec     INDEX2
LADBB:  ldy     COUNT
        jsr     INDIN2
        ldy     $6C
        sta     (INDEX2),y
        jsr     LAD91
        bne     LADB3
        rts

LADCA:  lda     #$80
        sta     SUBFLG
        jsr     L8E7C
        lda     #$81
        sta     SRCHTK
        jsr     L8871
        beq     LADE2
        ldy     #$12
        jsr     L8905
        jsr     LA760
LADE2:  jsr     LA769
        jsr     L8DBE
        tya
        ldy     #$11
        clc
        adc     TXTPTR
        sta     (TOS),y
        lda     $3C
        adc     #$00
        dey
        sta     (TOS),y
        lda     $3A
        dey
        sta     (TOS),y
        lda     CHRLIN
        dey
        sta     (TOS),y
        lda     #$A4
        jsr     L9493
        jsr     L9317
        jsr     L9314
        lda     FACSGN
        ora     #$7F
        and     FACH0
        sta     FACH0
        ldx     #$04
        ldy     #$0D
LAE18:  lda     FACEXP,x
        sta     (TOS),y
        dex
        dey
        bpl     LAE18
        lda     #$F0
        ldy     #$9F
        jsr     LA221
        jsr     CHRGOT
        cmp     #$A9
        bne     LAE34
        jsr     CHRGET
        jsr     L9314
LAE34:  jsr     LA2B0
        pha
        jsr     LA2A0
        pla
        ldy     #$08
        ldx     #$05
LAE40:  sta     (TOS),y
        lda     $60,x
        dey
        dex
        bpl     LAE40
        lda     $4A
        sta     (TOS),y
        lda     FORPNT
        dey
        sta     (TOS),y
        lda     #$81
        dey
        sta     (TOS),y
        rts

LAE57:  jmp     L94A1

LAE5A:  jsr     LB6DE
        jsr     CHRGOT
        beq     LAE57
        jsr     LAECA
        lda     $5F
        ldx     $60
        sta     INDEX2
        stx     $25
        jsr     L8A3D
        bcc     LAE87
        ldy     #$01
        jsr     INDLOW
        dey
        tax
        bne     LAE80
        jsr     INDLOW
        beq     LAE87
LAE80:  jsr     INDLOW
        sta     $5F
        stx     $60
LAE87:  lda     INDEX2
        sec
        sbc     $5F
        tax
        lda     $25
        sbc     $60
        tay
        bcs     LAEB3
        txa
        clc
        adc     VARTAB
        sta     VARTAB
        tya
        adc     $2E
        sta     $2E
        ldy     #$00
LAEA1:  jsr     INDLOW
        sta     (INDEX2),y
        iny
        bne     LAEA1
        inc     $60
        inc     $25
        lda     $2E
        cmp     $25
        bcs     LAEA1
LAEB3:  jsr     L8818
        lda     INDEX1
        ldx     $23
        clc
        adc     #$02
        sta     VARTAB
        bcc     LAEC2
        inx
LAEC2:  stx     $2E
        jsr     L8A93
        jmp     L867E

LAECA:  beq     LAED2
        bcc     LAED2
        cmp     #$AB
        bne     LAEF4
LAED2:  jsr     L8E3E
        jsr     L8A3D
        jsr     CHRGOT
        beq     LAEE9
        cmp     #$AB
        bne     LAEF4
        jsr     CHRGET
        jsr     L8E3E
        bne     LAEF4
LAEE9:  lda     ENDCHR
        bne     LAEF3
        lda     #$FF
        sta     LINNUM
        sta     $15
LAEF3:  rts

LAEF4:  jmp     L94A1

LAEF7:  ldx     #$FF
        stx     ENDFD
        jsr     CHRGET
        jsr     L932C
        jsr     L931A
        lda     $64
        pha
        lda     $65
        pha
        ldy     #$02
LAF0D:  jsr     INDFMO
        dey
        sta     FNDPNT,y
        bne     LAF0D
        jsr     INDFMO
        sta     LFOR
        tay
        beq     LAF2A
LAF1F:  dey
        jsr     L8171
        cmp     #$23
        beq     LAF2D
        tya
        bne     LAF1F
LAF2A:  jmp     L94A1

LAF2D:  lda     #$3B
LAF2F:  jsr     L9493
        sty     KEYNUM
        sty     BNR
        jsr     L932C
        bit     VALTYP
        bpl     LAF77
        jsr     LB170
        jsr     LB2B7
        ldx     CHSN
        beq     LAF5E
        ldx     #$00
        sec
        lda     CFORM
        sbc     $77
        bcc     LAF5E
        ldx     #$3D
        cpx     CHSN
        bne     LAF5D
        lsr     a
        adc     #$00
LAF5D:  tax
LAF5E:  ldy     #$00
LAF60:  txa
        beq     LAF68
        dex
LAF64:  lda     #$20
        bne     LAF70
LAF68:  cpy     $77
        bcs     LAF64
        jsr     INDIN1
        iny
LAF70:  jsr     LB2B0
        bne     LAF60
        beq     LAF9B
LAF77:  jsr     LA46F
        ldy     #$FF
LAF7C:  iny
        lda     FBUFFER,y
        bne     LAF7C
        tya
        jsr     L9B5C
        ldy     #$00
LAF88:  lda     FBUFFER,y
        beq     LAF92
        sta     (FACH0),y
        iny
        bne     LAF88
LAF92:  jsr     L9BB0
        jsr     LB170
        jsr     LAFBB
LAF9B:  jsr     CHRGOT
        cmp     #$2C
        beq     LAF2F
        sec
        ror     KEYNUM
        jsr     LB2B7
        pla
        tay
        pla
        jsr     L9C52
        jsr     CHRGOT
        cmp     #$3B
        beq     LAFB8
        jmp     L903E

LAFB8:  jmp     CHRGET

LAFBB:  lda     PUFILL
        sta     BLFD
        lda     #$FF
LAFC3:  sta     SNO
        jmp     LAFCB

LAFC9:  stx     POINT
LAFCB:  cpy     $77
        beq     LB002
        lda     FBUFFER,y
        iny
        cmp     #$20
        beq     LAFCB
        cmp     #$2D
        beq     LAFC3
        cmp     #$2E
        beq     LAFC9
        cmp     #$45
        beq     LAFF4
        sta     FBUFFER,x
        stx     ENR
        inx
        bit     POINT
        bpl     LAFCB
        inc     VN
        jmp     LAFCB

LAFF4:  lda     FBUFFER,y
        cmp     #$2D
        bne     LAFFE
        ror     USGN
LAFFE:  iny
        sty     UEXP
LB002:  lda     POINT
        bpl     LB008
        stx     POINT
LB008:  jsr     LB2B7
        lda     VF
        cmp     #$FF
        beq     LB03B
        lda     FESP
        beq     LB056
        lda     UEXP
        bne     LB02E
        ldx     ENR
        jsr     LB145
        dec     $0102,x
        inx
        stx     UEXP
        jsr     LB1CC
        beq     LB053
LB02E:  ldy     POSP
        bne     LB04A
        ldy     SNO
        bmi     LB04A
        lda     VF
LB03B:  beq     LB0A7
        dec     VF
        bne     LB047
        lda     NF
        beq     LB0A7
LB047:  inc     SWE
LB04A:  jsr     LB0BF
        jsr     LB18A
        jsr     LB0BF
LB053:  jmp     LB1ED

LB056:  ldy     UEXP
        beq     LB071
        sta     $77
        sec
        ror     ETOF
        ldy     POINT
        lda     USGN
        bpl     LB06E
        jsr     LB0F8
        jmp     LB07A

LB06E:  jsr     LB0D9
LB071:  ldy     POINT
        beq     LB07A
        jsr     LB1D0
        beq     LB080
LB07A:  jsr     LB18A
        jmp     LB083

LB080:  dec     VN
LB083:  sec
        lda     VF
        sbc     VN
        bcc     LB0A7
        sta     SWE
        ldy     POSP
        bne     LB0AF
        ldy     SNO
        bmi     LB0AF
        tay
        beq     LB0A7
        dey
        bne     LB0B2
        lda     NF
        ora     VN
        bne     LB053
LB0A7:  lda     #$2A
LB0A9:  jsr     LB2B0
        bne     LB0A9
        rts

LB0AF:  tay
        beq     LB053
LB0B2:  lda     VN
        bne     LB053
        dec     SWE
        inc     KEYNUM
        jmp     LB053

LB0BF:  sec
        lda     VF
        sbc     VN
        beq     LB101
        ldy     POINT
        bcc     LB0E2
        sta     $77
LB0CE:  cpy     ENR
        beq     LB0D5
        bcs     LB0D6
LB0D5:  iny
LB0D6:  inc     VN
LB0D9:  jsr     LB10E
        dec     $77
        bne     LB0CE
        beq     LB0FF
LB0E2:  eor     #$FF
        adc     #$01
        sta     $77
LB0E8:  cpy     BNR
        beq     LB0F4
        dey
        dec     VN
        jmp     LB0F6

LB0F4:  inc     KEYNUM
LB0F6:  lda     #$80
LB0F8:  jsr     LB110
        dec     $77
        bne     LB0E8
LB0FF:  sty     POINT
LB101:  rts

LB102:  bne     LB13D
        eor     #$09
        sta     FBUFFER,x
        dex
        cpx     UEXP
        rts

LB10E:  lda     #$00
LB110:  ldx     UEXP
        inx
        bit     ETOF
        bmi     LB129
        eor     USGN
        beq     LB129
LB11E:  jsr     LB153
        jsr     LB102
        bcs     LB11E
        jmp     L9FB2

LB129:  lda     FBUFFER,x
        dec     FBUFFER,x
        cmp     #$30
        jsr     LB102
        bcs     LB129
        bit     ETOF
        bpl     LB140
        sty     POINT
LB13D:  pla
        pla
        rts

LB140:  lda     USGN
        eor     #$80
LB145:  sta     USGN
        lda     #$30
        sta     $0101,x
        lda     #$31
        sta     $0102,x
        rts

LB153:  lda     FBUFFER,x
        inc     FBUFFER,x
        cmp     #$39
        rts

LB15C:  clc
        iny
        beq     LB165
        cpy     LFOR
        bcc     LB169
LB165:  ldy     KEYNUM
        bne     LB13D
LB169:  jsr     L8171
        inc     CFORM
        rts

LB170:  jsr     L9C4E
        sta     $77
        ldx     #$0A
        lda     #$00
LB179:  sta     SWE,x
        dex
        bpl     LB179
        stx     FLAG
        stx     POINT
        stx     DOLR
        tax
        tay
        rts

LB18A:  clc
        lda     POINT
        adc     NF
        bcs     LB1CB
        sec
        sbc     KEYNUM
        bcc     LB1CB
        cmp     ENR
        beq     LB19E
        bcs     LB1CB
LB19E:  cmp     BNR
        bcc     LB1CB
        tax
        lda     FBUFFER,x
        cmp     #$35
        bcc     LB1CB
LB1AB:  cpx     BNR
        beq     LB1BA
        dex
        jsr     LB153
        stx     ENR
        beq     LB1AB
        rts

LB1BA:  lda     #$31
        sta     FBUFFER,x
        inx
        stx     POINT
        dec     KEYNUM
        bpl     LB1CB
        inc     KEYNUM
        inc     VN
LB1CB:  rts

LB1CC:  ldy     POINT
        beq     LB1E7
LB1D0:  ldy     BNR
LB1D3:  lda     FBUFFER,y
        cmp     #$30
        rts

LB1D9:  inc     POINT
        jsr     LB10E
        inc     BNR
        cpy     ENR
        beq     LB1CB
        iny
LB1E7:  jsr     LB1D3
        beq     LB1D9
        rts

LB1ED:  lda     DOLR
        bmi     LB1F4
        inc     KEYNUM
LB1F4:  ldx     BNR
        dex
        ldy     BEGFD
LB1FB:  jsr     L8171
        iny
        cmp     #$2C
        bne     LB214
        bit     FLAG
        bmi     LB20E
        lda     PUCOMA
        jmp     LB276

LB20E:  lda     BLFD
        jmp     LB276

LB214:  cmp     #$2E
        bne     LB21E
        lda     PUDOT
        jmp     LB276

LB21E:  cmp     #$2B
        beq     LB25D
        cmp     #$2D
        beq     LB258
        cmp     #$5E
        bne     LB28D
        lda     #$45
        jsr     LB2B0
        ldy     UEXP
        jsr     LB1D3
        bne     LB23D
        iny
        jsr     LB1D3
        beq     LB244
LB23D:  lda     #$2D
        bit     USGN
        bmi     LB246
LB244:  lda     #$2B
LB246:  jsr     LB2B0
        ldx     UEXP
        lda     FBUFFER,x
        jsr     LB2B0
        ldy     ENDFD
        jmp     LB26C

LB258:  lda     SNO
        bmi     LB20E
LB25D:  lda     SNO
        jmp     LB276

LB263:  lda     KEYNUM
        bne     LB27C
        cpx     ENR
        beq     LB271
LB26C:  inx
        lda     FBUFFER,x
        .byte   $2C
LB271:  lda     #$30
LB273:  lsr     FLAG
LB276:  jsr     LB2B0
        bne     LB1FB
        rts

LB27C:  dec     KEYNUM
        lda     DOLR
        bmi     LB271
        sec
        ror     DOLR
        lda     PUMONY
        jmp     LB273

LB28D:  lda     SWE
        beq     LB263
        dec     SWE
LB295:  beq     LB29A
        jmp     LB20E

LB29A:  lda     POSP
        bmi     LB295
LB29F:  jsr     L8171
        cmp     #$2C
        bne     LB258
        lda     BLFD
        jsr     LB2B0
        iny
        jmp     LB29F

LB2B0:  jsr     L90B2
        dec     CFORM
        rts

LB2B7:  ldy     ENDFD
LB2BA:  jsr     LB15C
        jsr     LB36C
        bne     LB2D6
        sty     BEGFD
        bcc     LB2E1
        tax
LB2C8:  jsr     LB15C
        bcs     LB2D2
        jsr     LB374
        beq     LB2DC
LB2D2:  ldy     BEGFD
        txa
LB2D6:  jsr     L90B2
        jmp     LB2BA

LB2DC:  bcs     LB2C8
        ldy     BEGFD
LB2E1:  ldx     KEYNUM
        bne     LB35F
        stx     CFORM
        dey
LB2E9:  dec     CFORM
LB2EC:  jsr     LB15C
        bcs     LB365
        cmp     #$2C
        beq     LB2EC
        jsr     LB343
        bcc     LB2E9
        cmp     #$2E
        bne     LB306
        inx
        cpx     #$02
        bcc     LB2EC
LB303:  jmp     L94A1

LB306:  jsr     LB378
        bne     LB316
        bcc     LB310
        sta     CHSN
LB310:  inc     VF,x
        jmp     LB2EC

LB316:  cmp     #$24
        bne     LB329
        bit     DOLR
        bpl     LB310
        clc
        ror     DOLR
        dec     VF
        jmp     LB310

LB329:  cmp     #$5E
        bne     LB343
        ldx     #$02
LB32F:  jsr     LB15C
        bcs     LB303
        cmp     #$5E
        bne     LB303
        dex
        bpl     LB32F
        inc     FESP
        jsr     LB15C
        bcs     LB365
LB343:  cmp     #$2B
        bne     LB360
        lda     SNO
        bpl     LB351
        lda     #$2B
        sta     SNO
LB351:  lda     POSP
        bne     LB303
        ror     POSP
        sty     ENDFD
        inc     CFORM
LB35F:  rts

LB360:  cmp     #$2D
        beq     LB351
        sec
LB365:  sty     ENDFD
        dec     ENDFD
        rts

LB36C:  cmp     #$2B
        beq     LB385
        cmp     #$2D
        beq     LB385
LB374:  cmp     #$2E
        beq     LB385
LB378:  cmp     #$3D
        beq     LB385
        cmp     #$3E
        beq     LB385
        cmp     #$23
        bne     LB385
        clc
LB385:  rts

LB386:  lda     $64
        sta     TMPDES
        lda     $65
        sta     $04EC
        jsr     L932C
        jsr     L931A
        lda     $64
        sta     $04ED
        lda     $65
        sta     $04EE
        ldx     #$01
        stx     $65
        jsr     CHRGOT
        cmp     #$29
        beq     LB3AE
        jsr     L9DD8
LB3AE:  jsr     L948B
        ldx     $65
        bne     LB3B8
        jmp     L991C

LB3B8:  dex
        stx     FACEXP
        ldx     #$03
LB3BD:  lda     TMPDES,x
        sta     TEMPF1,x
        dex
        bpl     LB3BD
        ldy     #$02
LB3C7:  jsr     L8175
        sta     $5B,y
        jsr     L8179
        sta     $5E,y
        dey
        bpl     LB3C7
        lda     $5E
        beq     LB411
LB3DA:  lda     #$00
        sta     FACH0
        clc
        lda     $5E
        adc     FACEXP
        bcs     LB411
        cmp     $5B
        bcc     LB3EB
        bne     LB411
LB3EB:  ldy     FACH0
        cpy     $5E
        beq     LB40C
        tya
        clc
        adc     FACEXP
        tay
        jsr     L8169
        sta     $78
        ldy     FACH0
        jsr     L816D
        cmp     $78
        beq     LB408
        inc     FACEXP
        bne     LB3DA
LB408:  inc     FACH0
        bne     LB3EB
LB40C:  inc     FACEXP
        lda     FACEXP
        .byte   $2C
LB411:  lda     #$00
        pha
        lda     $04ED
        ldy     $04EE
        jsr     L9C52
        lda     TMPDES
        ldy     $04EC
        jsr     L9C52
        pla
        tay
        jmp     L9A81

LB42B:  jsr     L9A86
        jsr     CHRGOT
        beq     LB43A
        jsr     L9DE1
        sty     TRAPNO
        .byte   $2C
LB43A:  lda     #$FF
        sta     $04F3
        rts

LB440:  jsr     L9A86
        ldx     $04F1
        inx
        beq     LB4B9
        jsr     CHRGOT
        beq     LB495
        bcc     LB48A
        cmp     #$82
        bne     LB4B6
        jsr     LB495
        ldy     #$00
        jsr     INDTXT
        bne     LB484
        iny
        jsr     INDTXT
        bne     LB46D
        iny
        jsr     INDTXT
        bne     LB46D
        jmp     L867E

LB46D:  ldy     #$03
        jsr     INDTXT
        sta     CHRLIN
        iny
        jsr     INDTXT
        sta     $3A
        tya
        clc
        adc     TXTPTR
        sta     TXTPTR
        bcc     LB484
        inc     $3C
LB484:  jsr     CHRGET
        jmp     L8DB0

LB48A:  jsr     L9DE1
        sta     $15
        jsr     LB4A4
        jmp     L8D69

LB495:  ldx     #$01
LB497:  lda     ERRLIN,x
        sta     CHRLIN,x
        lda     ERRTXT,x
        sta     TXTPTR,x
        dex
        bpl     LB497
LB4A4:  ldx     #$FF
        stx     ERRNUM
        stx     ERRLIN
        stx     $04F1
        ldx     TMPTRP
        stx     $04F3
        rts

LB4B6:  jmp     L94A1

LB4B9:  ldx     #$1F
        jmp     L8683

LB4BE:  jsr     L9D87
        dex
        txa
        cmp     #$24
        bcs     LB4FB
        jsr     L8653
        ldy     #$FF
        ldx     #$00
LB4CE:  inx
LB4CF:  iny
        lda     (INDEX2),y
        bmi     LB4DA
        cmp     #$20
        bcc     LB4CF
        bcs     LB4CE
LB4DA:  txa
        jsr     L9B5C
        ldx     #$00
        ldy     #$FF
LB4E2:  iny
        lda     (INDEX2),y
        cmp     #$20
        bcc     LB4E2
        jsr     LB4FE
        pha
        and     #$7F
        sta     (FACH0),y
        jsr     LB4FE
        inx
        pla
        bpl     LB4E2
        jmp     L9CCA

LB4FB:  jmp     L991C

LB4FE:  pha
        txa
        pha
        tya
        tax
        pla
        tay
        pla
        rts

LB507:  jsr     L9317
        lda     LINNUM
        pha
        lda     $15
        pha
        jsr     L9DE4
        lda     #$04
        jsr     L9B5C
        ldy     #$00
        lda     $15
        jsr     LB52D
        lda     LINNUM
        jsr     LB52D
        pla
        sta     $15
        pla
        sta     LINNUM
        jmp     L9CCA

LB52D:  pha
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        jsr     LB536
        pla
LB536:  and     #$0F
        cmp     #$0A
        bcc     LB53E
        adc     #$06
LB53E:  adc     #$30
        sta     (FACH0),y
        iny
        rts

LB544:  jsr     L9C48
        tay
        dey
        cpy     #$04
        bcs     LB4FB
LB54D:  jsr     INDIN1
        sta     PUFILL,y
        dey
        bpl     LB54D
        rts

LB557:  ldy     #$01
LB559:  lda     TXTPTR,y
        sta     TMPTXT,y
        lda     CHRLIN,y
        sta     TMPLIN,y
        dey
        bpl     LB559
        jsr     CHRGOT
        beq     LB589
        cmp     #$FC
        beq     LB582
        cmp     #$FD
        bne     LB5B4
        jsr     LB64C
        lda     FACEXP
        bne     LB589
LB57C:  jsr     CHRGOT
        jmp     LB5BA

LB582:  jsr     LB64C
        lda     FACEXP
        bne     LB57C
LB589:  ldy     #$05
        jsr     L8905
        dey
        lda     $04F9
        sta     (TOS),y
        dey
        lda     TMPTXT
        sta     (TOS),y
        dey
        lda     $04FB
        sta     (TOS),y
        dey
        lda     TMPLIN
        sta     (TOS),y
        dey
        lda     #$EB
        sta     (TOS),y
        rts

LB5AC:  jsr     LB614
        jsr     CHRGOT
        beq     LB5BA
LB5B4:  jmp     L94A1

LB5B7:  jsr     CHRGET
LB5BA:  beq     LB5D9
        cmp     #$EC
        beq     LB600
        cmp     #$22
        beq     LB5CE
        cmp     #$EB
        bne     LB5B7
        jsr     LB5B7
        jmp     LB57C

LB5CE:  jsr     CHRGET
        beq     LB5D9
        cmp     #$22
        bne     LB5CE
        beq     LB5B7
LB5D9:  cmp     #$3A
        beq     LB5B7
        bit     RUNMOD
        bpl     LB625
        ldy     #$02
        jsr     INDTXT
        beq     LB625
        iny
        jsr     INDTXT
        sta     CHRLIN
        iny
        jsr     INDTXT
        sta     $3A
        tya
        clc
        adc     TXTPTR
        sta     TXTPTR
        bcc     LB5B7
        inc     $3C
        bne     LB5B7
LB600:  jmp     L8DB0

LB603:  beq     LB632
        cmp     #$FD
        beq     LB62D
        cmp     #$FC
        bne     LB5B4
        jsr     LB64C
        lda     FACEXP
        beq     LB632
LB614:  lda     #$EB
        sta     SRCHTK
        jsr     L8871
        bne     LB628
        jsr     LA769
        ldy     #$05
        jmp     LA772

LB625:  ldx     #$20
        .byte   $2C
LB628:  ldx     #$21
        jmp     L8683

LB62D:  jsr     LB64C
        beq     LB614
LB632:  jsr     LB614
        dey
        lda     (FNDPNT),y
        sta     $3C
        dey
        lda     (FNDPNT),y
        sta     TXTPTR
        dey
        lda     (FNDPNT),y
        jsr     LCD7F
        lda     (FNDPNT),y
        sta     CHRLIN
        jmp     LB557

LB64C:  jsr     CHRGET
        jmp     L932C

LB652:  lda     #$FF
        .byte   $2C
LB655:  lda     #$00
        sta     TRCFLG
        rts

        jsr     L948E
        jsr     L96A5
        sta     FORPNT
        sty     $4A
        jsr     L931A
        jsr     L9DD8
        dex
        stx     $77
        cmp     #$29
        beq     LB676
        jsr     L9DD8
        .byte   $2C
LB676:  ldx     #$FF
        stx     $78
        jsr     L948B
        lda     #$B2
        jsr     L9493
        jsr     L932C
        jsr     L931A
        ldy     #$02
LB68A:  lda     #$49
        jsr     INDSUB
        sta     $5B,y
        jsr     INDFMO
        sta     $5E,y
        dey
        bpl     LB68A
        sec
        lda     $5F
        sbc     $77
        sta     $5F
        bcs     LB6A6
        dec     $60
LB6A6:  lda     $78
        cmp     $5E
        bcc     LB6AE
        lda     $5E
LB6AE:  tax
        beq     LB6C7
        clc
        adc     $77
        bcs     LB6CA
        cmp     $5B
        bcc     LB6BC
        bne     LB6CA
LB6BC:  ldy     $77
LB6BE:  jsr     L816D
        sta     ($5C),y
        iny
        dex
        bne     LB6BE
LB6C7:  jmp     L9C4E

LB6CA:  jmp     L991C

LB6CD:  jsr     LB6DE
        jsr     L8E3E
        lda     LINNUM
        sta     AUTINC
        lda     $15
        sta     $74
        jmp     L867E

LB6DE:  bit     RUNMOD
        bmi     LB6E3
        rts

LB6E3:  ldx     #$22
        jmp     L8683

LB6E8:  ldx     ERRNUM
        inx
        beq     LB709
        lda     ERRLIN
        ldy     $04F1
        sta     LINNUM
        sty     $15
        jsr     L8A3D
        bcc     LB709
        ror     HELPER
        jsr     L903E
        ldx     LINNUM
        lda     $15
        jsr     L8B40
LB709:  jmp     L903E

LB70C:  ldx     $60
        tya
        clc
        adc     $5F
        bcc     LB715
        inx
LB715:  cpx     $04F6
        bne     LB728
        cmp     ERRTXT
        bcc     LB728
        beq     LB728
        lsr     HELPER
.if COMPILECOMPUTER >= PLUS4_01
        lda     #$82
.else
        lda     #$12
.fi
        jmp     L90B2

LB728:  rts

LB729:  bne     LB7A7
        ldx     #$00
        ldy     #$00
LB72F:  inx
        lda     KEYIDX,x
        beq     LB788
        sta     $77
        stx     KEYNUM
        ldx     #$05
LB73B:  lda     LCD6E,x
        dex
        bne     LB743
        ora     KEYNUM
LB743:  jsr     kCHROUT
        txa
        bpl     LB73B
        ldx     #$07
LB74B:  lda     PKYBUF,y
        iny
        pha
        stx     VOICNO
        ldx     #$04
LB754:  cmp     LB839,x
        beq     LB78D
        dex
        bne     LB754
        ldx     VOICNO
        cpx     #$08
        bcc     LB769
        bne     LB76E
        lda     #$2B
        jsr     kCHROUT
LB769:  lda     #$22
        jsr     kCHROUT
LB76E:  pla
        jsr     kCHROUT
        ldx     #$09
LB774:  dec     $77
        bne     LB74B
        cpx     #$09
        bcc     LB781
        lda     #$22
        jsr     kCHROUT
LB781:  lda     #$8D
        jsr     kCHROUT
        ldx     KEYNUM
LB788:  cpx     #$08
        bne     LB72F
        rts

LB78D:  ldx     VOICNO
LB78F:  lda     LB830,x
        jsr     kCHROUT
        dex
        cpx     #$03
        bcs     LB78F
        pla
        jsr     LCD74
        lda     #$29
        jsr     kCHROUT
        ldx     #$08
        bne     LB774
LB7A7:  jsr     L9D84
        dex
        cpx     #$08
        bcc     LB7B2
        jmp     L991C

LB7B2:  stx     KEYNUM
        jsr     L9491
        jsr     L9C48
        jsr     LB7C2
        bcc     LB831
        jmp     L8681

LB7C2:  sta     $77
        ldx     #$08
        jsr     LB83E
        sta     BNR
        ldx     KEYNUM
        inx
        jsr     LB83E
        sta     ENR
        ldx     KEYNUM
        lda     $77
        sec
        sbc     KEYBUF,x
        beq     LB814
        bcc     LB7FE
        clc
        adc     BNR
        bcs     LB832
        cmp     #$81
        bcs     LB832
        tax
        ldy     BNR
LB7EF:  cpy     ENR
        beq     LB814
        dey
        dex
        lda     PKYBUF,y
        sta     PKYBUF,x
        bcs     LB7EF
LB7FE:  adc     ENR
        tax
        ldy     ENR
LB805:  cpy     BNR
        bcs     LB814
        lda     PKYBUF,y
        sta     PKYBUF,x
        iny
        inx
        bcc     LB805
LB814:  ldx     KEYNUM
        jsr     LB83E
        tax
        ldy     KEYNUM
        lda     $77
        sta     KEYBUF,y
        ldy     #$00
        jsr     INDIN1
        dec     $77
        bmi     LB831
        sta     PKYBUF,x
        inx
        iny
        .byte   $D0
LB830:  .byte   $F2
LB831:  clc
LB832:  rts

        .TEXT   "($RHC+"
LB839:  .byte   $22,$0D,$8D,$22,$1B
LB83E:  lda     #$00
        clc
LB841:  dex
        bmi     LB832
        adc     KEYBUF,x
        bcc     LB841
LB849:  jsr     L9D84
        dex
        cpx     #$03
        bcs     LB8B5
        stx     VOICNO
        jsr     L9DDE
        cmp     #$04
        bcs     LB8B5
        sty     TMPTON
        sta     $7F
        jsr     L9DDE
        ldx     VOICNO
        cpx     #$02
        bne     LB868
        dex
LB868:  pha
        cpy     #$00
        bne     LB874
        cmp     #$00
        bne     LB874
        iny
        bne     LB883
LB874:  tya
        pha
LB876:  jsr     L8CC0
        lda     MTIMHI,x
        ora     MTIMLO,x
        bne     LB876
        pla
        tay
LB883:  tya
        eor     #$FF
        clc
        adc     #$01
        sei
        sta     MTIMLO,x
        pla
        eor     #$FF
        adc     #$00
        sta     MTIMHI,x
        lda     TMPTON
        sta     TEDFREQV1LO,x
        lda     LB8B8,x
        tax
        lda     TEDFREQV2HI,x
        and     #$FC
        ora     $7F
        sta     TEDFREQV2HI,x
        ldx     VOICNO
        lda     LB8BA,x
        ora     TEDVOL
        sta     TEDVOL
        cli
        rts

LB8B5:  jmp     L991C

LB8B8:  .byte   $02,$00
LB8BA:  .byte   $10,$20,$40
LB8BD:  jsr     L9D84
        cpx     #$09
        bcs     LB8B5
        stx     VOICNO
        lda     TEDVOL
        and     #$F0
        ora     VOICNO
        sta     TEDVOL
        rts

LB8D1:  jsr     LC3B6
        ldx     #$04
        jsr     LC3D9
        jsr     LC37B
        jsr     LC3A5
        cpx     #$02
        bcc     LB8E6
        jmp     L991C

LB8E6:  txa
        lsr     a
        ror     a
        sta     STOPNB
        bpl     LB8F1
        lda     COLSEL
        beq     LB8F8
LB8F1:  jsr     LC1F3
        bcs     LB8F8
        bne     LB8F9
LB8F8:  rts

LB8F9:  jsr     LA954
        lda     STREND
        sta     INDEX1
        lda     $32
        sta     $23
        sec
        lda     FRETOP
        sbc     #$03
        sta     TEMPST
        lda     $34
        sbc     #$00
        sta     $1A
LB911:  ldx     #$00
        stx     LTFLAG
        stx     RTFLAG
LB917:  ldx     YPO
        bne     LB91F
        dec     $02B0
LB91F:  dec     YPO
        jsr     LC1F3
        bcs     LB929
        bne     LB917
LB929:  inc     YPO
        bne     LB931
        inc     $02B0
LB931:  jsr     LC1C3
        ldx     XPOS
        bne     LB93C
        dec     $02AE
LB93C:  dec     XPOS
        lda     LTFLAG
        jsr     LB99F
        sta     LTFLAG
        clc
        lda     XPOS
        adc     #$02
        sta     XPOS
        bcc     LB954
        inc     $02AE
LB954:  lda     RTFLAG
        jsr     LB99F
        sta     RTFLAG
        ldx     XPOS
        bne     LB963
        dec     $02AE
LB963:  dec     XPOS
        inc     YPO
        bne     LB96E
        inc     $02B0
LB96E:  jsr     LC1F3
        bcs     LB975
        bne     LB931
LB975:  ldx     #$03
        ldy     #$00
        lda     $23
        cmp     $32
        bne     LB985
        lda     INDEX1
        cmp     STREND
        beq     LB99C
LB985:  lda     INDEX1
        bne     LB98B
        dec     $23
LB98B:  dec     INDEX1
        jsr     INDIN1
        sta     XPOS,x
        dex
        bpl     LB985
        jsr     L8CC0
        jmp     LB911

LB99C:  jmp     LC37B

LB99F:  pha
        jsr     LC1F3
        bcs     LB9D0
        beq     LB9D0
        pla
        bne     LB9D3
        tax
        tay
        lda     $23
        cmp     $1A
        bcc     LB9BD
        bne     LB9BA
        lda     INDEX1
        cmp     TEMPST
        bcc     LB9BD
LB9BA:  jmp     L8681

LB9BD:  lda     XPOS,x
        sta     (INDEX1),y
        inc     INDEX1
        bne     LB9C8
        inc     $23
LB9C8:  inx
        cpx     #$04
        bne     LB9BD
        lda     #$80
        rts

LB9D0:  pla
        lda     #$00
LB9D3:  rts

LB9D4:  jsr     LC3B9
        jsr     L9DD8
        cpx     #$28
        bcs     LB9E8
        stx     ETOF
        jsr     L9DD8
        cpx     #$19
        bcc     LB9EB
LB9E8:  jmp     L991C

LB9EB:  stx     CFORM
        jsr     L9491
        jsr     L9C48
        sta     NUMCNT
        tya
        pha
        txa
        pha
        jsr     LC3A5
        txa
        ror     a
        ror     $02B9
        pla
        sta     INDEX1
        pla
        sta     $23
        lda     GRAPHM
        bne     LBA28
        ldx     CFORM
        ldy     ETOF
        clc
        jsr     kPLOT
        ldy     #$00
LBA19:  cpy     NUMCNT
        beq     LBA27
        jsr     INDIN1
        jsr     kPRINT
        iny
        bne     LBA19
LBA27:  rts

LBA28:  jsr     LC7BF
        lda     FG
        pha
        lda     COLSEL
        pha
        bit     GRAPHM
        bpl     LBA44
        pla
        beq     LBA4A
        lsr     a
        beq     LBA4A
        ldx     MC1
        bcc     LBA4C
        ldx     TEDCOLBG1
        bcs     LBA4C
LBA44:  ldx     TEDCOLBG0
        pla
        beq     LBA4C
LBA4A:  ldx     FG
LBA4C:  stx     FG
        ldx     CFORM
        ldy     #$00
        sty     SNO
LBA56:  ldy     SNO
        inc     SNO
        jsr     INDIN1
        dec     NUMCNT
        bmi     LBA7B
        ldy     ETOF
        jsr     LBA7F
        inc     ETOF
        cpy     #$27
        bcc     LBA56
        ldy     #$00
        sty     ETOF
        inx
        cpx     #$18
        bcc     LBA56
LBA7B:  pla
        sta     FG
        rts

LBA7F:  pha
        jsr     LC21A
        jsr     LC291
        lda     #$00
        sta     TMPTON
        pla
        pha
        asl     a
        rol     TMPTON
        asl     a
        asl     a
        rol     TMPTON
        sta     INDEX2
        lda     TMPTON
        adc     CHRPAG
        sta     $25
        tya
        pha
        ldy     #$07
LBAA0:  lda     $02B9
        asl     a
        lda     (INDEX2),y
        bcc     LBAAA
        eor     #$FF
LBAAA:  bit     GRAPHM
        bpl     LBAD9
        and     #$AA
        sta     TMPTON
        lda     COLSEL
        bne     LBAC5
        lda     TMPTON
        bcs     LBAC1
        lsr     a
        eor     TMPTON
        eor     #$AA
        bne     LBAD9
LBAC1:  ora     #$55
        bne     LBAD9
LBAC5:  cmp     #$02
        bne     LBACD
        lda     TMPTON
        bcs     LBAD9
LBACD:  bcc     LBAD6
        lda     TMPTON
        lsr     a
        eor     TMPTON
        bcc     LBAD9
LBAD6:  lda     TMPTON
        lsr     a
LBAD9:  sta     (GRAPNT),y
        dey
        bpl     LBAA0
        pla
        tay
        pla
        rts

LBAE2:  jsr     LC3B6
        ldx     #$1F
        jsr     LC3F4
        ldx     #$2B
        jsr     LC3D9
        jsr     LC38F
        sty     FLAG
        sta     SWE
        jsr     LC3A5
        cpx     #$02
        bcc     LBB02
        jmp     L991C

LBB02:  stx     FILFLG
        txa
        pha
        jsr     LBBB4
        pla
        bne     LBB29
        beq     LBB12
LBB0F:  jsr     LBC36
LBB12:  jsr     LC0DA
        lda     ANGCNT
        bne     LBB0F
LBB1A:  ldx     #$04
LBB1C:  lda     NF,x
        sta     $02AC,x
        dex
        bne     LBB1C
        stx     FILFLG
        rts

LBB29:  ldx     #$00
        lda     ANGSGN
        lsr     a
        bcc     LBB33
        ldx     #$02
LBB33:  lda     SNO,x
        sta     VF
        lda     BLFD,x
        sta     NF
        lda     #$00
        ldx     #$03
LBB43:  sta     USGN,x
        dex
        bpl     LBB43
LBB49:  ldx     #$07
LBB4B:  lda     XPOS,x
        pha
        dex
        bpl     LBB4B
        jsr     LC0DA
        ldx     #$00
LBB57:  pla
        sta     XPOS,x
        inx
        cpx     #$08
        bne     LBB57
LBB60:  lda     VF
        bne     LBB6A
        dec     NF
        bmi     LBB1A
LBB6A:  dec     VF
        ldx     #$25
        ldy     #$1B
        lda     ANGSGN
        lsr     a
        bcc     LBB79
        ldy     #$19
LBB79:  lda     #$00
LBB7B:  lsr     a
        pha
        jsr     LC2F6
        sta     XPOS,x
        tya
        sta     $02AE,x
        pla
        bcc     LBB8C
        ora     #$A0
LBB8C:  inx
        inx
        ldy     #$19
        lsr     ANGSGN
        bcc     LBB97
        ldy     #$1B
LBB97:  rol     ANGSGN
        cpx     #$27
        beq     LBB7B
        ldx     #$06
        asl     a
        beq     LBB60
LBBA3:  bcc     LBBAD
        inc     XPOS,x
        bne     LBBAD
        inc     $02AE,x
LBBAD:  asl     a
        dex
        dex
        bpl     LBBA3
        bmi     LBB49
LBBB4:  ldy     #$23
        jsr     LBC56
        ldx     #$1F
        ldy     #$2B
LBBBD:  tya
        pha
        jsr     LC322
        sta     XDEST,x
        sta     XABS,x
        sta     $02BD,x
        tya
        sta     $02B2,x
        sta     $02B6,x
        sta     $02BE,x
        pla
        tay
        jsr     LC2F6
        sta     XPOS,x
        tya
        sta     $02AE,x
        ldy     #$2D
        inx
        inx
        cpx     #$21
        beq     LBBBD
        lda     #$90
        jsr     LBCD5
        lda     ANGSGN
        and     #$03
        sta     ANGSGN
        tax
        lda     LBC18,x
        jsr     LBC36
        jsr     LC37B
        lda     ANGCNT
        jsr     LBC36
        ldx     ANGSGN
        lda     LBC18,x
        and     #$F0
        sta     $02CB
        lda     LBC1C,x
        sta     ANGCNT
        rts

LBC18:  .byte   $BE,$E4
        .TEXT   "A"
        .byte   $1B
LBC1C:  .TEXT   "A"
        .byte   $1B,$BE,$E4
        .TEXT   "FRED B"
        .byte   $0D
        .TEXT   "TERRY R"
        .byte   $0D
        .TEXT   "MIKE I"
        .byte   $0D
LBC36:  jsr     LBD05
        ldx     #$04
LBC3B:  lda     $02AE,x
        asl     a
        ror     $02AE,x
        ror     XPOS,x
        bcc     LBC4F
        inc     XPOS,x
        bne     LBC4F
        inc     $02AE,x
LBC4F:  inx
        inx
        cpx     #$06
        beq     LBC3B
        rts

LBC56:  jsr     LC318
LBC59:  ldx     #$00
LBC5B:  inx
        sec
        sbc     #$5A
        bcs     LBC5B
        dey
        bpl     LBC5B
        stx     ANGSGN
        pha
        adc     #$5A
        jsr     LBC76
        pla
        clc
        eor     #$FF
        adc     #$01
        dec     ANGSGN
LBC76:  ldx     #$FF
LBC78:  inx
        sec
        sbc     #$0A
        bcs     LBC78
        adc     #$0A
        sta     VTEMP1
        txa
        asl     a
        tax
        lda     LC4B4,x
        ldy     LC4B3,x
LBC8B:  clc
        dec     VTEMP1
        bmi     LBC9C
        adc     LC4C8,x
        pha
        tya
        adc     LC4C7,x
        tay
        pla
        bcc     LBC8B
LBC9C:  pha
        ldx     #$00
        lda     ANGSGN
        lsr     a
        bcs     LBCA7
        ldx     #$02
LBCA7:  pla
        sta     SINVAL,x
        tya
        sta     $02C7,x
        rts

LBCB0:  ldy     #$19
        bcc     LBCB6
        ldy     #$1B
LBCB6:  lda     ANGSGN
        adc     #$02
        lsr     a
        lsr     a
        php
        jsr     LC318
        cpy     #$FF
        bcc     LBCCC
        txa
        tay
        jsr     LC318
        bcs     LBCCF
LBCCC:  jsr     LC337
LBCCF:  plp
        bcs     LBCED
        jmp     LC327

LBCD5:  sta     ANGCNT
        ldx     #$23
LBCDA:  asl     ANGCNT
        jsr     LBCB0
        sta     XPOS,x
        tya
        sta     $02AE,x
        inx
        inx
        cpx     #$2B
        bcc     LBCDA
LBCED:  rts

LBCEE:  ldy     #$2B
LBCF0:  jsr     LBC56
        ldx     #$07
LBCF5:  lda     SNO,x
        sta     FLAG,x
        dex
        bpl     LBCF5
        lda     #$50
        jsr     LBCD5
        lda     #$10
LBD05:  sta     ANGCNT
        ldy     #$1F
        ldx     #$23
LBD0C:  asl     $02CB
        rol     ANGCNT
        jsr     LC2F4
        inx
        inx
        asl     $02CB
        rol     ANGCNT
        jsr     LC2F0
        pha
        tya
        pha
        ldy     #$21
        inx
        inx
        cpx     #$27
        beq     LBD0C
        ldx     #$03
LBD2D:  pla
        sta     XDEST,x
        dex
        bpl     LBD2D
        rts

LBD35:  jsr     LC7BF
        jsr     L9C48
        sta     DOLR
        stx     INDEX2
        sty     $25
        ldx     #$04
        jsr     LC3D9
        jsr     LC3A5
        cpx     #$05
        bcc     LBD51
        jmp     L991C

LBD51:  stx     FLAG
        ldx     #$03
        ldy     DOLR
        cpy     #$05
        bcs     LBD5E
        rts

LBD5E:  dey
        jsr     INDIN2
        sta     CHSN,x
        dex
        bpl     LBD5E
        stx     SWE
        jsr     LC37B
        lda     CHSN
        sta     FESP
        lda     VF
        sta     ETOF
LBD7A:  lda     #$08
        sta     BITCNT
        inc     SWE
        ldy     SWE
        jsr     INDIN2
        sta     UEXP
LBD8B:  jsr     LC1F3
        sta     USGN
        asl     UEXP
        rol     a
        dec     BITCNT
        bit     GRAPHM
        bpl     LBDA3
        asl     UEXP
        rol     a
        dec     BITCNT
LBDA3:  ldx     FLAG
        cpx     #$03
        bcc     LBDB6
        beq     LBDB1
        eor     USGN
        bcs     LBDC2
LBDB1:  and     USGN
        bcs     LBDC2
LBDB6:  cpx     #$01
        bcc     LBDC2
        beq     LBDC0
        ora     USGN
LBDBF:  .byte   $2C
LBDC0:  eor     #$FF
LBDC2:  and     #$03
        bit     GRAPHM
        bmi     LBDCA
        and     #$01
LBDCA:  sta     COLSEL
        jsr     LC1C3
        inc     XPOS
        bne     LBDD7
        inc     $02AE
LBDD7:  sec
        lda     FESP
        bit     GRAPHM
        bpl     LBDE2
        sbc     #$02
LBDE1:  .byte   $2C
LBDE2:  sbc     #$01
        sta     FESP
        lda     ETOF
        sbc     #$00
        sta     ETOF
        bcs     LBE1E
        ldx     #$01
LBDF3:  lda     CHSN,x
        sta     FESP,x
        lda     XDEST,x
        sta     XPOS,x
        dex
        bpl     LBDF3
        inc     YPO
        bne     LBE0A
        inc     $02B0
LBE0A:  sec
        lda     NF
        sbc     #$01
        sta     NF
        lda     POSP
        sbc     #$00
        sta     POSP
        bcs     LBE26
        rts

LBE1E:  lda     BITCNT
        beq     LBE26
        jmp     LBD8B

LBE26:  jmp     LBD7A

LBE29:  jsr     LC7BF
        jsr     L96A5
        sta     CFORM
        sty     SNO
        bit     VALTYP
        bmi     LBE3C
        jmp     L9324

LBE3C:  ldx     #$28
        jsr     LC3F4
        ldx     #$04
        jsr     LC3D9
        ldx     #$2A
        ldy     #$06
        lda     #$02
        sta     VTEMP1
LBE4E:  jsr     LC322
        tax
        tya
        pha
        ldy     VTEMP1
        jsr     LC382
        bcc     LBE67
        lda     CHSN,y
        sta     XPOS,y
        lda     VF,y
        sta     $02AE,y
LBE67:  txa
        sta     CHSN,y
        sta     BEGFD,y
        pla
        sta     VF,y
        sta     LFOR,y
        ldx     #$28
        ldy     #$04
        dec     VTEMP1
        dec     VTEMP1
        beq     LBE4E
        ldy     #$FF
        sty     SWE
        lda     XPOS
        sta     FESP
        lda     $02AE
        sta     ETOF
        tya
        jsr     L9B5C
LBE94:  jsr     LC264
        lda     (GRAPNT),y
        bcc     LBEA9
        lda     XPOS
        bit     GRAPHM
        bpl     LBEA4
        sec
        rol     a
LBEA4:  and     #$07
        tax
        lda     #$00
LBEA9:  bit     GRAPHM
        bpl     LBEAE
        dex
LBEAE:  stx     BLFD
LBEB1:  asl     a
        dex
        bpl     LBEB1
        ror     a
        sta     VTEMP1
        lda     #$08
        bit     GRAPHM
        bpl     LBEBF
        lsr     a
LBEBF:  clc
        adc     XPOS
        sta     XPOS
        bcc     LBECB
        inc     $02AE
LBECB:  jsr     LC264
        lda     #$00
        bcs     LBED4
        lda     (GRAPNT),y
LBED4:  sta     VTEMP2
        ldx     BLFD
LBED9:  lsr     a
        inx
        cpx     #$08
        bne     LBED9
        ora     VTEMP1
        inc     SWE
        ldy     SWE
        cpy     #$FC
        bcc     LBEEE
        jmp     LCC4C

LBEEE:  sta     (FACH0),y
        ldx     BLFD
        lda     CHSN
        sec
        bit     GRAPHM
        bpl     LBEFE
        sbc     #$04
LBEFD:  .byte   $2C
LBEFE:  sbc     #$08
        sta     CHSN
        lda     VTEMP2
        bcs     LBEB1
        dec     VF
        bpl     LBEB1
        ldx     NF
        bne     LBF53
        dec     POSP
        bpl     LBF53
        bit     GRAPHM
        bpl     LBF20
        asl     BEGFD
        rol     LFOR
LBF20:  ldx     #$00
LBF22:  lda     BEGFD,x
        iny
        sta     (FACH0),y
        inx
        cpx     #$04
        bne     LBF22
        iny
        sty     BEGFD
        lda     FACH0
        sta     LFOR
        lda     $63
        sta     ENDFD
        lda     #$DE
        sta     $64
        lda     #$02
        sta     $65
        lda     CFORM
        sta     FORPNT
        lda     SNO
        sta     $4A
        jsr     L8F40
        jmp     LC37B

LBF53:  dec     NF
        inc     YPO
        bne     LBF5E
        inc     $02B0
LBF5E:  lda     FESP
        sta     XPOS
        lda     ETOF
        sta     $02AE
        lda     BEGFD
        sta     CHSN
        lda     LFOR
        sta     VF
        jmp     LBE94

LBF79:  lda     GRAPHM
        clc
        rol     a
        rol     a
        rol     a
        adc     #$00
        tay
        jmp     L9A81

LBF85:  sec
        .byte   $24
LBF87:  clc
        php
        jsr     L9D87
        lda     TEDCOLFRAME
        and     #$7F
        cpx     #$04
        beq     LBFAE
        bcs     LBFBE
        lda     TEDCOLBG0
        and     #$7F
        dex
        bmi     LBFAE
        lda     FG
        dex
        bmi     LBFAE
        lda     MC1
        dex
        bmi     LBFAE
        lda     TEDCOLBG1
        and     #$7F
LBFAE:  plp
        bcs     LBFB6
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        clc
LBFB6:  adc     #$00
        and     #$0F
        tay
        jmp     L9A81

LBFBE:  jmp     L991C

LBFC1:  jsr     L9D87
        dex
        cpx     #$02
        bcs     LBFBE
        lda     LBFFB,x
        tax
        sei
LBFCE:  stx     TEDKEYB
        lda     TEDKEYB
        stx     TEDKEYB
        cmp     TEDKEYB
        bne     LBFCE
        cli
        eor     #$FF
        tay
        and     #$0F
        tax
        lda     LBFF0,x
        cpy     #$0F
        bcc     LBFEC
        ora     #$80
LBFEC:  tay
        jmp     L9A81

LBFF0:  .byte   $00,$01,$05,$00,$07,$08,$06,$00
LBFF8:  .byte   $03,$02,$04
LBFFB:  .byte   $FA,$FD
LBFFD:  jsr     L9D87
        cpx     #$02
        bcc     LC011
        bne     LBFBE
        jsr     LC1F3
        tay
        bcc     LC00E
        ldy     #$00
LC00E:  jmp     L9A81

LC011:  txa
        asl     a
        tax
        lda     XPOS,x
        tay
        lda     $02AE,x
        jmp     L9471

LC01E:  jsr     LC3B6
        ldx     #$1F
        jsr     LC3D9
        jsr     LC38F
        sty     FLAG
        sta     SWE
        jsr     LC38F
        sty     USGN
        sta     UEXP
        php
        ldx     #$23
        jsr     LC2D3
        plp
        bcs     LC052
        lda     FLAG
        sta     USGN
        lda     SWE
        bit     GRAPHM
        bpl     LC052
        asl     USGN
        rol     a
LC052:  sta     UEXP
        jsr     LC38F
        sty     POSP
        sta     FESP
        jsr     LC38F
        sty     ETOF
        sta     CFORM
        jsr     LC38F
        sta     VOICNO
        tya
        ldy     VOICNO
        jsr     LBC59
        ldx     #$2D
        ldy     #$2B
        jsr     LC305
        bcc     LC089
        lda     #$68
        ldy     #$01
        jsr     LC2F9
        sta     XPOS,x
        tya
        sta     $02AE,x
LC089:  ldx     #$03
LC08B:  lda     FLAG,x
        sta     VN,x
        dex
        bpl     LC08B
        lda     #$90
        jsr     LBCD5
        ldx     #$07
LC09B:  lda     FLAG,x
        sta     SNO,x
        dex
        bpl     LC09B
        jsr     LBCEE
        jsr     LC37B
        ldx     #$02
        jsr     LC3A7
        stx     CIRSEG
        clc
LC0B2:  lda     CIRSEG
        bne     LC0B9
        jmp     L991C

LC0B9:  adc     POSP
        sta     POSP
        bcc     LC0C4
        inc     FESP
LC0C4:  ldx     #$2D
        ldy     #$2B
        jsr     LC305
        bcs     LC0D5
        jsr     LBCEE
        jsr     LC0DA
        bcc     LC0B2
LC0D5:  ldy     #$2D
        jsr     LBCF0
LC0DA:  ldx     #$02
        ldy     #$06
LC0DE:  lda     #$00
        sta     $02B9,x
        sta     $02BA,x
        jsr     LC322
        bpl     LC0F3
        dec     $02B9,x
        dec     $02BA,x
        bne     LC0FE
LC0F3:  cmp     #$00
        bne     LC0FB
        cpy     #$00
        beq     LC0FE
LC0FB:  inc     $02B9,x
LC0FE:  sta     XABS,x
        asl     a
        sta     $02BD,x
        tya
        sta     $02B6,x
        rol     a
        sta     $02BE,x
        dex
        dex
        ldy     #$04
        cpx     #$00
        beq     LC0DE
        ldx     #$0A
        ldy     #$08
        jsr     LC305
        lda     #$00
        rol     a
        rol     a
        sta     LESSER
        eor     #$02
        sta     $02C4
        clc
        lda     #$10
        adc     LESSER
        tay
        pha
        eor     #$02
        tax
        jsr     LC305
        sta     XPOS,x
        tya
        sta     $02AE,x
        pla
        tay
        clc
        lda     #$08
        adc     $02C4
        tax
        jsr     LC305
        sta     ERRVAL
        sty     $02C2
LC14F:  jsr     LC1A5
        ldy     $02C4
        sec
        lda     XABS,y
        sbc     #$01
        sta     XABS,y
        bcs     LC16B
        lda     $02B6,y
        sbc     #$00
        sta     $02B6,y
        bcs     LC16B
        rts

LC16B:  ldx     LESSER
        lda     $02C2
        bmi     LC179
        jsr     LC194
        ldx     $02C4
LC179:  clc
        lda     ERRVAL
        adc     $02BD,x
        sta     ERRVAL
        lda     $02C2
        adc     $02BE,x
        sta     $02C2
        ldx     $02C4
        jsr     LC194
        beq     LC14F
LC194:  ldy     #$02
        clc
LC197:  lda     XPOS,x
        adc     $02B9,x
        sta     XPOS,x
        inx
        dey
        bne     LC197
        rts

LC1A5:  lda     FILFLG
        ora     WIDTH
        beq     LC1C3
        inc     XPOS
        bne     LC1B5
        inc     $02AE
LC1B5:  jsr     LC1C3
        ldx     XPOS
        bne     LC1C0
        dec     $02AE
LC1C0:  dec     XPOS
LC1C3:  jsr     LC2AD
        bcs     LC1EC
        jsr     LC21A
        jsr     LC269
        sta     BITMSK
        lda     (GRAPNT),y
        ora     BITMSK
        bit     GRAPHM
        bpl     LC1ED
        pha
        ldx     COLSEL
        lda     BITMSK
        and     LC4AF,x
        sta     BITMSK
        pla
LC1E7:  eor     BITMSK
LC1EA:  sta     (GRAPNT),y
LC1EC:  rts

LC1ED:  ldx     COLSEL
        bne     LC1EA
        beq     LC1E7
LC1F3:  jsr     LC264
        bcs     LC219
        sta     BITMSK
        lda     (GRAPNT),y
        and     BITMSK
LC200:  rol     a
        dex
        bpl     LC200
        rol     a
        bit     STOPNB
        bmi     LC20F
        and     #$03
        cmp     COLSEL
        clc
        rts

LC20F:  clc
        and     #$03
        beq     LC217
        ldx     #$00
        rts

LC217:  ldx     #$FF
LC219:  rts

LC21A:  lda     LD802,x
        sta     GRAPNT
        lda     LD81B,x
        and     #$03
        pha
        ora     #$1C
        sta     $8D
        jsr     LC238
        sta     (GRAPNT),y
        pla
        ora     #$18
        sta     $8D
        jsr     LC24E
        sta     (GRAPNT),y
LC238:  lda     FG
        asl     a
        asl     a
        asl     a
        asl     a
        sta     TMPTON
        lda     TEDCOLBG0
        bit     GRAPHM
        bpl     LC249
        lda     MC1
LC249:  and     #$0F
        ora     TMPTON
        rts

LC24E:  lda     FG
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        sta     TMPTON
        lda     TEDCOLBG0
        bit     GRAPHM
        bpl     LC25F
        lda     MC1
LC25F:  and     #$F0
        ora     TMPTON
        rts

LC264:  jsr     LC2AD
        bcs     LC288
LC269:  jsr     LC291
        lda     YPO
        and     #$07
        tay
        lda     XPOS
        bit     GRAPHM
        php
        bpl     LC27B
        asl     a
LC27B:  and     #$07
        tax
        lda     LC289,x
        plp
        bpl     LC288
        inx
        ora     LC289,x
LC288:  rts

LC289:  .byte   $80,$40,$20,$10,$08,$04,$02,$01
LC291:  tya
        clc
        adc     LD802,x
        sta     GRAPNT
        lda     LD81B,x
        and     #$03
        adc     #$00
        asl     GRAPNT
        rol     a
        asl     GRAPNT
        rol     a
        asl     GRAPNT
        rol     a
        ora     #$20
        sta     $8D
        rts

LC2AD:  lda     $02AE
        lsr     a
        bne     LC2D1
        lda     XPOS
        ror     a
        lsr     a
        bit     GRAPHM
        bmi     LC2BD
        lsr     a
LC2BD:  tay
        cpy     #$28
        bcs     LC2D1
        lda     $02B0
        bne     LC2D1
        lda     YPO
        lsr     a
        lsr     a
        lsr     a
        tax
        cmp     SCYMAX
        rts

LC2D1:  sec
        rts

LC2D3:  lda     SCALEM
        beq     LC2EF
        lda     SCXMAX
        jsr     LC2DF
        lda     SCYMAX
LC2DF:  asl     a
        tay
        lda     #$00
        jsr     LC337
        sta     XPOS,x
        tya
        inx
        sta     XPOS,x
        inx
LC2EF:  rts

LC2F0:  bcc     LC2F9
        bcs     LC308
LC2F4:  bcs     LC305
LC2F6:  jsr     LC318
LC2F9:  clc
        adc     XPOS,x
        pha
        tya
        adc     $02AE,x
        tay
        pla
        rts

LC305:  jsr     LC318
LC308:  sec
        sbc     XPOS,x
        sta     TEMPF1
        tya
        sbc     $02AE,x
        tay
        php
        lda     TEMPF1
        plp
        rts

LC318:  lda     XPOS,y
        pha
        lda     $02AE,y
        tay
        pla
        rts

LC322:  jsr     LC305
LC325:  bpl     LC336
LC327:  php
        clc
        eor     #$FF
        adc     #$01
        pha
        tya
        eor     #$FF
        adc     #$00
        tay
        pla
        plp
LC336:  rts

LC337:  sty     VTEMP1
        sta     VTEMP2
        lda     XPOS,x
        ldy     $02AE,x
        php
        jsr     LC325
        sta     XPOS,x
        tya
        sta     $02AE,x
        lda     #$00
        sta     VTEMP3
        ldy     #$10
LC353:  lsr     VTEMP1
        ror     VTEMP2
        bcc     LC368
        clc
        adc     XPOS,x
        pha
        lda     VTEMP3
        adc     $02AE,x
        sta     VTEMP3
        pla
LC368:  lsr     VTEMP3
        ror     a
        dey
        bne     LC353
        adc     #$00
        ldy     VTEMP3
        bcc     LC377
        iny
LC377:  plp
        jmp     LC325

LC37B:  ldy     #$00
        jsr     LC382
        ldy     #$02
LC382:  lda     XDEST,y
        sta     XPOS,y
        lda     $02B2,y
        sta     $02AE,y
        rts

LC38F:  jsr     CHRGOT
        beq     LC3A0
        jsr     L9491
        cmp     #$2C
        beq     LC3A0
        jsr     L9DE1
        sec
        rts

LC3A0:  lda     #$00
        tay
        clc
LC3A4:  rts

LC3A5:  ldx     #$00
LC3A7:  jsr     CHRGOT
        beq     LC3A4
        jsr     L9491
        cmp     #$2C
        beq     LC3A4
        jmp     L9D84

LC3B6:  jsr     LC7BF
LC3B9:  ldx     #$01
        jsr     CHRGOT
LC3BE:  beq     LC3D3
        cmp     #$2C
        beq     LC3D3
        jsr     L9D84
        cpx     #$04
        bcs     LC3D6
        cpx     #$02
        bit     GRAPHM
        bmi     LC3D3
        bcs     LC3D6
LC3D3:  stx     COLSEL
        rts

LC3D6:  jmp     L991C

LC3D9:  jsr     CHRGOT
        beq     LC3E5
        jsr     L9491
        cmp     #$2C
        bne     LC3F7
LC3E5:  ldy     #$00
LC3E7:  lda     XPOS,y
        sta     XPOS,x
        inx
        iny
        cpy     #$04
        bne     LC3E7
        rts

LC3F4:  jsr     L9491
LC3F7:  stx     VTEMP4
        jsr     LC48F
        jsr     CHRGOT
        cmp     #$2C
        beq     LC45A
        cmp     #$3B
        beq     LC40B
        jmp     L94A1

LC40B:  jsr     CHRGET
        jsr     L9DE1
        sta     VOICNO
        tya
        ldy     VOICNO
        jsr     LBC59
        ldx     VTEMP4
        lda     XPOS,x
        sta     YPO,x
        lda     $02AE,x
        sta     $02B0,x
        jsr     LC2D3
        lda     #$0E
        sta     VTEMP5
        clc
        ldx     VTEMP4
LC434:  jsr     LBCB0
        sta     XPOS,x
        tya
        sta     $02AE,x
        ldy     #$00
        lsr     VTEMP5
        bcc     LC447
        ldy     #$02
LC447:  jsr     LC2F4
        sta     XPOS,x
        tya
        sta     $02AE,x
        inx
        inx
        lsr     VTEMP5
        bne     LC434
        clc
        rts

LC45A:  jsr     CHRGET
        inc     VTEMP4
        inc     VTEMP4
        jsr     LC48F
        ldx     VTEMP4
        dex
        dex
        jsr     LC2D3
        ldy     #$02
        ldx     VTEMP4
        inx
        inx
LC475:  dex
        dex
        lsr     VTEMP5
        bcc     LC486
        jsr     LC2F6
        sta     XPOS,x
        tya
        sta     $02AE,x
LC486:  ldy     #$00
        cpx     VTEMP4
        beq     LC475
        clc
        rts

LC48F:  jsr     CHRGOT
        cmp     #$AA
        beq     LC49B
        cmp     #$AB
        beq     LC49B
        clc
LC49B:  rol     VTEMP5
        jsr     L9314
        jsr     L9DE8
        ldx     VTEMP4
        sta     $02AE,x
        tya
        sta     XPOS,x
        rts

LC4AF:  .byte   $FF,$AA,$55,$00
LC4B3:  .byte   $00
LC4B4:  .byte   $00,$2C,$71,$57,$8D,$80,$00,$A4
        .byte   $8F,$C4,$19,$DD,$B2,$F0,$90,$FC
        .byte   $1C,$FF,$FF
LC4C7:  .byte   $04
LC4C8:  .byte   $72,$04,$50,$04,$0B,$03,$A8,$03
        .byte   $28,$02,$90,$01,$E3,$01,$28,$00
        .byte   $63
LC4D9:  jsr     LC7BF
        jsr     CHRGOT
        beq     LC4F3
        ldx     #$01
        cmp     #$A4
        jsr     LC3BE
LC4E8:  jsr     CHRGOT
        cmp     #$2C
        beq     LC4F4
        cmp     #$A4
        beq     LC4F4
LC4F3:  rts

LC4F4:  pha
        jsr     CHRGET
        ldx     #$04
        jsr     LC3F7
        pla
        bpl     LC506
        jsr     LC0DA
        jmp     LC4E8

LC506:  jsr     LC37B
        jsr     LC1A5
        jmp     LC4E8

LC50F:  jsr     LC7BF
        ldx     #$04
        jsr     LC3F7
        jmp     LC37B

LC51A:  jsr     L9D84
        cpx     #$05
        bcs     LC564
        stx     TMPTON
        jsr     L9DD8
        dex
        cpx     #$10
        bcs     LC564
        stx     $7F
        ldx     #$07
        jsr     LC3A7
        cpx     #$08
        bcs     LC564
        txa
        asl     a
        asl     a
        asl     a
        asl     a
        ora     $7F
        ldx     TMPTON
        cpx     #$01
        beq     LC54A
        bcs     LC551
        sta     TEDCOLBG0
        bne     LC563
LC54A:  sta     FG
        sta     COLOR
        beq     LC563
LC551:  cpx     #$03
        beq     LC55B
        bcs     LC560
        sta     MC1
        bne     LC563
LC55B:  sta     TEDCOLBG1
        beq     LC563
LC560:  sta     TEDCOLFRAME
LC563:  rts

LC564:  jmp     L991C

LC567:  lda     GRAPHM
        bne     LC570
LC56B:  lda     #$93
        jmp     kCHROUT

LC570:  and     #$40
        beq     LC57F
        jsr     LC56B
        ldx     #$14
        ldy     #$00
        clc
        jsr     kPLOT
LC57F:  lda     #$00
        ldy     #$20
        ldx     #$20
        jsr     LC5A7
        jsr     LC238
        ldy     #$1C
        ldx     #$04
        jsr     LC5A7
        jsr     LC24E
        ldy     #$18
        ldx     #$04
        jsr     LC5A7
        lda     #$00
        ldx     #$03
LC5A0:  sta     XPOS,x
        dex
        bpl     LC5A0
        rts

LC5A7:  sty     $8D
        ldy     #$00
        sty     GRAPNT
LC5AD:  sta     (GRAPNT),y
        dey
        bne     LC5AD
        inc     $8D
        dex
        bne     LC5AD
        rts

LC5B8:  jsr     L9D84
        cpx     #$02
        bcs     LC564
        stx     SCALEM
        rts

LC5C3:  cmp     #$9C
        bne     LC5D1
        jsr     LC738
        jsr     CHRGET
        lda     #$00
        beq     LC5DB
LC5D1:  jsr     L9D84
        cpx     #$05
        bcs     LC5ED
        lda     LC637,x
LC5DB:  cmp     GRAPHM
        beq     LC62A
        sta     GRAPHM
        tax
        bne     LC5F0
        jsr     LC7C9
        lda     #$28
        ldx     #$19
        bne     LC626
LC5ED:  jmp     L991C

LC5F0:  jsr     LC63C
        lda     TEDVSP
        ora     #$20
        sta     TEDVSP
        lda     TEDHSP
        and     #$EF
        bit     GRAPHM
        bpl     LC606
        ora     #$10
LC606:  sta     TEDHSP
        lda     TEDFREQV1HI
        and     #$C3
        ora     #$08
        sta     TEDFREQV1HI
        lda     TEDVIDEORAM
        and     #$03
        ora     #$18
        sta     TEDVIDEORAM
        lda     #$28
        ldx     #$19
        bit     GRAPHM
        bpl     LC626
        lsr     a
LC626:  sta     SCXMAX
        stx     SCYMAX
LC62A:  jsr     LC3A5
        txa
        lsr     a
        bne     LC5ED
        bcc     LC636
        jmp     LC567

LC636:  rts

LC637:  .byte   $00,$20,$60,$A0,$E0
LC63C:  lda     MVDFLG
        beq     LC641
        rts

LC641:  lda     $38
        cmp     #$40
        bcs     LC67B
        jsr     LA954
        jsr     LC86B
        txa
        clc
        adc     STREND
        tya
        adc     $32
        cmp     #$18
        bcs     LC678
        dec     MVDFLG
        lda     #$00
        sta     INDEX1
        lda     #$18
        sta     $23
        jsr     LC7F0
        lda     INDEX1
        sta     FRETOP
        lda     $23
        sta     $34
        lda     #$00
        sta     MEMSIZ
        lda     #$18
        sta     $38
        jmp     LC825

LC678:  jmp     L8681

LC67B:  jsr     LA954
        ldy     STREND
        sty     $5F
        lda     $32
        clc
        adc     #$30
        bcs     LC678
        sta     $60
        cmp     $34
        bcc     LC695
        bne     LC678
        cpy     FRETOP
        bcs     LC678
LC695:  dec     MVDFLG
        lda     #$00
        sta     DEFPNT
        lda     #$30
        sta     $4F
        jsr     LC877
        lda     $5F
        sta     INDEX1
        lda     $60
        sta     $23
        ldx     STREND
        stx     INDEX2
        lda     $32
        sta     $25
        sec
        sbc     #$10
        tay
        jsr     LC7F8
        clc
        lda     $32
        adc     #$30
        sta     $32
        lda     $30
        adc     #$30
        sta     $30
        lda     $2E
        adc     #$30
        sta     $2E
        lda     $2C
        adc     #$30
        sta     $2C
        lda     $42
        adc     #$30
        sta     $42
LC6D8:  jsr     L8818
        jsr     L884B
        bit     RUNMOD
        bpl     LC70F
        ldx     #$30
        bit     MVDFLG
.if COMPILECOMPUTER >= PLUS4_03
        bmi     LC6EA
.else
        bne     LC6EA
.fi
        ldx     #$D0
LC6EA:  txa
        clc
        adc     $3C
        sta     $3C
        txa
        clc
        adc     $025C
        sta     $025C
        txa
        clc
        adc     $04F6
        sta     $04F6
        jsr     LA760
LC703:  lda     FNDPNT
        cmp     #$B0
        bne     LC710
        lda     $3E
        cmp     #$07
        bne     LC710
LC70F:  rts

LC710:  ldy     #$00
        lda     (FNDPNT),y
        cmp     #$81
        bne     LC726
        ldy     #$02
        jsr     LC7AD
        ldy     #$10
        jsr     LC7AD
        lda     #$12
        bne     LC72D
LC726:  ldy     #$04
        jsr     LC7AD
        lda     #$05
LC72D:  clc
        adc     FNDPNT
        sta     FNDPNT
        bcc     LC703
        inc     $3E
        bne     LC703
LC738:  lda     MVDFLG
        bne     LC73D
        rts

LC73D:  ldy     #$00
        sty     MVDFLG
        lda     $38
        bmi     LC769
        jsr     LA954
        jsr     LC86B
        lda     MSIZ
        sta     INDEX1
        lda     $0534
        sta     $23
        jsr     LC7F0
        ldx     #$01
LC75A:  lda     MSIZ,x
        sta     MEMSIZ,x
        lda     INDEX1,x
        sta     FRETOP,x
        dex
        bpl     LC75A
        jmp     LC825

LC769:  ldy     #$00
        sty     MVDFLG
        sty     INDEX1
        sty     INDEX2
        lda     #$10
        sta     $23
        lda     #$40
        sta     $25
LC779:  jsr     INDIN2
        sta     (INDEX1),y
        iny
        bne     LC779
        inc     $23
        inc     $25
        lda     $32
        cmp     $25
        bcs     LC779
        lda     $32
        sec
        sbc     #$30
        sta     $32
        lda     $2C
        sbc     #$30
        sta     $2C
        lda     $2E
        sbc     #$30
        sta     $2E
        lda     $30
        sbc     #$30
        sta     $30
        lda     $42
        sbc     #$30
        sta     $42
        jmp     LC6D8

LC7AD:  lda     (FNDPNT),y
        bit     MVDFLG
        bne     LC7B9
        sec
        sbc     #$30
        sta     (FNDPNT),y
        rts

LC7B9:  clc
        adc     #$30
        sta     (FNDPNT),y
        rts

LC7BF:  lda     MVDFLG
        beq     LC7C4
        rts

LC7C4:  ldx     #$23
        jmp     L8683

LC7C9:  lda     TEDVSP
        and     #$DF
        sta     TEDVSP
        lda     TEDHSP
        and     #$EF
        sta     TEDHSP
        lda     TEDVIDEORAM
        and     #$07
        ora     #$08
        sta     TEDVIDEORAM
        lda     TEDFREQV1HI
        ora     #$04
        sta     TEDFREQV1HI
        lda     #$00
        sta     GRAPHM
        rts

LC7F0:  lda     MEMSIZ
        sta     INDEX2
        lda     $38
        sta     $25
LC7F8:  txa
        eor     #$FF
        sta     DEFPNT
        tya
        eor     #$FF
        sta     $4F
        ldy     #$00
LC804:  inc     DEFPNT
        bne     LC80C
        inc     $4F
        beq     LC824
LC80C:  lda     INDEX1
        bne     LC812
        dec     $23
LC812:  dec     INDEX1
        lda     INDEX2
        bne     LC81A
        dec     $25
LC81A:  dec     INDEX2
        jsr     INDIN2
        sta     (INDEX1),y
        jmp     LC804

LC824:  rts

LC825:  lda     MEMSIZ
        ldy     $38
        sta     INDEX1
        sty     $23
LC82D:  sec
        lda     FRETOP
        sbc     INDEX1
        lda     $34
        sbc     $23
        bcs     LC824
        sec
        lda     INDEX1
        sbc     #$02
        sta     INDEX1
        bcs     LC843
        dec     $23
LC843:  ldy     #$01
LC845:  jsr     INDIN1
        sta     INDEX2,y
        dey
        bpl     LC845
        iny
        jsr     INDIN2
        sta     VOICNO
        lda     INDEX1
        sec
        sbc     VOICNO
        sta     INDEX1
        bcs     LC85F
        dec     $23
LC85F:  ldy     #$02
LC861:  lda     $21,y
        sta     (INDEX2),y
        dey
        bne     LC861
        beq     LC82D
LC86B:  sec
        lda     MEMSIZ
        sbc     FRETOP
        tax
        lda     $38
        sbc     $34
        tay
        rts

LC877:  lda     MEMSIZ
        sta     INDEX1
        lda     $38
        sta     $23
LC87F:  sec
        lda     FRETOP
        sbc     INDEX1
        lda     $34
        sbc     $23
        bcs     LC8BB
        sec
        lda     INDEX1
        sbc     #$02
        sta     INDEX1
        bcs     LC895
        dec     $23
LC895:  clc
        ldy     #$00
LC898:  jsr     INDIN1
        sta     INDEX2,y
        adc     DEFPNT,y
        sta     (INDEX1),y
        iny
        cpy     #$01
        bne     LC898
        dey
        jsr     INDIN2
        sta     VOICNO
        lda     INDEX1
        sec
        sbc     VOICNO
        sta     INDEX1
        bcs     LC87F
        dec     $23
        bcc     LC87F
LC8BB:  rts

LC8BC:  jsr     LCB1F
        and     #$E6
        bne     LC93E
        ldy     #$00
        jsr     LCA3F
        lda     #$00
        ldx     DOSFA
        ldy     #$60
        jsr     kSETLFS
        sec
        jsr     kOPEN
        bcc     LC8E1
        pha
        jsr     LC935
        pla
        tax
        jmp     L8683

LC8E1:  ldx     #$00
        jsr     kCHKIN
        ldy     #$03
LC8E8:  sty     T3
LC8EB:  jsr     kCHRIN
        sta     T4
        jsr     kREADST
        bne     LC935
        jsr     kCHRIN
        sta     $02EE
        jsr     kREADST
        bne     LC935
        dec     T3
        bne     LC8EB
        ldx     T4
        lda     $02EE
        jsr     LA45F
        lda     #$20
        jsr     kCHROUT
LC914:  jsr     kCHRIN
        pha
        jsr     kREADST
        bne     LC934
        pla
        beq     LC926
        jsr     kCHROUT
        jmp     LC914

LC926:  lda     #$0D
        jsr     kCHROUT
        jsr     kSTOP
        beq     LC935
        ldy     #$02
        bne     LC8E8
LC934:  pla
LC935:  jsr     kCLRCHN
        lda     #$00
        clc
        jmp     kCLOSE

LC93E:  jmp     L94A1

LC941:  lda     #$66
        jsr     LCB21
        jsr     LCCB5
        ldy     #$04
        jsr     LCA3F
        jmp     LA7E1

LC951:  lda     #$E6
        jsr     LCB21
        jsr     LCCB5
        lda     #$00
        sta     DOSSA
        sta     VERCK
        ldy     #$05
        jsr     LCA3F
        jmp     LA7FA

LC968:  jsr     LCB1F
        jsr     LCCAF
        and     #$11
        cmp     #$11
        beq     LC977
LC974:  jmp     L94A1

LC977:  jsr     kCLALL
        jsr     LCD2B
        bne     LC996
        ldy     #$09
        jsr     LCA3F
        jsr     LCCCF
        bit     RUNMOD
        bmi     LC996
        ldy     #$00
        lda     #$7A
        jsr     INDSUB
        cmp     #$32
        bcs     LC997
LC996:  rts

LC997:  ldx     #$24
        jmp     L8683

LC99C:  jsr     LCB1F
        jsr     LCCAF
        jsr     LCD2B
        bne     LC996
        ldy     #$0F
        jsr     LCA3F
        jsr     LCCCF
        bit     RUNMOD
        bmi     LC996
        lda     #$0D
        jsr     kCHROUT
        ldy     #$00
LC9BA:  lda     #$7A
        jsr     INDSUB
        beq     LC9C7
        jsr     kCHROUT
        iny
        bne     LC9BA
LC9C7:  lda     #$0D
        jmp     kCHROUT

LC9CC:  jsr     LCB1F
        and     #$E7
        bne     LC974
        jsr     kCLALL
        ldy     #$14
        bne     LCA3F
LC9DA:  jsr     LCB1F
        and     #$30
.if COMPILECOMPUTER == PLUS4_BETA_0203
        eor     #$30
.else
        cmp     #$30
.fi
        bne     LC9E9
        lda     POINT
        and     #$C7
        beq     LC9F0
LC9E9:  lda     POINT
        jsr     LCCC0
        lda     POINT
LC9F0:  ldy     #$17
        bne     LCA3F
LC9F4:  lda     #$E4
        jsr     LCB21
        jsr     LCCC6
        ldy     #$1E
        bne     LCA3F
LCA00:  lda     #$C7
        jsr     LCB21
        and     #$30
        cmp     #$30
        beq     LCA0E
        jmp     L94A1

LCA0E:  jsr     kCLALL
        ldy     #$25
        jmp     LCA3F

LCA16:  pha
        lda     XCNT
        ldx     #$7C
        ldy     #$02
        jsr     kSETNAM
        lda     DOSLA
        ldx     DOSFA
        ldy     DOSSA
        jsr     kSETLFS
        pla
        beq     LCA3E
        ldx     XCNT
        sec
        jsr     kOPEN
        lda     DOSLA
        sec
        jmp     kCLOSE

LCA3E:  rts

LCA3F:  jsr     LCD57
        ldx     #$00
        stx     XCNT
LCA47:  lda     LCAF5,y
        beq     LCA16
        cmp     #$80
        beq     LCA16
        tax
        dex
        beq     LCA72
        dex
        beq     LCA78
        dex
        beq     LCA7E
        dex
        beq     LCA85
        dex
        beq     LCA8D
        dex
        beq     LCA97
        dex
        beq     LCAA5
        dex
        beq     LCAAF
        dex
        beq     LCAD2
LCA6C:  jsr     LCAEB
LCA6F:  iny
        bne     LCA47
LCA72:  lda     POINT
        and     #$10
        beq     LCA6F
LCA78:  lda     DOSDS1
        jmp     LCA81

LCA7E:  lda     DOSDS2
LCA81:  ora     #$30
        bne     LCA6C
LCA85:  lda     #$40
        bit     POINT
        bmi     LCA6C
        bpl     LCA6F
LCA8D:  lda     DOSF1L
        beq     LCA6F
        lda     #$3A
        jsr     LCAEB
LCA97:  tya
        pha
        lda     DOSF1A
        ldy     $0271
        ldx     DOSF1L
        jmp     LCABA

LCAA5:  lda     DOSF2L
        beq     LCA6F
        lda     #$3A
        jsr     LCAEB
LCAAF:  tya
        pha
        lda     DOSF2A
        ldy     $0275
        ldx     DOSF2L
LCABA:  sta     INDEX1
        sty     $23
        stx     VOICNO
        ldy     #$00
LCAC2:  jsr     INDIN1
        jsr     LCAEB
        iny
        cpy     VOICNO
        bne     LCAC2
        pla
        tay
        jmp     LCA6F

LCAD2:  lda     DODDID
        beq     LCA6F
        lda     #$2C
        jsr     LCAEB
        lda     DODDID
        jsr     LCAEB
        lda     $027A
        jsr     LCAEB
        jmp     LCA6F

LCAEB:  ldx     XCNT
        sta     DOSSTR,x
        inc     XCNT
        rts

LCAF5:  .TEXT   "$"
        .byte   $07,$05,$00,$04,$02
        .TEXT   ":"
        .byte   $06,$00
        .TEXT   "N"
        .byte   $02
        .TEXT   ":"
        .byte   $06,$09,$80
        .TEXT   "S"
        .byte   $02
        .TEXT   ":"
        .byte   $06,$80
        .TEXT   "V"
        .byte   $02,$80
        .TEXT   "C"
        .byte   $03,$07
        .TEXT   "="
        .byte   $02,$05,$80
        .TEXT   "R"
        .byte   $02
        .TEXT   ":"
        .byte   $08
        .TEXT   "="
        .byte   $06,$80
        .TEXT   "D"
        .byte   $03
        .TEXT   "="
        .byte   $02,$80
LCB1F:  lda     #$00
LCB21:  pha
        lda     #$00
        sta     POINT
        ldx     #$1E
LCB28:  sta     FNBUFR,x
        dex
        bne     LCB28
        ldx     #$08
        stx     DOSFA
        ldx     #$6F
        stx     DOSSA
        ldx     #$00
        stx     DOSLA
        jsr     CHRGOT
        bne     LCB49
LCB42:  pla
        jsr     LCCAA
        lda     POINT
        rts

LCB49:  cmp     #$44
        beq     LCB6A
        cmp     #$91
        beq     LCB9F
        cmp     #$55
        beq     LCB64
        cmp     #$49
        beq     LCB83
        cmp     #$22
        beq     LCBA5
        cmp     #$28
        beq     LCBA5
LCB61:  jmp     L94A1

LCB64:  jsr     LCC58
        jmp     LCBCD

LCB6A:  lda     #$10
        jsr     LCCAA
        jsr     LCC97
        cpx     #$02
        bcs     LCB80
        stx     DOSDS1
        stx     DOSDS2
        lda     #$10
        bne     LCBCD
LCB80:  jmp     LCC49

LCB83:  lda     DIDCHK
        bne     LCB61
        jsr     CHRGET
        sta     DODDID
        jsr     CHRGET
        sta     $027A
        lda     #$FF
        sta     DIDCHK
        jsr     CHRGET
        jmp     LCBD1

LCB9F:  jsr     LCC51
        jmp     LCBCD

LCBA5:  lda     #$01
        jsr     LCC69
        sta     DOSF1L
        sta     XCNT
        lda     #$5E
        sta     DOSF1A
        sta     INDEX2
        lda     #$02
        sta     $0271
        sta     $25
        ldy     #$00
LCBC0:  jsr     INDIN1
        sta     (INDEX2),y
        iny
        cpy     XCNT
        bcc     LCBC0
        lda     #$01
LCBCD:  ora     POINT
        sta     POINT
LCBD1:  jsr     CHRGOT
        bne     LCBD9
LCBD6:  jmp     LCB42

LCBD9:  cmp     #$2C
        bne     LCBE3
        jsr     CHRGET
        jmp     LCB49

LCBE3:  cmp     #$91
        beq     LCB9F
        cmp     #$A4
        bne     LCC46
LCBEB:  jsr     CHRGET
        cmp     #$44
        beq     LCC02
        cmp     #$91
        beq     LCC15
        cmp     #$55
        beq     LCC1B
        cmp     #$22
        beq     LCC21
        cmp     #$28
        beq     LCC21
LCC02:  lda     #$20
        jsr     LCCAA
        jsr     LCC97
        cpx     #$02
        bcs     LCC49
        stx     DOSDS2
        lda     #$20
        bne     LCC31
LCC15:  jsr     LCC51
        jmp     LCC31

LCC1B:  jsr     LCC58
        jmp     LCC31

LCC21:  lda     #$02
        jsr     LCC69
        sta     DOSF2L
        stx     DOSF2A
        sty     $0275
        lda     #$02
LCC31:  ora     POINT
        sta     POINT
        jsr     CHRGOT
        beq     LCBD6
        cmp     #$2C
        beq     LCBEB
        cmp     #$91
        beq     LCC15
        cmp     #$55
        beq     LCC1B
LCC46:  ldx     #$0B
        .byte   $2C
LCC49:  ldx     #$0E
        .byte   $2C
LCC4C:  ldx     #$17
        jmp     L8683

LCC51:  jsr     CHRGET
        cmp     #$55
        bne     LCC46
LCC58:  jsr     LCC97
        cpx     #$20
        bcs     LCC49
        cpx     #$03
        bcc     LCC49
        stx     DOSFA
        lda     #$08
        rts

LCC69:  jsr     LCCAA
        jsr     L9C48
        tax
        beq     LCC49
        ldy     #$00
        jsr     INDIN1
        cmp     #$40
        bne     LCC8D
        lda     #$80
        jsr     LCCAA
        lda     POINT
        ora     #$80
        sta     POINT
        dex
        inc     INDEX1
        bne     LCC8D
        inc     $23
LCC8D:  txa
        cmp     #$11
        bcs     LCC4C
        ldx     INDEX1
        ldy     $23
        rts

LCC97:  jsr     CHRGET
        beq     LCC46
        bcc     LCCA7
        jsr     L948E
        jsr     L9D84
        jmp     L948B

LCCA7:  jmp     L9D84

LCCAA:  and     POINT
        bne     LCC46
        rts

LCCAF:  and     #$E6
        beq     LCCB5
LCCB3:  bne     LCC46
LCCB5:  lda     POINT
        and     #$01
        cmp     #$01
        bne     LCCB3
        lda     POINT
        rts

LCCC0:  and     #$C4
        bne     LCCB3
        lda     POINT
LCCC6:  and     #$03
        cmp     #$03
        bne     LCCB3
        lda     POINT
        rts

LCCCF:  lda     DSDESC
        bne     LCCE4
        lda     #$28
        sta     DSDESC
        jsr     LA906
        stx     $7A
        sty     $7B
        ldy     #$28
.if COMPILECOMPUTER >= PLUS4_05
        jsr     LCDBA
        nop
.else
        lda     #$0D
        sta     ($7A),y
.fi
LCCE4:  ldx     DOSFA
        bne     LCCEE
        ldx     #$08
        stx     DOSFA
LCCEE:  lda     #$00
        ldy     #$6F
        jsr     kSETLFS
        lda     #$00
        jsr     kSETNAM
        jsr     kOPEN
        ldx     #$00
        jsr     kCHKIN
        bcs     LCD1F
        ldy     #$FF
LCD06:  iny
        jsr     kCHRIN
        cmp     #$0D
        beq     LCD12
        sta     ($7A),y
        bne     LCD06
LCD12:  lda     #$00
        sta     ($7A),y
        jsr     kCLRCHN
        lda     #$00
        sec
        jmp     kCLOSE

LCD1F:  pha
        jsr     LCD12
        jsr     LCD57
        pla
        tax
        jmp     L8683

LCD2B:  bit     RUNMOD
        bmi     LCD54
        jsr     LFF4F

        .TEXT   "ARE YOU SURE?",0

        jsr     kCLRCHN
        jsr     kCHRIN
        pha
LCD47:  cmp     #$0D
        beq     LCD50
        jsr     kCHRIN
        bne     LCD47
LCD50:  pla
        cmp     #$59
        rts

LCD54:  lda     #$00
        rts

LCD57:  tya
        pha
        lda     DSDESC
        beq     LCD67
        ldy     #$28
        tya
        sta     ($7A),y
        iny
        lda     #$FF
        sta     ($7A),y
LCD67:  lda     #$00
        sta     DSDESC
        pla
        tay
        rts

LCD6E:  .TEXT   ",0 YEK"
LCD74:  tax
        tya
        pha
        lda     #$00
        jsr     LA45F
        pla
        tay
        rts

LCD7F:  sta     $3A
        dey
        tax
        inx
        bne     LCD88
        stx     RUNMOD
LCD88:  rts

LCD89:  .byte   $D8,$1B,$14,$0C,$07,$7B,$01,$D7
        .byte   $D8,$11,$07,$10,$1D,$7B,$17,$D8
        .byte   $07,$10,$05,$1A,$1A,$16,$7B,$1F
        .byte   $D8,$1B,$10,$02,$1A,$17,$7B,$13
        .byte   $47,$D8
        ldy     #$21
LCDAD:  lda     LCD89,y
        eor     #$55
        jsr     kCHROUT
        dey
        bpl     LCDAD
        rts

        .byte   $00

.if COMPILECOMPUTER >= PLUS4_05

LCDBA:  lda     #$79
        sta     ($7A),y
        lda     #$00
        iny
        sta     ($7A),y
        rts

.elsif COMPILECOMPUTER == PLUS4_01

        .byte   $0E,$F0,$0E,$F1,$0F,$F5,$F0
        .byte   $0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0
        .byte   $1F,$F0,$0F,$F0,$0F,$D0,$0F,$F0
        .byte   $0F,$F0,$0F,$E0,$2F,$70,$0F,$70
        .byte   $0F,$D0,$0F,$B0,$6F,$F0,$4F,$0F
        .byte   $F0,$0F,$F1,$0F,$F0,$0F,$F0,$0F
        .byte   $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0E
        .byte   $F4,$0F,$F1,$0F,$F1,$07,$F3,$0B
        .byte   $F0,$0E,$F1,$07,$F0,$06,$F0
.fi

.if COMPILECOMPUTER < PLUS4_01
;        FillUntil $CDFF,$00
        .fill $CDFF-*,$00        

.if COMPILECOMPUTER == PLUS4_BETA_0119
        .byte   $F2
.else
        .byte   $9A
.fi
.fi

;        FillUntil $CE00,$FF
        .fill $CE00-*,$FF
        
LCE00:  tsx
        lda     $0104,x
        and     #$10
        bne     LCE0B
        jmp     (lICINV)

LCE0B:  jmp     (lICBINV)

LCE0E:  lda     TEDIFR
        and     #$02
        beq     LCE18
        jsr     LCE60
LCE18:  bit     APRES
        bpl     LCE2B
        lda     LFD01
        sta     ASTAT
        bpl     LCE2B
        jsr     LEA95
        jsr     LEA5B
LCE2B:  jsr     LE3E4
        lda     TEDIFR
        and     #$02
        beq     LCE5D
        sta     TEDIFR
        bit     TEDRASTER
        lda     #$CC
        bvc     LCE5A
        jmp     (lITIME)

LCE42:
.if COMPILECOMPUTER >= PLUS4_01
        jsr     LCFBF
.else
        jsr     kUDTIM
.fi
        jsr     LCECD
        lda     CURBNK
        pha
        lda     #$00
        sta     CURBNK
        php
        cli
        jsr     iSCNKEY
        plp
        pla
        sta     CURBNK
        lda     #$A1
LCE5A:  sta     TEDRASTER
LCE5D:  jmp     LFCBE

LCE60:  lda     TEDRASTERROWHi
        and     #$01
        bne     LCEA0
        lda     TEDRASTERROWLO
        cmp     #$A3
        bcs     LCE9C
        bit     GRAPHM
        bvc     LCEC4
.if COMPILECOMPUTER == PLUS4_BETA_0119
        lda     TEDVIDEORAM
        and     #$07
        ora     #$08
.else
        lda     #$08
.fi
        sta     TEDVIDEORAM
        lda     TEDVSP
        and     #$DF
        tay
        lda     TEDHSP
        and     #$EF
        tax
        lda     TEDFREQV1HI
.if COMPILECOMPUTER == PLUS4_BETA_0119
        ora     #$04
.else
        ora     FFRMSK
.fi
        pha
LCE8A:  lda     TEDRASTERROWLO
        cmp     #$A3
        bcc     LCE8A
        pla
        sta     TEDFREQV1HI
        sty     TEDVSP
        stx     TEDHSP
        rts

LCE9C:  cmp     #$CC
        bcc     LCEC4
LCEA0:  ldx     GRAPHM
        beq     LCEC4
        bpl     LCEAE
        lda     TEDHSP
        ora     #$10
        sta     TEDHSP
LCEAE:  lda     TEDVSP
        ora     #$20
        sta     TEDVSP
        lda     TEDFREQV1HI
        and     #$FB
        sta     TEDFREQV1HI
.if COMPILECOMPUTER == PLUS4_BETA_0119
        lda     TEDVIDEORAM
        and     #$07
        ora     #$18
.else
        lda     VMBMSK
.fi
        sta     TEDVIDEORAM
LCEC4:  rts

;        FillUntil $CECD,$EA
        .fill $CECD-*,$EA

LCECD:  ldx     #$01
LCECF:  lda     MTIMLO,x
        ora     MTIMHI,x
        beq     LCEEA
        inc     MTIMLO,x
        bne     LCEEA
        inc     MTIMHI,x
        bne     LCEEA
        lda     LCEEE,x
        and     TEDVOL
        sta     TEDVOL
LCEEA:  dex
        bpl     LCECF
        rts

LCEEE:  .byte   $EF,$9F

iUDTIM: inc     $A5
        bne     LCEFA
        inc     $A4
        bne     LCEFA
        inc     TIME
LCEFA:  sec
        lda     $A5
        sbc     #$01
        lda     $A4
        sbc     #$1A
        lda     TIME
        sbc     #$4F
        bcc     LCF11
        ldx     #$00
        stx     TIME
        stx     $A4
        stx     $A5
LCF11:  lda     #$7F
        jsr     LDB70
        sta     $EE
        lda     #$7F
        jsr     LDB70
        cmp     $EE
        bne     LCF11
        ora     #$7F
        sta     STKEY
        rts

iRDTIM: sei
        lda     $A5
        ldx     $A4
        ldy     TIME
iSETTIM:sei
        sta     $A5
        stx     $A4
        sty     TIME
        cli
        rts

LCF36:  .byte   $0D
        .TEXT   "MONITOR"
        .byte   $8D,$0D
        .TEXT   "BREA"
        .byte   $CB,$0D
        .TEXT   "   PC  SR AC XR YR SP"


        .byte   $0D
        .TEXT   ";"
        .byte   $A0
        .TEXT   "A"
        .byte   $A0
        .TEXT   " ERRO"
        .byte   $D2
LCF66:  lda     LCF36,x
        php
        and     #$7F
        jsr     kCHROUT
        inx
        plp
        bpl     LCF66
        rts

LCF74:  lda     #$0D
        ldx     DFLTN
        cpx     #$03
        beq     LCF82
        ldx     DFLTO
        cpx     #$03
        beq     LCF85
LCF82:  jsr     LDC49
LCF85:  lda     #$0D
        jmp     LD9B0

LCF8A:  lda     COLKEY,x
        bit     COLSW
        bpl     LCF95
        lda     LE143,x
LCF95:  rts

LCF96:  bit     RAMROM
        bmi     LCF9E
        lda     (T2),y
        rts

LCF9E:  lda     #$A1
        sta     $07DF
        jmp     KLUDES

LCFA6:  lda     #$09
        sta     LFD20
        ora     #$80
        sta     LFD20
        jmp     LFC1E

.if COMPILECOMPUTER == PLUS4_BETA_0119

        .byte   $FF
        .byte   $C2
        inc     PDIR,x
        inx
        .byte   $23
        .byte   $F7
        lsr     $ADDE
        .byte   $72
        ror     SGNFLG
.else
LCFB3:  php
        sei
        sta     TEDROMSEL
        lda     (PDIR),y
        sta     TEDRAMSEL
        plp
        rts
.fi

.if COMPILECOMPUTER < PLUS4_01

.if COMPILECOMPUTER == PLUS4_BETA_0203
        .byte $67
.fi
        .byte $32, $87, $60, $7f, $10, $4d, $92, $ef, $28, $3b, $be, $7d, $30, $1d, $76, $0d
        .byte $20, $eb, $62, $eb, $e0, $4f, $f2, $bf, $4a, $3f, $40, $af, $a8, $5f, $10, $6f
        .byte $45, $f3, $1c, $d4, $07, $e8, $31, $e9, $3d, $7d, $0e, $ff, $07, $6a, $00, $d7
        .byte $05, $75, $b4, $e8, $02, $fe, $02, $fd, $11, $f2, $0a, $fe, $28, $db, $08

.else

LCFBF:  lda     SPI6529
        and     #$04
        bne     LCFE1
        bit     LSEM
        bmi     LCFD1
        lda     PORT
        and     #$F7
        sta     PORT
LCFD1:

.if IS_PAL
        dec     PALCNT
        bpl     LCFDE
        lda     #$04
        sta     PALCNT
        jsr     iUDTIM
.fi

LCFDE:  jmp     iUDTIM

LCFE1:  sta     LSEM
        jsr     LE3B0
        jmp     LCFD1

LCFEA:  inx
        stx     LFEC4
        stx     LFEC0
        lda     #$80
        sta     TEDVOL
        rts

.if COMPILECOMPUTER == PLUS4_01
        .byte   $F5,$07,$F0,$0A,$F8,$0F,$F8,$0A
        .byte   $F2
.fi
.fi

;        FillUntil $D000,$FF
        .fill $D000-*,$FF

CHARROMCAP:
        .byte   $3C,$66,$6E,$6E,$60,$62,$3C,$00
        .byte   $18,$3C,$66,$7E,$66,$66,$66,$00
        .byte   $7C,$66,$66,$7C,$66,$66,$7C,$00
        .byte   $3C,$66,$60,$60,$60,$66,$3C,$00
        .byte   $78,$6C,$66,$66,$66,$6C,$78,$00
        .byte   $7E,$60,$60,$78,$60,$60,$7E,$00
        .byte   $7E,$60,$60,$78,$60,$60,$60,$00
        .byte   $3C,$66,$60,$6E,$66,$66,$3C,$00
        .byte   $66,$66,$66,$7E,$66,$66,$66,$00
        .byte   $3C,$18,$18,$18,$18,$18,$3C,$00
        .byte   $1E,$0C,$0C,$0C,$0C,$6C,$38,$00
        .byte   $66,$6C,$78,$70,$78,$6C,$66,$00
        .byte   $60,$60,$60,$60,$60,$60,$7E,$00
        .byte   $63,$77,$7F,$6B,$63,$63,$63,$00
        .byte   $66,$76,$7E,$7E,$6E,$66,$66,$00
        .byte   $3C,$66,$66,$66,$66,$66,$3C,$00
        .byte   $7C,$66,$66,$7C,$60,$60,$60,$00
        .byte   $3C,$66,$66,$66,$66,$3C,$0E,$00
        .byte   $7C,$66,$66,$7C,$78,$6C,$66,$00
        .byte   $3C,$66,$60,$3C,$06,$66,$3C,$00
        .byte   $7E,$18,$18,$18,$18,$18,$18,$00
        .byte   $66,$66,$66,$66,$66,$66,$3C,$00
        .byte   $66,$66,$66,$66,$66,$3C,$18,$00
        .byte   $63,$63,$63,$6B,$7F,$77,$63,$00
        .byte   $66,$66,$3C,$18,$3C,$66,$66,$00
        .byte   $66,$66,$66,$3C,$18,$18,$18,$00
        .byte   $7E,$06,$0C,$18,$30,$60,$7E,$00
        .byte   $3C,$30,$30,$30,$30,$30,$3C,$00
        .byte   $0C,$12,$30,$7C,$30,$62,$FC,$00
        .byte   $3C,$0C,$0C,$0C,$0C,$0C,$3C,$00
        .byte   $00,$18,$3C,$7E,$18,$18,$18,$18
        .byte   $00,$10,$30,$7F,$7F,$30,$10,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $18,$18,$18,$18,$00,$00,$18,$00
        .byte   $66,$66,$66,$00,$00,$00,$00,$00
        .byte   $66,$66,$FF,$66,$FF,$66,$66,$00
        .byte   $18,$3E,$60,$3C,$06,$7C,$18,$00
        .byte   $62,$66,$0C,$18,$30,$66,$46,$00
        .byte   $3C,$66,$3C,$38,$67,$66,$3F,$00
        .byte   $06,$0C,$18,$00,$00,$00,$00,$00
        .byte   $0C,$18,$30,$30,$30,$18,$0C,$00
        .byte   $30,$18,$0C,$0C,$0C,$18,$30,$00
        .byte   $00,$66,$3C,$FF,$3C,$66,$00,$00
        .byte   $00,$18,$18,$7E,$18,$18,$00,$00
        .byte   $00,$00,$00,$00,$00,$18,$18,$30
        .byte   $00,$00,$00,$7E,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$18,$18,$00
        .byte   $00,$03,$06,$0C,$18,$30,$60,$00
        .byte   $3C,$66,$6E,$76,$66,$66,$3C,$00
        .byte   $18,$18,$38,$18,$18,$18,$7E,$00
        .byte   $3C,$66,$06,$0C,$30,$60,$7E,$00
        .byte   $3C,$66,$06,$1C,$06,$66,$3C,$00
        .byte   $06,$0E,$1E,$66,$7F,$06,$06,$00
        .byte   $7E,$60,$7C,$06,$06,$66,$3C,$00
        .byte   $3C,$66,$60,$7C,$66,$66,$3C,$00
        .byte   $7E,$66,$0C,$18,$18,$18,$18,$00
        .byte   $3C,$66,$66,$3C,$66,$66,$3C,$00
        .byte   $3C,$66,$66,$3E,$06,$66,$3C,$00
        .byte   $00,$00,$18,$00,$00,$18,$00,$00
        .byte   $00,$00,$18,$00,$00,$18,$18,$30
        .byte   $0E,$18,$30,$60,$30,$18,$0E,$00
        .byte   $00,$00,$7E,$00,$7E,$00,$00,$00
        .byte   $70,$18,$0C,$06,$0C,$18,$70,$00
        .byte   $3C,$66,$06,$0C,$18,$00,$18,$00
        .byte   $00,$00,$00,$FF,$FF,$00,$00,$00
        .byte   $08,$1C,$3E,$7F,$7F,$1C,$3E,$00
        .byte   $18,$18,$18,$18,$18,$18,$18,$18
        .byte   $00,$00,$00,$FF,$FF,$00,$00,$00
        .byte   $00,$00,$FF,$FF,$00,$00,$00,$00
        .byte   $00,$FF,$FF,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$FF,$FF,$00,$00
        .byte   $30,$30,$30,$30,$30,$30,$30,$30
        .byte   $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .byte   $00,$00,$00,$E0,$F0,$38,$18,$18
        .byte   $18,$18,$1C,$0F,$07,$00,$00,$00
        .byte   $18,$18,$38,$F0,$E0,$00,$00,$00
        .byte   $C0,$C0,$C0,$C0,$C0,$C0,$FF,$FF
        .byte   $C0,$E0,$70,$38,$1C,$0E,$07,$03
        .byte   $03,$07,$0E,$1C,$38,$70,$E0,$C0
        .byte   $FF,$FF,$C0,$C0,$C0,$C0,$C0,$C0
        .byte   $FF,$FF,$03,$03,$03,$03,$03,$03
        .byte   $00,$3C,$7E,$7E,$7E,$7E,$3C,$00
        .byte   $00,$00,$00,$00,$00,$FF,$FF,$00
        .byte   $36,$7F,$7F,$7F,$3E,$1C,$08,$00
        .byte   $60,$60,$60,$60,$60,$60,$60,$60
        .byte   $00,$00,$00,$07,$0F,$1C,$18,$18
        .byte   $C3,$E7,$7E,$3C,$3C,$7E,$E7,$C3
        .byte   $00,$3C,$7E,$66,$66,$7E,$3C,$00
        .byte   $18,$18,$66,$66,$18,$18,$3C,$00
        .byte   $06,$06,$06,$06,$06,$06,$06,$06
        .byte   $08,$1C,$3E,$7F,$3E,$1C,$08,$00
        .byte   $18,$18,$18,$FF,$FF,$18,$18,$18
        .byte   $C0,$C0,$30,$30,$C0,$C0,$30,$30
        .byte   $18,$18,$18,$18,$18,$18,$18,$18
        .byte   $00,$00,$03,$3E,$76,$36,$36,$00
        .byte   $FF,$7F,$3F,$1F,$0F,$07,$03,$01
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
        .byte   $00,$00,$00,$00,$FF,$FF,$FF,$FF
        .byte   $FF,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$FF
        .byte   $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        .byte   $CC,$CC,$33,$33,$CC,$CC,$33,$33
        .byte   $03,$03,$03,$03,$03,$03,$03,$03
        .byte   $00,$00,$00,$00,$CC,$CC,$33,$33
        .byte   $FF,$FE,$FC,$F8,$F0,$E0,$C0,$80
        .byte   $03,$03,$03,$03,$03,$03,$03,$03
        .byte   $18,$18,$18,$1F,$1F,$18,$18,$18
        .byte   $00,$00,$00,$00,$0F,$0F,$0F,$0F
        .byte   $18,$18,$18,$1F,$1F,$00,$00,$00
        .byte   $00,$00,$00,$F8,$F8,$18,$18,$18
        .byte   $00,$00,$00,$00,$00,$00,$FF,$FF
        .byte   $00,$00,$00,$1F,$1F,$18,$18,$18
        .byte   $18,$18,$18,$FF,$FF,$00,$00,$00
        .byte   $00,$00,$00,$FF,$FF,$18,$18,$18
        .byte   $18,$18,$18,$F8,$F8,$18,$18,$18
        .byte   $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        .byte   $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0
        .byte   $07,$07,$07,$07,$07,$07,$07,$07
        .byte   $FF,$FF,$00,$00,$00,$00,$00,$00
        .byte   $FF,$FF,$FF,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$FF,$FF,$FF
        .byte   $03,$03,$03,$03,$03,$03,$FF,$FF
        .byte   $00,$00,$00,$00,$F0,$F0,$F0,$F0
        .byte   $0F,$0F,$0F,$0F,$00,$00,$00,$00
        .byte   $18,$18,$18,$F8,$F8,$00,$00,$00
        .byte   $F0,$F0,$F0,$F0,$00,$00,$00,$00
        .byte   $F0,$F0,$F0,$F0,$0F,$0F,$0F,$0F
CHARROMSMALL:
        .byte   $3C,$66,$6E,$6E,$60,$62,$3C,$00
        .byte   $00,$00,$3C,$06,$3E,$66,$3E,$00
        .byte   $60,$60,$7C,$66,$66,$66,$7C,$00
        .byte   $00,$00,$3C,$66,$60,$66,$3C,$00
        .byte   $06,$06,$3E,$66,$66,$66,$3E,$00
        .byte   $00,$00,$3C,$66,$7E,$60,$3E,$00
        .byte   $1C,$36,$30,$78,$30,$30,$30,$00
        .byte   $00,$00,$3E,$66,$66,$3E,$06,$7C
        .byte   $60,$60,$7C,$66,$66,$66,$66,$00
        .byte   $18,$00,$18,$18,$18,$18,$18,$00
        .byte   $06,$00,$06,$06,$06,$06,$66,$3C
        .byte   $60,$60,$66,$6C,$78,$7C,$66,$00
        .byte   $38,$18,$18,$18,$18,$18,$3C,$00
.if COMPILECOMPUTER >= PLUS4_01
        .byte   $00,$00,$6B,$7F,$7F,$63,$63,$00
.else
        .byte   $00,$00,$66,$7F,$6B,$63,$63,$00
.fi
        .byte   $00,$00,$7C,$66,$66,$66,$66,$00
        .byte   $00,$00,$3C,$66,$66,$66,$3C,$00
        .byte   $00,$00,$7C,$66,$66,$7C,$60,$60
        .byte   $00,$00,$3E,$66,$66,$3E,$06,$06
        .byte   $00,$00,$7C,$66,$60,$60,$60,$00
        .byte   $00,$00,$3C,$60,$3C,$06,$7C,$00
        .byte   $30,$30,$FC,$30,$30,$36,$1C,$00
        .byte   $00,$00,$66,$66,$66,$66,$3C,$00
        .byte   $00,$00,$66,$66,$66,$3C,$18,$00
.if COMPILECOMPUTER >= PLUS4_01
        .byte   $00,$00,$63,$6B,$7F,$36,$22,$00
.else
        .byte   $00,$00,$63,$6B,$6B,$7F,$36,$00
.fi
        .byte   $00,$00,$66,$3C,$18,$3C,$66,$00
        .byte   $00,$00,$66,$66,$66,$3E,$06,$7C
        .byte   $00,$00,$7E,$0C,$18,$30,$7E,$00
        .byte   $3C,$30,$30,$30,$30,$30,$3C,$00
        .byte   $0C,$12,$30,$7C,$30,$62,$FC,$00
        .byte   $3C,$0C,$0C,$0C,$0C,$0C,$3C,$00
        .byte   $00,$18,$3C,$7E,$18,$18,$18,$18
        .byte   $00,$10,$30,$7F,$7F,$30,$10,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $18,$18,$18,$18,$00,$00,$18,$00
        .byte   $66,$66,$66,$00,$00,$00,$00,$00
        .byte   $66,$66,$FF,$66,$FF,$66,$66,$00
        .byte   $18,$3E,$60,$3C,$06,$7C,$18,$00
        .byte   $62,$66,$0C,$18,$30,$66,$46,$00
        .byte   $3C,$66,$3C,$38,$67,$66,$3F,$00
        .byte   $06,$0C,$18,$00,$00,$00,$00,$00
        .byte   $0C,$18,$30,$30,$30,$18,$0C,$00
        .byte   $30,$18,$0C,$0C,$0C,$18,$30,$00
        .byte   $00,$66,$3C,$FF,$3C,$66,$00,$00
        .byte   $00,$18,$18,$7E,$18,$18,$00,$00
        .byte   $00,$00,$00,$00,$00,$18,$18,$30
        .byte   $00,$00,$00,$7E,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$18,$18,$00
        .byte   $00,$03,$06,$0C,$18,$30,$60,$00
        .byte   $3C,$66,$6E,$76,$66,$66,$3C,$00
        .byte   $18,$18,$38,$18,$18,$18,$7E,$00
        .byte   $3C,$66,$06,$0C,$30,$60,$7E,$00
        .byte   $3C,$66,$06,$1C,$06,$66,$3C,$00
        .byte   $06,$0E,$1E,$66,$7F,$06,$06,$00
        .byte   $7E,$60,$7C,$06,$06,$66,$3C,$00
        .byte   $3C,$66,$60,$7C,$66,$66,$3C,$00
        .byte   $7E,$66,$0C,$18,$18,$18,$18,$00
        .byte   $3C,$66,$66,$3C,$66,$66,$3C,$00
        .byte   $3C,$66,$66,$3E,$06,$66,$3C,$00
        .byte   $00,$00,$18,$00,$00,$18,$00,$00
        .byte   $00,$00,$18,$00,$00,$18,$18,$30
        .byte   $0E,$18,$30,$60,$30,$18,$0E,$00
        .byte   $00,$00,$7E,$00,$7E,$00,$00,$00
        .byte   $70,$18,$0C,$06,$0C,$18,$70,$00
        .byte   $3C,$66,$06,$0C,$18,$00,$18,$00
        .byte   $00,$00,$00,$FF,$FF,$00,$00,$00
        .byte   $18,$3C,$66,$7E,$66,$66,$66,$00
        .byte   $7C,$66,$66,$7C,$66,$66,$7C,$00
        .byte   $3C,$66,$60,$60,$60,$66,$3C,$00
        .byte   $78,$6C,$66,$66,$66,$6C,$78,$00
        .byte   $7E,$60,$60,$78,$60,$60,$7E,$00
        .byte   $7E,$60,$60,$78,$60,$60,$60,$00
        .byte   $3C,$66,$60,$6E,$66,$66,$3C,$00
        .byte   $66,$66,$66,$7E,$66,$66,$66,$00
        .byte   $3C,$18,$18,$18,$18,$18,$3C,$00
        .byte   $1E,$0C,$0C,$0C,$0C,$6C,$38,$00
        .byte   $66,$6C,$78,$70,$78,$6C,$66,$00
        .byte   $60,$60,$60,$60,$60,$60,$7E,$00
        .byte   $63,$77,$7F,$6B,$63,$63,$63,$00
        .byte   $66,$76,$7E,$7E,$6E,$66,$66,$00
        .byte   $3C,$66,$66,$66,$66,$66,$3C,$00
        .byte   $7C,$66,$66,$7C,$60,$60,$60,$00
        .byte   $3C,$66,$66,$66,$66,$3C,$0E,$00
        .byte   $7C,$66,$66,$7C,$78,$6C,$66,$00
        .byte   $3C,$66,$60,$3C,$06,$66,$3C,$00
        .byte   $7E,$18,$18,$18,$18,$18,$18,$00
        .byte   $66,$66,$66,$66,$66,$66,$3C,$00
        .byte   $66,$66,$66,$66,$66,$3C,$18,$00
        .byte   $63,$63,$63,$6B,$7F,$77,$63,$00
        .byte   $66,$66,$3C,$18,$3C,$66,$66,$00
        .byte   $66,$66,$66,$3C,$18,$18,$18,$00
        .byte   $7E,$06,$0C,$18,$30,$60,$7E,$00
        .byte   $18,$18,$18,$FF,$FF,$18,$18,$18
        .byte   $C0,$C0,$30,$30,$C0,$C0,$30,$30
        .byte   $18,$18,$18,$18,$18,$18,$18,$18
        .byte   $33,$33,$CC,$CC,$33,$33,$CC,$CC
        .byte   $33,$99,$CC,$66,$33,$99,$CC,$66
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
        .byte   $00,$00,$00,$00,$FF,$FF,$FF,$FF
        .byte   $FF,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$FF
        .byte   $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        .byte   $CC,$CC,$33,$33,$CC,$CC,$33,$33
        .byte   $03,$03,$03,$03,$03,$03,$03,$03
        .byte   $00,$00,$00,$00,$CC,$CC,$33,$33
        .byte   $CC,$99,$33,$66,$CC,$99,$33,$66
        .byte   $03,$03,$03,$03,$03,$03,$03,$03
        .byte   $18,$18,$18,$1F,$1F,$18,$18,$18
        .byte   $00,$00,$00,$00,$0F,$0F,$0F,$0F
        .byte   $18,$18,$18,$1F,$1F,$00,$00,$00
        .byte   $00,$00,$00,$F8,$F8,$18,$18,$18
        .byte   $00,$00,$00,$00,$00,$00,$FF,$FF
        .byte   $00,$00,$00,$1F,$1F,$18,$18,$18
        .byte   $18,$18,$18,$FF,$FF,$00,$00,$00
        .byte   $00,$00,$00,$FF,$FF,$18,$18,$18
        .byte   $18,$18,$18,$F8,$F8,$18,$18,$18
        .byte   $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        .byte   $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0
        .byte   $07,$07,$07,$07,$07,$07,$07,$07
        .byte   $FF,$FF,$00,$00,$00,$00,$00,$00
        .byte   $FF,$FF,$FF,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$FF,$FF,$FF
        .byte   $01,$03,$06,$6C,$78,$70,$60,$00
        .byte   $00,$00,$00,$00,$F0,$F0,$F0,$F0
        .byte   $0F,$0F,$0F,$0F,$00,$00,$00,$00
        .byte   $18,$18,$18,$F8,$F8,$00,$00,$00
        .byte   $F0,$F0,$F0,$F0,$00,$00,$00,$00
        .byte   $F0,$F0,$F0,$F0,$0F,$0F,$0F,$0F


LD800:   .word   VERSION_INFO_D800

LD802:  .byte   $00,$28,$50,$78,$A0,$C8,$F0,$18
        .byte   $40,$68,$90,$B8,$E0,$08,$30,$58
        .byte   $80,$A8,$D0,$F8,$20,$48,$70,$98
        .byte   $C0
LD81B:  .byte   $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D
        .byte   $0D,$0D,$0D,$0D,$0D,$0E,$0E,$0E
.if COMPILECOMPUTER >= PLUS4_01
        .byte   $0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F
.elsif COMPILECOMPUTER == PLUS4_BETA_0203
        .byte   $0E,$0E,$0E,$0E,$0F,$0F,$0D,$0F
.elsif COMPILECOMPUTER == PLUS4_BETA_0119
        .byte   $0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F
.fi
        .byte   $0F
iSCREEN:ldx     #$28
        ldy     #$19
        rts

iPLOT:  bcs     LD849
        stx     TBLX
        stx     LSXP
        sty     PNTR
        sty     $C5
        jsr     LDE70
        jsr     LD8A8
LD849:  ldx     TBLX
        ldy     PNTR
        rts

iCINT:  lda     #$0C
        sta     HIBASE
        lda     #$03
        sta     DFLTO
        lda     #$00
        sta     DFLTN
        sta     MODE
        sta     GRAPHM
        sta     NDX
        sta     STPFLG
        lda     #$7A
        sta     KEYLOG
        lda     #$DB
        sta     $0546
        lda     #$0A
        sta     XMAX
        sta     ROLFLG
        sta     DELAY
        lda     #$80
        sta     RPTFLG
        lda     #$10
        sta     COLOR
        lda     #$04
        sta     KOUNT
LD888:  jsr     LDE70
LD88B:  jsr     LD89A
LD88E:  jsr     LD8AA
        jsr     LDAF7
        cpx     SCBOT
        inx
        bcc     LD88E
LD89A:  ldx     SCTOP
        stx     TBLX
        stx     LSXP
LD8A1:  ldy     SCLF
        sty     PNTR
        sty     $C5
LD8A8:  ldx     TBLX
LD8AA:  lda     LD802,x
        sta     PNT
        lda     LD81B,x
        sta     $C9
LD8B4:  lda     PNT
        sta     USER
        lda     $C9
        and     #$03
        ora     #$08
        sta     $EB
        rts

LD8C1:
.if COMPILECOMPUTER >= PLUS4_05
        ldx     KYNDX
        beq     LD8D5
.else
        ldy     KYNDX
        beq     LD8D5
.fi
        ldy     KEYIDX
        lda     PKYBUF,y
        dec     KYNDX
        inc     KEYIDX
        cli
.if COMPILECOMPUTER >= PLUS4_05
        clc
.fi
        rts

LD8D5:
        ldy     KEYD
.if COMPILECOMPUTER >= PLUS4_05
        nop
.else
        ldx     #$00
.fi
LD8D9:  lda     $0528,x
        sta     KEYD,x
        inx
        cpx     NDX
        bne     LD8D9
        dec     NDX
        tya
        cli
        clc
        rts

LD8EA:  jsr     LDC49
LD8ED:  jsr     LD8B4
        ldy     PNTR
        lda     (USER),y
        pha
        lda     COLOR
        sta     (USER),y
        tya
        clc
        adc     PNT
        sta     TEDCRSRPOSLO
        lda     $C9
        adc     #$00
        sbc     #$0B
        sta     TEDCRSRPOSHI
LD90A:  lda     NDX
        ora     KYNDX
        beq     LD90A
        pla
        sta     (USER),y
        lda     #$FF
        sta     TEDCRSRPOSHI
        sta     TEDCRSRPOSLO
        jsr     LD8C1
        cmp     #$83
        bne     LD933
        ldx     #$09
        sei
        stx     NDX
LD928:  lda     LE129,x
        sta     $0526,x
        dex
        bne     LD928
LD931:  beq     LD8ED
LD933:  cmp     #$0D
        bne     LD8EA
        sta     CRSW
        jsr     LDF95
        stx     $0549
        jsr     LDF87
        lda     #$00
        sta     QTSW
        ldy     SCLF
        lda     LSXP
        bmi     LD960
        cmp     TBLX
        bcc     LD960
        ldy     $C5
        cmp     $0549
        bne     LD95C
        cpy     INDX
        beq     LD95E
LD95C:  bcs     LD96F
LD95E:  sta     TBLX
LD960:  sty     PNTR
        jmp     LD977

LD965:  tya
        pha
        txa
        pha
        lda     CRSW
        beq     LD931
        bpl     LD977
LD96F:  lda     #$00
        sta     CRSW
        jmp     LCF74

        nop
LD977:  jsr     LD8A8
        jsr     LDF2F
        sta     DATAX
        and     #$3F
        asl     DATAX
        bit     DATAX
        bpl     LD989
        ora     #$80
LD989:  bcc     LD98F
        ldx     QTSW
        bne     LD993
LD98F:  bvs     LD993
        ora     #$40
LD993:  jsr     LD9BA
        ldy     TBLX
        cpy     $0549
        bcc     LD9A7
        ldy     PNTR
        cpy     INDX
        bcc     LD9A7
        ror     CRSW
        bmi     LD9AA
LD9A7:  jsr     LDFBF
LD9AA:  cmp     #$DE
        bne     LD9B0
        lda     #$FF
LD9B0:  sta     DATAX
        pla
        tax
        pla
        tay
        lda     DATAX
        clc
        rts

LD9BA:  cmp     #$22
        bne     LD9C6
        lda     QTSW
        eor     #$01
        sta     QTSW
        lda     #$22
LD9C6:  rts

        lda     DATAX
        sta     LSTCH
        pla
        tay
        lda     INSRT
        beq     LD9D4
        lsr     QTSW
LD9D4:  pla
        tax
        pla
        clc
        rts

LD9D9:  ora     #$40
LD9DB:  ldx     RVS
        beq     LD9E1
LD9DF:  ora     #$80
LD9E1:  ldx     INSRT
        beq     LD9E7
        dec     INSRT
LD9E7:  bit     INSFL
        bpl     LD9F5
        pha
        jsr     LDDCE
        ldx     #$00
        stx     INSRT
        pla
LD9F5:  jsr     LE001
LD9F8:  cpy     SCRT
        bcc     LDA09
        ldx     TBLX
        cpx     SCBOT
        bcc     LDA09
        bit     SCRDIS
        bmi     LDA20
LDA09:  jsr     LD8A8
        jsr     LDFBF
        bcc     LDA20
        jsr     LDF39
        bcs     LDA1F
        sec
        bit     SCRDIS
        bvs     LDA20
        jsr     LDA5E
LDA1F:  clc
LDA20:  rts

LDA21:  ldx     TBLX
        cpx     SCBOT
        bcc     LDA38
        bit     SCRDIS
        bpl     LDA34
        lda     SCTOP
        sta     TBLX
        bcs     LDA3A
LDA34:  jsr     LDA89
        clc
LDA38:  inc     TBLX
LDA3A:  jmp     LD8A8

LDA3D:  lda     LD802,x
        sta     FPVERR
        sta     SEDSAL
        lda     LD81B,x
        sta     $C1
        and     #$03
        ora     #$08
        sta     DCOUNT
LDA4F:  lda     (SEDSAL),y
        sta     (PNT),y
        lda     (FPVERR),y
        sta     (USER),y
        cpy     SCRT
        iny
        bcc     LDA4F
        rts

LDA5E:  ldx     LSXP
        bmi     LDA68
        cpx     TBLX
        bcc     LDA68
        inc     LSXP
LDA68:  ldx     SCBOT
LDA6B:  jsr     LD8AA
        ldy     SCLF
        cpx     TBLX
        beq     LDA83
        dex
        jsr     LDF3B
        inx
        jsr     LDF48
        dex
        jsr     LDA3D
        bcs     LDA6B
LDA83:  jsr     LDAF7
        jmp     LDF59

LDA89:  ldx     SCTOP
LDA8C:  inx
        jsr     LDF3B
        bcc     LDA9E
        cpx     SCBOT
        bcc     LDA8C
        ldx     SCTOP
        inx
        jsr     LDF4A
LDA9E:  dec     TBLX
        bit     LSXP
        bmi     LDAA6
        dec     LSXP
LDAA6:  ldx     SCTOP
        cpx     SEDT2
        bcs     LDAAF
        dec     SEDT2
LDAAF:  jsr     LDAC5
        ldx     SCTOP
        jsr     LDF3B
        php
        jsr     LDF4A
        plp
        bcc     LDAC4
        bit     LOGSCR
        bmi     LDA89
LDAC4:  rts

LDAC5:  jsr     LD8AA
        ldy     SCLF
        cpx     SCBOT
        bcs     LDADE
        inx
        jsr     LDF3B
        dex
        jsr     LDF48
        inx
        jsr     LDA3D
        bcs     LDAC5
LDADE:  jsr     LDAF7
        lda     #$7F
        jsr     LDB70
        cmp     #$DF
        bne     LDAF3
        ldy     #$00
LDAEC:  nop
        dex
        bne     LDAEC
        dey
        bne     LDAEC
LDAF3:  rts

        nop
        nop
        nop
LDAF7:  ldy     SCLF
        jsr     LDF4A
LDAFD:  jsr     LD8AA
        dey
LDB01:  iny
        lda     #$20
        sta     (PNT),y
        lda     COLOR
        sta     (USER),y
        cpy     SCRT
        bne     LDB01
        rts

iSCNKEY:lda     #$00
        sta     SHFLAG
        ldy     #$40
        sty     SFDX
        jsr     LDB70
        tax
        cpx     #$FF
        bne     LDB25
        jmp     LDC01

LDB25:  ldy     #$00
        lda     #$26
        sta     KEYTAB
        lda     #$E0
        sta     $ED
        lda     #$FE
LDB31:  ldx     #$08
        pha
LDB34:  pla
        pha
        jsr     LDB70
        sta     $EE
        pla
        pha
        jsr     LDB70
        cmp     $EE
        bne     LDB34
LDB44:  lsr     a
        bcs     LDB5D
        pha
        lda     (KEYTAB),y
        cmp     #$05
        bcs     LDB5A
        cmp     #$03
        beq     LDB5A
        ora     SHFLAG
        sta     SHFLAG
        bpl     LDB5C
LDB5A:  sty     SFDX
LDB5C:  pla
LDB5D:  iny
        cpy     #$41
        bcs     LDB6A
        dex
        bne     LDB44
        sec
        pla
        rol     a
        bne     LDB31
LDB6A:  pla
        lda     SFDX
        jmp     (KEYLOG)

LDB70:  sta     LFD30
        sta     TEDKEYB
        lda     TEDKEYB
        rts

        lda     SHFLAG
        cmp     #$03
        bne     LDB9A
        lda     MODE
        bmi     LDBBA
        lda     LSTSHF
        bne     LDBBA
        lda     TEDROMSTATUS
        eor     #$04
        sta     TEDROMSTATUS
        lda     #$08
        sta     LSTSHF
        bne     LDBBA
LDB9A:  asl     a
        cmp     #$08
        bcc     LDBAF
        lda     #$06
        ldx     STPDSB
        bne     LDBAF
        ldx     SFDX
        cpx     #$0D
        bne     LDBAF
        stx     STPFLG
        rts

LDBAF:  tax
        lda     LE01E,x
        sta     KEYTAB
        lda     LE01E+1,x
        sta     $ED
LDBBA:  ldy     SFDX
        lda     (KEYTAB),y
        tax
        cpy     LSTX
        beq     LDBCB
        ldy     #$10
        sty     DELAY
        bne     LDC01
LDBCB:  and     #$7F
        bit     RPTFLG
        bmi     LDBE8
        bvs     LDC2B
        cmp     #$7F
        beq     LDC01
        cmp     #$14
        beq     LDBE8
        cmp     #$20
        beq     LDBE8
        cmp     #$1D
        beq     LDBE8
        cmp     #$11
        bne     LDC2B
LDBE8:  ldy     DELAY
        beq     LDBF2
        dec     DELAY
        bne     LDC2B
LDBF2:  dec     KOUNT
        bne     LDC2B
        ldy     #$04
        sty     KOUNT
        ldy     NDX
        dey
        bpl     LDC2B
LDC01:  nop
        nop
        lsr     LSTSHF
        ldy     SFDX
        sty     LSTX
        cpx     #$FF
        beq     LDC2B
        txa
        ldx     #$00
        stx     STPFLG
        ldx     #$07
LDC16:  cmp     LDC41,x
        beq     LDC2C
        dex
        bpl     LDC16
        ldx     NDX
        cpx     XMAX
        bcs     LDC2B
        sta     KEYD,x
        inx
        stx     NDX
LDC2B:  rts

LDC2C:  lda     KEYBUF,x
        sta     KYNDX
        lda     #$00
LDC34:  dex
        bmi     LDC3D
        clc
        adc     KEYBUF,x
        bcc     LDC34
LDC3D:  sta     KEYIDX
        rts

LDC41:  sta     LTFLAG
        stx     RTFLAG
        .byte   $87
        .byte   $8B
        dey
        .byte   $8C
LDC49:  sta     DATAX
        pha
        txa
        pha
        tya
        pha
LDC50:  lda     STPFLG
        bne     LDC50
        sta     CRSW
        lda     #$D9
        pha
        lda     #$C6
        pha
        ldy     PNTR
        lda     DATAX
        cmp     #$0D
        beq     LDC8C
        cmp     #$8D
        beq     LDC8C
        ldx     LSTCH
        cpx     #$1B
        bne     LDC72
        jmp     LDE06

LDC72:  tax
        bmi     LDC89
        cmp     #$20
        bcc     LDCA7
        cmp     #$60
        bcc     LDC81
        and     #$DF
        bne     LDC83
LDC81:  and     #$3F
LDC83:  jsr     LD9BA
        jmp     LD9DB

LDC89:  jmp     LDD47

LDC8C:  jsr     LDF95
        inx
        jsr     LDF4A
        ldy     SCLF
        sty     PNTR
        jsr     LDA21
LDC9B:  lda     #$00
        sta     INSRT
        sta     RVS
        sta     QTSW
        sta     FLASH
        rts

LDCA7:  cmp     #$1B
        beq     LDCF9
        ldx     INSRT
        beq     LDCB2
LDCAF:  jmp     LD9DF

LDCB2:  cmp     #$14
        bne     LDCB9
        jmp     LDD99

LDCB9:  ldx     QTSW
        bne     LDCAF
        cmp     #$12
        bne     LDCC3
        sta     RVS
LDCC3:  cmp     #$13
        bne     LDCD2
        cmp     LSTCH
        bne     LDCCF
        jsr     LDE70
LDCCF:  jmp     LD89A

LDCD2:  cmp     #$1D
        beq     LDCFA
        cmp     #$11
        beq     LDD00
        cmp     #$0E
        beq     LDD27
        cmp     #$08
        beq     LDD2E
        cmp     #$09
        beq     LDD35
LDCE6:  ldx     #$0F
LDCE8:  cmp     LE133,x
        beq     LDCF1
        dex
        bpl     LDCE8
        rts

LDCF1:  pha
        jsr     LCF8A
        sta     COLOR
        pla
LDCF9:  rts

LDCFA:  jsr     LDFBF
        bcs     LDD03
        rts

LDD00:  jsr     LDA21
LDD03:  jsr     LDF39
        bcs     LDD0B
        sec
        ror     LSXP
LDD0B:  clc
LDD0C:  rts

LDD0D:  ldx     SCTOP
        cpx     TBLX
        bcs     LDD0C
LDD14:  jsr     LDD03
        dec     TBLX
        jmp     LD8A8

LDD1C:  jsr     LDFD4
        bcs     LDD0C
        bne     LDD0B
        inc     TBLX
        bne     LDD14
LDD27:  lda     TEDROMSTATUS
        ora     #$04
        bne     LDD43
LDD2E:  lda     #$80
        ora     MODE
        bmi     LDD3A
LDD35:  lda     #$7F
        and     MODE
LDD3A:  sta     MODE
        rts

LDD3E:  lda     TEDROMSTATUS
        and     #$FB
LDD43:  sta     TEDROMSTATUS
        rts

LDD47:  and     #$7F
        cmp     #$7F
        bne     LDD4F
        lda     #$5E
LDD4F:  cmp     #$20
        bcc     LDD56
        jmp     LD9D9

LDD56:  ldx     QTSW
        beq     LDD5F
LDD5A:  ora     #$40
        jmp     LD9DF

LDD5F:  cmp     #$14
        beq     LDDCE
        ldx     INSRT
        bne     LDD5A
        cmp     #$11
        beq     LDD0D
        cmp     #$12
        bne     LDD73
        lda     #$00
        sta     RVS
LDD73:  cmp     #$1D
        beq     LDD1C
        cmp     #$13
        bne     LDD7E
        jmp     LD88B

LDD7E:  cmp     #$02
        bne     LDD87
        lda     #$80
        sta     FLASH
LDD87:  cmp     #$04
        bne     LDD90
        lda     #$00
        sta     FLASH
LDD90:  cmp     #$0E
        beq     LDD3E
        ora     #$80
        jmp     LDCE6

LDD99:  jsr     LDD1C
        jsr     LDFF6
        bcs     LDDB1
LDDA1:  cpy     SCRT
        bcc     LDDBC
        ldx     TBLX
        inx
        jsr     LDF3B
        bcs     LDDBC
        jsr     LDFFF
LDDB1:  lda     SEDT1
        sta     PNTR
        lda     SEDT2
        sta     TBLX
        jmp     LD8A8

LDDBC:  jsr     LDFBF
        jsr     LDF2F
        jsr     LDFD4
        jsr     LE011
        jsr     LDFBF
        jmp     LDDA1

LDDCE:  jsr     LDFF6
        jsr     LDF95
        cpx     SEDT2
        bne     LDDDA
        cpy     SEDT1
LDDDA:  bcc     LDDFD
        jsr     LD9F8
        bcs     LDE03
LDDE1:  jsr     LDFD4
        jsr     LDF2F
        jsr     LDFBF
        jsr     LE011
        jsr     LDFD4
        ldx     TBLX
        cpx     SEDT2
        bne     LDDE1
        cpy     SEDT1
        bne     LDDE1
        jsr     LDFFF
LDDFD:  inc     INSRT
        bne     LDE03
        dec     INSRT
LDE03:  jmp     LDDB1

LDE06:  and     #$7F
        sec
        sbc     #$41
        cmp     #$17
        bcs     LDE19
        asl     a
        tax
        lda     LDE1A+1,x
        pha
        lda     LDE1A,x
        pha
LDE19:  rts

LDE1A:  .word   $DF28,$DE5F,$DF25,$DE9F
        .word   $DE18,$DE18,$DE18,$DE18
        .word   $DE8A,$DF81,$DF94,$DF1C
        .word   $DF1F,$D887,$DC9A,$DEE0
        .word   $DECA,$DE47,$DE18,$DE5D
        .word   $DE18,$DEF5,$DF03
LDE48:  jsr     LDE70
        jsr     LD88B
        lda     #$01
        tax
        jsr     LDE7A
        lda     #$17
        ldx     #$26
        jsr     LDE67
        jmp     LD89A

LDE5E:  clc
        .byte   $24
LDE60:  sec
        ldx     PNTR
        lda     TBLX
        bcc     LDE7A
LDE67:  sta     SCBOT
        stx     SCRT
        jmp     LDE80

LDE70:  lda     #$18
        ldx     #$27
        jsr     LDE67
        lda     #$00
        tax
LDE7A:  sta     SCTOP
        stx     SCLF
LDE80:  lda     #$00
        ldx     #$04
LDE84:  sta     TCOLOR,x
        dex
        bne     LDE84
        rts

LDE8B:  jsr     LDA5E
        jsr     LD8A1
        inx
        jsr     LDF3B
        php
        jsr     LDF46
        plp
        bcs     LDE9F
        sec
        ror     LSXP
LDE9F:  rts

LDEA0:  jsr     LDF87
        lda     SCTOP
        pha
        lda     TBLX
        sta     SCTOP
        lda     LOGSCR
        pha
        lda     #$80
        sta     LOGSCR
        jsr     LDA9E
        pla
        sta     LOGSCR
        lda     SCTOP
        sta     TBLX
        pla
        sta     SCTOP
        sec
        ror     LSXP
        jmp     LD8A1

LDECB:  jsr     LDFF6
LDECE:  jsr     LDAFD
        inc     TBLX
        jsr     LD8A8
        ldy     SCLF
        jsr     LDF39
        bcs     LDECE
LDEDE:  jmp     LDDB1

LDEE1:  jsr     LDFF6
LDEE4:  jsr     LDFFF
        cpy     SCLF
        bne     LDEF1
        jsr     LDF39
        bcc     LDEDE
LDEF1:  jsr     LDFD4
        bcc     LDEE4
LDEF6:  jsr     LDFF6
        txa
        pha
        jsr     LDA89
        pla
        sta     SEDT2
        jmp     LDEDE

LDF04:  jsr     LDFF6
        jsr     LDF39
        bcs     LDF0F
        sec
        ror     LSXP
LDF0F:  lda     SCTOP
        sta     TBLX
        jsr     LDA5E
        jsr     LDF4A
        jmp     LDEDE

LDF1D:  lda     #$00
        .byte   $2C
LDF20:  lda     #$80
        sta     SCRDIS
        rts

LDF26:  lda     #$00
        .byte   $2C
LDF29:  lda     #$FF
        sta     INSFL
        rts

LDF2F:  ldy     PNTR
        lda     (USER),y
        sta     TCOLOR
        lda     (PNT),y
        rts

LDF39:  ldx     TBLX
LDF3B:  jsr     LDF66
        and     BITABL,x
        cmp     #$01
        jmp     LDF55

LDF46:  ldx     TBLX
LDF48:  bcs     LDF59
LDF4A:  jsr     LDF66
        eor     #$FF
        and     BITABL,x
LDF52:  sta     BITABL,x
LDF55:  ldx     BITMSK
        rts

LDF59:  bit     SCRDIS
        bvs     LDF3B
        jsr     LDF66
        ora     BITABL,x
        bne     LDF52
LDF66:  stx     BITMSK
        txa
        and     #$07
        tax
        lda     LDF7A,x
        pha
        lda     BITMSK
        lsr     a
        lsr     a
        lsr     a
        tax
        pla
        rts

LDF7A:  .byte   $80,$40,$20,$10,$08,$04,$02,$01
LDF82:  ldy     SCLF
        sty     PNTR
LDF87:  jsr     LDF39
        bcc     LDF92
        dec     TBLX
        bpl     LDF87
        inc     TBLX
LDF92:  jmp     LD8A8

LDF95:  inc     TBLX
        jsr     LDF39
        bcs     LDF95
        dec     TBLX
        jsr     LD8A8
        ldy     SCRT
        sty     PNTR
LDFA6:  jsr     LDF2F
        cmp     #$20
        bne     LDFBC
        cpy     SCLF
        bne     LDFB7
        jsr     LDF39
        bcc     LDFBC
LDFB7:  jsr     LDFD4
        bcc     LDFA6
LDFBC:  sty     INDX
        rts

LDFBF:  pha
        ldy     PNTR
        cpy     SCRT
        bcc     LDFCF
        jsr     LDA21
        ldy     SCLF
        dey
        sec
LDFCF:  iny
        sty     PNTR
        pla
        rts

LDFD4:  ldy     PNTR
        dey
        bmi     LDFDE
        cpy     SCLF
        bcs     LDFEF
LDFDE:  ldy     SCTOP
        cpy     TBLX
        bcs     LDFF5
        dec     TBLX
        pha
        jsr     LD8A8
        pla
        ldy     SCRT
LDFEF:  sty     PNTR
        cpy     SCRT
        clc
LDFF5:  rts

LDFF6:  ldy     PNTR
        sty     SEDT1
        ldx     TBLX
        stx     SEDT2
        rts

LDFFF:  lda     #$20
LE001:  ldy     PNTR
        sta     (PNT),y
        jsr     LD8B4
        lda     COLOR
        ora     FLASH
        sta     (USER),y
        rts

LE011:  ldy     PNTR
        sta     (PNT),y
        jsr     LD8B4
        lda     TCOLOR
        sta     (USER),y
        rts

LE01E:  .addr   LE026
        .addr   LE067
        .addr   LE0A8
        .addr   LE0E9
LE026:  .byte   $14,$0D,$5C,$8C,$85,$89,$86,$40
        .byte   $33,$57,$41,$34,$5A,$53,$45,$01
        .byte   $35,$52,$44,$36,$43,$46,$54,$58
        .byte   $37,$59,$47,$38,$42,$48,$55,$56
        .byte   $39,$49,$4A,$30,$4D,$4B,$4F,$4E
        .byte   $11,$50,$4C,$91,$2E,$3A,$2D,$2C
        .byte   $9D,$2A,$3B,$1D,$1B,$3D,$2B,$2F
        .byte   $31,$13,$04,$32,$20,$02,$51,$03
        .byte   $FF
LE067:  .byte   $94,$8D,$A9,$88,$8A,$87,$8B,$BA
        .byte   $23,$D7,$C1,$24,$DA,$D3,$C5,$01
        .byte   $25,$D2,$C4,$26,$C3,$C6,$D4,$D8
        .byte   $27,$D9,$C7,$28,$C2,$C8,$D5,$D6
        .byte   $29,$C9,$CA,$5E,$CD,$CB,$CF,$CE
        .byte   $11,$D0,$CC,$91,$3E,$5B,$DD,$3C
        .byte   $9D,$C0,$5D,$1D,$1B,$5F,$DB,$3F
        .byte   $21,$93,$04,$22,$A0,$02,$D1,$83
        .byte   $FF
LE0A8:  .byte   $94,$8D,$A8,$88,$8A,$87,$8B,$A4
        .byte   $96,$B3,$B0,$97,$AD,$AE,$B1,$01
        .byte   $98,$B2,$AC,$99,$BC,$BB,$A3,$BD
        .byte   $9A,$B7,$A5,$9B,$BF,$B4,$B8,$BE
        .byte   $29,$A2
LE0CA:  .byte   $B5,$30,$A7,$A1,$B9,$AA,$11,$AF
        .byte   $B6,$91,$3E,$5B,$DC,$3C,$9D,$DF
        .byte   $5D,$1D,$1B,$DE,$A6,$3F,$81,$93
        .byte   $04,$95,$A0,$02,$AB,$83,$FF
LE0E9:  .byte   $FF,$FF,$1C,$FF,$FF,$FF,$FF,$FF
        .byte   $1C,$17,$01,$9F,$1A,$13,$05,$FF
        .byte   $9C,$12,$04,$1E,$03,$06,$14,$18
        .byte   $1F,$19,$07,$9E,$02,$08,$15,$16
        .byte   $12,$09,$0A,$92,$0D,$0B,$0F,$0E
        .byte   $FF,$10,$0C,$FF,$84,$1B,$FF,$82
        .byte   $FF,$FF,$1D,$FF,$1B,$06,$FF,$FF
        .byte   $90,$FF,$FF,$05,$FF,$FF,$11,$FF
LE129:  .byte   $FF
        .TEXT   "D"
        .byte   $CC,$22
        .TEXT   "*"
        .byte   $0D
        .TEXT   "RUN"
        .byte   $0D
LE133:  .byte   $90,$05,$1C,$9F,$9C,$1E,$1F,$9E
        .byte   $81,$95,$96,$97,$98,$99,$9A,$9B
LE143:  .byte   $00
        .TEXT   "q2cD5FwH)Zk\m._"

LE153:  ora     #$40
        .byte   $2C
LE156:  ora     #$20
LE158:  pha
        bit     C3P0
        bpl     LE167
        sec
        ror     R2D2
        jsr     LE181
        lsr     C3P0
        lsr     R2D2
LE167:  pla
        sta     BSOUR
        sei
        jsr     LE2C6
        jsr     LE2BF
        lda     PORT
        ora     #$04
        sta     PORT
LE177:  sei
        jsr     LE2BF
        jsr     LE2C6
        jsr     LE2DC
LE181:  sei
        jsr     LE2C6
        jsr     LE2D4
        bcs     LE1E9
        jsr     LE2B8
        bit     R2D2
        bpl     LE19F
LE191:  jsr     LE2D4
        bcc     LE191
LE196:  lda     PORT
        cmp     PORT
        bne     LE196
        asl     a
        bcs     LE196
LE19F:  jsr     LE2D4
        bcc     LE19F
        jsr     LE2BF
        lda     #$08
        sta     DCOUNT
LE1AB:  jsr     LE2D4
        bcc     LE1EE
        ror     BSOUR
        bcs     LE1B9
        jsr     LE2CD
        bne     LE1BC
LE1B9:  jsr     LE2C6
LE1BC:  jsr     LE311
        jsr     LE2B8
        jsr     LE311
        lda     PORT
        and     #$FE
        ora     #$02
        sta     PORT
        dec     DCOUNT
        bne     LE1AB
        txa
        pha
        ldx     #$78
LE1D5:  lda     PORT
        cmp     PORT
        bne     LE1D5
        asl     a
        bcc     LE1E5
        dex
        bne     LE1D5
        pla
        tax
        bcs     LE1EE
LE1E5:  pla
        tax
        cli
        rts

LE1E9:  lda     #$80
        jmp     LE1F0

LE1EE:  lda     #$03
LE1F0:  jsr     LF41E
        cli
        clc
        bcc     LE242
LE1F7:  sta     BSOUR
        jsr     LE177
LE1FC:  lda     PORT
        and     #$FB
        sta     PORT
        rts

LE203:  sta     BSOUR
        jsr     LE177
        bit     STATUS
        bmi     LE242
LE20C:  sei
        jsr     LE2CD
        jsr     LE1FC
        jsr     LE2B8

LE216:
.if COMPILECOMPUTER >= PLUS4_03
        bit     PORT
        bvs     LE216
.else
        jsr     LE2D4
        bmi     LE216
.fi
        cli
        rts

;        FillUntil $E21D,$FF
        .fill $E21D-*,$FF

LE21D:  bit     C3P0
        bmi     LE226
        sec
        ror     C3P0
        bne     LE22B
LE226:  pha
        jsr     LE181
        pla
LE22B:  sta     BSOUR
        clc
        rts

LE22F:  sei
        jsr     LE2BF
        lda     PORT
        ora     #$04
        sta     PORT
        lda     #$5F
        bne     LE23F
LE23D:  lda     #$3F
LE23F:  jsr     LE158
LE242:  jsr     LE1FC
LE245:  txa
        ldx     #$14
LE248:  dex
        bne     LE248
        tax
        jsr     LE2B8
        jmp     LE2C6

LE252:  sei
        lda     #$00
        sta     DCOUNT
        jsr     LE2B8
        txa
        pha
LE25C:  jsr     LE2D4
        bpl     LE25C
LE261:  ldx     #$20
        jsr     LE2C6
LE266:  lda     PORT
        cmp     PORT
        bne     LE266
        asl     a
        bpl     LE28E
        dex
        bne     LE266
        lda     DCOUNT
        beq     LE27D
        pla
        tax
        lda     #$02
        jmp     LE1F0

LE27D:  jsr     LE2CD
        ldx     #$40
LE282:  dex
        bne     LE282
        lda     #$40
        jsr     LF41E
        inc     DCOUNT
        bne     LE261
LE28E:  ldx     #$08
LE290:  lda     PORT
        asl     a
        bpl     LE290
        ror     BSOUR1
LE297:  lda     PORT
        cmp     PORT
        bne     LE297
        asl     a
        bmi     LE297
        dex
        bne     LE290
        stx     DCOUNT
        pla
        tax
        jsr     LE2CD
        lda     #$40
        bit     STATUS
        bvc     LE2B3
        jsr     LE245
LE2B3:  lda     BSOUR1
        cli
        clc
        rts

LE2B8:  lda     PORT
        and     #$FD
        sta     PORT
        rts

LE2BF:  lda     PORT
        ora     #$02
        sta     PORT
        rts

LE2C6:  lda     PORT
        and     #$FE
        sta     PORT
        rts

LE2CD:  lda     PORT
        ora     #$01
        sta     PORT
        rts

LE2D4:  lda     PORT
        cmp     PORT
        bne     LE2D4
        asl     a
        rts

LE2DC:  jsr     LE2F8
        lda     #$10
LE2E1:  bit     TEDIFR
        beq     LE2E1
        sta     TEDIFR
        rts

LE2EA:  jsr     LE2FC
        lda     #$10
LE2EF:  bit     TEDIFR
        beq     LE2EF
        sta     TEDIFR
        rts

LE2F8:  lda     #$04
        bne     LE2FE
LE2FC:  lda     #$40
LE2FE:  php
        pha
        sei
        lda     #$00
        sta     TEDT2L
        pla
        sta     TEDT2H
        lda     #$10
        sta     TEDIFR
        plp
        rts

LE311beta:

.if COMPILECOMPUTER < PLUS4_01
        jsr    $FBD8
        rol    $2e2e
        .byte  $4f,$4b
        brk
        rts
.fi

LE311:  txa
        ldx     #$05
LE314:  dex
        bne     LE314
        tax
        rts

.if COMPILECOMPUTER < PLUS4_01
LE319:  jsr     LE2D4
        bcc     LE374
        jsr     LFBD8
        .byte   $0D,"PRESS PLAY & RECORD ON TAPE",0

        jmp     LE367

LE31B:
        jsr     LE2D4

        bcc     LE374
        jsr     LFBD8

        .byte   $0D,"PRESS PLAY ON TAPE",0

LE367:  jsr     LFBCB
        bcs     LE375
        jsr     LE2D4
        bcs     LE367
.if COMPILECOMPUTER >= PLUS4_01
        jsr     LE311
.else
        jsr     LE311beta
.fi
LE374:  clc
LE375:  rts

.else

LE319:  sec
        .byte   $24
LE31B:  clc
        lda     SPI6529
        and     #$04
        beq     LE362
        php
        jsr     LFBD8
        .TEXT   $0D,"PRESS PLAY ", 0

        plp
        bcc     LE344
        jsr     LFBD8
        .TEXT   "& RECORD ", 0

LE344:  jsr     LFBD8
        .TEXT   "ON TAPE", 0
LE34F:  jsr     LFBCB
        bcs     LE363
        lda     SPI6529
        and     #$04
        bne     LE34F
        jsr     LFBD8
        .TEXT   $0D, "OK", 0
LE362:  clc
LE363:  rts

.fi

LE364:  sei
        lda     TEDVSP
        and     #$EF
        sta     TEDVSP
        lda     TEDIER
        and     #$FD
        ora     #$08
        sta     TEDIER
        rts

LE378:  sei
        lda     TEDVSP
        ora     #$10
        sta     TEDVSP
        lda     TEDIER
        and     #$F7
        ora     #$02
        sta     TEDIER
        cli
        rts

LE38D:  php
.if COMPILECOMPUTER >= PLUS4_01
        sec
        ror     LSEM
        lda     PORT
        and     #$F5
        sta     PORT
        ldx     #$1E
LE39A:  jsr     LE2EA
        dex
        bne     LE39A
        plp
        rts

        .TEXT   "C1984COMMODORE"
.else
        lda PORT
        .byte ")",$F5,$85,$01,$A2,$1E, " ", $EA, $E2, $CA, $D0, $FA, "(`"
.fi

LE3B0:  lda     PORT
        ora     #$08
        sta     PORT
        rts

LE3B7:  ldy     #$00
        lda     #$20
LE3BB:  sta     (TAPEBS),y
        iny
        cpy     #$C0
        bne     LE3BB
        rts

LE3C3:  pha
        lda     #$33
        sta     TAPEBS
        lda     #$03
        sta     $B7
        pla
        rts

LE3CE:  jsr     LFBCB
        bcc     LE3E3
        jsr     LE3B0
        jsr     LE378
        ldx     SRECOV
        txs
        lda     #$00
        sta     SRECOV
        sec
LE3E3:  rts

LE3E4:  lda     TEDIFR
        and     TEDIER
        and     #$08
        bne     LE3EF
        rts

LE3EF:  sta     TEDIFR
        sei
        lda     #$90
        sta     TEDT1RL
        lda     #$33
        sta     TEDT1RH
        ldx     DRECOV
        txs
        sec
        rts

LE403:  lda     #$A8
        sta     TEDT1RL
        lda     #$48
        sta     TEDT1RH
        lda     #$08
        sta     TEDIFR
        rts

LE413:  sec
        bcs     LE417
LE416:  clc
LE417:  sty     $07CA
        stx     $07CB
        ldy     T1PIPE
        ldx     $07C9
        lda     #$10
LE425:  bit     TEDIFR
        beq     LE425
        sty     TEDT2L
        stx     TEDT2H
        sta     TEDIFR
        lda     PORT
        eor     #$02
        sta     PORT
        php
        jsr     LE3CE
        plp
        ldy     $07CA
        ldx     $07CB
        bcs     LE416
        rts

LE447:  lda     #<CONST_E447_T1PIPE
        sta     T1PIPE
        lda     #>CONST_E447_T1PIPE
        sta     T1PIPE + 1
        rts

LE452:  lda     #<CONST_E452_T1PIPE
        sta     T1PIPE
        lda     #>CONST_E452_T1PIPE
        sta     T1PIPE + 1
        rts

LE45D:  lda     #<CONST_E45D_T1PIPE
        sta     T1PIPE
        lda     #>CONST_E45D_T1PIPE
        sta     T1PIPE + 1
        rts

LE468:  jsr     LE452
        jsr     LE413
        jsr     LE45D
        jmp     LE413

LE474:  jsr     LE45D
        jsr     LE413
        jsr     LE452
        jmp     LE413

LE480:  jsr     LE447
        jsr     LE413
        jsr     LE45D
        jmp     LE413

LE48C:  sta     TPBYTE
        lda     #$01
        sta     PARITY
        jsr     LE480
        ldx     #$08
LE498:  ror     TPBYTE
        bcs     LE4A5
        inc     PARITY
        jsr     LE468
        jmp     LE4A8

LE4A5:  jsr     LE474
LE4A8:  dex
        bne     LE498
        ror     PARITY
        bcs     LE4B6
        jsr     LE468
        jmp     LE4B9

LE4B6:  jsr     LE474
LE4B9:  rts

LE4BA:  tsx
        stx     SRECOV
        lda     PORT
        ora     #$02
        sta     PORT
        jsr     LE452
        ldy     #$01
        sty     TEDT2H
        lda     #$10
        sta     TEDIFR
        bit     PASS
        bpl     LE4D9
        ldy     #$40
        ldx     #$FE
LE4D9:  jsr     LE413
        dex
        bne     LE4D9
        dey
        bne     LE4D9
        ldy     #$09
LE4E4:  tya
        ora     PASS
        jsr     LE48C
        dey
        bne     LE4E4
.if COMPILECOMPUTER < PLUS4_04
        ldy     #$00
        sty     CHKSUM
.fi
        lda     TYPE
.if COMPILECOMPUTER < PLUS4_04
        beq     LE4F6
        eor     CHKSUM
.fi
        sta     CHKSUM

.if COMPILECOMPUTER >= PLUS4_04
        beq     LE4F6
.else
        lda     TYPE
.fi
        jsr     LE48C
LE4F6:
.if COMPILECOMPUTER >= PLUS4_04
        ldy     #$00
        lda     #$BA
        sta     $07DF
        jsr     KLUDES
.else
        lda     (WRBASE),y
.fi
        pha
        eor     CHKSUM
        sta     CHKSUM
        pla
        jsr     LE48C
        inc     WRBASE
        bne     LE50F
        inc     $BB
LE50F:  inc     WRLEN
        bne     LE4F6
        inc     $03F4
        bne     LE4F6
        lda     CHKSUM
        jsr     LE48C
        jsr     LE45D
        jsr     LE413
        jsr     LE452
        ldy     #$01
        ldx     #$C2
LE52B:  jsr     LE413
        dex
        bne     LE52B
        dey
        bne     LE52B
        rts

LE535:  jsr     LE319
        jsr     LE364
        jsr     LE38D
        bcs     LE566
        lda     #$80
        sta     PASS
LE544:  lda     TAPEBS
        sta     WRBASE
        lda     $B7
        sta     $BB
        lda     #$41
        sta     WRLEN
        lda     #$FF
        sta     $03F4
        jsr     LE4BA
        bcs     LE566
        lda     PASS
        bpl     LE565
        lda     #$00
        sta     PASS
        bpl     LE544
LE565:  clc
LE566:  jsr     LE3B0
        jmp     LE378

LE56C:  jsr     LE3C3
        jsr     LE3B7
        ldy     #$00
        lda     STAL
        sta     (TAPEBS),y
        iny
        lda     $B3
        sta     (TAPEBS),y
        iny
        lda     EAL
        sta     (TAPEBS),y
        iny
        lda     $9E
        sta     (TAPEBS),y
        iny
        sty     TT3
        ldy     #$00
        sty     TT1
LE590:  ldy     TT1
        cpy     FNLEN
        beq     LE5AD
        lda     #$AF
        sta     $07DF
        jsr     KLUDES
        ldy     TT3
        sta     (TAPEBS),y
        inc     TT1
        inc     TT3
        jmp     LE590

LE5AD:  jmp     LE535

LE5B0:  jsr     LE319
        jsr     LE364
        jsr     LE38D
        bcs     LE5EA
        lda     #$80
        sta     PASS
LE5BF:  lda     STAL
        sta     WRBASE
        lda     $B3
        sta     $BB
.if COMPILECOMPUTER >= PLUS4_03
        clc
.else
        sec
.fi
        lda     EAL
        sbc     STAL
        eor     #$FF
        sta     WRLEN
        lda     $9E
        sbc     $B3
        eor     #$FF
        sta     $03F4
        jsr     LE4BA
        bcs     LE5EA
        lda     PASS
        bpl     LE5E9
        lda     #$00
        sta     PASS
        bpl     LE5BF
LE5E9:  clc
LE5EA:  jsr     LE3B0
        jmp     LE378

LE5F0:  jsr     LE3B7
        lda     #$05
        sta     TYPE
        jmp     LE535

LE5FA:  .byte   $40
LE5FB:  .byte   $00
LE5FC:  .byte   $80
LE5FD:  ldx     DSAMP1
        ldy     $07B9
LE603:  lda     $07BB
        pha
        lda     DSAMP2
        pha
        lda     #$10
LE60D:  bit     PORT
        beq     LE60D
LE611:  bit     PORT
        bne     LE611
        stx     TEDT2L
        sty     TEDT2H
        pla
        sta     TEDT3L
        pla
        sta     TEDT3H
        lda     #$50
        sta     TEDIFR
LE628:  lda     PORT
        cmp     PORT
        bne     LE628
        and     #$10
        bne     LE603
        jsr     LE3CE
        lda     #$10
LE637:  bit     PORT
        bne     LE682
        bit     TEDIFR
        beq     LE637
LE640:  lda     PORT
        cmp     PORT
        bne     LE640
        and     #$10
        bne     LE682
        lda     #$40
LE64C:  bit     TEDIFR
        beq     LE64C
LE651:  lda     PORT
        cmp     PORT
        bne     LE651
        and     #$10
        bne     LE687
        lda     ZCELL
        sta     TEDT2L
        lda     $07BD
        sta     TEDT2H
        lda     #$10
        sta     TEDIFR
        lda     #$10
LE66E:  bit     TEDIFR
        beq     LE66E
LE673:  lda     PORT
        cmp     PORT
        bne     LE673
        and     #$10
        beq     LE68C
        bit     LE5FC
        bmi     LE68A
LE682:  bit     LE5FA
        bvs     LE68A
LE687:  bit     LE5FB
LE68A:  clc
        rts

LE68C:  sec
        rts

LE68E:  .byte   $40
LE68F:  .byte   $00
LE690:  .byte   $80
LE691:  jsr     LE5FD
        bcs     LE6D3
        bvs     LE6AA
        bpl     LE69C
        bmi     LE6C3
LE69C:  jsr     LE5FD
        bcs     LE6D3
        bvs     LE6A5
        bvc     LE6D3
LE6A5:  bit     LE68F
        clc
        rts

LE6AA:  jsr     LE5FD
        bvs     LE6B3
        bpl     LE6BE
        bmi     LE6D3
LE6B3:  jsr     LE5FD
        bcs     LE6D3
        bvs     LE6B3
        bpl     LE6D3
        bmi     LE6C3
LE6BE:  bit     LE68E
        clc
        rts

LE6C3:  jsr     LE5FD
        bcs     LE6D3
        bvs     LE6D3
        bpl     LE6CE
        bmi     LE6D3
LE6CE:  bit     LE690
        clc
        rts

LE6D3:  sec
        rts

LE6D5:  tsx
        stx     DRECOV
        clc
        ror     ENEXT
        cli
LE6DE:  jsr     LE691
        bcs     LE6DE
        bvs     LE6DE
        bpl     LE6DE
        jsr     LE403
        clc
        rts

LE6EC:  bit     ENEXT
        bmi     LE742
        jsr     LE6D5
        bcs     LE742
LE6F6:  lda     #$01
        sta     PARITY
        ldx     #$08
        stx     RDBITS
        sec
        ror     ENEXT
LE704:  jsr     LE691
        bcs     LE742
        bvs     LE70F
        bpl     LE71C
        bmi     LE742
LE70F:  clc
        ror     TPBYTE
        inc     PARITY
        dec     RDBITS
        bne     LE704
        beq     LE724
LE71C:  sec
        ror     TPBYTE
        dec     RDBITS
        bne     LE704
LE724:  jsr     LE691
        bcs     LE742
        bvs     LE72F
        bpl     LE738
        bmi     LE742
LE72F:  lda     PARITY
        and     #$01
        bne     LE742
        beq     LE73F
LE738:  lda     PARITY
        and     #$01
        beq     LE742
LE73F:  clc
        bcc     LE743
LE742:  sec
LE743:  sei
        php
        clc
        ror     ENEXT
        plp
        rts

LE74B:  tsx
        stx     SRECOV
        lda     VERFCK
        beq     LE756
        sec
        ror     VERFCK
LE756:  jsr     LE38D
        jsr     LE364
        lda     TRSAVE
        sta     TAPEBS
        lda     $07C1
        sta     $B7
        lda     $07C2
        sta     RDCNT
        lda     $07C3
        sta     $03F6
        jsr     LE91D
        ldy     #$00
        sty     ERRSP
        sty     FPERRS
        sty     CHKSUM
        sty     ERRSUM
        sty     TYPE
.if COMPILECOMPUTER >= PLUS4_04
        lda     #$B6
        sta     $07DF
.else
        dey
        sty     FPVERR
        sty     $92
.fi
        bit     WROUT
        bpl     LE7A0
        jsr     LE6EC
        bcs     LE79D
        lda     TPBYTE
        sta     TYPE
        eor     CHKSUM
        sta     CHKSUM
        jmp     LE7A0

LE79D:  sec
        ror     TYPE
LE7A0:  jsr     LE6EC
        bcs     LE7BE
.if COMPILECOMPUTER < PLUS4_04
        lda     TPBYTE
.fi
        ldy     #$00
.if COMPILECOMPUTER >= PLUS4_04
        jsr     KLUDES
        nop
.fi
        bit     VERFCK
.if COMPILECOMPUTER >= PLUS4_04
        bmi     LE7B1
        lda     TPBYTE
LE7B1:  cmp     TPBYTE
        bne     LE7BE
        sta     (TAPEBS),y
        eor     CHKSUM
.else
        bpl     LE7B5
        cmp     (TAPEBS),y
        beq     LE7B5
        sty     FPVERR
        bne     LE7B7
LE7B5:  sta     (TAPEBS),y
LE7B7:  eor     CHKSUM
.fi
        sta     CHKSUM
        jmp     LE7DC

LE7BE:  ldy     ERRSP
        cpy     #$1E
        bcs     LE7D7
        lda     TAPEBS
        sta     ESTAKL,y
        lda     $B7
        sta     ESTAKH,y
        inc     ERRSP
        inc     ERRSUM
        jmp     LE7DC

LE7D7:  lda     #$FF
        sta     ERRSP
LE7DC:  inc     TAPEBS
        bne     LE7E2
        inc     $B7
LE7E2:  inc     RDCNT
        bne     LE7A0
        inc     $03F6
        bne     LE7A0
        lda     ERRSP
        sta     FPERRS
        jsr     LE6EC
        lda     FPERRS
        bne     LE800
        lda     TPBYTE
        cmp     CHKSUM
        bne     LE803
LE800:  jmp     LE80A

LE803:  lda     PASS
        bmi     LE80A
        jmp     LE8B7

LE80A:  lda     PASS
        bmi     LE819
        lda     FPERRS
        beq     LE816
        jmp     LE8B7

LE816:  jmp     LE8C7

LE819:  lda     #$00
        sta     ERRSP
        sta     CHKSUM
        lda     TRSAVE
        sta     TAPEBS
        lda     $07C1
        sta     $B7
        lda     $07C2
        sta     RDCNT
        lda     $07C3
        sta     $03F6
        jsr     LE91D
        bit     WROUT
        bpl     LE853
        jsr     LE6EC
        bit     TYPE
        bpl     LE84D
        lda     TPBYTE
        sta     TYPE
        bcc     LE84D
        ror     TYPE
LE84D:  lda     TYPE
        eor     CHKSUM
        sta     CHKSUM
LE853:  jsr     LE6EC
        ror     RDETMP
        lda     TPBYTE
        eor     CHKSUM
        sta     CHKSUM
        bit     FPERRS
        bmi     LE896
        ldy     ERRSP
        cpy     FPERRS
        beq     LE896
        lda     ESTAKL,y
        cmp     TAPEBS
        bne     LE896
        lda     ESTAKH,y
        cmp     $B7
        bne     LE896
        inc     ERRSP
        lda     RDETMP
        bmi     LE896
        ldy     #$00
.if COMPILECOMPUTER >= PLUS4_04
        jsr     KLUDES
        nop
.else
        lda     TPBYTE
.fi
        bit     VERFCK
.if COMPILECOMPUTER >= PLUS4_04
        bmi     LE88E
        lda     TPBYTE
LE88E:  cmp     TPBYTE
.else
        bpl     LE892
        cmp     (TAPEBS),y
        beq     LE892
        sty     $92
.fi
        bne     LE896
LE892:  dec     ERRSUM
        sta     (TAPEBS),y
LE896:  inc     TAPEBS
        bne     LE89C
        inc     $B7
LE89C:  inc     RDCNT
        bne     LE853
        inc     $03F6
        bne     LE853
        jsr     LE6EC
.if COMPILECOMPUTER >= PLUS4_04
        lda     #$00
        sta     STATUS
.else
        lda     ERRSUM
        bne     LE8B7
        lda     $92
.if COMPILECOMPUTER >= PLUS4_03
        and     FPVERR
.else
        ora     FPVERR
.fi
        beq     LE8BF
.fi
        lda     TYPE
.if COMPILECOMPUTER >= PLUS4_04
        ldx     ERRSUM
        beq     LE8C7
        bit     VERFCK
        bmi     LE8BF
.else
        bpl     LE8C7
.fi
LE8B7:  lda     #$60
.if COMPILECOMPUTER >= PLUS4_04
        sta     STATUS
.else
        jsr     LF41E
.fi
        sec
.if COMPILECOMPUTER >= PLUS4_04
        jmp     LE8C8
.else
        bcs     LE8C8
.fi
LE8BF:  lda     #$10
.if COMPILECOMPUTER >= PLUS4_04
        sta     STATUS
.else
        jsr     LF41E
.fi
        sec
.if COMPILECOMPUTER >= PLUS4_04
        jmp     LE8C8
.else
        bcs     LE8C8
.fi
LE8C7:  clc
LE8C8:  jsr     LE3B0
        jsr     LE378
        rts

LE8CF:  .addr   L0333
        .addr   LFF41

LE8D3:  ldy     #$03
LE8D5:  lda     LE8CF,y
        sta     TRSAVE,y
        dey
        bpl     LE8D5
        sty     WROUT
        lda     VERFCK
        pha
        iny
        sty     VERFCK
        sty     TPTR
        jsr     LE74B
        pla
        sta     VERFCK
        jmp     LE3C3

LE8F3:  lda     STAL
        sta     TRSAVE
        lda     $B3
        sta     $07C1
.if COMPILECOMPUTER >= PLUS4_03
        clc
.else
        sec
.fi
        lda     EAL
        sbc     STAL
        eor     #$FF
        sta     $07C2
        lda     $9E
        sbc     $B3
        eor     #$FF
        sta     $07C3
        clc
        ror     WROUT
        jmp     LE74B

LE917:  .word   $0102,$0202,$020D
LE91D:  ldx     #$05
LE91F:  lda     LE917,x
        sta     DSAMP1,x
        dex
        bpl     LE91F
LE928:  lda     #$0A
        sta     LDRSCN
LE92D:  jsr     LE5FD
        bcs     LE928
        bvc     LE928
        dec     LDRSCN
        bne     LE92D
LE939:  lda     #$00
        sta     WRBASE
        sta     $BB
        ldy     #$10
LE941:  ldx     #$00
        lda     #$10
LE945:  bit     PORT
        beq     LE945
LE949:  bit     PORT
        bne     LE949
LE94D:  inx
        beq     LE939
        bit     PORT
        beq     LE94D
LE954:  inx
        beq     LE939
        bit     PORT
        bne     LE954
        txa
        clc
        adc     WRBASE
        sta     WRBASE
        lda     #$00
        adc     $BB
        sta     $BB
        dey
        bne     LE941
        lsr     $BB
        ror     WRBASE
        lsr     $BB
        ror     WRBASE
        lda     WRBASE
        sta     DSAMP1
        asl     a
        sta     DSAMP2
        sta     ZCELL
        lda     $BB
        sta     $07B9
        rol     a
        sta     $07BB
        sta     $07BD
LE98A:  jsr     LE5FD
        bcs     LE98A
        bvs     LE98A
        bpl     LE98A
        jsr     LE5FD
        bcs     LE98A
        bvs     LE98A
        bmi     LE98A
        clc
        ror     ENEXT
        jsr     LE403
        lda     #$03
        sta     CDERRM
        jsr     LE6F6
        bcc     LE9B0
        dec     CDERRM
LE9B0:  jsr     LE6EC
        bcc     LE9BD
        dec     CDERRM
        bne     LE9BD
        jmp     LE91D

LE9BD:  lda     TPBYTE
        and     #$0F
        cmp     #$01
        bne     LE9B0
        lda     TPBYTE
        and     #$80
        sta     PASS
        rts

LE9CC:  jsr     LE8D3
        bcs     LEA1E
        lda     TYPE
        cmp     #$05
        beq     LEA1A
        cmp     #$01
        beq     LE9E3
        cmp     #$03
        beq     LE9E3
        cmp     #$04
        bne     LE9CC
LE9E3:  tax
        bit     MSGFLG
        bpl     LEA17
        jsr     LFBD8
        .byte   $0D
        .TEXT   "FOUND "
        .byte   $00
        ldy     #$04
LE9F5:  lda     (TAPEBS),y
        jsr     kCHROUT
        iny
        cpy     #$15
        bne     LE9F5
        ldx     #$FF
LEA01:  jsr     LE2EA
        jsr     LE2EA
        dex
        beq     LEA17
        lda     #$7F
        jsr     LDB70
        cmp     #$7F
        beq     LEA1E
        cmp     #$DF
        bne     LEA01
LEA17:  clc
        lda     TYPE
LEA1A:  rts

        nop
        nop
        nop
LEA1E:  lda     #$00
        rts

LEA21:  jsr     LE9CC
        bcs     LEA53
        cmp     #$05
        beq     LEA55
.if COMPILECOMPUTER >= PLUS4_03
        ldy     #$FF
LEA2C:  iny
        cpy     FNLEN
.else
        ldy     #$04
        sty     TT3
        ldy     #$00
        sty     TT1
LEA34:  cpy     FNLEN
.fi
        beq     LEA57
        lda     #$AF
        sta     $07DF
        jsr     KLUDES
.if COMPILECOMPUTER >= PLUS4_03
        cmp     $0337,y
        beq     LEA2C
        lsr     TYPE
        bcc     LEA21
        ldy     #$FF
        sty     $07C3
        dey
        sty     $07C2
        ldy     #$01
        jsr     LE8D5
        jmp     LEA21
 .else
        ldy     TT3
        cmp     (TAPEBS),y
        bne     LEA21
        inc     TT1
        inc     TT3
        ldy     TT1
        jmp     LEA34
.fi

LEA53:  lda     #$00
LEA55:  sec
        rts

LEA57:  clc
        lda     TYPE
        rts

LEA5B:  lda     ASTAT
        and     #$10
        beq     LEA94
        lda     SPI6529
        and     #$02
        beq     LEA94
        ldx     #$00
        bit     SOUNFG
        bpl     LEA79
        lda     SOUTQ
        stx     SOUNFG
        jmp     LEA89

LEA79:  bit     UOUTFG
        bpl     LEA94
        bit     ALSTOP
        bmi     LEA94
        lda     UOUTQ
        stx     UOUTFG
LEA89:  sta     ACIA
        lda     ASTAT
        and     #$EF
        sta     ASTAT
LEA94:  rts

LEA95:  lda     ASTAT
        and     #$08
        beq     LEAF0
        lda     ASTAT
        and     #$F7
        sta     ASTAT
        lda     ACIA
        beq     LEAC2
        sta     AINTMP
        cmp     XON
        bne     LEAB7
        lda     #$00
        sta     ALSTOP
        beq     LEAF0
LEAB7:  cmp     XOFF
        bne     LEAC2
        lda     #$FF
        sta     ALSTOP
        bne     LEAF0
LEAC2:  lda     INQCNT
        cmp     #$3F
        beq     LEAF0
        cmp     #$38
        bne     LEADC
        lda     XOFF
        beq     LEADC
        sta     SOUTQ
        lda     #$FF
        sta     SOUNFG
        sta     ARSTOP
LEADC:  ldx     INQFPT
        inx
        txa
        and     #$3F
        sta     INQFPT
        tax
        lda     AINTMP
        sta     $03F7,x
        inc     INQCNT
LEAF0:  rts

LEAF1:  lda     INQCNT
        beq     LEB2A
        php
        sei
        ldx     INQRPT
        inx
        txa
        and     #$3F
        sta     INQRPT
        plp
        tax
        lda     $03F7,x
        pha
        dec     INQCNT
        lda     INQCNT
        cmp     #$08
        bne     LEB2B
        bit     ARSTOP
        bpl     LEB2B
        lda     XON
        beq     LEB2B
        sta     SOUTQ
        sec
        ror     SOUNFG
        lsr     ARSTOP
LEB25:  bit     APRES
        bpl     LEB35
LEB2A:  pha
LEB2B:  lda     ASTAT
        and     #$4F
        eor     #$40
        sta     STATUS
        pla
LEB35:  clc
        rts

LEB37:  bit     UOUTFG
        bmi     LEB37
        sta     UOUTQ
        sec
        ror     UOUTFG
        jmp     LEB2A

LEB46:  lda     #$00
        ldx     #$0B
LEB4A:  sta     UOUTQ,x
        dex
        bpl     LEB4A
        sta     LFD01
        sta     XON
        sta     XOFF
        rts

LEB58:  .byte   $0D
        .TEXT   "I/O ERROR "

        .byte   $A3,$0D
        .TEXT   "SEARCHING"

        .byte   $A0
        .TEXT   "FOR"
        .byte   $A0,$0D
        .TEXT   "PRESS PLAY ON TAP"


        .byte   $C5
        .TEXT   "PRESS RECORD & PLAY ON TAP"



        .byte   $C5,$0D
        .TEXT   "LOADIN"
        .byte   $C7,$0D
        .TEXT   "SAVING"
        .byte   $A0,$0D
        .TEXT   "VERIFYIN"
        .byte   $C7,$0D
        .TEXT   "FOUND"
        .byte   $A0,$0D
        .TEXT   "OK"
        .byte   $8D
LEBC6:  bit     MSGFLG
        bpl     LEBD7
LEBCA:  lda     LEB58,y
        php
        and     #$7F
        jsr     kCHROUT
        iny
        plp
        bpl     LEBCA
LEBD7:  clc
        rts

LEBD9:  lda     DFLTN
        bne     LEBF7
        lda     NDX
        ora     KYNDX
        beq     LEC22
        sei
        jmp     LD8C1

LEBE8:  lda     DFLTN
        bne     LEBF7
        lda     PNTR
        sta     $C5
        lda     TBLX
        sta     LSXP
        jmp     LD965

LEBF7:  cmp     #$03
        bne     LEC1A
        ora     CRSW
        sta     CRSW
        lda     SCRT
        sta     INDX
        jmp     LD965

LEC07:  jsr     LFBBA
        cmp     #$01
        bne     LEC14
        jsr     LEC24
        jmp     LFBC4

LEC14:  jsr     LEAF1
        jmp     LFBC4

LEC1A:  bcc     LEC07
        lda     STATUS
        beq     iACPTR
        lda     #$0D
LEC22:  clc
        rts

LEC24:  ldy     TPTR
        cpy     #$BF
        bcc     LEC31
        jsr     LE8D3
        bcc     LEC24
        rts

LEC31:  ldy     TPTR
        lda     (TAPEBS),y
        pha
        iny
        cpy     #$BF
        bcs     LEC45
        lda     (TAPEBS),y
        bne     LEC45
        lda     #$40
        jsr     LF41E
LEC45:  inc     TPTR
        pla
        clc
        rts

LEC4B:  pha
        lda     DFLTO
        cmp     #$03
        bne     LEC56
        pla
        jmp     LDC49

LEC56:  bcc     LEC5C
        pla
        jmp     iCIOUT

LEC5C:  jsr     LFBB7
        cmp     #$01
        bne     LEC84
        ldy     TPTR
        cpy     #$BF
        bcc     LEC75
        jsr     LE535
        bcs     LEC7E
        lda     #$02
        sta     TYPE
        ldy     #$00
LEC75:  pla
        sta     (TAPEBS),y
        iny
        sty     TPTR
        bcc     LEC88
LEC7E:  pla
        lda     #$00
        jmp     LFBC4

LEC84:  pla
        jsr     LEB37
LEC88:  jmp     LFBC1

iACPTR:
.if COMPILECOMPUTER >= PLUS4_01
        stx     WRBASE
.fi
        bit     USEKDY
        bvs     LEC96
.if COMPILECOMPUTER >= PLUS4_01
        ldx     WRBASE
.fi
        jmp     LE252

LEC96:
.if COMPILECOMPUTER >= PLUS4_01
        lda     USEKDY
        and     #$30
        tax
        lda     #$84
        sta     LFEC0,x
LECA0:  lda     LFEC2,x
        bmi     LECA0
        lda     #$00
        sta     LFEC3,x
        sta     LFEC2,x
LECAD:  lda     LFEC2,x
        bpl     LECAD
        lda     LFEC1,x
.else
        lda     #$84
        sta     LFEF0
LEC97:  lda     LFEF2
        bmi     LEC97
        lda     #$00
        sta     LFEF3
        sta     LFEF2
LECA4:  lda     LFEF2
        bpl     LECA4
        lda     LFEF1
.fi
        and     #$03
        cmp     #$03
        bne     LECBD
        lda     #$40
LECBD:  jsr     LF41E
.if COMPILECOMPUTER >= PLUS4_01
        lda     LFEC0,x
.else
        lda     LFEF0
.fi
        pha
        lda     #$40
.if COMPILECOMPUTER >= PLUS4_01
        sta     LFEC2,x
.else
        sta     LFEF2
.fi
LECC9:
.if COMPILECOMPUTER >= PLUS4_01
        lda     LFEC2,x
.else
        lda     LFEF2
.fi
        bmi     LECC9
        lda     #$FF
.if COMPILECOMPUTER >= PLUS4_01
        sta     LFEC3,x
        lda     #$00
        sta     LFEC0,x
        sta     LFEC2,x
        jmp     LEDD4
        nop
.else
        sta     LFEF3
        lda     #$00
        sta     LFEF0
        sta     LFEF2
LECD2:  lda     LFEF2
        bpl     LECD2
        lda     #$40
        sta     LFEF2
LECDC:  pla
        clc
        rts
.fi

iCIOUT: bit     USEKDY
        bmi     LECE6
        jmp     LE21D

LECE6:  pha
        sta     KDYCMD
        lda     #$83

LECEC:
.if COMPILECOMPUTER >= PLUS4_01
        stx     WRBASE
        pha
        lda     USEKDY
        and     #$30
        tax
        pla
        sta     LFEC0,x
LECF8:  lda     LFEC2,x
        bmi     LECF8
.else
        sta LFEF0
LECEF:  lda LFEF2
        bmi LECEF
.fi
        lda     KDYCMD
.if COMPILECOMPUTER >= PLUS4_01
        sta     LFEC0,x
.else
        sta     LFEF0
.fi
        lda     #$00
.if COMPILECOMPUTER >= PLUS4_01
        sta     LFEC2,x
.else
        sta     LFEF2
.fi

LED08:
.if COMPILECOMPUTER >= PLUS4_01
        lda     LFEC2,x
.else
        lda     LFEF2
.fi
        bpl     LED08
.if COMPILECOMPUTER >= PLUS4_01
        lda     LFEC1,x
.else
        lda     LFEF1
.fi
        and     #$03
        jsr     LF41E
.if COMPILECOMPUTER >= PLUS4_01
        jmp     LEDDB
.else
        lda     #$00
        sta     LFEF0
        lda     #$40
        sta     LFEF2
        bne     LECDC
.fi

LED18:  jsr     LEEE8
        beq     LED20
        jmp     LF279

LED20:  jsr     LEEF8
        beq     LED36
        cmp     #$03
        beq     LED36
        bcs     LED3A
        cmp     #$02
        bne     LED57
        jsr     LEB25
        bcs     LED39
        lda     FA
LED36:  sta     DFLTN
        clc
LED39:  rts

LED3A:  tax
        jsr     iTALK
        bit     STATUS
        bmi     LED54
        lda     SA
        bpl     LED4C
        jsr     LEE13
        jmp     LED4F

LED4C:  jsr     iTKSA
LED4F:  txa
        bit     STATUS
        bpl     LED36
LED54:  jmp     LF27F

LED57:  ldx     SA
        cpx     #$60
        beq     LED36
        jmp     LF282

LED60:  jsr     LEEE8
        beq     LED68
        jmp     LF279

LED68:  jsr     LEEF8
        bne     LED70
LED6D:  jmp     LF285

LED70:  cmp     #$03
        beq     LED81
        bcs     LED85
        cmp     #$02
        bne     LEDA1
        jsr     LEB25
        bcs     LED84
        lda     FA
LED81:  sta     DFLTO
        clc
LED84:  rts

LED85:  tax
        jsr     iLISTEN
        bit     STATUS
        bmi     LED9E
        lda     SA
        bpl     LED96
        jsr     LEE45
        bne     LED99
LED96:  jsr     iSECOND
LED99:  txa
        bit     STATUS
        bpl     LED81
LED9E:  jmp     LF27F

LEDA1:  ldx     SA
        cpx     #$60
        beq     LED6D
        bne     LED81
LEDA9:  pha
.if COMPILECOMPUTER >= PLUS4_01
        stx     WRBASE
        ldx     #$30
        lda     FA
        cmp     #$08
        beq     LEDBA
        cmp     #$09
        bne     LEDCF
        ldx     #$00
LEDBA:  lda     #$55
        sta     LFEC0,x
        eor     LFEC0,x
        bne     LEDCF
        lda     LFEC1,x
.else
        txa
        pha
        ldx     #$08
        lda     #$55
        sta     LFEF0
        eor     LFEF0
        bne     LEDCF
        lda     #$33
        sta     LFEF0
        eor     LFEF0
        bne     LEDCF
        lda     LFEF1
.fi
        and     #$02
        bne     LEDCF
.if COMPILECOMPUTER >= PLUS4_01
        stx     USEKDY
.else
        lda     #$85
        sta     LFEF0
        .byte   $AD
        .byte   $F2
        inc     $FB30,x
        stx     LFEF2
LEDD6:  lda     LFEF2
        bpl     LEDD6
        lda     LFEF1
        and     #$03
        beq     LEDE3
        inx
LEDE3:  lda     #$40
        sta     LFEF0
        sta     LFEF2
        txa
        sta     KDYNUM
        cmp     FA
        bne     LEDCF
.fi
        clc
        .byte   $24
LEDCF:  sec
.if COMPILECOMPUTER >= PLUS4_01
        ldx     WRBASE
        pla
        rts

LEDD4:  lda     LFEC2,x
        bpl     LEDD4
        bmi     LEDE0
LEDDB:  lda     #$00
        sta     LFEC0,x
LEDE0:  lda     #$40
        sta     LFEC2,x
        ldx     WRBASE
        pla
        clc
        rts
.else
        pla
        tax
        pla
        rts
.fi

.if COMPILECOMPUTER >= PLUS4_01
LEDEA:  sta     LFEF2
        sta     LFEC5
        sta     LFEC2
        dex
        stx     LFEC3
        jmp     LCFEA
.fi

iTALK:  jsr     LEDA9
        bcc     LEE02
        jmp     LE153

LEE02:  pha
        lda     #$40
        sta     KDYCMD
        lda     USEKDY
        ora     #$40
        sta     USEKDY
        lda     #$81
        jmp     LECEC

LEE13:  bit     USEKDY
        bvs     LEE4C
        jmp     LE20C

iTKSA:  bit     USEKDY
        bvs     LEE21
        jmp     LE203

LEE21:  pha
.if COMPILECOMPUTER >= PLUS4_05
        nop
        nop
.else
        lda     SA
.fi
        sta     KDYCMD
        lda     #$82
        jmp     LECEC

iLISTEN:jsr     LEDA9
        bcc     LEE34
        jmp     LE156

LEE34:  pha
        lda     #$20
        sta     KDYCMD
        lda     USEKDY
        ora     #$80
        sta     USEKDY
        lda     #$81
        jmp     LECEC

LEE45:  bit     USEKDY
        bmi     LEE4C
        jmp     LE1FC

LEE4C:  rts

iSECOND:bit     USEKDY
        bmi     LEE54
        jmp     LE1F7

LEE54:  pha
        sta     KDYCMD
        lda     #$82
        jmp     LECEC

LEE5D:  ror     WRBASE
        jsr     LEEED
        beq     LEE66
        clc
        rts

LEE66:  jsr     LEEF8
        txa
        pha
        lda     FA
        beq     LEECA
        cmp     #$03
        beq     LEECA
        bcs     LEEB5
        cmp     #$02
        bne     LEE81
        php
        sei
        jsr     LEB46
        plp
        beq     LEECA
LEE81:  lda     SA
        and     #$0F
        beq     LEECA
        ldy     TPTR
        cpy     #$BF
        bcc     LEE9C
        jsr     LE535
        bcs     LEEA5
        lda     #$02
        sta     TYPE
        ldy     #$00
        sty     TPTR
LEE9C:  lda     #$00
        sta     (TAPEBS),y
        jsr     LE535
        bcc     LEEA9
LEEA5:  pla
        lda     #$00
        rts

LEEA9:  lda     SA
        cmp     #$62
        bne     LEECA
        jsr     LE5F0
        jmp     LEECA

LEEB5:  bit     WRBASE
        bpl     LEEC7
        lda     FA
        cmp     #$08
        bcc     LEEC7
        lda     SA
        and     #$0F
        cmp     #$0F
        beq     LEECA
LEEC7:  jsr     LF211
LEECA:  pla
        tax
        dec     LDTND
        cpx     LDTND
        beq     LEEE6
        ldy     LDTND
        lda     LAT,y
        sta     LAT,x
        lda     FAT,y
        sta     FAT,x
        lda     SAT,y
        sta     SAT,x
LEEE6:  clc
        rts

LEEE8:  lda     #$00
        sta     STATUS
        txa
LEEED:  ldx     LDTND
LEEEF:  dex
        bmi     LEF07
        cmp     LAT,x
        bne     LEEEF
        rts

LEEF8:  lda     LAT,x
        sta     LA
        lda     SAT,x
        sta     SA
        lda     FAT,x
        sta     FA
LEF07:  rts

LEF08:  lda     #$00
        sta     LDTND
LEF0C:  ldx     #$03
        cpx     DFLTO
        bcs     LEF15
        jsr     iUNLSN
LEF15:  cpx     DFLTN
        bcs     LEF1C
        jsr     iUNTLK
LEF1C:  stx     DFLTO
        lda     #$00
        sta     DFLTN
        rts

iUNLSN: bit     USEKDY
        bmi     LEF2A
        jmp     LE23D

LEF2A:  pha
        lda     #$3F
        sta     KDYCMD
        lda     USEKDY
        and     #$7F
        sta     USEKDY
        lda     #$81
        jmp     LECEC

iUNTLK: bit     USEKDY
        bvs     LEF42
        jmp     LE22F

LEF42:  pha
        lda     #$5F
        sta     KDYCMD
        lda     USEKDY
        and     #$BF
        sta     USEKDY
        lda     #$81
        jmp     LECEC

LEF53:  ldx     LA
        jsr     LEEE8
        bne     LEF5D
        jmp     LF276

LEF5D:  ldx     LDTND
        cpx     #$0A
        bcc     LEF66
        jmp     LF273

LEF66:  inc     LDTND
        lda     LA
        sta     LAT,x
        lda     SA
        ora     #$60
        sta     SA
        sta     SAT,x
        lda     FA
        sta     FAT,x
        beq     LEF86
        cmp     #$03
        beq     LEF86
        bcc     LEF88
        jsr     LF005
LEF86:  clc
        rts

LEF88:  cmp     #$02
        bne     LEFB8
        jsr     LEB46
        tax
LEF90:  inx
        beq     LEF9E
        stx     LFD03
        cpx     LFD03
        beq     LEF90
        jmp     LF27F

LEF9E:  sec
        ror     APRES
        lda     #$AF
        sta     $07DF
        ldy     #$00
        jsr     KLUDES
        sta     LFD03
        iny
        jsr     KLUDES
        sta     LFD02
        clc
        rts

LEFB8:  lda     SA
        and     #$0F
        bne     LEFEA
        jsr     LE31B
        bcs     LEFE9
        jsr     LF160
        lda     FNLEN
        beq     LEFD4
        jsr     LEA21
        bcc     LEFDF
        beq     LEFE9
LEFD1:  jmp     LF27C

LEFD4:  jsr     LE9CC
        beq     LEFE9
        bcs     LEFD1
        cmp     #$05
        beq     LEFD1
LEFDF:  ldy     #$BF
        sty     TPTR
        lda     #$02
        sta     TYPE
LEFE8:  clc
LEFE9:  rts

LEFEA:  jsr     LE319
        bcs     LEFE9
        lda     #$04
        sta     TYPE
        jsr     LE56C
        bcs     LF004
        lda     #$02
        sta     TYPE
        ldy     #$00
        sty     TPTR
        sty     CTALLY
LF004:  rts

LF005:  lda     SA
        bmi     LEFE8
        ldy     FNLEN
        beq     LEFE8
        lda     #$00
        sta     STATUS
        lda     FA
        jsr     iLISTEN
        bit     STATUS
        bmi     LF025
        lda     SA
        ora     #$F0
        jsr     iSECOND
        lda     STATUS
        bpl     LF02A
LF025:  pla
        pla
        jmp     LF27F

LF02A:  lda     FNLEN
        beq     LF040
        ldy     #$00
LF030:  lda     #$AF
        sta     $07DF
        jsr     KLUDES
        jsr     iCIOUT
        iny
        cpy     FNLEN
        bne     LF030
LF040:  jmp     LF223

iLOAD:  stx     MEMUSS
        sty     $B5
        jmp     (lILOAD)

LF04A:  sta     VERFCK
        lda     #$00
        sta     STATUS
        lda     FA
        bne     LF057
LF054:  jmp     LF28B

LF057:  cmp     #$03
        beq     LF054
        bcs     LF064
        cmp     #$02
        beq     LF054
        jmp     LF0F0

LF064:  ldy     FNLEN
        bne     LF06B
        jmp     LF288

LF06B:  ldx     SA
        jsr     LF160
        lda     #$60
        sta     SA
        jsr     LF005
        lda     FA
        jsr     iTALK
        lda     SA
        jsr     iTKSA
        jsr     iACPTR
        sta     EAL
        lda     STATUS
        lsr     a
        lsr     a
        bcs     LF0E8
        jsr     iACPTR
        sta     $9E
        txa
        bne     LF09C
        lda     MEMUSS
        sta     EAL
        lda     $B5
        sta     $9E
LF09C:  jsr     LF189
LF09F:  lda     #$FD
        and     STATUS
        sta     STATUS
        jsr     kSTOP
        bne     LF0AD
        jmp     LF1FF

LF0AD:  jsr     iACPTR
        tax
        lda     STATUS
        lsr     a
        lsr     a
        bcs     LF09F
        txa
        ldy     VERFCK
        beq     LF0D4
        ldy     #$00
        sta     VSAVE
        lda     #$9D
        sta     $07DF
        jsr     KLUDES
        cmp     VSAVE
        beq     LF0D6
        lda     #$10
        jsr     LF41E
        .byte   $2C
LF0D4:  sta     (EAL),y
LF0D6:  inc     EAL
        bne     LF0DC
        inc     $9E
LF0DC:  bit     STATUS
        bvc     LF09F
        jsr     iUNTLK
        jsr     LF211
        bcc     LF0EB
LF0E8:  jmp     LF27C

LF0EB:  ldx     EAL
        ldy     $9E
LF0EF:  rts

LF0F0:  jsr     LE31B
        bcs     LF0EF
        jsr     LF160
LF0F8:  lda     FNLEN
        beq     LF105
        jsr     LEA21
        bcc     LF10C
        beq     LF0EF
        bcs     LF0E8
LF105:  jsr     LE9CC
        beq     LF0EF
        bcs     LF0E8
LF10C:  lda     TYPE
        cmp     #$01
        beq     LF124
        cmp     #$03
        bne     LF0F8
LF116:  ldy     #$00
        lda     (TAPEBS),y
        sta     MEMUSS
        iny
        lda     (TAPEBS),y
        sta     $B5
        jmp     LF128

LF124:  lda     SA
        bne     LF116
LF128:  sec
        ldy     #$02
        lda     (TAPEBS),y
        ldy     #$00
        sbc     (TAPEBS),y
        tax
        ldy     #$03
        lda     (TAPEBS),y
        ldy     #$01
        sbc     (TAPEBS),y
        tay
        clc
        txa
        adc     MEMUSS
        sta     EAL
        tya
        adc     $B5
        sta     $9E
        lda     MEMUSS
        sta     STAL
        lda     $B5
        sta     $B3
        jsr     LF189
        jsr     LE8F3
        bcc     LF0EB
        lda     #$1D
        bit     VERFCK
        bpl     LF0EF
        lda     #$1C
        bne     LF0EF
LF160:  lda     MSGFLG
        bpl     LF188
        ldy     #$0C
        jsr     LEBCA
        lda     FNLEN
        beq     LF188
        ldy     #$17
        jsr     LEBCA
LF172:  ldy     FNLEN
        beq     LF188
        ldy     #$00
LF178:  lda     #$AF
        sta     $07DF
        jsr     KLUDES
        jsr     kCHROUT
        iny
        cpy     FNLEN
        bne     LF178
LF188:  rts

LF189:  ldy     #$49
        lda     VERFCK
        beq     LF191
        ldy     #$59
LF191:  jmp     LEBC6

iSAVE:  stx     EAL
        sty     $9E
        tax
        lda     PDIR,x
        sta     STAL
        lda     PORT,x
        sta     $B3
        jmp     (lISAVE)

LF1A4:  lda     FA
        bne     LF1AB
LF1A8:  jmp     LF28B

LF1AB:  cmp     #$03
        beq     LF1A8
        cmp     #$02
        beq     LF1A8
        bcc     LF234
        lda     #$61
        sta     SA
        ldy     FNLEN
        bne     LF1C0
        jmp     LF288

LF1C0:  jsr     LF005
        jsr     LF228
        lda     FA
        jsr     iLISTEN
        lda     SA
        jsr     iSECOND
        ldy     #$00
        lda     $B3
        sta     $9C
        lda     STAL
        sta     SAL
        lda     SAL
        jsr     iCIOUT
        lda     $9C
        jsr     iCIOUT
LF1E4:  sec
        lda     SAL
        sbc     EAL
        lda     $9C
        sbc     $9E
        bcs     LF20E
        lda     #$9B
        sta     $07DF
        jsr     KLUDES
        jsr     iCIOUT
        jsr     kSTOP
        bne     LF206
LF1FF:  jsr     LF211
        lda     #$00
        sec
        rts

LF206:  inc     SAL
        bne     LF1E4
        inc     $9C
        bne     LF1E4
LF20E:  jsr     iUNLSN
LF211:  bit     SA
        bmi     LF226
        lda     FA
        jsr     iLISTEN
        lda     SA
        and     #$EF
        ora     #$E0
        jsr     iSECOND
LF223:  jsr     iUNLSN
LF226:  clc
        rts

LF228:  lda     MSGFLG
        bpl     LF264
        ldy     #$51
        jsr     LEBCA
        jmp     LF172

LF234:  jsr     LE319
        bcs     LF262
        jsr     LF228
        ldx     #$03
        lda     SA
        and     #$01
        bne     LF246
        ldx     #$01
LF246:  stx     TYPE
        jsr     LE56C
        bcs     LF262
        lda     #$00
        sta     TYPE
        jsr     LE5B0
        bcs     LF262
        lda     SA
        and     #$02
        beq     LF261
        jsr     LE5F0
        bcs     LF262
LF261:  clc
LF262:  lda     #$00
LF264:  rts

LF265:  lda     STKEY
        cmp     #$7F
        bne     LF272
        php
        jsr     kCLRCHN
        sta     NDX
        plp
LF272:  rts

LF273:  lda     #$01
        .byte   $2C
LF276:  lda     #$02
        .byte   $2C
LF279:  lda     #$03
        .byte   $2C
LF27C:  lda     #$04
        .byte   $2C
LF27F:  lda     #$05
        .byte   $2C
LF282:  lda     #$06
        .byte   $2C
LF285:  lda     #$07
        .byte   $2C
LF288:  lda     #$08
        .byte   $2C
LF28B:  lda     #$09
        pha
        jsr     kCLRCHN
        ldy     #$00
        bit     MSGFLG
        bvc     LF2A1
        jsr     LEBCA
        pla
        pha
        ora     #$30
        jsr     kCHROUT
LF2A1:  pla
        sec
        rts

NMI:    ldx     #$FF
        sei
        txs
        cld
        jsr     LCFA6
        jsr     iIOINIT
        jsr     LCF11
        php
        bmi     LF2BC
        lda     #$A5
        cmp     DEJAVU
        beq     LF2BF
LF2BC:  jsr     iRAMTAS
LF2BF:  jsr     iRESTOR
        jsr     iCINT
        plp
        bmi     LF2CB
        jmp     LF445

LF2CB:  jmp     L8000

iRESTOR:ldx     #$EB
        ldy     #$F2
        clc
iVECTOR:stx     TMP2
        sty     $B9
        ldy     #$1F
LF2D9:  lda     lITIME,y
        bcs     LF2E0
        lda     (TMP2),y
LF2E0:  sta     lITIME,y
        bcc     LF2E7
        sta     (TMP2),y
LF2E7:  dey
        bpl     LF2D9
        rts

        .addr   LCE42
        .addr   LCE0E
        .addr   LF44C
        .addr   LEF53
        .addr   LEE5D
        .addr   LED18
        .addr   LED60
        .addr   LEF0C
        .addr   LEBE8
        .addr   LEC4B
        .addr   LF265
        .addr   LEBD9
        .addr   LEF08
        .addr   LF44C
        .addr   LF04A
        .addr   LF1A4
iIOINIT:lda     #$0F
        sta     PDIR
        lda     #$08
        sta     PORT
        ldx     #$FF
        stx     SPI6529
        stx     LFEF3
        inx
        stx     LFEF4
        stx     LFEF0
        lda     #$40
        sta     LFEF5
.if COMPILECOMPUTER >= PLUS4_01
        jsr     LEDEA
.else
        sta     LFEF2
.fi
LF32A:  lda     LF338,x
        sta     TEDT1RL,x
        inx
        cpx     #$1A
        bne     LF32A
        jmp     LEB46

LF338:  .byte   $F1,$39,$00,$00,$00,$00,$1B,$08 | LF338_NTSC
        .byte   $00,$00,$02,$CC,$00,$00,$00,$00
        .byte   $00,$00,$04,$D0,$08,$71,$5B,$75
        .byte   $77,$6E
iRAMTAS:lda     #$00
        tay
LF355:  sta     SRCHTK,y
        sta     BUF,y
        sta     lIERROR,y
        sta     $0400,y
        sta     $0700,y
        iny
        bne     LF355
        ldx     #$08
        stx     T1
LF36B:  lda     RESET - 1,x
        sta     RESET - 1,x
        cmp     $3FF5,x
        bne     LF377
        iny
LF377:  cmp     $7FF5,x
        bne     LF37E
        dec     T1
LF37E:  dex
        bne     LF36B
        cpy     #$08
        beq     LF38C
        lda     T1
        bne     LF391
        ldy     #$7F
        .byte   $2C
LF38C:  ldy     #$3F
        ldx     #$F6
        .byte   $2C
LF391:  ldy     #$FD
        clc
        jsr     LF42F
        lda     #$10
        sta     $0532
        ldx     #$3A
LF39E:  lda     LF3D1,x
        sta     KEYIDX,x
        dex
        bne     LF39E
        stx     KYNDX
        ldx     #$0B
LF3AC:  lda     LCFB3,x
        sta     KLUDES,x
        dex
        bpl     LF3AC
        ldx     #$0F
LF3B7:  lda     LE143,x
        sta     COLKEY,x
        dex
        bpl     LF3B7
        lda     #$A5
        sta     DEJAVU
.if COMPILECOMPUTER >= PLUS4_BETA_0203
        lda     #$04
        sta     FFRMSK
        lda     #$18
        sta     VMBMSK
.fi
        rts

.if COMPILECOMPUTER = PLUS4_BETA_0119
LCFB3:  php
        sei
        sta     TEDROMSEL
        lda     (PDIR),y
        sta     TEDRAMSEL
        plp
LF3D1:  rts

.else
        nop
LF3D1:  nop
.fi
        .byte   $07,$06,$0A,$07,$06,$04,$05,$05
        .TEXT   "GRAPHICDLOAD"

        .byte   $22
        .TEXT   "DIRECTORY"

        .byte   $0D
        .TEXT   "SCNCLR"
        .byte   $0D
        .TEXT   "DSAVE"
        .byte   $22
        .TEXT   "RUN"
        .byte   $0D
        .TEXT   "LIST"
        .byte   $0D
        .TEXT   "HELP"
        .byte   $0D
iSETNAM:sta     FNLEN
        stx     FNADR
        sty     $B0
        rts

iSETLFS:sta     LA
        stx     FA
        sty     SA
        rts

iSETMSF:sta     MSGFLG
iREADST:lda     STATUS
LF41E:  ora     STATUS
        sta     STATUS
        rts

iSETTMO:sta     TIMOUT
        rts

iMEMTOP:bcc     LF42F
        ldx     MSIZ
        ldy     $0534
LF42F:  stx     MSIZ
        sty     $0534
        rts

iMEMBOT:bcc     LF43E
        ldx     MEMSTR
        ldy     $0532
LF43E:  stx     MEMSTR
        sty     $0532
        rts

LF445:  ldx     #$00
        stx     FLGS
        beq     LF458
LF44C:  cld
        ldx     #$05
LF44F:  pla
        sta     PCH,x
        dex
        bpl     LF44F
        ldx     #$09
LF458:  stx     SYREG
        lda     #$C0
        sta     MSGFLG
        tsx
        stx     SP
        ldx     SYREG
        jsr     LCF66
        lda     TEDVSP
        ora     #$10
        sta     TEDVSP
        lda     #$00
        sta     T2
        sta     $A2
        cli
LF478:  ldx     #$0F
        jsr     LCF66
        lda     PCH
        jsr     LFB10
        ldy     #$00
LF485:  lda     PCL,y
        jsr     LFB05
        iny
        cpy     #$06
        bcc     LF485
        bcs     LF495
LF492:  jsr     LFB0B
LF495:  jsr     LFB3A
        ldx     #$00
        stx     CHRPTR
LF49C:  jsr     kCHRIN
        sta     BUF,x
        inx
        cmp     #$0D
        bne     LF49C
        dex
        stx     BUFEND
LF4AA:  jsr     LFB3F
        beq     LF495
        cmp     #$20
        beq     LF4AA
        ldx     #$0F
LF4B5:  cmp     LF570,x
        beq     LF4BF
        dex
        bpl     LF4B5
        bmi     LF492
LF4BF:  cpx     #$0D
        bcs     LF4D1
        txa
        asl     a
        tax
        lda     LF580+1,x
        pha
        lda     LF580,x
        pha
        jmp     LFAAD

LF4D1:  sta     CMPFLG
        jmp     LF66E

LF4D7:  bcs     LF4E1
        jsr     LFB5B
        jsr     LFAAD
        bcc     LF4E7
LF4E1:  lda     #$0B
        sta     T0
        bne     LF4F5
LF4E7:  jsr     LFB64
        lsr     a
.if COMPILECOMPUTER == PLUS4_BETA_0203
        ror     $51
.else
        ror     T0
.fi
        lsr     a
        ror     T0
        lsr     a
        ror     T0
        sta     $F2
LF4F5:  jsr     kSTOP
        beq     LF507
        jsr     LF59A
        lda     #$08
        jsr     LFB96
        jsr     LFB72
        bcs     LF4F5
LF507:  jmp     LF495

LF50A:  bcs     LF507
        lda     T0
        ldy     $F2
        sta     PCL
        sty     PCH
        ldy     #$00
LF518:  jsr     LFAAD
        bcs     LF507
        lda     T0
        sta     FLGS,y
        iny
        cpy     #$05
        bcc     LF518
        bcs     LF507
LF529:  bcs     LF53E
        jsr     LFB5B
        ldy     #$00
LF530:  jsr     LFAAD
        bcs     LF53E
        lda     T0
        sta     (T2),y
        iny
        cpy     #$08
        bcc     LF530

LF53E:
.if COMPILECOMPUTER >= PLUS4_01
        jsr     LFBD8
        .byte   $1B
        .byte   $4F
        sta     (PDIR),y
        jsr     LF59A
        jmp     LF495
.else
        lda     #$91
        jsr     kCHROUT
        jsr     LDF87
        jsr     LF59A
        bcs     LF507
.fi

LF54B:  bcs     LF557
        lda     T0
        sta     PCL
        lda     $F2
        sta     PCH
LF557:  ldx     SP
        txs
        ldx     #$00
LF55D:  lda     PCH,x
        pha
        inx
        cpx     #$03
        bne     LF55D
        ldx     XR
        ldy     YR
        lda     ACC
        rti

LF570:  .TEXT   "XMRGTCDA.HF>;LSV"

LF580:  .word   $8002,$F4D6,$F477,$F54A
        .word   $F5D0,$F5CD,$F723,$F91E
        .word   $F91E,$F60D,$F709,$F528
        .word   $F509
LF59A:  jsr     LFB3A
        lda     #$3E
        jsr     kCHROUT
        jsr     LFAFB
        ldy     #$00
LF5A7:  jsr     LCF96
        jsr     LFB05
        iny
        cpy     #$08
        bcc     LF5A7
        jsr     LFBD8
        .TEXT   ":"
        .byte   $12,$00
        ldy     #$00
LF5BA:  jsr     LCF96
        and     #$7F
        cmp     #$20
        bcs     LF5C5
        lda     #$2E
LF5C5:  jsr     kCHROUT
        iny
        cpy     #$08
        bcc     LF5BA
        rts

LF5CE:  lda     #$00
        .byte   $2C
LF5D1:  lda     #$80
.if COMPILECOMPUTER >= PLUS4_01
        sta     $BB
.else
        sta     CMPFLG
.fi
        jsr     LFBA0
        bcs     LF60A
        jsr     LFAAD
        bcs     LF60A
        jsr     LFB3A
        ldy     #$00
LF5E4:
.if COMPILECOMPUTER >= PLUS4_01
        jsr     LCF96
        bit     $BB
.else
        lda     (T2),y
        bit     CMPFLG
.fi
        bpl     LF5ED
        sta     (T0),y
LF5ED:  cmp     (T0),y
        beq     LF5F9
        jsr     kSTOP
        beq     LF607
        jsr     LFAFB
LF5F9:  inc     T0
        bne     LF5FF
        inc     $F2
LF5FF:  jsr     LFB94
        jsr     LFB86
        bcs     LF5E4
LF607:  jmp     LF495

LF60A:  jmp     LF492

.if COMPILECOMPUTER >= PLUS4_01
        nop
.fi

LF60E:  jsr     LFBA0
        bcs     LF60A
        ldy     #$00
        jsr     LFB3F
        cmp     #$27
        bne     LF62E
        jsr     LFB3F
LF61F:
.if COMPILECOMPUTER >= PLUS4_01
        sta     XCNT,y
.else
        sta     $77,y
.fi
        iny
        jsr     LFB3F
        beq     LF643
        cpy     #$20
        bne     LF61F
        beq     LF643
LF62E:  sty     BAD
        jsr     LFAAB
LF634:  lda     T0
.if COMPILECOMPUTER >= PLUS4_01
        sta     XCNT,y
.else
        sta     $77,y
.fi
        iny
        jsr     LFAAD
        bcs     LF643
        cpy     #$20
        bne     LF634
LF643:  sty     CMPFLG
        jsr     LFB3A
LF649:  ldx     #$00
        ldy     #$00
LF64D:  jsr     LCF96
.if COMPILECOMPUTER >= PLUS4_01
        cmp     XCNT,x
.else
        cmp     $77,x
.fi
        bne     LF664
        iny
        inx
        cpx     CMPFLG
        bne     LF64D
        jsr     kSTOP
.if COMPILECOMPUTER >= PLUS4_01
        beq     LF607
.else
        beq     LF66B
.fi
        jsr     LFAFB
LF664:  jsr     LFB94
        jsr     LFB86
        bcs     LF649
.if COMPILECOMPUTER >= PLUS4_01
        bcc     LF607
.else
LF66B:  jmp     LF495
.fi

LF66E:  ldy     #$01
        sty     FA
        sty     SA
        dey
        sty     FNLEN
        sty     STATUS
        sty     VERFCK
.if COMPILECOMPUTER >= PLUS4_01
        lda     #>XCNT
        sta     FNADR+1
        lda     #<XCNT
.else
        nop
        sty     FNADR+1
        lda     #$77
.fi
        sta     FNADR
LF683:  jsr     LFB3F
        beq     LF6E6
        cmp     #$20
        beq     LF683
        cmp     #$22
        bne     LF6A7
        ldx     CHRPTR
LF692:  cpx     BUFEND
        bcs     LF6E6
        lda     BUF,x
        inx
        cmp     #$22
        beq     LF6AB
        sta     (FNADR),y
        inc     FNLEN
        iny
.if COMPILECOMPUTER >= PLUS4_01
        cpy     #$11
.else
        cpy     #$10
.fi
        bcc     LF692
LF6A7:  jmp     LF492

.if COMPILECOMPUTER >= PLUS4_01
        nop
.fi

LF6AB:  stx     CHRPTR
        jsr     LFB3F
        jsr     LFAAD
        bcs     LF6E6
        lda     T0
.if COMPILECOMPUTER < PLUS4_01
        and     #$0F
.fi
        beq     LF6A7
        cmp     #$03
        beq     LF6A7
        sta     FA
        jsr     LFAAD
        bcs     LF6E6
        jsr     LFB5B
        jsr     LFAAD
        bcs     LF6A7
        jsr     LFB3A
        ldx     T0
        ldy     $F2
        lda     CMPFLG
        cmp     #$53
        bne     LF6A7
        lda     #$00
        sta     SA
        lda     #$A1
        jsr     kSAVE
LF6E3:  jmp     LF495

LF6E6:  lda     CMPFLG
        cmp     #$56
        beq     LF6F3
        cmp     #$4C
        bne     LF6A7
        lda     #$00
LF6F3:  jsr     kLOAD
        lda     STATUS
        and     #$10
        beq     LF6E3
        lda     CMPFLG
        cmp     #$4C
        beq     LF6A7
        ldx     #$2A
        jsr     LCF66
        bmi     LF6E3
LF70A:  jsr     LFBA0
        bcs     LF6A7
        jsr     LFAAD
        bcs     LF6A7
        ldy     #$00
LF716:  lda     T0
        sta     (T2),y
        jsr     LFB94
        jsr     LFB86
        bcs     LF716
        bcc     LF6E3
LF724:  bcs     LF72E
        jsr     LFB5B
        jsr     LFAAD
        bcc     LF734
LF72E:  lda     #$14
        sta     T0
        bne     LF737
LF734:  jsr     LFB64
LF737:  jsr     LFB3A
        jsr     kSTOP
        beq     LF6E3
        jsr     LF752
        inc     LENGTH
        lda     LENGTH
        jsr     LFB96
        lda     LENGTH
        jsr     LFB74
        bcs     LF737
        bcc     LF6E3
LF752:  lda     #$2E
        jsr     kCHROUT
        jsr     LFB08
LF75A:  jsr     LFAFB
        jsr     LFB08
        ldy     #$00
        jsr     LCF96
        jsr     LF7D4
        pha
        ldx     LENGTH
        inx
LF76C:  dex
        bpl     LF77A
        jsr     LFBD8
        .TEXT   "   "
        .byte   $00
        jmp     LF780

        nop
LF77A:  jsr     LCF96
        jsr     LFB05
LF780:  iny
        cpy     #$03
        bcc     LF76C
        pla
        ldx     #$03
        jsr     LF81B
        ldx     #$06
LF78D:  cpx     #$03
        bne     LF7A5
        ldy     LENGTH
        beq     LF7A5
LF795:  lda     FORMAT
        cmp     #$E8
        jsr     LCF96
        bcs     LF7BC
        jsr     LFB10
        dey
        bne     LF795
LF7A5:  asl     FORMAT
        bcc     LF7B8
        lda     LF88E,x
        jsr     kCHROUT
        lda     LF894,x
        beq     LF7B8
        jsr     kCHROUT
LF7B8:  dex
        bne     LF78D
        rts

LF7BC:  jsr     LF7C8
        clc
        adc     #$01
        bne     LF7C5
        inx
LF7C5:  jmp     LFAFF

LF7C8:  ldx     $A2
        tay
        bpl     LF7CE
        dex
LF7CE:  adc     T2
        bcc     LF7D3
        inx
LF7D3:  rts

LF7D4:  tay
        lsr     a
        bcc     LF7E3
        lsr     a
        bcs     LF7F2
        cmp     #$22
        beq     LF7F2
        and     #$07
        ora     #$80
LF7E3:  lsr     a
        tax
        lda     LF83D,x
        bcs     LF7EE
        lsr     a
        lsr     a
        lsr     a
        lsr     a
LF7EE:  and     #$0F
        bne     LF7F6
LF7F2:  ldy     #$80
        lda     #$00
LF7F6:  tax
        lda     LF881,x
        sta     FORMAT
        and     #$03
        sta     LENGTH
        tya
        and     #$8F
        tax
        tya
        ldy     #$03
        cpx     #$8A
        beq     LF817
LF80C:  lsr     a
        bcc     LF817
        lsr     a
LF810:  lsr     a
        ora     #$20
        dey
        bne     LF810
        iny
LF817:  dey
        bne     LF80C
        rts

LF81B:  tay
        lda     LF89B,y
        sta     T1
        lda     LF8DB,y
        sta     $A0
LF826:  lda     #$00
        ldy     #$05
LF82A:  asl     $A0
        rol     T1
        rol     a
        dey
        bne     LF82A
        adc     #$3F
        jsr     kCHROUT
        dex
        bne     LF826
        jmp     LFB08

LF83D:  .TEXT   "@"
        .byte   $02
        .TEXT   "E"
        .byte   $03,$D0,$08
        .TEXT   "@"
        .byte   $09
        .TEXT   "0"
        .byte   $22
        .TEXT   "E3"
        .byte   $D0,$08
        .TEXT   "@"
        .byte   $09
        .TEXT   "@"
        .byte   $02
        .TEXT   "E3"
        .byte   $D0,$08
        .TEXT   "@"
        .byte   $09
        .TEXT   "@"
        .byte   $02
        .TEXT   "E"
        .byte   $B3,$D0,$08
        .TEXT   "@"
        .byte   $09,$00,$22
        .TEXT   "D3"
        .byte   $D0,$8C
        .TEXT   "D"
        .byte   $00,$11,$22
        .TEXT   "D3"
        .byte   $D0,$8C
        .TEXT   "D"
        .byte   $9A,$10,$22
        .TEXT   "D3"
        .byte   $D0,$08
        .TEXT   "@"
        .byte   $09,$10,$22
        .TEXT   "D3"
        .byte   $D0,$08
        .TEXT   "@"
        .byte   $09
        .TEXT   "b"
        .byte   $13
        .TEXT   "x"
        .byte   $A9
LF881:  .byte   $00
        .TEXT   "!"
        .byte   $81,$82,$00,$00
        .TEXT   "YM"
        .byte   $91,$92,$86
        .TEXT   "J"
        .byte   $85
LF88E:  .byte   $9D
        .TEXT   ",),#("
LF894:  .TEXT   "$Y"
        .byte   $00
        .TEXT   "X$$"
        .byte   $00
LF89B:  .byte   $1C,$8A,$1C
        .TEXT   "#]"
        .byte   $8B,$1B,$A1,$9D,$8A,$1D
        .TEXT   "#"
        .byte   $9D,$8B,$1D,$A1,$00
        .TEXT   ")"
        .byte   $19,$AE
        .TEXT   "i"
        .byte   $A8,$19
        .TEXT   "#$S"
        .byte   $1B
        .TEXT   "#$S"
        .byte   $19,$A1,$00,$1A
        .TEXT   "[["
        .byte   $A5
        .TEXT   "i$$"
        .byte   $AE,$AE,$A8,$AD
        .TEXT   ")"
        .byte   $00
        .TEXT   "|"
        .byte   $00,$15,$9C
        .TEXT   "m"
        .byte   $9C,$A5
        .TEXT   "i)S"
        .byte   $84,$13
        .TEXT   "4"
        .byte   $11,$A5
        .TEXT   "i#"
        .byte   $A0
LF8DB:  .byte   $D8
        .TEXT   "bZH&b"
        .byte   $94,$88
        .TEXT   "TD"
        .byte   $C8
        .TEXT   "ThD"
        .byte   $E8,$94,$00,$B4,$08,$84
        .TEXT   "t"
        .byte   $B4
        .TEXT   "(nt"
        .byte   $F4,$CC
        .TEXT   "Jr"
        .byte   $F2,$A4,$8A,$00,$AA,$A2,$A2
        .TEXT   "tttrDh"
        .byte   $B2
        .TEXT   "2"
        .byte   $B2,$00,$22,$00,$1A,$1A
        .TEXT   "&&rr"
        .byte   $88,$C8,$C4,$CA
        .TEXT   "&HDD"
        .byte   $A2,$C8,$0D
        .TEXT   "   "
LF91F:  bcc     LF924
        jmp     LF492

LF924:  jsr     LFB5B
LF927:  ldx     #$00
        stx     $78
LF92B:  jsr     LFB3F
        bne     LF937
        cpx     #$00
        bne     LF937
        jmp     LF495

LF937:  cmp     #$20
        beq     LF927
        sta     MSAL,x
        inx
        cpx     #$03
        bne     LF92B
LF943:  dex
        bmi     LF958
        lda     MSAL,x
        sec
        sbc     #$3F
        ldy     #$05
LF94E:  lsr     a
        ror     $78
        ror     $77
        dey
        bne     LF94E
        beq     LF943
LF958:  ldx     #$02
LF95A:  jsr     LFB3F
        beq     LF97D
        cmp     #$20
        beq     LF95A
        jsr     LFA7D
        bcs     LF976
        jsr     LFA8B
        ldy     T0
        sty     $F2
        sta     T0
        lda     #$30
        sta     $77,x
        inx
LF976:  sta     $77,x
        inx
.if COMPILECOMPUTER >= PLUS4_03
        cpx     #$0A
.else
        cpx     #$1E
.fi
        bcc     LF95A
LF97D:  stx     T1
        ldx     #$00
        stx     WRAP
LF984:  ldx     #$00
        stx     TMPC
        lda     WRAP
        jsr     LF7D4
        ldx     FORMAT
        stx     $A0
        tax
        lda     LF8DB,x
        jsr     LFA5E
        lda     LF89B,x
        jsr     LFA5E
        ldx     #$06
LF9A3:  cpx     #$03
        bne     LF9BA
        ldy     LENGTH
        beq     LF9BA
LF9AB:  lda     FORMAT
        cmp     #$E8
        lda     #$30
        bcs     LF9D2
        jsr     LFA5B
        dey
        bne     LF9AB
LF9BA:  asl     FORMAT
        bcc     LF9CD
        lda     LF88E,x
        jsr     LFA5E
        lda     LF894,x
        beq     LF9CD
        jsr     LFA5E
LF9CD:  dex
        bne     LF9A3
        beq     LF9D8
LF9D2:  jsr     LFA5B
        jsr     LFA5B
LF9D8:  lda     T1
        cmp     TMPC
        beq     LF9E2
        jmp     LFA6A

LF9E2:  ldy     LENGTH
        beq     LFA1A
        lda     $A0
        cmp     #$9D
        bne     LFA12
        lda     T0
        sbc     T2
        sta     DIFF
        lda     $F2
        sbc     $A2
        bcc     LFA02
        bne     LFA72
        ldx     DIFF
        bmi     LFA72
        bpl     LFA0B
LFA02:  tay
        iny
        bne     LFA72
        ldx     DIFF
        bpl     LFA72
LFA0B:  dex
        dex
        txa
        ldy     LENGTH
        bne     LFA15
LFA12:  lda     STPFLG,y
LFA15:  sta     (T2),y
        dey
        bne     LFA12
LFA1A:  lda     WRAP
        sta     (T2),y
        jsr     LFB35
        ldx     #$28
        jsr     LCF66
        jsr     LF75A
        inc     LENGTH
        lda     LENGTH
        jsr     LFB96
        lda     #$41
        sta     KEYD
        lda     #$20
        sta     $0528
        sta     $052D
        lda     $A2
        jsr     LFB20
        sta     $0529
        stx     $052A
        lda     T2
        jsr     LFB20
        sta     $052B
        stx     $052C
        lda     #$07
        sta     NDX
        jmp     LF495

LFA5B:  jsr     LFA5E
LFA5E:  stx     SXREG
        ldx     TMPC
        cmp     $77,x
        beq     LFA75
        pla
        pla
LFA6A:  inc     WRAP
        beq     LFA72
        jmp     LF984

LFA72:  jmp     LF492

LFA75:  inx
        stx     TMPC
        ldx     SXREG
        rts

LFA7D:  cmp     #$41
        bcc     LFA84
        cmp     #$47
        rts

LFA84:  cmp     #$30
        bcc     LFA9E
        cmp     #$3A
        rts

LFA8B:  jsr     LFAA0
        asl     a
        asl     a
        asl     a
        asl     a
        sta     BAD
        jsr     LFB3F
        jsr     LFAA0
        ora     BAD
LFA9E:  sec
        rts

LFAA0:  cmp     #$3A
        php
        and     #$0F
        plp
        bcc     LFAAA
        adc     #$08
LFAAA:  rts

LFAAB:  dec     CHRPTR
LFAAD:  lda     #$00
        sta     T0
        sta     $F2
        sta     SYREG
LFAB6:  jsr     LFB3F
        beq     LFAF5
        cmp     #$20
        beq     LFAB6
LFABF:  cmp     #$20
        beq     LFAF1
        cmp     #$2C
        beq     LFAF1
        cmp     #$30
        bcc     LFAF6
        cmp     #$47
        bcs     LFAF6
        cmp     #$3A
        bcc     LFAD9
        cmp     #$41
        bcc     LFAF6
        sbc     #$08
LFAD9:  sbc     #$2F
        asl     a
        asl     a
        asl     a
        asl     a
        ldx     #$04
LFAE1:  asl     a
        rol     T0
        rol     $F2
        dex
        bne     LFAE1
        inc     SYREG
        jsr     LFB3F
        bne     LFABF
LFAF1:  lda     SYREG
        clc
LFAF5:  rts

LFAF6:  pla
        pla
        jmp     LF492

LFAFB:  lda     T2
        ldx     $A2
LFAFF:  pha
        txa
        jsr     LFB10
        pla
LFB05:  jsr     LFB10
LFB08:  lda     #$20
        .byte   $2C
LFB0B:  lda     #$3F
        jmp     kCHROUT

LFB10:  stx     SXREG
        jsr     LFB20
        jsr     kCHROUT
        txa
        ldx     SXREG
        jmp     kCHROUT

LFB20:  pha
        jsr     LFB2A
        tax
        pla
        lsr     a
        lsr     a
        lsr     a
        lsr     a
LFB2A:  and     #$0F
        cmp     #$0A
        bcc     LFB32
        adc     #$06
LFB32:  adc     #$30
        rts

LFB35:  lda     #$91
        jsr     kCHROUT
LFB3A:  lda     #$0D
        jmp     kCHROUT

LFB3F:  stx     SXREG
        ldx     CHRPTR
        cpx     BUFEND
        bcs     LFB57
        lda     BUF,x
        cmp     #$3A
        beq     LFB57
        inc     CHRPTR
LFB51:  php
        ldx     SXREG
        plp
        rts

LFB57:  lda     #$00
        beq     LFB51
LFB5B:  lda     T0
        sta     T2
        lda     $F2
        sta     $A2
        rts

LFB64:  sec
        lda     T0
        sbc     T2
        sta     T0
        lda     $F2
        sbc     $A2
        sta     $F2
        rts

LFB72:  lda     #$01
LFB74:  sta     SXREG
        sec
        lda     T0
        sbc     SXREG
        sta     T0
        lda     $F2
        sbc     #$00
        sta     $F2
        rts

LFB86:  sec
        lda     T1
        sbc     #$01
        sta     T1
        lda     $A0
        sbc     #$00
        sta     $A0
        rts

LFB94:  lda     #$01
LFB96:  clc
        adc     T2
        sta     T2
        bcc     LFB9F
        inc     $A2
LFB9F:  rts

LFBA0:  bcs     LFBB6
        jsr     LFB5B
        jsr     LFAAD
        bcs     LFBB6
        jsr     LFB64
        lda     T0
        sta     T1
        lda     $F2
        sta     $A0
        clc
LFBB6:  rts

LFBB7:  sta     SAVEA
LFBBA:  stx     $0112
        sty     SAVEY
        rts

LFBC1:  lda     SAVEA
LFBC4:  ldx     $0112
        ldy     SAVEY
        rts

LFBCB:  stx     XSTOP
        jsr     LCF11
        ldx     XSTOP
        eor     #$80
        asl     a
        lda     #$00
        rts

LFBD8:  pha
        tya
        pha
        txa
        pha
        tsx
        inx
        inx
        inx
        inx
        lda     FBUFFER,x
        sta     IMPARM
        inx
        lda     FBUFFER,x
        sta     $BD
        inc     IMPARM
        bne     LFBF3
        inc     $BD
LFBF3:  ldy     #$00
LFBF5:  lda     (IMPARM),y
        beq     LFBFF
        jsr     kCHROUT
        iny
        bne     LFBF5
LFBFF:  tya
        tsx
        inx
        inx
        inx
        inx
        clc
        adc     IMPARM
        sta     FBUFFER,x
        lda     #$00
        adc     $BD
        inx
        sta     FBUFFER,x
        pla
        tax
        pla
        tay
        pla
        rts

iIOBASE:ldx     #<ACIA
        ldy     #>ACIA
        rts

LFC1E:  ldx     #$03
        stx     RSAV
        lda     #$00
LFC24:  sta     PAT,x
        dex
        bpl     LFC24
LFC2A:  ldx     RSAV
        lda     LFC7B,x
        tax
        sta     LFDD0,x
        ldy     #$02
LFC35:  lda     L8007,y
        cmp     LFC56,y
        bne     LFC51
        dey
        bpl     LFC35
        lda     L8006
        ldx     RSAV
        sta     PAT,x
        cmp     #$01
        bne     LFC51
        stx     CURBNK
        jsr     L8000
LFC51:  dec     RSAV
        bpl     LFC2A
        rts

LFC56:  .TEXT   "CBM"
LFC59:  sei
        ldx     #$03
LFC5C:  lda     PAT,x
        beq     LFC71
        txa
        pha
        lda     LFC7B,x
        tax
        sta     LFDD0,x
        stx     CURBNK
        jsr     L8000
        pla
        tax
LFC71:  dex
        bne     LFC5C
        sta     LFDD0
        stx     CURBNK
        cli
        rts

LFC7B:  .byte   $00,$05,$0A,$0F
LFC7F:  sta     LFDD0,x
        tax
        lda     (FETPTR),y
        sta     LFDD0,x
        rts

LFC89:  pha
        stx     CURBNK
        sta     LFDD0,x
        ldx     FETXRG
        lda     FETSRG
        pha
        lda     FETARG
        plp
        jsr     LFCB0
        sta     FETARG
        php
        pla
        sta     FETSRG
        stx     FETXRG
        pla
        sta     CURBNK
        tax
        sta     LFDD0,x
        rts

LFCB0:  jmp     (LNGJMP)

IRQ:    pha
        txa
        pha
        tya
        pha
LFCB8:  sta     LFDD0
        jmp     LCE00

LFCBE:  ldx     CURBNK
        sta     LFDD0,x
        pla
        tay
        pla
        tax
        pla
        rti

LFCC9:  ldx     CURBNK
        sta     LFDD0,x
        jmp     (BNKVEC)

.if COMPILECOMPUTER == PLUS4_01
        .byte   $1E,$B0,$6F,$E0,$0F,$F1,$4F,$F0
        .byte   $0F,$D0,$0F,$30,$0F,$B0,$0F,$82
        .byte   $3F,$32,$FB,$D6,$FD,$85,$FD,$38
        .byte   $EF,$0D,$B7,$0D,$DB,$42,$3D,$0F
.elseif COMPILECOMPUTER = PLUS4_BETA_0203 .OR COMPILECOMPUTER = PLUS4_BETA_0119
        .byte   $FE,$39,$F5,$EF,$77,$B5,$4A,$85
        .byte   $4F,$41,$2E,$1A,$F6,$30,$4F,$86
        .byte   $1F,$3B,$7B,$D6,$FC,$A5,$5D,$38
        .byte   $6E,$CD,$97,$2D,$5B,$53,$1D,$54
.fi

;        FillUntil $FCF1,$FF
        .fill $FCF1-*,$FF

        jmp     LFCC9

LFCF4:  jmp     LFC59

        jmp     LFC7F

        jmp     LFC89

        jmp     LFCB8

ACIA:   .byte   FILLER_FD00
LFD01:  .byte   FILLER_FD00
LFD02:  .byte   FILLER_FD00
LFD03:  .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
SPI6529:.byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
LFD20:  .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
LFD30:  .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
LFDD0:  .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
LFEC0:  .byte   FILLER_FD00
LFEC1:  .byte   FILLER_FD00
LFEC2:  .byte   FILLER_FD00
LFEC3:  .byte   FILLER_FD00
LFEC4:  .byte   FILLER_FD00
LFEC5:  .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00
LFEF0:  .byte   FILLER_FD00
LFEF1:  .byte   FILLER_FD00
LFEF2:  .byte   FILLER_FD00
LFEF3:  .byte   FILLER_FD00
LFEF4:  .byte   FILLER_FD00
LFEF5:  .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00
TEDT1RL:.byte   FILLER_FD00
TEDT1RH:.byte   FILLER_FD00
TEDT2L: .byte   FILLER_FD00
TEDT2H: .byte   FILLER_FD00
TEDT3L: .byte   FILLER_FD00
TEDT3H: .byte   FILLER_FD00
TEDVSP: .byte   FILLER_FD00
TEDHSP: .byte   FILLER_FD00
TEDKEYB:.byte   FILLER_FD00
TEDIFR: .byte   FILLER_FD00
TEDIER: .byte   FILLER_FD00
TEDRASTER:
        .byte   FILLER_FD00
TEDCRSRPOSHI:
        .byte   FILLER_FD00
TEDCRSRPOSLO:
        .byte   FILLER_FD00
TEDFREQV1LO:
        .byte   FILLER_FD00
TEDFREQV2LO:
        .byte   FILLER_FD00
TEDFREQV2HI:
        .byte   FILLER_FD00
TEDVOL: .byte   FILLER_FD00
TEDFREQV1HI:
        .byte   FILLER_FD00
TEDROMSTATUS:
        .byte   FILLER_FD00
TEDVIDEORAM:
        .byte   FILLER_FD00
TEDCOLBG0:
        .byte   FILLER_FD00
TEDCOLBG1:
        .byte   FILLER_FD00
TEDCOLBG2:
        .byte   FILLER_FD00
TEDCOLBG3:
        .byte   FILLER_FD00
TEDCOLFRAME:
        .byte   FILLER_FD00
TEDBMRHI:
        .byte   FILLER_FD00
TEDBMRLO:
        .byte   FILLER_FD00
TEDRASTERROWHi:
        .byte   FILLER_FD00
TEDRASTERROWLO:
        .byte   FILLER_FD00
TEDRASTERCOL:
        .byte   FILLER_FD00
TEDVERTSUBADDRESS:
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
        .byte   FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00,FILLER_FD00
TEDRAMSEL:
        .byte   FILLER_FD00
TEDROMSEL:
        .byte   FILLER_FD00

        .byte   FILLER_FF40

LFF41:

.if COMPILECOMPUTER == PLUS4_BETA_0203 || COMPILECOMPUTER = PLUS4_BETA_0119
        .byte   $5C,$D0,$C5,$9B,$B2,$F8,$DB,$00
.elsif COMPILECOMPUTER == PLUS4_01
        .byte   $5F,$D0,$8D,$99,$1A,$A0,$DB,$00
.fi

;        FillUntil $FF49,$FF
        .fill $FF49-*,$FF
kDEFFNKEY:
        jmp     LB7C2

kPRINT: jmp     LDC49

LFF4F:  jmp     LFBD8

kMLMONITOR:
        jmp     LF445

.if COMPILECOMPUTER == PLUS4_BETA_0203 || COMPILECOMPUTER == PLUS4_BETA_0119
        .byte   $68,$77,$07,$C8,$C7,$25,$7E,$6F
        .byte   $BE,$B0,$4E,$B7,$D8,$1C,$2D,$18
        .byte   $DF,$73,$F7,$20,$77,$84,$64,$D8
        .byte   $7B,$30,$E3,$0A,$79,$42,$B3,$AB
        .byte   $3A,$5E,$E2,$3F,$87,$4F,$7C,$36
        .byte   $7D,$A0
.elsif COMPILECOMPUTER == PLUS4_01
        .byte   $2D,$F0,$0F,$F0,$8F,$F0,$2F,$61
        .byte   $2F,$F0,$4F,$A7,$D9,$8C,$AD,$18
        .byte   $DD,$73,$F7,$08,$57,$04,$75,$C8
        .byte   $7B,$62,$E5,$0A,$F8,$03,$F1,$0B
        .byte   $FA,$0E,$F0,$0F,$F1,$4F,$F8,$06
        .byte   $FC,$0C
.fi

;        FillUntil $FF7F,$FF
        .fill $FF7F-*,$FF
        
        .byte   ROM_CHECKSUM,ROM_VERSION

kCINT:  jmp     iCINT

kIOINIT:jmp     iIOINIT

kRAMTAS:jmp     iRAMTAS

kRESTOR:jmp     iRESTOR

kVECTOR:jmp     iVECTOR

kSETMSF:jmp     iSETMSF

kSECOND:jmp     iSECOND

kTKSA:  jmp     iTKSA

kMEMTOP:jmp     iMEMTOP

kMEMBOT:jmp     iMEMBOT

kSCNKEY:jmp     iSCNKEY

kSETTMO:jmp     iSETTMO

kACPTR: jmp     iACPTR

kCIOUT: jmp     iCIOUT

kUNTLK: jmp     iUNTLK

kUNLSN: jmp     iUNLSN

kLISTEN:jmp     iLISTEN

kTALK:  jmp     iTALK

kREADST:jmp     iREADST

kSETLFS:jmp     iSETLFS

kSETNAM:jmp     iSETNAM

kOPEN:  jmp     (lIOPEN)

kCLOSE: jmp     (lICLOSE)

kCHKIN: jmp     (lICHKIN)

kCHKOUT:jmp     (lICHKOUT)

kCLRCHN:jmp     (lICLRCHN)

kCHRIN: jmp     (lICHRIN)

kCHROUT:jmp     (lICHROUT)

kLOAD:  jmp     iLOAD

kSAVE:  jmp     iSAVE

kSETTIM:jmp     iSETTIM

kRDTIM: jmp     iRDTIM

kSTOP:  jmp     (lISTOP)

kGETIN: jmp     (lIGETIN)

kCLALL: jmp     (lICLALL)

kUDTIM: jmp     iUDTIM

kSCREEN:jmp     iSCREEN

kPLOT:  jmp     iPLOT

kIOBASE:jmp     iIOBASE

RESET:  sta     TEDRAMSEL
        jmp     NMI

        .addr   RESET
        .addr   IRQ

