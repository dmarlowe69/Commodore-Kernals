
 * = $A000

;There are two sections: BASIC and KERNAL.

;Commodore 64 BASIC ROM Disassembly
;Version 1.0 (June 1994)


A000   .word $E394   ; RESET


A002   .word $E37B   ; Warm Start



; CBMBASIC

A004   .byte $43,$42,$4D,$42,$41,$53,$49,$43


; address table for commands
; (address minus 1 used)

A00C   .word $A830   ; end
A00E   .word $A741   ; for
A010   .word $AD1D   ; next
A012   .word $A8F7   ; data
A014   .word $ABA4   ; input#
A016   .word $ABBE   ; input
A018   .word $B080   ; dim
A01A   .word $AC05   ; read
A01C   .word $A9A4   ; let
A01E   .word $A89F   ; goto
A020   .word $A870   ; run
A022   .word $A927   ; if
A024   .word $A81C   ; restore
A026   .word $A882   ; gosub
A028   .word $A8D1   ; return
A02A   .word $A93A   ; rem
A02C   .word $A82E   ; stop
A02E   .word $A94A   ; on
A030   .word $B82C   ; wait
A032   .word $E167   ; load
A034   .word $E155   ; save
A036   .word $E164   ; verify
A038   .word $B3B2   ; def
A03A   .word $B823   ; poke
A03C   .word $AA7F   ; print#
A03E   .word $AA9F   ; print
A040   .word $A856   ; cont
A042   .word $A69B   ; list
A044   .word $A65D   ; clr
A046   .word $AA85   ; cmd
A048   .word $E129   ; sys
A04A   .word $E1BD   ; open
A04C   .word $E1C6   ; close
A04E   .word $AB7A   ; get
A050   .word $A641   ; new


; address table for functions

A052   .word $BC39   ; sgn
A054   .word $BCCC   ; int
A056   .word $BC58   ; abs
A058   .word $0310   ; usr
A05A   .word $B37D   ; fre
A05C   .word $B39E   ; pos
A05E   .word $BF71   ; sqr
A060   .word $E097   ; rnd
A062   .word $B9EA   ; log
A064   .word $BFED   ; exp
A066   .word $E264   ; cos
A068   .word $E26B   ; sin
A06A   .word $E2B4   ; tan
A06C   .word $E30E   ; atn
A06E   .word $B80D   ; peek
A070   .word $B77C   ; len
A072   .word $B465   ; str$
A074   .word $B7AD   ; val
A076   .word $B78B   ; asc
A078   .word $B6EC   ; chr$
A07A   .word $B700   ; left$
A07C   .word $B72C   ; right$
A07E   .word $B737   ; mid$


; priority and address table
; for operators
; (address minus 1 used)

A080   .byte $79
A081   .word $B869   ; plus
A083   .byte $79
A084   .word $B852   ; minus
A086   .byte $7B
A087   .word $BA2A   ; multiply
A089   .byte $7B
A08A   .word $BB11   ; divide
A08C   .byte $7F
A08D   .word $BF7A   ; power
A08F   .byte $50
A090   .word $AFE8   ; AND
A092   .byte $46
A093   .word $AFE5   ; OR
A095   .byte $7D
A096   .word $BFB3   ; negative
A098   .byte $5A
A099   .word $AED3   ; NOT
A09B   .byte $64
A09C   .word $B015   ; greater / equal / less


; table of commands
; each ended with a +$80

A09E   .byte $45,$4E,$C4   ; end
A0A1   .byte $46,$4F,$D2   ; for
A0A4   .byte $4E,$45,$58,$D4   ; next
A0A8   .byte $44,$41,$54,$C1   ; data
A0AC   .byte $49,$4E,$50,$55,$54,$A3   ; input#
A0B2   .byte $49,$4E,$50,$55,$D4   ; input
A0B7   .byte $44,$49,$CD   ; dim
A0BA   .byte $52,$45,$41,$C4   ; read
A0BE   .byte $4C,$45,$D4   ; let
A0C1   .byte $47,$4F,$54,$CF   ; goto
A0C5   .byte $52,$55,$CE   ; run
A0C8   .byte $49,$C6   ; if
A0CA   .byte $52,$45,$53,$54,$4F,$52,$C5   ; restore
A0D1   .byte $47,$4F,$53,$55,$C2   ; gosub
A0D6   .byte $52,$45,$54,$55,$52,$CE   ; return
A0DC   .byte $52,$45,$CD   ; rem
A0DF   .byte $53,$54,$4F,$D0   ; stop
A0E3   .byte $4F,$CE   ; on
A0E5   .byte $57,$41,$49,$D4   ; wait
A0E9   .byte $4C,$4F,$41,$C4   ; load
A0ED   .byte $53,$41,$56,$C5   ; save
A0F1   .byte $56,$45,$52,$49,$46,$D9   ; verify
A0F7   .byte $44,$45,$C6   ; def
A0FA   .byte $50,$4F,$4B,$C5   ; poke
A0FE   .byte $50,$52,$49,$4E,$54,$A3   ; print#
A104   .byte $50,$52,$49,$4E,$D4   ; print
A109   .byte $43,$4F,$4E,$D4   ; cont
A10D   .byte $4C,$49,$53,$D4   ; list
A111   .byte $43,$4C,$D2   ; clr
A114   .byte $43,$4D,$C4   ; cmd
A117   .byte $53,$59,$D3   ; sys
A11A   .byte $4F,$50,$45,$CE   ; open
A11E   .byte $43,$4C,$4F,$53,$C5   ; close
A123   .byte $47,$45,$D4   ; get
A126   .byte $4E,$45,$D7   ; new


; table of functions
; each ended with a +$80

A129   .byte $54,$41,$42,$A8   ; tab(
A12D   .byte $54,$CF   ; to
A12F   .byte $46,$CE   ; fn
A131   .byte $53,$50,$43,$A8   ; spc(
A135   .byte $54,$48,$45,$CE   ; then
A139   .byte $4E,$4F,$D4   ; not
A13C   .byte $53,$54,$45,$D0   ; step
A140   .byte $AB   ; plus
A141   .byte $AD   ; minus
A142   .byte $AA   ; multiply
A143   .byte $AF   ; divide
A144   .byte $DE   ; power
A145   .byte $41,$4E,$C4   ; and
A148   .byte $4F,$D2   ; on
A14A   .byte $BE   ; greater
A14B   .byte $BD   ; equal
A14C   .byte $BC   ; less
A14D   .byte $53,$47,$CE   ; sgn
A150   .byte $49,$4E,$D4   ; int
A153   .byte $41,$42,$D3   ; abs
A156   .byte $55,$53,$D2   ; usr
A159   .byte $46,$52,$C5   ; fre
A15C   .byte $50,$4F,$D3   ; pos
A15F   .byte $53,$51,$D2   ; sqr
A162   .byte $52,$4E,$C4   ; rnd
A165   .byte $4C,$4F,$C7   ; log
A168   .byte $45,$58,$D0   ; exp
A16B   .byte $43,$4F,$D3   ; cos
A16E   .byte $53,$49,$CE   ; sin
A171   .byte $54,$41,$CE   ; tan
A174   .byte $41,$54,$CE   ; atn
A177   .byte $50,$45,$45,$CB   ; peek
A17B   .byte $4C,$45,$CE   ; len
A17E   .byte $53,$54,$52,$A4   ; str$
A182   .byte $56,$41,$CC   ; val
A185   .byte $41,$53,$C3   ; asc
A188   .byte $43,$48,$52,$A4   ; chr$
A18C   .byte $4C,$45,$46,$54,$A4   ; left$
A191   .byte $52,$49,$47,$48,$54,$A4   ; right$
A197   .byte $4D,$49,$44,$A4   ; mid$


; other commands

A19B   .byte $47,$CF   ; go
A19D   .byte $00

; table of errors messages
; each ended with a +$80

; too many files

A19E   .byte $54,$4F,$4F
A1A1   .byte $20,$4D,$41,$4E,$59
A1A6   .byte $20,$46,$49,$4C,$45,$D3

; file open

A1AC   .byte $46,$49,$4C,$45
A1B0   .byte $20,$4F,$50,$45,$CE

; file not open

A1B5   .byte $46,$49,$4C,$45
A1B9   .byte $20,$4E,$4F,$54
A1BD   .byte $20,$4F,$50,$45,$CE

; file not found

A1C2   .byte $46,$49,$4C,$45
A1C6   .byte $20,$4E,$4F,$54
A1CA   .byte $20,$46,$4F,$55,$4E,$C4

; device not present

A1D0   .byte $44,$45,$56,$49,$43,$45
A1D6   .byte $20,$4E,$4F,$54
A1DA   .byte $20,$50,$52,$45,$53,$45,$4E,$D4


; not input file
A1E2   .byte $4E,$4F,$54
A1E5   .byte $20,$49,$4E,$50,$55,$54
A1EB   .byte $20,$46,$49,$4C,$C5

; not output file

A1F0   .byte $4E,$4F,$54
A1F3   .byte $20,$4F,$55,$54,$50,$55,$54
A1FA   .byte $20,$46,$49,$4C,$C5

; missisng file name

A1FF   .byte $4D,$49,$53,$53,$49,$4E,$47
A206   .byte $20,$46,$49,$4C,$45
A20B   .byte $20,$4E,$41,$4D,$C5

; illegal device number

A210   .byte $49,$4C,$4C,$45,$47,$41,$4C
A217   .byte $20,$44,$45,$56,$49,$43,$45
A21E   .byte $20,$4E,$55,$4D,$42,$45,$D2

; next without for

A225   .byte $4E,$45,$58,$54
A229   .byte $20,$57,$49,$54,$48,$4F,$55,$54
A231   .byte $20,$46,$4F,$D2

; syntax

A235   .byte $53,$59,$4E,$54,$41,$D8

; return without gosub

A23B   .byte $52,$45,$54,$55,$52,$4E
A241   .byte $20,$57,$49,$54,$48,$4F,$55,$54
A249   .byte $20,$47,$4F,$53,$55,$C2

; out of data

A24F   .byte $4F,$55,$54
A252   .byte $20,$4F,$46
A255   .byte $20,$44,$41,$54,$C1

; illegal quantity

A25A   .byte $49,$4C,$4C,$45,$47,$41,$4C
A261   .byte $20,$51,$55,$41,$4E,$54,$49,$54,$D9

; overflow

A26A   .byte $4F,$56,$45,$52,$46,$4C,$4F,$D7

; out of memory

A272   .byte $4F,$55,$54
A275   .byte $20,$4F,$46
A278   .byte $20,$4D,$45,$4D,$4F,$52,$D9

; undef'd statement

A27F   .byte $55,$4E,$44,$45,$46,$27,$44
A286   .byte $20,$53,$54,$41,$54,$45,$4D,$45,$4E,$D4

; bad subscript

A290   .byte $42,$41,$44
A293   .byte $20,$53,$55,$42,$53,$43,$52,$49,$50,$D4

; redim'd array

A29D   .byte $52,$45,$44,$49,$4D,$27,$44
A2A4   .byte $20,$41,$52,$52,$41,$D9

; division by zero

A2AA   .byte $44,$49,$56,$49,$53,$49,$4F,$4E
A2B2   .byte $20,$42,$59
A2B5   .byte $20,$5A,$45,$52,$CF

; illegal direct

A2BA   .byte $49,$4C,$4C,$45,$47,$41,$4C
A2C1   .byte $20,$44,$49,$52,$45,$43,$D4

; type mismatch

A2C8   .byte $54,$59,$50,$45
A2CC   .byte $20,$4D,$49,$53,$4D,$41,$54,$43,$C8

; string to long

A2D5   .byte $53,$54,$52,$49,$4E,$47
A2DB   .byte $20,$54,$4F,$4F
A2DF   .byte $20,$4C,$4F,$4E,$C7

; file data

A2E4   .byte $46,$49,$4C,$45
A2E8   .byte $20,$44,$41,$54,$C1

; formula too complex

A2ED   .byte $46,$4F,$52,$4D,$55,$4C,$41
A2F4   .byte $20,$54,$4F,$4F
A2F8   .byte $20,$43,$4F,$4D,$50,$4C,$45,$D8

; can't continue

A300   .byte $43,$41,$4E,$27,$54
A305   .byte $20,$43,$4F,$4E,$54,$49,$4E,$55,$C5

; undef'd function

A30E   .byte $55,$4E,$44,$45,$46,$27,$44
A315   .byte $20,$46,$55,$4E,$43,$54,$49,$4F,$CE

; verify

A31E   .byte $56,$45,$52,$49,$46,$D9

; load

A324   .byte $4C,$4F,$41,$C4


; error message address locations

A328   .word $A19E   ; 01 too many files
A32A   .word $A1AC   ; 02 file open
A32C   .word $A1B5   ; 03 file not open
A32E   .word $A1C2   ; 04 file not found
A330   .word $A1D0   ; 05 device not present
A332   .word $A1E2   ; 06 not input file
A334   .word $A1F0   ; 07 not output file
A336   .word $A1FF   ; 08 missing file name
A338   .word $A210   ; 09 illegal device number
A33A   .word $A225   ; 0A next without for
A33C   .word $A235   ; 0B syntax
A33E   .word $A23B   ; 0C return without gosub
A340   .word $A24F   ; 0D out of data
A342   .word $A25A   ; 0E illegal quantity
A344   .word $A26A   ; 0F overflow
A346   .word $A272   ; 10 out of memory
A348   .word $A27F   ; 11 undef'd statment
A34A   .word $A290   ; 12 bad subscript
A34C   .word $A29D   ; 13 redim'd array
A34E   .word $A2AA   ; 14 devision by zero
A350   .word $A2BA   ; 15 illegal direct
A352   .word $A2C8   ; 16 type mismatch
A354   .word $A2D5   ; 17 string too long
A356   .word $A2E4   ; 18 file data
A358   .word $A2ED   ; 19 formula too complex
A35A   .word $A300   ; 1A can't continue
A35C   .word $A30E   ; 1B undef'd function
A35E   .word $A31E   ; 1C verify
A360   .word $A324   ; 1D load
A362   .word $A383   ; 1E break

; other messages

; ok

A364   .byte $0D,$4F,$4B,$0D
A368   .byte $00

; error

A369   .byte $20,$20,$45,$52,$52,$4F,$52
A370   .byte $00

; in

A371   .byte $20,$49,$4E,$20
A375   .byte $00

; ready.

A376   .byte $0D,$0A,$52,$45,$41,$44,$59,$2E,$0D,$0A
A380   .byte $00

; break

A381   .byte $0D,$0A

A383   .byte $42,$52,$45,$41,$4B

A388   .byte $00

A389   .byte $A0


; search for "for" blocks on stack

A38A   TSX
A38B   INX
A38C   INX
A38D   INX
A38E   INX
A38F   LDA $0101,X
A392   CMP #$81   ; for block code
A394   BNE $A3B7
A396   LDA $4A
A398   BNE $A3A4
A39A   LDA $0102,X
A39D   STA $49
A39F   LDA $0103,X
A3A2   STA $4A
A3A4   CMP $0103,X
A3A7   BNE $A3B0
A3A9   LDA $49
A3AB   CMP $0102,X
A3AE   BEQ $A3B7
A3B0   TXA
A3B1   CLC
A3B2   ADC #$12
A3B4   TAX
A3B5   BNE $A38F
A3B7   RTS


; move bytes after check for space

A3B8   JSR $A408
A3BB   STA $31
A3BD   STY $32


; move bytes routine
;  $5F/$60 source start address
;  $5A/$5B source end address
;  $58/$59 destination end address

A3BF   SEC
A3C0   LDA $5A
A3C2   SBC $5F
A3C4   STA $22
A3C6   TAY
A3C7   LDA $5B
A3C9   SBC $60
A3CB   TAX
A3CC   INX
A3CD   TYA
A3CE   BEQ $A3F3
A3D0   LDA $5A
A3D2   SEC
A3D3   SBC $22
A3D5   STA $5A
A3D7   BCS $A3DC
A3D9   DEC $5B
A3DB   SEC
A3DC   LDA $58
A3DE   SBC $22
A3E0   STA $58
A3E2   BCS $A3EC
A3E4   DEC $59
A3E6   BCC $A3EC
A3E8   LDA ($5A),Y
A3EA   STA ($58),Y
A3EC   DEY
A3ED   BNE $A3E8
A3EF   LDA ($5A),Y
A3F1   STA ($58),Y
A3F3   DEC $5B
A3F5   DEC $59
A3F7   DEX
A3F8   BNE $A3EC
A3FA   RTS


; test for 2 * A bytes free on stack

A3FB   ASL
A3FC   ADC #$3E
A3FE   BCS $A435
A400   STA $22
A402   TSX
A403   CPX $22
A405   BCC $A435
A407   RTS


; array area overflow check

A408   CPY $34
A40A   BCC $A434
A40C   BNE $A412
A40E   CMP $33
A410   BCC $A434
A412   PHA
A413   LDX #$09
A415   TYA
A416   PHA
A417   LDA $57,X
A419   DEX
A41A   BPL $A416
A41C   JSR $B526
A41F   LDX #$F7
A421   PLA
A422   STA $61,X
A424   INX
A425   BMI $A421
A427   PLA
A428   TAY
A429   PLA
A42A   CPY $34
A42C   BCC $A434
A42E   BNE $A435
A430   CMP $33
A432   BCS $A435
A434   RTS


; out of memory error

A435   LDX #$10   ; error number


; handle error messages

A437   JMP ($0300)   ; normally A43A


; standard error message handler

A43A   TXA
A43B   ASL
A43C   TAX
A43D   LDA $A326,X
A440   STA $22
A442   LDA $A327,X
A445   STA $23
A447   JSR $FFCC
A44A   LDA #$00
A44C   STA $13
A44E   JSR $AAD7
A451   JSR $AB45
A454   LDY #$00
A456   LDA ($22),Y
A458   PHA
A459   AND #$7F
A45B   JSR $AB47
A45E   INY
A45F   PLA
A460   BPL $A456
A462   JSR $A67A
A465   LDA #$69   ; low  A369
A467   LDY #$A3   ; high A369

A469   JSR $AB1E

A46C   LDY $3A
A46E   INY
A46F   BEQ $A474
A471   JSR $BDC2

A474   LDA #$76   ; low A376

A476   LDY #$A3   ; low A376
A478   JSR $AB1E
A47B   LDA #$80
A47D   JSR $FF90

A480   JMP ($0302)   ; normally A483



; standard warm start routine

A483   JSR $A560
A486   STX $7A
A488   STY $7B
A48A   JSR $0073
A48D   TAX
A48E   BEQ $A480
A490   LDX #$FF
A492   STX $3A
A494   BCC $A49C
A496   JSR $A579
A499   JMP $A7E1


; handle insert/delete basic lines

A49C   JSR $A96B
A49F   JSR $A579
A4A2   STY $0B
A4A4   JSR $A613
A4A7   BCC $A4ED


; delete old line

A4A9   LDY #$01
A4AB   LDA ($5F),Y
A4AD   STA $23
A4AF   LDA $2D
A4B1   STA $22
A4B3   LDA $60
A4B5   STA $25
A4B7   LDA $5F
A4B9   DEY
A4BA   SBC ($5F),Y
A4BC   CLC
A4BD   ADC $2D
A4BF   STA $2D
A4C1   STA $24
A4C3   LDA $2E
A4C5   ADC #$FF
A4C7   STA $2E
A4C9   SBC $60
A4CB   TAX
A4CC   SEC
A4CD   LDA $5F
A4CF   SBC $2D
A4D1   TAY
A4D2   BCS $A4D7
A4D4   INX
A4D5   DEC $25
A4D7   CLC
A4D8   ADC $22
A4DA   BCC $A4DF
A4DC   DEC $23
A4DE   CLC
A4DF   LDA ($22),Y
A4E1   STA ($24),Y
A4E3   INY
A4E4   BNE $A4DF
A4E6   INC $23
A4E8   INC $25
A4EA   DEX
A4EB   BNE $A4DF


; insert new line

A4ED   JSR $A659
A4F0   JSR $A533
A4F3   LDA $0200
A4F6   BEQ $A480
A4F8   CLC
A4F9   LDA $2D
A4FB   STA $5A
A4FD   ADC $0B
A4FF   STA $58
A501   LDY $2E
A503   STY $5B
A505   BCC $A508
A507   INY
A508   STY $59
A50A   JSR $A3B8
A50D   LDA $14
A50F   LDY $15
A511   STA $01FE
A514   STY $01FF
A517   LDA $31
A519   LDY $32
A51B   STA $2D
A51D   STY $2E
A51F   LDY $0B
A521   DEY
A522   LDA $01FC,Y
A525   STA ($5F),Y
A527   DEY
A528   BPL $A522

A52A   JSR $A659

A52D   JSR $A533
A530   JMP $A480


; relink basic program

A533   LDA $2B
A535   LDY $2C
A537   STA $22
A539   STY $23
A53B   CLC
A53C   LDY #$01
A53E   LDA ($22),Y
A540   BEQ $A55F
A542   LDY #$04
A544   INY
A545   LDA ($22),Y
A547   BNE $A544
A549   INY
A54A   TYA
A54B   ADC $22
A54D   TAX
A54E   LDY #$00
A550   STA ($22),Y
A552   LDA $23
A554   ADC #$00
A556   INY
A557   STA ($22),Y
A559   STX $22
A55B   STA $23
A55D   BCC $A53C
A55F   RTS


; get statement into buffer

A560   LDX #$00
A562   JSR $E112
A565   CMP #$0D
A567   BEQ $A576
A569   STA $0200,X
A56C   INX
A56D   CPX #$59
A56F   BCC $A562
A571   LDX #$17   ; error number
A573   JMP $A437
A576   JMP $AACA   ; goto end of line


; crunch tokens

A579   JMP ($0304)   ; normally A57C


; standard token cruncher

A57C   LDX $7A
A57E   LDY #$04
A580   STY $0F
A582   LDA $0200,X
A585   BPL $A58E
A587   CMP #$FF   ; PI
A589   BEQ $A5C9
A58B   INX
A58C   BNE $A582
A58E   CMP #$20   ; space
A590   BEQ $A5C9
A592   STA $08
A594   CMP #$22    ; quote mark
A596   BEQ $A5EE
A598   BIT $0F
A59A   BVS $A5C9
A59C   CMP #$3F   ; question mark
A59E   BNE $A5A4
A5A0   LDA #$99   ; PRINT code
A5A2   BNE $A5C9
A5A4   CMP #$30    ; 0
A5A6   BCC $A5AC
A5A8   CMP #$3C
A5AA   BCC $A5C9
A5AC   STY $71
A5AE   LDY #$00
A5B0   STY $0B
A5B2   DEY
A5B3   STX $7A
A5B5   DEX
A5B6   INY
A5B7   INX
A5B8   LDA $0200,X
A5BB   SEC
A5BC   SBC $A09E,Y
A5BF   BEQ $A5B6
A5C1   CMP #$80
A5C3   BNE $A5F5
A5C5   ORA $0B
A5C7   LDY $71
A5C9   INX
A5CA   INY
A5CB   STA $01FB,Y
A5CE   LDA $01FB,Y
A5D1   BEQ $A609
A5D3   SEC
A5D4   SBC #$3A   ; colon
A5D6   BEQ $A5DC
A5D8   CMP #$49   ; DATA code
A5DA   BNE $A5DE
A5DC   STA $0F
A5DE   SEC
A5DF   SBC #$55   ; REM code
A5E1   BNE $A582
A5E3   STA $08
A5E5   LDA $0200,X
A5E8   BEQ $A5C9
A5EA   CMP $08
A5EC   BEQ $A5C9
A5EE   INY
A5EF   STA $01FB,Y
A5F2   INX
A5F3   BNE $A5E5
A5F5   LDX $7A
A5F7   INC $0B
A5F9   INY
A5FA   LDA $A09D,Y
A5FD   BPL $A5F9
A5FF   LDA $A09E,Y
A602   BNE $A5B8
A604   LDA $0200,X
A607   BPL $A5C7
A609   STA $01FD,Y
A60C   DEC $7B
A60E   LDA #$FF
A610   STA $7A
A612   RTS


; search for a line in a program

A613   LDA $2B
A615   LDX $2C

A617   LDY #$01

A619   STA $5F
A61B   STX $60
A61D   LDA ($5F),Y
A61F   BEQ $A640
A621   INY
A622   INY
A623   LDA $15
A625   CMP ($5F),Y
A627   BCC $A641
A629   BEQ $A62E
A62B   DEY
A62C   BNE $A637
A62E   LDA $14
A630   DEY
A631   CMP ($5F),Y
A633   BCC $A641
A635   BEQ $A641
A637   DEY
A638   LDA ($5F),Y
A63A   TAX
A63B   DEY
A63C   LDA ($5F),Y
A63E   BCS $A617
A640   CLC
A641   RTS


; NEW command

A642   BNE $A641

A644   LDA #$00

A646   TAY
A647   STA ($2B),Y
A649   INY
A64A   STA ($2B),Y
A64C   LDA $2B
A64E   CLC
A64F   ADC #$02
A651   STA $2D
A653   LDA $2C
A655   ADC #$00
A657   STA $2E

A659   JSR $A68E

A65C   LDA #$00


; CLR command

A65E   BNE $A68D

A660   JSR $FFE7


A663   LDA $37

A665   LDY $38
A667   STA $33
A669   STY $34
A66B   LDA $2D
A66D   LDY $2E
A66F   STA $2F
A671   STY $30
A673   STA $31
A675   STY $32

A677   JSR $A81D



; reset stack and program pointers

A67A   LDX #$19
A67C   STX $16
A67E   PLA
A67F   TAY
A680   PLA
A681   LDX #$FA
A683   TXS
A684   PHA
A685   TYA
A686   PHA
A687   LDA #$00
A689   STA $3E
A68B   STA $10
A68D   RTS


; set current character pointer to start of basic - 1

A68E   CLC
A68F   LDA $2B
A691   ADC #$FF
A693   STA $7A
A695   LDA $2C
A697   ADC #$FF
A699   STA $7B
A69B   RTS


; LIST command

A69C   BCC $A6A4
A69E   BEQ $A6A4
A6A0   CMP #$AB
A6A2   BNE $A68D
A6A4   JSR $A96B
A6A7   JSR $A613
A6AA   JSR $0079
A6AD   BEQ $A6BB
A6AF   CMP #$AB
A6B1   BNE $A641
A6B3   JSR $0073
A6B6   JSR $A96B
A6B9   BNE $A641
A6BB   PLA
A6BC   PLA
A6BD   LDA $14
A6BF   ORA $15
A6C1   BNE $A6C9
A6C3   LDA #$FF
A6C5   STA $14
A6C7   STA $15


; list lines from $5F/$60 to $14/$15

A6C9   LDY #$01
A6CB   STY $0F
A6CD   LDA ($5F),Y
A6CF   BEQ $A714
A6D1   JSR $A82C
A6D4   JSR $AAD7
A6D7   INY
A6D8   LDA ($5F),Y
A6DA   TAX
A6DB   INY
A6DC   LDA ($5F),Y
A6DE   CMP $15
A6E0   BNE $A6E6
A6E2   CPX $14
A6E4   BEQ $A6E8
A6E6   BCS $A714
A6E8   STY $49
A6EA   JSR $BDCD
A6ED   LDA #$20
A6EF   LDY $49
A6F1   AND #$7F
A6F3   JSR $AB47
A6F6   CMP #$22
A6F8   BNE $A700
A6FA   LDA $0F
A6FC   EOR #$FF
A6FE   STA $0F
A700   INY
A701   BEQ $A714
A703   LDA ($5F),Y
A705   BNE $A717
A707   TAY
A708   LDA ($5F),Y
A70A   TAX
A70B   INY
A70C   LDA ($5F),Y
A70E   STX $5F
A710   STA $60
A712   BNE $A6C9
A714   JMP $E386


; print tokens routine

A717   JMP ($0306)   ; normally A71A


; standard token printer

A71A   BPL $A6F3
A71C   CMP #$FF
A71E   BEQ $A6F3
A720   BIT $0F
A722   BMI $A6F3
A724   SEC
A725   SBC #$7F
A727   TAX
A728   STY $49
A72A   LDY #$FF
A72C   DEX
A72D   BEQ $A737
A72F   INY
A730   LDA $A09E,Y
A733   BPL $A72F
A735   BMI $A72C


; print keyword

A737   INY
A738   LDA $A09E,Y
A73B   BMI $A6EF
A73D   JSR $AB47
A740   BNE $A737


; FOR command

A742   LDA #$80
A744   STA $10
A746   JSR $A9A5
A749   JSR $A38A
A74C   BNE $A753
A74E   TXA
A74F   ADC #$0F
A751   TAX
A752   TXS
A753   PLA
A754   PLA
A755   LDA #$09
A757   JSR $A3FB
A75A   JSR $A906
A75D   CLC
A75E   TYA
A75F   ADC $7A
A761   PHA
A762   LDA $7B
A764   ADC #$00
A766   PHA
A767   LDA $3A
A769   PHA
A76A   LDA $39
A76C   PHA
A76D   LDA #$A4
A76F   JSR $AEFF
A772   JSR $AD8D
A775   JSR $AD8A
A778   LDA $66
A77A   ORA #$7F
A77C   AND $62
A77E   STA $62
A780   LDA #$8B   ; low  A78B
A782   LDY #$A7   ; high A78B
A784   STA $22
A786   STY $23
A788   JMP $AE43


A78B   LDA #$BC   ; low  B9BC

A78D   LDY #$B9   ; high B9BC
A78F   JSR $BBA2
A792   JSR $0079
A795   CMP #$A9
A797   BNE $A79F
A799   JSR $0073
A79C   JSR $AD8A
A79F   JSR $BC2B
A7A2   JSR $AE38
A7A5   LDA $4A
A7A7   PHA
A7A8   LDA $49
A7AA   PHA
A7AB   LDA #$81   ; FOR block code
A7AD   PHA


; execute next statement

A7AE   JSR $A82C
A7B1   LDA $7A
A7B3   LDY $7B
A7B5   CPY #$02
A7B7   NOP
A7B8   BEQ $A7BE
A7BA   STA $3D
A7BC   STY $3E
A7BE   LDY #$00
A7C0   LDA ($7A),Y
A7C2   BNE $A807
A7C4   LDY #$02
A7C6   LDA ($7A),Y
A7C8   CLC
A7C9   BNE $A7CE
A7CB   JMP $A84B

A7CE   INY
A7CF   LDA ($7A),Y
A7D1   STA $39
A7D3   INY
A7D4   LDA ($7A),Y
A7D6   STA $3A
A7D8   TYA
A7D9   ADC $7A
A7DB   STA $7A
A7DD   BCC $A7E1
A7DF   INC $7B

A7E1   JMP ($0308)   ; normally A7E4



; execute a statement

A7E4   JSR $0073
A7E7   JSR $A7ED
A7EA   JMP $A7AE


; execute command in A

A7ED   BEQ $A82B

A7EF   SBC #$80

A7F1   BCC $A804
A7F3   CMP #$23
A7F5   BCS $A80E
A7F7   ASL
A7F8   TAY
A7F9   LDA $A00D,Y
A7FC   PHA
A7FD   LDA $A00C,Y
A800   PHA
A801   JMP $0073

A804   JMP $A9A5

A807   CMP #$3A   ; colon
A809   BEQ $A7E1
A80B   JMP $AF08

A80E   CMP #$4B   ; GO code
A810   BNE $A80B
A812   JSR $0073
A815   LDA #$A4   ; TO code
A817   JSR $AEFF
A81A   JMP $A8A0   ; do GOTO


; RESTORE command

A81D   SEC
A81E   LDA $2B
A820   SBC #$01
A822   LDY $2C
A824   BCS $A827
A826   DEY

A827   STA $41

A829   STY $42
A82B   RTS


A82C   JSR $FFE1   ; test stop key



; STOP command

A82F   BCS $A832


; END command

A831   CLC
A832   BNE $A870
A834   LDA $7A
A836   LDY $7B
A838   LDX $3A
A83A   INX
A83B   BEQ $A849
A83D   STA $3D
A83F   STY $3E
A841   LDA $39
A843   LDY $3A
A845   STA $3B
A847   STY $3C
A849   PLA
A84A   PLA

A84B   LDA #$81   ; low  A381

A84D   LDY #$A3   ; high A381
A84F   BCC $A854
A851   JMP $A469
A854   JMP $E386


; CONT command

A857   BNE $A870
A859   LDX #$1A   ; error number
A85B   LDY $3E
A85D   BNE $A862
A85F   JMP $A437

A862   LDA $3D
A864   STA $7A
A866   STY $7B
A868   LDA $3B
A86A   LDY $3C
A86C   STA $39
A86E   STY $3A
A870   RTS


; RUN command

A871   PHP
A872   LDA #$00
A874   JSR $FF90
A877   PLP
A878   BNE $A87D
A87A   JMP $A659

A87D   JSR $A660   ; do CLR
A880   JMP $A897   ; do GOTO


; GOSUB command

A883   LDA #$03
A885   JSR $A3FB
A888   LDA $7B
A88A   PHA
A88B   LDA $7A
A88D   PHA
A88E   LDA $3A
A890   PHA
A891   LDA $39
A893   PHA
A894   LDA #$8D
A896   PHA

A897   JSR $0079

A89A   JSR $A8A0
A89D   JMP $A7AE


; GOTO command

A8A0   JSR $A96B
A8A3   JSR $A909
A8A6   SEC
A8A7   LDA $39
A8A9   SBC $14
A8AB   LDA $3A
A8AD   SBC $15
A8AF   BCS $A8BC
A8B1   TYA
A8B2   SEC
A8B3   ADC $7A
A8B5   LDX $7B
A8B7   BCC $A8C0
A8B9   INX
A8BA   BCS $A8C0
A8BC   LDA $2B
A8BE   LDX $2C
A8C0   JSR $A617
A8C3   BCC $A8E3
A8C5   LDA $5F
A8C7   SBC #$01
A8C9   STA $7A
A8CB   LDA $60
A8CD   SBC #$00
A8CF   STA $7B
A8D1   RTS


; RETURN command

A8D2   BNE $A8D1
A8D4   LDA #$FF
A8D6   STA $4A
A8D8   JSR $A38A
A8DB   TXS
A8DC   CMP #$8D
A8DE   BEQ $A8EB
A8E0   LDX #$0C
A8E2   .byte $2C
A8E3   LDX #$11
A8E5   JMP $A437

A8E8   JMP $AF08


; remove GOSUB block from stack

A8EB   PLA
A8EC   PLA
A8ED   STA $39
A8EF   PLA
A8F0   STA $3A
A8F2   PLA
A8F3   STA $7A
A8F5   PLA
A8F6   STA $7B


; DATA command

A8F8   JSR $A906

A8FB   TYA

A8FC   CLC
A8FD   ADC $7A
A8FF   STA $7A
A901   BCC $A905
A903   INC $7B
A905   RTS


; get end of statement

A906   LDX #$3A   ; colon
A908   .byte $2C


; get end of line

A909   LDX #$00
A90B   STX $07
A90D   LDY #$00
A90F   STY $08
A911   LDA $08
A913   LDX $07
A915   STA $07
A917   STX $08
A919   LDA ($7A),Y
A91B   BEQ $A905
A91D   CMP $08
A91F   BEQ $A905
A921   INY
A922   CMP #$22   ; quote mark
A924   BNE $A919
A926   BEQ $A911


; IF command

A928   JSR $AD9E
A92B   JSR $0079
A92E   CMP #$89
A930   BEQ $A937
A932   LDA #$A7
A934   JSR $AEFF
A937   LDA $61
A939   BNE $A940


; REM command

A93B   JSR $A909
A93E   BEQ $A8FB


; THEN part of IF

A940   JSR $0079
A943   BCS $A948
A945   JMP $A8A0   ; do GOTO
A948   JMP $A7ED


; ON command

A94B   JSR $B79E
A94E   PHA
A94F   CMP #$8D   ; GOSUB code
A951   BEQ $A957
A953   CMP #$89   ; GOTO code
A955   BNE $A8E8
A957   DEC $65
A959   BNE $A95F
A95B   PLA
A95C   JMP $A7EF
A95F   JSR $0073
A962   JSR $A96B
A965   CMP #$2C   ; comma
A967   BEQ $A957
A969   PLA
A96A   RTS


; get decimal number into $14/$15

A96B   LDX #$00
A96D   STX $14
A96F   STX $15

A971   BCS $A96A

A973   SBC #$2F
A975   STA $07
A977   LDA $15
A979   STA $22
A97B   CMP #$19
A97D   BCS $A953
A97F   LDA $14
A981   ASL   ; times 2
A982   ROL $22
A984   ASL   ; times 2
A985   ROL $22
A987   ADC $14   ; add original
A989   STA $14
A98B   LDA $22
A98D   ADC $15
A98F   STA $15
A991   ASL $14   ; times 2
A993   ROL $15   ; = times 10 overall
A995   LDA $14
A997   ADC $07
A999   STA $14
A99B   BCC $A99F
A99D   INC $15
A99F   JSR $0073
A9A2   JMP $A971


; LET command

A9A5   JSR $B08B
A9A8   STA $49
A9AA   STY $4A
A9AC   LDA #$B2    ; equals code
A9AE   JSR $AEFF
A9B1   LDA $0E
A9B3   PHA
A9B4   LDA $0D
A9B6   PHA
A9B7   JSR $AD9E
A9BA   PLA
A9BB   ROL
A9BC   JSR $AD90
A9BF   BNE $A9D9
A9C1   PLA

A9C2   BPL $A9D6



; assign to integer

A9C4   JSR $BC1B
A9C7   JSR $B1BF
A9CA   LDY #$00
A9CC   LDA $64
A9CE   STA ($49),Y
A9D0   INY
A9D1   LDA $65
A9D3   STA ($49),Y
A9D5   RTS


; assign to float

A9D6   JMP $BBD0


; assign to string

A9D9   PLA

A9DA   LDY $4A

A9DC   CPY #$BF
A9DE   BNE $AA2C


; assign to TI$

A9E0   JSR $B6A6
A9E3   CMP #$06   ; length 6
A9E5   BNE $AA24
A9E7   LDY #$00
A9E9   STY $61
A9EB   STY $66
A9ED   STY $71
A9EF   JSR $AA1D
A9F2   JSR $BAE2
A9F5   INC $71
A9F7   LDY $71
A9F9   JSR $AA1D
A9FC   JSR $BC0C
A9FF   TAX
AA00   BEQ $AA07
AA02   INX
AA03   TXA
AA04   JSR $BAED
AA07   LDY $71
AA09   INY
AA0A   CPY #$06
AA0C   BNE $A9ED
AA0E   JSR $BAE2
AA11   JSR $BC9B
AA14   LDX $64
AA16   LDY $63
AA18   LDA $65
AA1A   JMP $FFDB


; add next digit to float accum

AA1D   LDA ($22),Y
AA1F   JSR $0080
AA22   BCC $AA27
AA24   JMP $B248

AA27   SBC #$2F
AA29   JMP $BD7E


; assign to string variable

AA2C   LDY #$02
AA2E   LDA ($64),Y
AA30   CMP $34
AA32   BCC $AA4B
AA34   BNE $AA3D
AA36   DEY
AA37   LDA ($64),Y
AA39   CMP $33
AA3B   BCC $AA4B
AA3D   LDY $65
AA3F   CPY $2E
AA41   BCC $AA4B
AA43   BNE $AA52
AA45   LDA $64
AA47   CMP $2D
AA49   BCS $AA52
AA4B   LDA $64
AA4D   LDY $65
AA4F   JMP $AA68

AA52   LDY #$00
AA54   LDA ($64),Y
AA56   JSR $B475
AA59   LDA $50
AA5B   LDY $51
AA5D   STA $6F
AA5F   STY $70
AA61   JSR $B67A
AA64   LDA #$61   ; low  0061
AA66   LDY #$00   ; high 0061


; move descriptor into variable

AA68   STA $50
AA6A   STY $51
AA6C   JSR $B6DB
AA6F   LDY #$00
AA71   LDA ($50),Y
AA73   STA ($49),Y
AA75   INY
AA76   LDA ($50),Y
AA78   STA ($49),Y
AA7A   INY
AA7B   LDA ($50),Y
AA7D   STA ($49),Y
AA7F   RTS


; PRINT# comand

AA80   JSR $AA86
AA83   JMP $ABB5


; CMD command

AA86   JSR $B79E
AA89   BEQ $AA90
AA8B   LDA #$2C    ; comma
AA8D   JSR $AEFF
AA90   PHP
AA91   STX $13
AA93   JSR $E118
AA96   PLP
AA97   JMP $AAA0   ; do PRINT

AA9A   JSR $AB21
AA9D   JSR $0079


; PRINT command

AAA0   BEQ $AAD7

AAA2   BEQ $AAE7

AAA4   CMP #$A3   ; TAB( code
AAA6   BEQ $AAF8
AAA8   CMP #$A6   ; SPC( code
AAAA   CLC
AAAB   BEQ $AAF8
AAAD   CMP #$2C   ; comma
AAAF   BEQ $AAE8
AAB1   CMP #$3B   ; semi-colon
AAB3   BEQ $AB13
AAB5   JSR $AD9E
AAB8   BIT $0D
AABA   BMI $AA9A
AABC   JSR $BDDD
AABF   JSR $B487
AAC2   JSR $AB21
AAC5   JSR $AB3B
AAC8   BNE $AA9D


; end statement in buffer and screen

AACA   LDA #$00
AACC   STA $0200,X
AACF   LDX #$FF
AAD1   LDY #$01
AAD3   LDA $13
AAD5   BNE $AAE7


; end line on CMD output file

AAD7   LDA #$0D
AAD9   JSR $AB47
AADC   BIT $13
AADE   BPL $AAE5
AAE0   LDA #$0A
AAE2   JSR $AB47

AAE5   EOR #$FF

AAE7   RTS


; routine for printing TAB( and SPC(

AAE8   SEC
AAE9   JSR $FFF0
AAEC   TYA
AAED   SEC
AAEE   SBC #$0A
AAF0   BCS $AAEE
AAF2   EOR #$FF
AAF4   ADC #$01
AAF6   BNE $AB0E
AAF8   PHP
AAF9   SEC
AAFA   JSR $FFF0
AAFD   STY $09
AAFF   JSR $B79B
AB02   CMP #$29   ; )
AB04   BNE $AB5F
AB06   PLP
AB07   BCC $AB0F
AB09   TXA
AB0A   SBC $09
AB0C   BCC $AB13
AB0E   TAX
AB0F   INX
AB10   DEX
AB11   BNE $AB19
AB13   JSR $0073
AB16   JMP $AAA2
AB19   JSR $AB3B
AB1C   BNE $AB10


; print string form AY

AB1E   JSR $B487


; print string from $22/$23

AB21   JSR $B6A6
AB24   TAX
AB25   LDY #$00
AB27   INX

AB28   DEX

AB29   BEQ $AAE7
AB2B   LDA ($22),Y
AB2D   JSR $AB47
AB30   INY
AB31   CMP #$0D
AB33   BNE $AB28
AB35   JSR $AAE5
AB38   JMP $AB28


; print character on CMD output file

AB3B   LDA $13
AB3D   BEQ $AB42
AB3F   LDA #$20   ; space
AB41   .byte $2C
AB42   LDA #$1D   ; csr right
AB44   .byte $2C

AB45   LDA #$3F   ; question mark


AB47   JSR $E10C

AB4A   AND #$FF
AB4C   RTS


; read errors

AB4D   LDA $11
AB4F   BEQ $AB62
AB51   BMI $AB57
AB53   LDY #$FF
AB55   BNE $AB5B
AB57   LDA $3F
AB59   LDY $40
AB5B   STA $39
AB5D   STY $3A
AB5F   JMP $AF08
AB62   LDA $13
AB64   BEQ $AB6B
AB66   LDX #$18
AB68   JMP $A437

AB6B   LDA #$0C   ; low  AD0C
AB6D   LDY #$AD   ; high AD0C
AB6F   JSR $AB1E
AB72   LDA $3D
AB74   LDY $3E
AB76   STA $7A
AB78   STY $7B
AB7A   RTS


; GET command

AB7B   JSR $B3A6
AB7E   CMP #$23   ; #
AB80   BNE $AB92
AB82   JSR $0073
AB85   JSR $B79E
AB88   LDA #$2C   ; comma
AB8A   JSR $AEFF
AB8D   STX $13
AB8F   JSR $E11E
AB92   LDX #$01
AB94   LDY #$02
AB96   LDA #$00
AB98   STA $0201
AB9B   LDA #$40   ; GET code
AB9D   JSR $AC0F
ABA0   LDX $13
ABA2   BNE $ABB7
ABA4   RTS


; INPUT# command

ABA5   JSR $B79E
ABA8   LDA #$2C   ; comma
ABAA   JSR $AEFF
ABAD   STX $13
ABAF   JSR $E11E
ABB2   JSR $ABCE

ABB5   LDA $13

ABB7   JSR $FFCC
ABBA   LDX #$00
ABBC   STX $13
ABBE   RTS


; INPUT command

ABBF   CMP #$22   ; quote mark
ABC1   BNE $ABCE
ABC3   JSR $AEBD
ABC6   LDA #$3B   ; semi-colon
ABC8   JSR $AEFF
ABCB   JSR $AB21

ABCE   JSR $B3A6

ABD1   LDA #$2C   ; comma
ABD3   STA $01FF
ABD6   JSR $ABF9
ABD9   LDA $13
ABDB   BEQ $ABEA
ABDD   JSR $FFB7
ABE0   AND #$02
ABE2   BEQ $ABEA
ABE4   JSR $ABB5
ABE7   JMP $A8F8   ; do DATA

ABEA   LDA $0200
ABED   BNE $AC0D
ABEF   LDA $13
ABF1   BNE $ABD6
ABF3   JSR $A906
ABF6   JMP $A8FB


; get line into input buffer

ABF9   LDA $13
ABFB   BNE $AC03
ABFD   JSR $AB45
AC00   JSR $AB3B
AC03   JMP $A560


; READ command

AC06   LDX $41
AC08   LDY $42
AC0A   LDA #$98   ; READ code
AC0C   .byte $2C
AC0D   LDA #$00

AC0F   STA $11

AC11   STX $43
AC13   STY $44

AC15   JSR $B08B

AC18   STA $49
AC1A   STY $4A
AC1C   LDA $7A
AC1E   LDY $7B
AC20   STA $4B
AC22   STY $4C
AC24   LDX $43
AC26   LDY $44
AC28   STX $7A
AC2A   STY $7B
AC2C   JSR $0079
AC2F   BNE $AC51
AC31   BIT $11
AC33   BVC $AC41
AC35   JSR $E124
AC38   STA $0200
AC3B   LDX #$FF
AC3D   LDY #$01
AC3F   BNE $AC4D
AC41   BMI $ACB8
AC43   LDA $13
AC45   BNE $AC4A
AC47   JSR $AB45
AC4A   JSR $ABF9
AC4D   STX $7A
AC4F   STY $7B

AC51   JSR $0073

AC54   BIT $0D
AC56   BPL $AC89
AC58   BIT $11
AC5A   BVC $AC65
AC5C   INX
AC5D   STX $7A
AC5F   LDA #$00
AC61   STA $07
AC63   BEQ $AC71
AC65   STA $07
AC67   CMP #$22   ; quote mark
AC69   BEQ $AC72
AC6B   LDA #$3A   ; colon
AC6D   STA $07
AC6F   LDA #$2C   ; comma
AC71   CLC
AC72   STA $08
AC74   LDA $7A
AC76   LDY $7B
AC78   ADC #$00
AC7A   BCC $AC7D
AC7C   INY
AC7D   JSR $B48D
AC80   JSR $B7E2
AC83   JSR $A9DA
AC86   JMP $AC91

AC89   JSR $BCF3
AC8C   LDA $0E
AC8E   JSR $A9C2

AC91   JSR $0079

AC94   BEQ $AC9D
AC96   CMP #$2C   ; comma
AC98   BEQ $AC9D
AC9A   JMP $AB4D

AC9D   LDA $7A
AC9F   LDY $7B
ACA1   STA $43
ACA3   STY $44
ACA5   LDA $4B
ACA7   LDY $4C
ACA9   STA $7A
ACAB   STY $7B
ACAD   JSR $0079
ACB0   BEQ $ACDF
ACB2   JSR $AEFD
ACB5   JMP $AC15

ACB8   JSR $A906
ACBB   INY
ACBC   TAX
ACBD   BNE $ACD1
ACBF   LDX #$0D   ; error number
ACC1   INY
ACC2   LDA ($7A),Y
ACC4   BEQ $AD32
ACC6   INY
ACC7   LDA ($7A),Y
ACC9   STA $3F
ACCB   INY
ACCC   LDA ($7A),Y
ACCE   INY
ACCF   STA $40
ACD1   JSR $A8FB
ACD4   JSR $0079
ACD7   TAX
ACD8   CPX #$83   ; DATA code
ACDA   BNE $ACB8
ACDC   JMP $AC51

ACDF   LDA $43
ACE1   LDY $44
ACE3   LDX $11
ACE5   BPL $ACEA
ACE7   JMP $A827

ACEA   LDY #$00
ACEC   LDA ($43),Y
ACEE   BEQ $ACFB
ACF0   LDA $13
ACF2   BNE $ACFB
ACF4   LDA #$FC   ; low  ACFC
ACF6   LDY #$AC   ; high ACFC
ACF8   JMP $AB1E

ACFB   RTS

; messages used dring READ

; ?EXTRA IGNORED

ACFC   .byte $3F,$45,$58,$54,$52,$41
AD02   .byte $20,$49,$47,$4E,$4F,$52,$45,$44
AD0A   .byte $0D,$00

; ?REDO FROM START

AD0C   .byte $3F,$52,$45,$44,$4F
AD11   .byte $20,$46,$52,$4F,$4D
AD16   .byte $20,$53,$54,$41,$52,$54
AD1C   .byte $0D,$00


; NEXT command

AD1E   BNE $AD24
AD20   LDY #$00
AD22   BEQ $AD27

AD24   JSR $B08B

AD27   STA $49
AD29   STY $4A
AD2B   JSR $A38A
AD2E   BEQ $AD35
AD30   LDX #$0A   ; error number
AD32   JMP $A437

AD35   TXS
AD36   TXA
AD37   CLC
AD38   ADC #$04
AD3A   PHA
AD3B   ADC #$06
AD3D   STA $24
AD3F   PLA
AD40   LDY #$01
AD42   JSR $BBA2
AD45   TSX
AD46   LDA $0109,X
AD49   STA $66
AD4B   LDA $49
AD4D   LDY $4A
AD4F   JSR $B867
AD52   JSR $BBD0
AD55   LDY #$01
AD57   JSR $BC5D
AD5A   TSX
AD5B   SEC
AD5C   SBC $0109,X
AD5F   BEQ $AD78
AD61   LDA $010F,X
AD64   STA $39
AD66   LDA $0110,X
AD69   STA $3A
AD6B   LDA $0112,X
AD6E   STA $7A
AD70   LDA $0111,X
AD73   STA $7B

AD75   JMP $A7AE
AD78   TXA
AD79   ADC #$11
AD7B   TAX
AD7C   TXS
AD7D   JSR $0079
AD80   CMP #$2C   ; comma
AD82   BNE $AD75
AD84   JSR $0073
AD87   JSR $AD24


; get next non-string value

AD8A   JSR $AD9E


AD8D   CLC

AD8E   .byte $24


; check value to be string

AD8F   SEC


; check value according to C flag

AD90   BIT $0D
AD92   BMI $AD97
AD94   BCS $AD99
AD96   RTS

AD97   BCS $AD96
AD99   LDX #$16
AD9B   JMP $A437


; evaluate expression

AD9E   LDX $7A
ADA0   BNE $ADA4
ADA2   DEC $7B
ADA4   DEC $7A
ADA6   LDX #$00
ADA8   .byte $24

ADA9   PHA

ADAA   TXA
ADAB   PHA
ADAC   LDA #$01
ADAE   JSR $A3FB
ADB1   JSR $AE83
ADB4   LDA #$00
ADB6   STA $4D

ADB8   JSR $0079


ADBB   SEC

ADBC   SBC #$B1   ; code for greater than
ADBE   BCC $ADD7
ADC0   CMP #$03
ADC2   BCS $ADD7
ADC4   CMP #$01
ADC6   ROL
ADC7   EOR #$01
ADC9   EOR $4D
ADCB   CMP $4D
ADCD   BCC $AE30
ADCF   STA $4D
ADD1   JSR $0073
ADD4   JMP $ADBB

ADD7   LDX $4D
ADD9   BNE $AE07
ADDB   BCS $AE58
ADDD   ADC #$07
ADDF   BCC $AE58
ADE1   ADC $0D
ADE3   BNE $ADE8
ADE5   JMP $B63D

ADE8   ADC #$FF
ADEA   STA $22
ADEC   ASL
ADED   ADC $22
ADEF   TAY
ADF0   PLA
ADF1   CMP $A080,Y
ADF4   BCS $AE5D
ADF6   JSR $AD8D
ADF9   PHA

ADFA   JSR $AE20

ADFD   PLA
ADFE   LDY $4B
AE00   BPL $AE19
AE02   TAX
AE03   BEQ $AE5B
AE05   BNE $AE66
AE07   LSR $0D
AE09   TXA
AE0A   ROL
AE0B   LDX $7A
AE0D   BNE $AE11
AE0F   DEC $7B
AE11   DEC $7A
AE13   LDY #$1B
AE15   STA $4D
AE17   BNE $ADF0
AE19   CMP $A080,Y
AE1C   BCS $AE66
AE1E   BCC $ADF9


; recursive entry for evaluation of expressions

AE20   LDA $A082,Y
AE23   PHA
AE24   LDA $A081,Y
AE27   PHA
AE28   JSR $AE33
AE2B   LDA $4D
AE2D   JMP $ADA9
AE30   JMP $AF08


; save rounded value of left operand

AE33   LDA $66
AE35   LDX $A080,Y

AE38   TAY

AE39   PLA   ; pull return address
AE3A   STA $22
AE3C   INC $22
AE3E   PLA   ; and store in $22/$23
AE3F   STA $23
AE41   TYA
AE42   PHA

AE43   JSR $BC1B

AE46   LDA $65
AE48   PHA
AE49   LDA $64
AE4B   PHA
AE4C   LDA $63
AE4E   PHA
AE4F   LDA $62
AE51   PHA
AE52   LDA $61
AE54   PHA
AE55   JMP ($0022)   ; return to caller


; apply operator

AE58   LDY #$FF
AE5A   PLA
AE5B   BEQ $AE80
AE5D   CMP #$64
AE5F   BEQ $AE64
AE61   JSR $AD8D
AE64   STY $4B
AE66   PLA
AE67   LSR
AE68   STA $12
AE6A   PLA
AE6B   STA $69
AE6D   PLA
AE6E   STA $6A
AE70   PLA
AE71   STA $6B
AE73   PLA
AE74   STA $6C
AE76   PLA
AE77   STA $6D
AE79   PLA
AE7A   STA $6E
AE7C   EOR $66
AE7E   STA $6F
AE80   LDA $61
AE82   RTS


; get arithmetic element routine

AE83   JMP ($030A)   ; normally AE86


; standard arithmetic element

AE86   LDA #$00
AE88   STA $0D
AE8A   JSR $0073
AE8D   BCS $AE92
AE8F   JMP $BCF3

AE92   JSR $B113
AE95   BCC $AE9A
AE97   JMP $AF28

AE9A   CMP #$FF   ; PI
AE9C   BNE $AEAD
AE9E   LDA #$A8   ; low  AEA8
AEA0   LDY #$AE   ; high AEA8
AEA2   JSR $BBA2
AEA5   JMP $0073


; float value of PI

AEA8   .byte $82,$49,$0F,$DA,$A1

AEAD   CMP #$2E   ; decimal point
AEAF   BEQ $AE8F
AEB1   CMP #$AB   ; plus code
AEB3   BEQ $AF0D
AEB5   CMP #$AA   ; times code
AEB7   BEQ $AE8A
AEB9   CMP #$22   ; quote mark
AEBB   BNE $AECC

AEBD   LDA $7A

AEBF   LDY $7B
AEC1   ADC #$00
AEC3   BCC $AEC6
AEC5   INY
AEC6   JSR $B487
AEC9   JMP $B7E2

AECC   CMP #$A8   ; NOT code
AECE   BNE $AEE3
AED0   LDY #$18
AED2   BNE $AF0F


; NOT operator

AED4   JSR $B1BF
AED7   LDA $65
AED9   EOR #$FF
AEDB   TAY
AEDC   LDA $64
AEDE   EOR #$FF
AEE0   JMP $B391


; GET operand

AEE3   CMP #$A5
AEE5   BNE $AEEA
AEE7   JMP $B3F4

AEEA   CMP #$B4    ; SGN code or higher
AEEC   BCC $AEF1
AEEE   JMP $AFA7


AEF1   JSR $AEFA

AEF4   JSR $AD9E


; check and skip characters

AEF7   LDA #$29   ; )
AEF9   .byte $2C

AEFA   LDA #$28   ; (

AEFC   .byte $2C

AEFD   LDA #$2C   ; comma


AEFF   LDY #$00

AF01   CMP ($7A),Y
AF03   BNE $AF08
AF05   JMP $0073


AF08   LDX #$0B   ; error number

AF0A   JMP $A437


; recursive geet value

AF0D   LDY #$15
AF0F   PLA
AF10   PLA
AF11   JMP $ADFA


; check variable pointer range

AF14   SEC
AF15   LDA $64
AF17   SBC #$00
AF19   LDA $65
AF1B   SBC #$A0
AF1D   BCC $AF27
AF1F   LDA #$A2
AF21   SBC $64
AF23   LDA #$E3
AF25   SBC $65
AF27   RTS


; get value of variable

AF28   JSR $B08B
AF2B   STA $64
AF2D   STY $65
AF2F   LDX $45
AF31   LDY $46
AF33   LDA $0D
AF35   BEQ $AF5D
AF37   LDA #$00
AF39   STA $70
AF3B   JSR $AF14
AF3E   BCC $AF5C
AF40   CPX #$54   ; T
AF42   BNE $AF5C
AF44   CPY #$C9   ; I$
AF46   BNE $AF5C
AF48   JSR $AF84
AF4B   STY $5E
AF4D   DEY
AF4E   STY $71
AF50   LDY #$06
AF52   STY $5D
AF54   LDY #$24
AF56   JSR $BE68
AF59   JMP $B46F

AF5C   RTS

AF5D   BIT $0E
AF5F   BPL $AF6E
AF61   LDY #$00
AF63   LDA ($64),Y
AF65   TAX
AF66   INY
AF67   LDA ($64),Y
AF69   TAY
AF6A   TXA
AF6B   JMP $B391

AF6E   JSR $AF14
AF71   BCC $AFA0
AF73   CPX #$54   ; T
AF75   BNE $AF92
AF77   CPY #$49   ; I
AF79   BNE $AFA0
AF7B   JSR $AF84
AF7E   TYA
AF7F   LDX #$A0
AF81   JMP $BC4F


; get time in float accu

AF84   JSR $FFDE
AF87   STX $64
AF89   STY $63
AF8B   STA $65
AF8D   LDY #$00
AF8F   STY $62
AF91   RTS


; continue of get value of variable

AF92   CPX #$53   ; S
AF94   BNE $AFA0
AF96   CPY #$54   ; T
AF98   BNE $AFA0
AF9A   JSR $FFB7
AF9D   JMP $BC3C

AFA0   LDA $64
AFA2   LDY $65
AFA4   JMP $BBA2


; apply function

AFA7   ASL
AFA8   PHA
AFA9   TAX
AFAA   JSR $0073
AFAD   CPX #$8F
AFAF   BCC $AFD1
AFB1   JSR $AEFA
AFB4   JSR $AD9E
AFB7   JSR $AEFD
AFBA   JSR $AD8F
AFBD   PLA
AFBE   TAX
AFBF   LDA $65
AFC1   PHA
AFC2   LDA $64
AFC4   PHA
AFC5   TXA
AFC6   PHA
AFC7   JSR $B79E
AFCA   PLA
AFCB   TAY
AFCC   TXA
AFCD   PHA
AFCE   JMP $AFD6

AFD1   JSR $AEF1
AFD4   PLA
AFD5   TAY

AFD6   LDA $9FEA,Y

AFD9   STA $55
AFDB   LDA $9FEB,Y
AFDE   STA $56
AFE0   JSR $0054
AFE3   JMP $AD8D


; OR operator

AFE6   LDY #$FF
AFE8   .byte $2C


; AND operator

AFE9   LDY #$00
AFEB   STY $0B
AFED   JSR $B1BF
AFF0   LDA $64
AFF2   EOR $0B
AFF4   STA $07
AFF6   LDA $65
AFF8   EOR $0B
AFFA   STA $08
AFFC   JSR $BBFC
AFFF   JSR $B1BF
B002   LDA $65
B004   EOR $0B
B006   AND $08
B008   EOR $0B
B00A   TAY
B00B   LDA $64
B00D   EOR $0B
B00F   AND $07
B011   EOR $0B
B013   JMP $B391


; greater/equal/less operator

B016   JSR $AD90
B019   BCS $B02E
B01B   LDA $6E
B01D   ORA #$7F
B01F   AND $6A
B021   STA $6A
B023   LDA #$69
B025   LDY #$00
B027   JSR $BC5B
B02A   TAX
B02B   JMP $B061

B02E   LDA #$00
B030   STA $0D
B032   DEC $4D
B034   JSR $B6A6
B037   STA $61
B039   STX $62
B03B   STY $63
B03D   LDA $6C
B03F   LDY $6D
B041   JSR $B6AA
B044   STX $6C
B046   STY $6D
B048   TAX
B049   SEC
B04A   SBC $61
B04C   BEQ $B056
B04E   LDA #$01
B050   BCC $B056
B052   LDX $61
B054   LDA #$FF
B056   STA $66
B058   LDY #$FF
B05A   INX
B05B   INY
B05C   DEX
B05D   BNE $B066
B05F   LDX $66

B061   BMI $B072

B063   CLC
B064   BCC $B072
B066   LDA ($6C),Y
B068   CMP ($62),Y
B06A   BEQ $B05B
B06C   LDX #$FF
B06E   BCS $B072
B070   LDX #$01
B072   INX
B073   TXA
B074   ROL
B075   AND $12
B077   BEQ $B07B
B079   LDA #$FF
B07B   JMP $BC3C


; DIM command

B07E   JSR $AEFD

B081   TAX

B082   JSR $B090
B085   JSR $0079
B088   BNE $B07E
B08A   RTS


; get name and pointer to a variable

B08B  LDX #$00
B08D  JSR $0079

B090  STX $0C


B092  STA $45

B094  JSR $0079
B097  JSR $B113
B09A  BCS $B09F
B09C  JMP $AF08

B09F  LDX #$00
B0A1  STX $0D
B0A3  STX $0E
B0A5  JSR $0073
B0A8  BCC $B0AF
B0AA  JSR $B113
B0AD  BCC $B0BA
B0AF  TAX
B0B0  JSR $0073
B0B3  BCC $B0B0
B0B5  JSR $B113
B0B8  BCS $B0B0
B0BA  CMP #$24   ; $
B0BC  BNE $B0C4
B0BE  LDA #$FF
B0C0  STA $0D
B0C2  BNE $B0D4
B0C4  CMP #$25   ; %
B0C6  BNE $B0DB
B0C8  LDA $10
B0CA  BNE $B09C
B0CC  LDA #$80
B0CE  STA $0E
B0D0  ORA $45
B0D2  STA $45
B0D4  TXA
B0D5  ORA #$80
B0D7  TAX
B0D8  JSR $0073
B0DB  STX $46
B0DD  SEC
B0DE  ORA $10
B0E0  SBC #$28    ; (
B0E2  BNE $B0E7
B0E4  JMP $B1D1

B0E7  LDY #$00
B0E9  STY $10
B0EB  LDA $2D
B0ED  LDX $2E
B0EF  STX $60
B0F1  STA $5F
B0F3  CPX $30
B0F5  BNE $B0FB
B0F7  CMP $2F
B0F9  BEQ $B11D
B0FB  LDA $45
B0FD  CMP ($5F),Y
B0FF  BNE $B109
B101  LDA $46
B103  INY
B104  CMP ($5F),Y
B106  BEQ $B185
B108  DEY
B109  CLC
B10A  LDA $5F
B10C  ADC #$07
B10E  BCC $B0F1
B110  INX
B111  BNE $B0EF


; check character in A
; C=1 if alphabetic, C=0 if not

B113   CMP #$41   ; A
B115   BCC $B11C
B117   SBC #$5B   ; Z
B119   SEC
B11A   SBC #$A5
B11C   RTS


; variable not found

B11D   PLA
B11E   PHA
B11F   CMP #$2A
B121   BNE $B128
B123   LDA #$13
B125   LDY #$BF
B127   RTS

B128   LDA $45
B12A   LDY $46
B12C   CMP #$54   ; T
B12E   BNE $B13B
B130   CPY #$C9   ; I$
B132   BEQ $B123
B134   CPY #$49   ; I
B136   BNE $B13B
B138   JMP $AF08

B13B   CMP #$53   ; S
B13D   BNE $B143
B13F   CPY #$54   ; T
B141   BEQ $B138
B143   LDA $2F
B145   LDY $30
B147   STA $5F
B149   STY $60
B14B   LDA $31
B14D   LDY $32
B14F   STA $5A
B151   STY $5B
B153   CLC
B154   ADC #$07
B156   BCC $B159
B158   INY
B159   STA $58
B15B   STY $59
B15D   JSR $A3B8
B160   LDA $58
B162   LDY $59
B164   INY
B165   STA $2F
B167   STY $30
B169   LDY #$00
B16B   LDA $45
B16D   STA ($5F),Y
B16F   INY
B170   LDA $46
B172   STA ($5F),Y
B174   LDA #$00
B176   INY
B177   STA ($5F),Y
B179   INY
B17A   STA ($5F),Y
B17C   INY
B17D   STA ($5F),Y
B17F   INY
B180   STA ($5F),Y
B182   INY
B183   STA ($5F),Y


; variable found

B185   LDA $5F
B187   CLC
B188   ADC #$02
B18A   LDY $60
B18C   BCC $B18F
B18E   INY
B18F   STA $47
B191   STY $48
B193   RTS


; compute pointer to array body

B194   LDA $0B
B196   ASL
B197   ADC #$05
B199   ADC $5F
B19B   LDY $60
B19D   BCC $B1A0
B19F   INY
B1A0   STA $58
B1A2   STY $59
B1A4   RTS


; float number for conversion to integer

B1A5   .byte $90,$80,$00,$00,$00


; routine to convert float to fixed point

B1AA   JSR $B1BF
B1AD   LDA $64
B1AF   LDY $65
B1B1   RTS


; convert value from statement to integer

B1B2   JSR $0073
B1B5   JSR $AD9E

B1B8   JSR $AD8D

B1BB   LDA $66
B1BD   BMI $B1CC


; convert float number to integer

B1BF   LDA $61
B1C1   CMP #$90
B1C3   BCC $B1CE
B1C5   LDA #$A5   ; low  B1A5
B1C7   LDY #$B1   ; high B1A5
B1C9   JSR $BC5B
B1CC   BNE $B248
B1CE   JMP $BC9B


; get pointer to dimensioned variable

B1D1   LDA $0C
B1D3   ORA $0E
B1D5   PHA
B1D6   LDA $0D
B1D8   PHA
B1D9   LDY #$00
B1DB   TYA
B1DC   PHA
B1DD   LDA $46
B1DF   PHA
B1E0   LDA $45
B1E2   PHA
B1E3   JSR $B1B2
B1E6   PLA
B1E7   STA $45
B1E9   PLA
B1EA   STA $46
B1EC   PLA
B1ED   TAY
B1EE   TSX
B1EF   LDA $0102,X
B1F2   PHA
B1F3   LDA $0101,X
B1F6   PHA
B1F7   LDA $64
B1F9   STA $0102,X
B1FC   LDA $65
B1FE   STA $0101,X
B201   INY
B202   JSR $0079
B205   CMP #$2C   ; comma
B207   BEQ $B1DB
B209   STY $0B
B20B   JSR $AEF7
B20E   PLA
B20F   STA $0D
B211   PLA
B212   STA $0E
B214   AND #$7F
B216   STA $0C
B218   LDX $2F
B21A   LDA $30
B21C   STX $5F
B21E   STA $60
B220   CMP $32
B222   BNE $B228
B224   CPX $31
B226   BEQ $B261
B228   LDY #$00
B22A   LDA ($5F),Y
B22C   INY
B22D   CMP $45
B22F   BNE $B237
B231   LDA $46
B233   CMP ($5F),Y
B235   BEQ $B24D
B237   INY
B238   LDA ($5F),Y
B23A   CLC
B23B   ADC $5F
B23D   TAX
B23E   INY
B23F   LDA ($5F),Y
B241   ADC $60
B243   BCC $B21C

B245   LDX #$12   ; error number

B247   .byte $2C

B248   LDX #$0E   ; error number

B24A   JMP $A437

B24D   LDX #$13   ; error number
B24F   LDA $0C
B251   BNE $B24A
B253   JSR $B194
B256   LDA $0B
B258   LDY #$04
B25A   CMP ($5F),Y
B25C   BNE $B245
B25E   JMP $B2EA


; allocate array

B261   JSR $B194
B264   JSR $A408
B267   LDY #$00
B269   STY $72
B26B   LDX #$05
B26D   LDA $45
B26F   STA ($5F),Y
B271   BPL $B274
B273   DEX
B274   INY
B275   LDA $46
B277   STA ($5F),Y
B279   BPL $B27D
B27B   DEX
B27C   DEX
B27D   STX $71
B27F   LDA $0B
B281   INY
B282   INY
B283   INY
B284   STA ($5F),Y
B286   LDX #$0B
B288   LDA #$00
B28A   BIT $0C
B28C   BVC $B296
B28E   PLA
B28F   CLC
B290   ADC #$01
B292   TAX
B293   PLA
B294   ADC #$00
B296   INY
B297   STA ($5F),Y
B299   INY
B29A   TXA
B29B   STA ($5F),Y
B29D   JSR $B34C
B2A0   STX $71
B2A2   STA $72
B2A4   LDY $22
B2A6   DEC $0B
B2A8   BNE $B286
B2AA   ADC $59
B2AC   BCS $B30B
B2AE   STA $59
B2B0   TAY
B2B1   TXA
B2B2   ADC $58
B2B4   BCC $B2B9
B2B6   INY
B2B7   BEQ $B30B
B2B9   JSR $A408
B2BC   STA $31
B2BE   STY $32
B2C0   LDA #$00
B2C2   INC $72
B2C4   LDY $71
B2C6   BEQ $B2CD
B2C8   DEY
B2C9   STA ($58),Y
B2CB   BNE $B2C8
B2CD   DEC $59
B2CF   DEC $72
B2D1   BNE $B2C8
B2D3   INC $59
B2D5   SEC
B2D6   LDA $31
B2D8   SBC $5F
B2DA   LDY #$02
B2DC   STA ($5F),Y
B2DE   LDA $32
B2E0   INY
B2E1   SBC $60
B2E3   STA ($5F),Y
B2E5   LDA $0C
B2E7   BNE $B34B
B2E9   INY


; compute reference to array element

B2EA   LDA ($5F),Y
B2EC   STA $0B
B2EE   LDA #$00
B2F0   STA $71
B2F2   STA $72
B2F4   INY
B2F5   PLA
B2F6   TAX
B2F7   STA $64
B2F9   PLA
B2FA   STA $65
B2FC   CMP ($5F),Y
B2FE   BCC $B30E
B300   BNE $B308
B302   INY
B303   TXA
B304   CMP ($5F),Y
B306   BCC $B30F
B308   JMP $B245

B30B   JMP $A435

B30E   INY
B30F   LDA $72
B311   ORA $71
B313   CLC
B314   BEQ $B320
B316   JSR $B34C
B319   TXA
B31A   ADC $64
B31C   TAX
B31D   TYA
B31E   LDY $22
B320   ADC $65
B322   STX $71
B324   DEC $0B
B326   BNE $B2F2
B328   STA $72
B32A   LDX #$05
B32C   LDA $45
B32E   BPL $B331
B330   DEX
B331   LDA $46
B333   BPL $B337
B335   DEX
B336   DEX
B337   STX $28
B339   LDA #$00
B33B   JSR $B355
B33E   TXA
B33F   ADC $58
B341   STA $47
B343   TYA
B344   ADC $59
B346   STA $48
B348   TAY
B349   LDA $47
B34B   RTS


; XY = XA = length * limit from array data

B34C   STY $22
B34E   LDA ($5F),Y
B350   STA $28
B352   DEY
B353   LDA ($5F),Y

B355   STA $29

B357   LDA #$10
B359   STA $5D
B35B   LDX #$00
B35D   LDY #$00
B35F   TXA
B360   ASL
B361   TAX
B362   TYA
B363   ROL
B364   TAY
B365   BCS $B30B
B367   ASL $71
B369   ROL $72
B36B   BCC $B378
B36D   CLC
B36E   TXA
B36F   ADC $28
B371   TAX
B372   TYA
B373   ADC $29
B375   TAY
B376   BCS $B30B
B378   DEC $5D
B37A   BNE $B35F
B37C   RTS


; FRE function

B37D   LDA $0D
B37F   BEQ $B384
B381   JSR $B6A6
B384   JSR $B526
B387   SEC
B388   LDA $33
B38A   SBC $31
B38C   TAY
B38D   LDA $34
B38F   SBC $32


; routine to convert integer to float

B391   LDX #$00
B393   STX $0D
B395   STA $62
B397   STY $63
B399   LDX #$90
B39B   JMP $BC44


; POS function

B39E   SEC
B39F   JSR $FFF0

B3A2   LDA #$00

B3A4   BEQ $B391


; check for non-direct mode

B3A6   LDX $3A
B3A8   INX
B3A9   BNE $B34B
B3AB   LDX #$15   ; error number
B3AD   .byte $2C
B3AE   LDX #$1B   ; error number
B3B0   JMP $A437


; DEF command

B3B3   JSR $B3E1
B3B6   JSR $B3A6
B3B9   JSR $AEFA
B3BC   LDA #$80
B3BE   STA $10
B3C0   JSR $B08B
B3C3   JSR $AD8D
B3C6   JSR $AEF7
B3C9   LDA #$B2
B3CB   JSR $AEFF
B3CE   PHA
B3CF   LDA $48
B3D1   PHA
B3D2   LDA $47
B3D4   PHA
B3D5   LDA $7B
B3D7   PHA
B3D8   LDA $7A
B3DA   PHA
B3DB   JSR $A8F8
B3DE   JMP $B44F


; get function name

B3E1   LDA #$A5
B3E3   JSR $AEFF
B3E6   ORA #$80
B3E8   STA $10
B3EA   JSR $B092
B3ED   STA $4E
B3EF   STY $4F
B3F1   JMP $AD8D


; expand FN call

B3F4   JSR $B3E1
B3F7   LDA $4F
B3F9   PHA
B3FA   LDA $4E
B3FC   PHA
B3FD   JSR $AEF1
B400   JSR $AD8D
B403   PLA
B404   STA $4E
B406   PLA
B407   STA $4F
B409   LDY #$02
B40B   LDA ($4E),Y
B40D   STA $47
B40F   TAX
B410   INY
B411   LDA ($4E),Y
B413   BEQ $B3AE
B415   STA $48
B417   INY
B418   LDA ($47),Y
B41A   PHA
B41B   DEY
B41C   BPL $B418
B41E   LDY $48
B420   JSR $BBD4
B423   LDA $7B
B425   PHA
B426   LDA $7A
B428   PHA
B429   LDA ($4E),Y
B42B   STA $7A
B42D   INY
B42E   LDA ($4E),Y
B430   STA $7B
B432   LDA $48
B434   PHA
B435   LDA $47
B437   PHA
B438   JSR $AD8A
B43B   PLA
B43C   STA $4E
B43E   PLA
B43F   STA $4F
B441   JSR $0079
B444   BEQ $B449
B446   JMP $AF08

B449   PLA
B44A   STA $7A
B44C   PLA
B44D   STA $7B

B44F   LDY #$00

B451   PLA
B452   STA ($4E),Y
B454   PLA
B455   INY
B456   STA ($4E),Y
B458   PLA
B459   INY
B45A   STA ($4E),Y
B45C   PLA
B45D   INY
B45E   STA ($4E),Y
B460   PLA
B461   INY
B462   STA ($4E),Y
B464   RTS


; STR$ function

B465   JSR $AD8D
B468   LDY #$00
B46A   JSR $BDDF
B46D   PLA
B46E   PLA

B46F   LDA #$FF

B471   LDY #$00
B473   BEQ $B487

B475   LDX $64

B477   LDY $65
B479   STX $50
B47B   STY $51


; allocate area according to A

B47D   JSR $B4F4
B480   STX $62
B482   STY $63
B484   STA $61
B486   RTS


; get description of string into float accu

B487   LDX #$22   ; quote mark
B489   STX $07
B48B   STX $08

B48D   STA $6F

B48F   STY $70
B491   STA $62
B493   STY $63
B495   LDY #$FF
B497   INY
B498   LDA ($6F),Y
B49A   BEQ $B4A8
B49C   CMP $07
B49E   BEQ $B4A4
B4A0   CMP $08
B4A2   BNE $B497
B4A4   CMP #$22   ; quote mark
B4A6   BEQ $B4A9
B4A8   CLC
B4A9   STY $61
B4AB   TYA
B4AC   ADC $6F
B4AE   STA $71
B4B0   LDX $70
B4B2   BCC $B4B5
B4B4   INX
B4B5   STX $72
B4B7   LDA $70
B4B9   BEQ $B4BF
B4BB   CMP #$02
B4BD   BNE $B4CA
B4BF   TYA
B4C0   JSR $B475
B4C3   LDX $6F
B4C5   LDY $70
B4C7   JSR $B688


; save descriptor from $61-$63 on stack

B4CA   LDX $16
B4CC   CPX #$22
B4CE   BNE $B4D5
B4D0   LDX #$19
B4D2   JMP $A437
B4D5   LDA $61
B4D7   STA $00,X
B4D9   LDA $62
B4DB   STA $01,X
B4DD   LDA $63
B4DF   STA $02,X
B4E1   LDY #$00
B4E3   STX $64
B4E5   STY $65
B4E7   STY $70
B4E9   DEY
B4EA   STY $0D
B4EC   STX $17
B4EE   INX
B4EF   INX
B4F0   INX
B4F1   STX $16
B4F3   RTS


; allocate number of bytes in A

B4F4   LSR $0F
B4F6   PHA
B4F7   EOR #$FF
B4F9   SEC
B4FA   ADC $33
B4FC   LDY $34
B4FE   BCS $B501
B500   DEY
B501   CPY $32
B503   BCC $B516
B505   BNE $B50B
B507   CMP $31
B509   BCC $B516
B50B   STA $33
B50D   STY $34
B50F   STA $35
B511   STY $36
B513   TAX
B514   PLA
B515   RTS

B516   LDX #$10
B518   LDA $0F
B51A   BMI $B4D2
B51C   JSR $B526
B51F   LDA #$80
B521   STA $0F
B523   PLA
B524   BNE $B4F6


; string garbage clean up

B526   LDX $37
B528   LDA $38

B52A   STX $33

B52C   STA $34
B52E   LDY #$00
B530   STY $4F
B532   STY $4E
B534   LDA $31
B536   LDX $32
B538   STA $5F
B53A   STX $60
B53C   LDA #$19   ; low  0019
B53E   LDX #$00   ; high 0019
B540   STA $22
B542   STX $23
B544   CMP $16
B546   BEQ $B54D
B548   JSR $B5C7
B54B   BEQ $B544
B54D   LDA #$07
B54F   STA $53
B551   LDA $2D
B553   LDX $2E
B555   STA $22
B557   STX $23
B559   CPX $30
B55B   BNE $B561
B55D   CMP $2F
B55F   BEQ $B566
B561   JSR $B5BD
B564   BEQ $B559
B566   STA $58
B568   STX $59
B56A   LDA #$03
B56C   STA $53
B56E   LDA $58
B570   LDX $59
B572   CPX $32
B574   BNE $B57D
B576   CMP $31
B578   BNE $B57D
B57A   JMP $B606
B57D   STA $22
B57F   STX $23
B581   LDY #$00
B583   LDA ($22),Y
B585   TAX
B586   INY
B587   LDA ($22),Y
B589   PHP
B58A   INY
B58B   LDA ($22),Y
B58D   ADC $58
B58F   STA $58
B591   INY
B592   LDA ($22),Y
B594   ADC $59
B596   STA $59
B598   PLP
B599   BPL $B56E
B59B   TXA
B59C   BMI $B56E
B59E   INY
B59F   LDA ($22),Y
B5A1   LDY #$00
B5A3   ASL
B5A4   ADC #$05
B5A6   ADC $22
B5A8   STA $22
B5AA   BCC $B5AE
B5AC   INC $23
B5AE   LDX $23
B5B0   CPX $59
B5B2   BNE $B5B8
B5B4   CMP $58
B5B6   BEQ $B572
B5B8   JSR $B5C7
B5BB   BEQ $B5B0


; check string area

B5BD   LDA ($22),Y
B5BF   BMI $B5F6
B5C1   INY
B5C2   LDA ($22),Y
B5C4   BPL $B5F6
B5C6   INY


; check string area

B5C7   LDA ($22),Y
B5C9   BEQ $B5F6
B5CB   INY
B5CC   LDA ($22),Y
B5CE   TAX
B5CF   INY
B5D0   LDA ($22),Y
B5D2   CMP $34
B5D4   BCC $B5DC
B5D6   BNE $B5F6
B5D8   CPX $33
B5DA   BCS $B5F6
B5DC   CMP $60
B5DE   BCC $B5F6
B5E0   BNE $B5E6
B5E2   CPX $5F
B5E4   BCC $B5F6
B5E6   STX $5F
B5E8   STA $60
B5EA   LDA $22
B5EC   LDX $23
B5EE   STA $4E
B5F0   STX $4F
B5F2   LDA $53
B5F4   STA $55
B5F6   LDA $53
B5F8   CLC
B5F9   ADC $22
B5FB   STA $22
B5FD   BCC $B601
B5FF   INC $23
B601   LDX $23
B603   LDY #$00
B605   RTS


; continuation of garbage clean up

B606   LDA $4F
B608   ORA $4E
B60A   BEQ $B601
B60C   LDA $55
B60E   AND #$04
B610   LSR
B611   TAY
B612   STA $55
B614   LDA ($4E),Y
B616   ADC $5F
B618   STA $5A
B61A   LDA $60
B61C   ADC #$00
B61E   STA $5B
B620   LDA $33
B622   LDX $34
B624   STA $58
B626   STX $59
B628   JSR $A3BF
B62B   LDY $55
B62D   INY
B62E   LDA $58
B630   STA ($4E),Y
B632   TAX
B633   INC $59
B635   LDA $59
B637   INY
B638   STA ($4E),Y
B63A   JMP $B52A


; joining strings

B63D   LDA $65
B63F   PHA
B640   LDA $64
B642   PHA
B643   JSR $AE83
B646   JSR $AD8F
B649   PLA
B64A   STA $6F
B64C   PLA
B64D   STA $70
B64F   LDY #$00
B651   LDA ($6F),Y
B653   CLC
B654   ADC ($64),Y
B656   BCC $B65D
B658   LDX #$17
B65A   JMP $A437

B65D   JSR $B475
B660   JSR $B67A
B663   LDA $50
B665   LDY $51
B667   JSR $B6AA
B66A   JSR $B68C
B66D   LDA $6F
B66F   LDY $70
B671   JSR $B6AA
B674   JSR $B4CA
B677   JMP $ADB8


; move string

B67A   LDY #$00
B67C   LDA ($6F),Y
B67E   PHA
B67F   INY
B680   LDA ($6F),Y
B682   TAX
B683   INY
B684   LDA ($6F),Y
B686   TAY
B687   PLA


; move string with length A, pointer in XY

B688   STX $22
B68A   STY $23

B68C   TAY

B68D   BEQ $B699
B68F   PHA
B690   DEY
B691   LDA ($22),Y
B693   STA ($35),Y
B695   TYA
B696   BNE $B690
B698   PLA
B699   CLC
B69A   ADC $35
B69C   STA $35
B69E   BCC $B6A2
B6A0   INC $36
B6A2   RTS


; de-allocate temporary string

B6A3   JSR $AD8F

B6A6   LDA $64

B6A8   LDY $65

B6AA   STA $22

B6AC   STY $23
B6AE   JSR $B6DB
B6B1   PHP
B6B2   LDY #$00
B6B4   LDA ($22),Y
B6B6   PHA
B6B7   INY
B6B8   LDA ($22),Y
B6BA   TAX
B6BB   INY
B6BC   LDA ($22),Y
B6BE   TAY
B6BF   PLA
B6C0   PLP
B6C1   BNE $B6D6
B6C3   CPY $34
B6C5   BNE $B6D6
B6C7   CPX $33
B6C9   BNE $B6D6
B6CB   PHA
B6CC   CLC
B6CD   ADC $33
B6CF   STA $33
B6D1   BCC $B6D5
B6D3   INC $34
B6D5   PLA
B6D6   STX $22
B6D8   STY $23
B6DA   RTS


; check descriptor stack

B6DB   CPY $18
B6DD   BNE $B6EB
B6DF   CMP $17
B6E1   BNE $B6EB
B6E3   STA $16
B6E5   SBC #$03
B6E7   STA $17
B6E9   LDY #$00
B6EB   RTS


; CHR$ function

B6EC   JSR $B7A1
B6EF   TXA
B6F0   PHA
B6F1   LDA #$01
B6F3   JSR $B47D
B6F6   PLA
B6F7   LDY #$00
B6F9   STA ($62),Y
B6FB   PLA
B6FC   PLA
B6FD   JMP $B4CA


; LEFT$ function

B700   JSR $B761
B703   CMP ($50),Y
B705   TYA

B706   BCC $B70C

B708   LDA ($50),Y
B70A   TAX
B70B   TYA
B70C   PHA
B70D   TXA
B70E   PHA
B70F   JSR $B47D
B712   LDA $50
B714   LDY $51
B716   JSR $B6AA
B719   PLA
B71A   TAY
B71B   PLA
B71C   CLC
B71D   ADC $22
B71F   STA $22
B721   BCC $B725
B723   INC $23
B725   TYA
B726   JSR $B68C
B729   JMP $B4CA


; RIGHT$ function

B72C   JSR $B761
B72F   CLC
B730   SBC ($50),Y
B732   EOR #$FF
B734   JMP $B706


; MID$ function

B737   LDA #$FF   ; default 3 parameter
B739   STA $65
B73B   JSR $0079
B73E   CMP #$29   ; )
B740   BEQ $B748
B742   JSR $AEFD
B745   JSR $B79E
B748   JSR $B761
B74B   BEQ $B798
B74D   DEX
B74E   TXA
B74F   PHA
B750   CLC
B751   LDX #$00
B753   SBC ($50),Y
B755   BCS $B70D
B757   EOR #$FF
B759   CMP $65
B75B   BCC $B70E
B75D   LDA $65
B75F   BCS $B70E


; get first 2 parameters for
; LEFT$, RIGHT$ and MID$

B761   JSR $AEF7
B764   PLA
B765   TAY
B766   PLA
B767   STA $55
B769   PLA
B76A   PLA
B76B   PLA
B76C   TAX
B76D   PLA
B76E   STA $50
B770   PLA
B771   STA $51
B773   LDA $55
B775   PHA
B776   TYA
B777   PHA
B778   LDY #$00
B77A   TXA
B77B   RTS


; LEN function

B77C   JSR $B782
B77F   JMP $B3A2


B782   JSR $B6A3

B785   LDX #$00
B787   STX $0D
B789   TAY
B78A   RTS


; ASC function

B78B   JSR $B782
B78E   BEQ $B798
B790   LDY #$00
B792   LDA ($22),Y
B794   TAY
B795   JMP $B3A2

B798   JMP $B248


; fetch integer value in X and check range

B79B   JSR $0073

B79E   JSR $AD8A


B7A1   JSR $B1B8

B7A4   LDX $64
B7A6   BNE $B798
B7A8   LDX $65
B7AA   JMP $0079


; VAL function

B7AD   JSR $B782
B7B0   BNE $B7B5
B7B2   JMP $B8F7
B7B5   LDX $7A
B7B7   LDY $7B
B7B9   STX $71
B7BB   STY $72
B7BD   LDX $22
B7BF   STX $7A
B7C1   CLC
B7C2   ADC $22
B7C4   STA $24
B7C6   LDX $23
B7C8   STX $7B
B7CA   BCC $B7CD
B7CC   INX
B7CD   STX $25
B7CF   LDY #$00
B7D1   LDA ($24),Y
B7D3   PHA
B7D4   TYA
B7D5   STA ($24),Y
B7D7   JSR $0079
B7DA   JSR $BCF3
B7DD   PLA
B7DE   LDY #$00
B7E0   STA ($24),Y

B7E2   LDX $71

B7E4   LDY $72
B7E6   STX $7A
B7E8   STY $7B
B7EA   RTS


; get address into $14/$15 and integer in X

B7EB   JSR $AD8A
B7EE   JSR $B7F7

B7F1   JSR $AEFD

B7F4   JMP $B79E


; convert float ti integer in $14/$15

B7F7   LDA $66
B7F9   BMI $B798
B7FB   LDA $61
B7FD   CMP #$91
B7FF   BCS $B798
B801   JSR $BC9B
B804   LDA $64
B806   LDY $65
B808   STY $14
B80A   STA $15
B80C   RTS


; PEEK function

B80D   LDA $15
B80F   PHA
B810   LDA $14
B812   PHA
B813   JSR $B7F7
B816   LDY #$00
B818   LDA ($14),Y
B81A   TAY
B81B   PLA
B81C   STA $14
B81E   PLA
B81F   STA $15
B821   JMP $B3A2


; POKE command

B824   JSR $B7EB
B827   TXA
B828   LDY #$00
B82A   STA ($14),Y
B82C   RTS


; WAIT command

B82D   JSR $B7EB
B830   STX $49
B832   LDX #$00
B834   JSR $0079
B837   BEQ $B83C
B839   JSR $B7F1
B83C   STX $4A
B83E   LDY #$00
B840   LDA ($14),Y
B842   EOR $4A
B844   AND $49
B846   BEQ $B840
B848   RTS


; add 0.5 to float accu (rounding)

B849   LDA #$11   ; low  BF11
B84B   LDY #$BF   ; high BF11
B84D   JMP $B867


; minus operator

B850   JSR $BA8C

B853   LDA $66

B855   EOR #$FF
B857   STA $66
B859   EOR $6E
B85B   STA $6F
B85D   LDA $61
B85F   JMP $B86A

B862   JSR $B999
B865   BCC $B8A3


; add float indexed by AY to float accu

B867   JSR $BA8C


; plus operator

B86A   BNE $B86F
B86C   JMP $BBFC

B86F   LDX $70
B871   STX $56
B873   LDX #$69
B875   LDA $69

B877   TAY

B878   BEQ $B848
B87A   SEC
B87B   SBC $61
B87D   BEQ $B8A3
B87F   BCC $B893
B881   STY $61
B883   LDY $6E
B885   STY $66
B887   EOR #$FF
B889   ADC #$00
B88B   LDY #$00
B88D   STY $56
B88F   LDX #$61
B891   BNE $B897
B893   LDY #$00
B895   STY $70
B897   CMP #$F9
B899   BMI $B862
B89B   TAY
B89C   LDA $70
B89E   LSR $01,X
B8A0   JSR $B9B0
B8A3   BIT $6F
B8A5   BPL $B8FE
B8A7   LDY #$61
B8A9   CPX #$69
B8AB   BEQ $B8AF
B8AD   LDY #$69
B8AF   SEC
B8B0   EOR #$FF
B8B2   ADC $56
B8B4   STA $70
B8B6   LDA $0004,Y
B8B9   SBC $04,X
B8BB   STA $65
B8BD   LDA $0003,Y
B8C0   SBC $03,X
B8C2   STA $64
B8C4   LDA $0002,Y
B8C7   SBC $02,X
B8C9   STA $63
B8CB   LDA $0001,Y
B8CE   SBC $01,X
B8D0   STA $62

B8D2   BCS $B8D7

B8D4   JSR $B947

B8D7   LDY #$00

B8D9   TYA
B8DA   CLC
B8DB   LDX $62
B8DD   BNE $B929
B8DF   LDX $63
B8E1   STX $62
B8E3   LDX $64
B8E5   STX $63
B8E7   LDX $65
B8E9   STX $64
B8EB   LDX $70
B8ED   STX $65
B8EF   STY $70
B8F1   ADC #$08
B8F3   CMP #$20
B8F5   BNE $B8DB

B8F7   LDA #$00


B8F9   STA $61


B8FB   STA $66

B8FD   RTS


; add fractions

B8FE   ADC $56
B900   STA $70
B902   LDA $65
B904   ADC $6D
B906   STA $65
B908   LDA $64
B90A   ADC $6C
B90C   STA $64
B90E   LDA $63
B910   ADC $6B
B912   STA $63
B914   LDA $62
B916   ADC $6A
B918   STA $62
B91A   JMP $B936


; postshift

B91D   ADC #$01
B91F   ASL $70
B921   ROL $65
B923   ROL $64
B925   ROL $63
B927   ROL $62
B929   BPL $B91D
B92B   SEC
B92C   SBC $61
B92E   BCS $B8F7
B930   EOR #$FF
B932   ADC #$01
B934   STA $61

B936   BCC $B946


B938   INC $61

B93A   BEQ $B97E
B93C   ROR $62
B93E   ROR $63
B940   ROR $64
B942   ROR $65
B944   ROR $70
B946   RTS


; negate float accu

B947   LDA $66
B949   EOR #$FF
B94B   STA $66

B94D   LDA $62

B94F   EOR #$FF
B951   STA $62
B953   LDA $63
B955   EOR #$FF
B957   STA $63
B959   LDA $64
B95B   EOR #$FF
B95D   STA $64
B95F   LDA $65
B961   EOR #$FF
B963   STA $65
B965   LDA $70
B967   EOR #$FF
B969   STA $70
B96B   INC $70
B96D   BNE $B97D


; increment fraction

B96F   INC $65
B971   BNE $B97D
B973   INC $64
B975   BNE $B97D
B977   INC $63
B979   BNE $B97D
B97B   INC $62
B97D   RTS


B97E   LDX #$0F   ; error number

B980   JMP $A437


; preshift

B983   LDX #$25
B985   LDY $04,X
B987   STY $70
B989   LDY $03,X
B98B   STY $04,X
B98D   LDY $02,X
B98F   STY $03,X
B991   LDY $01,X
B993   STY $02,X
B995   LDY $68
B997   STY $01,X

B999   ADC #$08

B99B   BMI $B985
B99D   BEQ $B985
B99F   SBC #$08
B9A1   TAY
B9A2   LDA $70
B9A4   BCS $B9BA
B9A6   ASL $01,X
B9A8   BCC $B9AC
B9AA   INC $01,X
B9AC   ROR $01,X
B9AE   ROR $01,X

B9B0   ROR $02,X

B9B2   ROR $03,X
B9B4   ROR $04,X
B9B6   ROR
B9B7   INY
B9B8   BNE $B9A6
B9BA   CLC
B9BB   RTS


; 1

B9BC   .byte $81,$00,$00,$00,$00


; LOG polynomial table

B9C1   .byte $03   ; degree 4
B9C2   .byte $7F,$5E,$56,$CB,$79
B9C7   .byte $80,$13,$9B,$0B,$64
B9CC   .byte $80,$76,$38,$93,$16
B9D1   .byte $82,$38,$AA,$3B,$20


; 0,5 * SQR(2)

B9D6   .byte $80,$35,$04,$F3,$34

; SQR(2)

B9DB   .byte $81,$35,$04,$F3,$34

; -0.5

B9E0   .byte $80,$80,$00,$00,$00

; LOG(2)

B9E5   .byte $80,$31,$72,$17,$F8


; LOG function

B9EA   JSR $BC2B
B9ED   BEQ $B9F1
B9EF   BPL $B9F4
B9F1   JMP $B248

B9F4   LDA $61
B9F6   SBC #$7F
B9F8   PHA
B9F9   LDA #$80
B9FB   STA $61
B9FD   LDA #$D6   ; low  B9D6
B9FF   LDY #$B9   ; high B9D6
BA01   JSR $B867
BA04   LDA #$DB   ; low  B9DB
BA06   LDY #$B9   ; high B9DB
BA08   JSR $BB0F
BA0B   LDA #$BC   ; low  B9BC
BA0D   LDY #$B9   ; high B9BC
BA0F   JSR $B850
BA12   LDA #$C1   ; low  B9C1
BA14   LDY #$B9   ; high B9C1
BA16   JSR $E043
BA19   LDA #$E0   ; low  B9E0
BA1B   LDY #$B9   ; high B9E0
BA1D   JSR $B867
BA20   PLA
BA21   JSR $BD7E
BA24   LDA #$E5   ; low  B9E5
BA26   LDY #$B9   ; high B9E5

BA28   JSR $BA8C



; times operator

BA2B   BNE $BA30
BA2D   JMP $BA8B

BA30   JSR $BAB7
BA33   LDA #$00
BA35   STA $26
BA37   STA $27
BA39   STA $28
BA3B   STA $29
BA3D   LDA $70
BA3F   JSR $BA59
BA42   LDA $65
BA44   JSR $BA59
BA47   LDA $64
BA49   JSR $BA59
BA4C   LDA $63
BA4E   JSR $BA59
BA51   LDA $62
BA53   JSR $BA5E
BA56   JMP $BB8F


BA59   BNE $BA5E

BA5B   JMP $B983


BA5E   LSR

BA5F   ORA #$80
BA61   TAY
BA62   BCC $BA7D
BA64   CLC
BA65   LDA $29
BA67   ADC $6D
BA69   STA $29
BA6B   LDA $28
BA6D   ADC $6C
BA6F   STA $28
BA71   LDA $27
BA73   ADC $6B
BA75   STA $27
BA77   LDA $26
BA79   ADC $6A
BA7B   STA $26
BA7D   ROR $26
BA7F   ROR $27
BA81   ROR $28
BA83   ROR $29
BA85   ROR $70
BA87   TYA
BA88   LSR
BA89   BNE $BA61

BA8B   RTS



; move float indexed by AY into second float accu

BA8C   STA $22
BA8E   STY $23
BA90   LDY #$04
BA92   LDA ($22),Y
BA94   STA $6D
BA96   DEY
BA97   LDA ($22),Y
BA99   STA $6C
BA9B   DEY
BA9C   LDA ($22),Y
BA9E   STA $6B
BAA0   DEY
BAA1   LDA ($22),Y
BAA3   STA $6E
BAA5   EOR $66
BAA7   STA $6F
BAA9   LDA $6E
BAAB   ORA #$80
BAAD   STA $6A
BAAF   DEY
BAB0   LDA ($22),Y
BAB2   STA $69
BAB4   LDA $61
BAB6   RTS


; add exponents

BAB7   LDA $69

BAB9   BEQ $BADA

BABB   CLC
BABC   ADC $61
BABE   BCC $BAC4
BAC0   BMI $BADF
BAC2   CLC
BAC3   .byte $2C
BAC4   BPL $BADA
BAC6   ADC #$80
BAC8   STA $61
BACA   BNE $BACF
BACC   JMP $B8FB

BACF   LDA $6F
BAD1   STA $66
BAD3   RTS


BAD4   LDA $66

BAD6   EOR #$FF
BAD8   BMI $BADF
BADA   PLA
BADB   PLA
BADC   JMP $B8F7

BADF   JMP $B97E


; multiply float accu by 10

BAE2   JSR $BC0C
BAE5   TAX
BAE6   BEQ $BAF8
BAE8   CLC
BAE9   ADC #$02
BAEB   BCS $BADF

BAED   LDX #$00

BAEF   STX $6F
BAF1   JSR $B877
BAF4   INC $61
BAF6   BEQ $BADF
BAF8   RTS


; constant 10 for division

BAF9   .byte $84,$20,$00,$00,$00


; divide float by 10

BAFE   JSR $BC0C
BB01   LDA #$F9   ; low  BAF9
BB03   LDY #$BA   ; high BAF9
BB05   LDX #$00

BB07   STX $6F

BB09   JSR $BBA2
BB0C   JMP $BB12


; divide number indexed by AY by float accu

BB0F   JSR $BA8C


; divide operator

BB12   BEQ $BB8A
BB14   JSR $BC1B
BB17   LDA #$00
BB19   SEC
BB1A   SBC $61
BB1C   STA $61
BB1E   JSR $BAB7
BB21   INC $61
BB23   BEQ $BADF
BB25   LDX #$FC
BB27   LDA #$01
BB29   LDY $6A
BB2B   CPY $62
BB2D   BNE $BB3F
BB2F   LDY $6B
BB31   CPY $63
BB33   BNE $BB3F
BB35   LDY $6C
BB37   CPY $64
BB39   BNE $BB3F
BB3B   LDY $6D
BB3D   CPY $65
BB3F   PHP
BB40   ROL
BB41   BCC $BB4C
BB43   INX
BB44   STA $29,X
BB46   BEQ $BB7A
BB48   BPL $BB7E
BB4A   LDA #$01
BB4C   PLP
BB4D   BCS $BB5D

BB4F   ASL $6D

BB51   ROL $6C
BB53   ROL $6B
BB55   ROL $6A
BB57   BCS $BB3F
BB59   BMI $BB29
BB5B   BPL $BB3F
BB5D   TAY
BB5E   LDA $6D
BB60   SBC $65
BB62   STA $6D
BB64   LDA $6C
BB66   SBC $64
BB68   STA $6C
BB6A   LDA $6B
BB6C   SBC $63
BB6E   STA $6B
BB70   LDA $6A
BB72   SBC $62
BB74   STA $6A
BB76   TYA
BB77   JMP $BB4F

BB7A   LDA #$40
BB7C   BNE $BB4C
BB7E   ASL
BB7F   ASL
BB80   ASL
BB81   ASL
BB82   ASL
BB83   ASL
BB84   STA $70
BB86   PLP
BB87   JMP $BB8F

BB8A   LDX #$14   ; error number
BB8C   JMP $A437


BB8F   LDA $26

BB91   STA $62
BB93   LDA $27
BB95   STA $63
BB97   LDA $28
BB99   STA $64
BB9B   LDA $29
BB9D   STA $65
BB9F   JMP $B8D7


BBA2   STA $22

BBA4   STY $23
BBA6   LDY #$04
BBA8   LDA ($22),Y
BBAA   STA $65
BBAC   DEY
BBAD   LDA ($22),Y
BBAF   STA $64
BBB1   DEY
BBB2   LDA ($22),Y
BBB4   STA $63
BBB6   DEY
BBB7   LDA ($22),Y
BBB9   STA $66
BBBB   ORA #$80
BBBD   STA $62
BBBF   DEY
BBC0   LDA ($22),Y
BBC2   STA $61
BBC4   STY $70
BBC6   RTS


; store float accu at $5C-$60

BBC7   LDX #$5C   ; low  005C
BBC9   .byte $2C


; store float accu at $57-$5B

BBCA   LDX #$57   ; low  0057
BBCC   LDY #$00   ; high 0057
BBCE   BEQ $BBD4


; store float accu in index at $49/$4A

BBD0   LDX $49
BBD2   LDY $4A


; store float accu in index XY

BBD4   JSR $BC1B
BBD7   STX $22
BBD9   STY $23
BBDB   LDY #$04
BBDD   LDA $65
BBDF   STA ($22),Y
BBE1   DEY
BBE2   LDA $64
BBE4   STA ($22),Y
BBE6   DEY
BBE7   LDA $63
BBE9   STA ($22),Y
BBEB   DEY
BBEC   LDA $66
BBEE   ORA #$7F
BBF0   AND $62
BBF2   STA ($22),Y
BBF4   DEY
BBF5   LDA $61
BBF7   STA ($22),Y
BBF9   STY $70
BBFB   RTS


; move second float accu into first

BBFC   LDA $6E

BBFE   STA $66

BC00   LDX #$05
BC02   LDA $68,X
BC04   STA $60,X
BC06   DEX
BC07   BNE $BC02
BC09   STX $70
BC0B   RTS


; move rounded float accu into second

BC0C   JSR $BC1B

BC0F   LDX #$06

BC11   LDA $60,X
BC13   STA $68,X
BC15   DEX
BC16   BNE $BC11
BC18   STX $70
BC1A   RTS


; round float accu according to guard bit

BC1B   LDA $61
BC1D   BEQ $BC1A
BC1F   ASL $70
BC21   BCC $BC1A

BC23   JSR $B96F

BC26   BNE $BC1A
BC28   JMP $B938


; get sign of float accu in A

BC2B   LDA $61
BC2D   BEQ $BC38
BC2F   LDA $66

BC31   ROL

BC32   LDA #$FF
BC34   BCS $BC38
BC36   LDA #$01
BC38   RTS


; SGN function

BC39   JSR $BC2B


; move signed number from A into float accu

BC3C   STA $62
BC3E   LDA #$00
BC40   STA $63
BC42   LDX #$88

BC44   LDA $62

BC46   EOR #$FF
BC48   ROL

BC49   LDA #$00

BC4B   STA $65
BC4D   STA $64

BC4F   STX $61

BC51   STA $70
BC53   STA $66
BC55   JMP $B8D2


; ABS function

BC58   LSR $66
BC5A   RTS


; compare float accu to float indexed by XY

BC5B   STA $24

BC5D   STY $25

BC5F   LDY #$00
BC61   LDA ($24),Y
BC63   INY
BC64   TAX
BC65   BEQ $BC2B
BC67   LDA ($24),Y
BC69   EOR $66
BC6B   BMI $BC2F
BC6D   CPX $61
BC6F   BNE $BC92
BC71   LDA ($24),Y
BC73   ORA #$80
BC75   CMP $62
BC77   BNE $BC92
BC79   INY
BC7A   LDA ($24),Y
BC7C   CMP $63
BC7E   BNE $BC92
BC80   INY
BC81   LDA ($24),Y
BC83   CMP $64
BC85   BNE $BC92
BC87   INY
BC88   LDA #$7F
BC8A   CMP $70
BC8C   LDA ($24),Y
BC8E   SBC $65
BC90   BEQ $BCBA
BC92   LDA $66
BC94   BCC $BC98
BC96   EOR #$FF
BC98   JMP $BC31


; convert float to a 4 byte signed integer

BC9B   LDA $61
BC9D   BEQ $BCE9
BC9F   SEC
BCA0   SBC #$A0
BCA2   BIT $66
BCA4   BPL $BCAF
BCA6   TAX
BCA7   LDA #$FF
BCA9   STA $68
BCAB   JSR $B94D
BCAE   TXA
BCAF   LDX #$61
BCB1   CMP #$F9
BCB3   BPL $BCBB
BCB5   JSR $B999
BCB8   STY $68
BCBA   RTS

BCBB   TAY
BCBC   LDA $66
BCBE   AND #$80
BCC0   LSR $62
BCC2   ORA $62
BCC4   STA $62
BCC6   JSR $B9B0
BCC9   STY $68
BCCB   RTS


; INT function

BCCC   LDA $61
BCCE   CMP #$A0
BCD0   BCS $BCF2
BCD2   JSR $BC9B
BCD5   STY $70
BCD7   LDA $66
BCD9   STY $66
BCDB   EOR #$80
BCDD   ROL
BCDE   LDA #$A0
BCE0   STA $61
BCE2   LDA $65
BCE4   STA $07
BCE6   JMP $B8D2


; clear float accu

BCE9   STA $62
BCEB   STA $63
BCED   STA $64
BCEF   STA $65
BCF1   TAY
BCF2   RTS


; convert string to float in float accu

BCF3   LDY #$00
BCF5   LDX #$0A
BCF7   STY $5D,X
BCF9   DEX
BCFA   BPL $BCF7
BCFC   BCC $BD0D
BCFE   CMP #$2D   ; minus
BD00   BNE $BD06
BD02   STX $67
BD04   BEQ $BD0A
BD06   CMP #$2B   ; plus
BD08   BNE $BD0F

BD0A   JSR $0073

BD0D   BCC $BD6A
BD0F   CMP #$2E   ; decimal point
BD11   BEQ $BD41
BD13   CMP #$45   ; E
BD15   BNE $BD47
BD17   JSR $0073
BD1A   BCC $BD33
BD1C   CMP #$AB   ; minus code
BD1E   BEQ $BD2E
BD20   CMP #$2D   ; minus
BD22   BEQ $BD2E
BD24   CMP #$AA   ; plus code
BD26   BEQ $BD30
BD28   CMP #$2B   ; plus
BD2A   BEQ $BD30
BD2C   BNE $BD35
BD2E   ROR $60

BD30   JSR $0073

BD33   BCC $BD91
BD35   BIT $60
BD37   BPL $BD47
BD39   LDA #$00
BD3B   SEC
BD3C   SBC $5E
BD3E   JMP $BD49

BD41   ROR $5F
BD43   BIT $5F
BD45   BVC $BD0A
BD47   LDA $5E

BD49   SEC

BD4A   SBC $5D
BD4C   STA $5E
BD4E   BEQ $BD62
BD50   BPL $BD5B
BD52   JSR $BAFE
BD55   INC $5E
BD57   BNE $BD52
BD59   BEQ $BD62
BD5B   JSR $BAE2
BD5E   DEC $5E
BD60   BNE $BD5B
BD62   LDA $67
BD64   BMI $BD67
BD66   RTS

BD67   JMP $BFB4

BD6A   PHA
BD6B   BIT $5F
BD6D   BPL $BD71
BD6F   INC $5D
BD71   JSR $BAE2
BD74   PLA
BD75   SEC
BD76   SBC #$30   ; 0
BD78   JSR $BD7E
BD7B   JMP $BD0A


; add signed integer from A to float accu

BD7E   PHA
BD7F   JSR $BC0C
BD82   PLA
BD83   JSR $BC3C
BD86   LDA $6E
BD88   EOR $66
BD8A   STA $6F
BD8C   LDX $61
BD8E   JMP $B86A


; get exponent of number from string

BD91   LDA $5E
BD93   CMP #$0A
BD95   BCC $BDA0
BD97   LDA #$64
BD99   BIT $60
BD9B   BMI $BDAE
BD9D   JMP $B97E

BDA0   ASL
BDA1   ASL
BDA2   CLC
BDA3   ADC $5E
BDA5   ASL
BDA6   CLC
BDA7   LDY #$00
BDA9   ADC ($7A),Y
BDAB   SEC
BDAC   SBC #$30   ; 0
BDAE   STA $5E
BDB0   JMP $BD30


; constants for float to string conversion

BDB3   .byte $9B,$3E,$BC,$1F,$FD

BDB8   .byte $9E,$6E,$6B,$27,$FD


BDBD   .byte $9E,$6E,$6B,$28,$00



; print IN followed by line number

BDC2   LDA #$71   ; low  A371
BDC4   LDY #$A3   ; high A371
BDC6   JSR $BDDA
BDC9   LDA $3A
BDCB   LDX $39


; print number from AX

BDCD   STA $62
BDCF   STX $63
BDD1   LDX #$90
BDD3   SEC
BDD4   JSR $BC49
BDD7   JSR $BDDF

BDDA   JMP $AB1E



; convert number in float accu to string

BDDD   LDY #$01

BDDF   LDA #$20

BDE1   BIT $66
BDE3   BPL $BDE7
BDE5   LDA #$2D   ; minus
BDE7   STA $00FF,Y
BDEA   STA $66
BDEC   STY $71
BDEE   INY
BDEF   LDA #$30   ; 0
BDF1   LDX $61
BDF3   BNE $BDF8
BDF5   JMP $BF04

BDF8   LDA #$00
BDFA   CPX #$80
BDFC   BEQ $BE00
BDFE   BCS $BE09
BE00   LDA #$BD   ; low  BDBD
BE02   LDY #$BD   ; high BDBD
BE04   JSR $BA28
BE07   LDA #$F7
BE09   STA $5D
BE0B   LDA #$B8   ; low  BDB8
BE0D   LDY #$BD   ; high BDB8
BE0F   JSR $BC5B
BE12   BEQ $BE32
BE14   BPL $BE28
BE16   LDA #$B3   ; low  BDB3
BE18   LDY #$BD   ; high BDB3
BE1A   JSR $BC5B
BE1D   BEQ $BE21
BE1F   BPL $BE2F
BE21   JSR $BAE2
BE24   DEC $5D
BE26   BNE $BE16
BE28   JSR $BAFE
BE2B   INC $5D
BE2D   BNE $BE0B
BE2F   JSR $B849
BE32   JSR $BC9B
BE35   LDX #$01
BE37   LDA $5D
BE39   CLC
BE3A   ADC #$0A
BE3C   BMI $BE47
BE3E   CMP #$0B
BE40   BCS $BE48
BE42   ADC #$FF
BE44   TAX
BE45   LDA #$02
BE47   SEC
BE48   SBC #$02
BE4A   STA $5E
BE4C   STX $5D
BE4E   TXA
BE4F   BEQ $BE53
BE51   BPL $BE66
BE53   LDY $71
BE55   LDA #$2E   ; decimal point
BE57   INY
BE58   STA $00FF,Y
BE5B   TXA
BE5C   BEQ $BE64
BE5E   LDA #$30   ; 0
BE60   INY
BE61   STA $00FF,Y
BE64   STY $71
BE66   LDY #$00

BE68   LDX #$80

BE6A   LDA $65
BE6C   CLC
BE6D   ADC $BF19,Y
BE70   STA $65
BE72   LDA $64
BE74   ADC $BF18,Y
BE77   STA $64
BE79   LDA $63
BE7B   ADC $BF17,Y
BE7E   STA $63
BE80   LDA $62
BE82   ADC $BF16,Y
BE85   STA $62
BE87   INX
BE88   BCS $BE8E
BE8A   BPL $BE6A
BE8C   BMI $BE90
BE8E   BMI $BE6A
BE90   TXA
BE91   BCC $BE97
BE93   EOR #$FF
BE95   ADC #$0A
BE97   ADC #$2F
BE99   INY
BE9A   INY
BE9B   INY
BE9C   INY
BE9D   STY $47
BE9F   LDY $71
BEA1   INY
BEA2   TAX
BEA3   AND #$7F
BEA5   STA $00FF,Y
BEA8   DEC $5D
BEAA   BNE $BEB2
BEAC   LDA #$2E
BEAE   INY
BEAF   STA $00FF,Y
BEB2   STY $71
BEB4   LDY $47
BEB6   TXA
BEB7   EOR #$FF
BEB9   AND #$80
BEBB   TAX
BEBC   CPY #$24
BEBE   BEQ $BEC4
BEC0   CPY #$3C
BEC2   BNE $BE6A
BEC4   LDY $71
BEC6   LDA $00FF,Y
BEC9   DEY
BECA   CMP #$30   ; 0
BECC   BEQ $BEC6
BECE   CMP #$2E   ; decimal point
BED0   BEQ $BED3
BED2   INY
BED3   LDA #$2B   ; plus
BED5   LDX $5E
BED7   BEQ $BF07
BED9   BPL $BEE3
BEDB   LDA #$00
BEDD   SEC
BEDE   SBC $5E
BEE0   TAX
BEE1   LDA #$2D   ; minus
BEE3   STA $0101,Y
BEE6   LDA #$45
BEE8   STA $0100,Y
BEEB   TXA
BEEC   LDX #$2F
BEEE   SEC
BEEF   INX
BEF0   SBC #$0A
BEF2   BCS $BEEF
BEF4   ADC #$3A
BEF6   STA $0103,Y
BEF9   TXA
BEFA   STA $0102,Y
BEFD   LDA #$00
BEFF   STA $0104,Y
BF02   BEQ $BF0C

BF04   STA $00FF,Y

BF07   LDA #$00
BF09   STA $0100,Y
BF0C   LDA #$00   ; low  0100
BF0E   LDY #$01   ; high 0100
BF10   RTS


; 0.5

BF11   .byte $80,$00,$00,$00,$00


; divisors for decimal conversion

BF16   .byte $FA,$0A,$1F,$00
BF1A   .byte $00,$98,$96,$80
BF1E   .byte $FF,$F0,$BD,$C0
BF22   .byte $00,$01,$86,$A0
BF26   .byte $FF,$FF,$D8,$F0
BF2A   .byte $00,$00,$03,$E8
BF2E   .byte $FF,$FF,$FF,$9C
BF32   .byte $00,$00,$00,$0A
BF36   .byte $FF,$FF,$FF,$FF


; divisors for time conversion

BF3A   .byte $FF,$DF,$0A,$80
BF3E   .byte $00,$03,$4B,$C0
BF42   .byte $FF,$FF,$73,$60
BF46   .byte $00,$00,$0E,$10
BF4A   .byte $FF,$FF,$FD,$A8
BF4E   .byte $00,$00,$00,$3C


; unused
; is this some version id?

BF52   .byte $EC


; unused

BF53   .byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
BF5B   .byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
BF63   .byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
BF6B   .byte $AA,$AA,$AA,$AA,$AA,$AA


; SQR function

BF71   JSR $BC0C
BF74   LDA #$11
BF76   LDY #$BF
BF78   JSR $BBA2


; power operator

BF7B   BEQ $BFED
BF7D   LDA $69
BF7F   BNE $BF84
BF81   JMP $B8F9

BF84   LDX #$4E   ; low  004E
BF86   LDY #$00   ; high 004E
BF88   JSR $BBD4
BF8B   LDA $6E
BF8D   BPL $BF9E
BF8F   JSR $BCCC
BF92   LDA #$4E   ; low  004E
BF94   LDY #$00   ; high 004E
BF96   JSR $BC5B
BF99   BNE $BF9E
BF9B   TYA
BF9C   LDY $07
BF9E   JSR $BBFE
BFA1   TYA
BFA2   PHA
BFA3   JSR $B9EA
BFA6   LDA #$4E   ; low  004E
BFA8   LDY #$00   ; high 004E
BFAA   JSR $BA28
BFAD   JSR $BFED
BFB0   PLA
BFB1   LSR
BFB2   BCC $BFBE


; minus operator
BFB4   LDA $61
BFB6   BEQ $BFBE
BFB8   LDA $66
BFBA   EOR #$FF
BFBC   STA $66
BFBE   RTS

; floating point constands for EXP

; 1/LOG(2)

BFBF   .byte $81,$38,$AA,$3B,$29


; EXP polynomial table

BFC4   .byte $07   ; degree 8
BFC5   .byte $71,$34,$58,$3E,$56
BFCA   .byte $74,$16,$7E,$B3,$1B
BFCF   .byte $77,$2F,$EE,$E3,$85
BFD4   .byte $7A,$1D,$84,$1C,$2A
BFD9   .byte $7C,$63,$59,$58,$0A
BFDE   .byte $7E,$75,$FD,$E7,$C6
BFE3   .byte $80,$31,$72,$18,$10
BFE8   .byte $81,$00,$00,$00,$00


; EXP command

BFED    LDA #$BF
BFEF    LDY #$BF
BFF1    JSR $BA28
BFF4    LDA $70
BFF6    ADC #$50
BFF8    BCC $BFFD
BFFA    JSR $BC23
BFFD    JMP $E000

