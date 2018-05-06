
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


 * = $E000

;Commodore 64 KERNAL ($03) ROM dissasembly
;Version 1.0 (June 1994)


; continuation of EXP function

E000   STA $56
E002   JSR $BC0F
E005   LDA $61
E007   CMP #$88
E009   BCC $E00E
E00B   JSR $BAD4
E00E   JSR $BCCC
E011   LDA $07
E013   CLC
E014   ADC #$81
E016   BEQ $E00B
E018   SEC
E019   SBC #$01
E01B   PHA
E01C   LDX #$05
E01E   LDA $69,X
E020   LDY $61,X
E022   STA $61,X
E024   STY $69,X
E026   DEX
E027   BPL $E01E
E029   LDA $56
E02B   STA $70
E02D   JSR $B853
E030   JSR $BFB4
E033   LDA #$C4
E035   LDY #$BF
E037   JSR $E059
E03A   LDA #$00
E03C   STA $6F
E03E   PLA
E03F   JSR $BAB9
E042   RTS


; compute odd degrees for SIN and ATN

E043   STA $71
E045   STY $72
E047   JSR $BBCA
E04A   LDA #$57
E04C   JSR $BA28
E04F   JSR $E05D
E052   LDA #$57
E054   LDY #$00
E056   JMP $BA28


; compute polynomials according to table indexed by AY

E059   STA $71
E05B   STY $72

E05D   JSR $BBC7

E060   LDA ($71),Y
E062   STA $67
E064   LDY $71
E066   INY
E067   TYA
E068   BNE $E06C
E06A   INC $72
E06C   STA $71
E06E   LDY $72
E070   JSR $BA28
E073   LDA $71
E075   LDY $72
E077   CLC
E078   ADC #$05
E07A   BCC $E07D
E07C   INY
E07D   STA $71
E07F   STY $72
E081   JSR $B867
E084   LDA #$5C
E086   LDY #$00
E088   DEC $67
E08A   BNE $E070
E08C   RTS


; float numbers for RND

E08D   .byte $98,$35,$44,$7A,$00
E092   .byte $68,$28,$B1,$46,$00


; RND function

E097   JSR $BC2B
E09A   BMI $E0D3
E09C   BNE $E0BE
E09E   JSR $FFF3
E0A1   STX $22
E0A3   STY $23
E0A5   LDY #$04
E0A7   LDA ($22),Y
E0A9   STA $62
E0AB   INY
E0AC   LDA ($22),Y
E0AE   STA $64
E0B0   LDY #$08
E0B2   LDA ($22),Y
E0B4   STA $63
E0B6   INY
E0B7   LDA ($22),Y
E0B9   STA $65
E0BB   JMP $E0E3

E0BE   LDA #$8B
E0C0   LDY #$00
E0C2   JSR $BBA2
E0C5   LDA #$8D
E0C7   LDY #$E0
E0C9   JSR $BA28
E0CC   LDA #$92
E0CE   LDY #$E0
E0D0   JSR $B867
E0D3   LDX $65
E0D5   LDA $62
E0D7   STA $65
E0D9   STX $62
E0DB   LDX $63
E0DD   LDA $64
E0DF   STA $63
E0E1   STX $64

E0E3   LDA #$00

E0E5   STA $66
E0E7   LDA $61
E0E9   STA $70
E0EB   LDA #$80
E0ED   STA $61
E0EF   JSR $B8D7
E0F2   LDX #$8B
E0F4   LDY #$00

E0F6   JMP $BBD4



; handle errors for direct I/O
; calls from basic

E0F9   CMP #$F0
E0FB   BNE $E104
E0FD   STY $38
E0FF   STX $37
E101   JMP $A663

E104   TAX
E105   BNE $E109
E107   LDX #$1E
E109   JMP $A437


E10C   JSR $FFD2

E10F   BCS $E0F9
E111   RTS


E112   JSR $FFCF

E115   BCS $E0F9
E117   RTS


E118   JSR $E4AD

E11B   BCS $E0F9
E11D   RTS


E11E   JSR $FFC6

E121   BCS $E0F9
E123   RTS


E124   JSR $FFE4

E127   BCS $E0F9
E129   RTS


; SYS command

E12A   JSR $AD8A
E12D   JSR $B7F7
E130   LDA #$E1   ; low  E146
E132   PHA
E133   LDA #$46   ; high E146
E135   PHA
E136   LDA $030F
E139   PHA
E13A   LDA $030C
E13D   LDX $030D
E140   LDY $030E
E143   PLP
E144   JMP ($0014)


E147   PHP

E148   STA $030C
E14B   STX $030D
E14E   STY $030E
E151   PLA
E152   STA $030F
E155   RTS


; SAVE command

E156   JSR $E1D4
E159   LDX $2D
E15B   LDY $2E
E15D   LDA #$2B
E15F   JSR $FFD8
E162   BCS $E0F9
E164   RTS


; VERIFY command

E165   LDA #$01
E167   .byte $2C


; LOAD command

E168   LDA #$00
E16A   STA $0A
E16C   JSR $E1D4
E16F   LDA $0A
E171   LDX $2B
E173   LDY $2C
E175   JSR $FFD5
E178   BCS $E1D1
E17A   LDA $0A
E17C   BEQ $E195
E17E   LDX #$1C
E180   JSR $FFB7
E183   AND #$10
E185   BNE $E19E
E187   LDA $7A
E189   CMP #$02
E18B   BEQ $E194
E18D   LDA #$64
E18F   LDY #$A3
E191   JMP $AB1E
E194   RTS

E195   JSR $FFB7
E198   AND #$BF
E19A   BEQ $E1A1
E19C   LDX #$1D
E19E   JMP $A437

E1A1   LDA $7B
E1A3   CMP #$02
E1A5   BNE $E1B5
E1A7   STX $2D
E1A9   STY $2E
E1AB   LDA #$76
E1AD   LDY #$A3
E1AF   JSR $AB1E
E1B2   JMP $A52A

E1B5   JSR $A68E
E1B8   JSR $A533
E1BB   JMP $A677


; OPEN command

E1BE   JSR $E219
E1C1   JSR $FFC0
E1C4   BCS $E1D1
E1C6   RTS


; CLOSE command

E1C7   JSR $E219
E1CA   LDA $49
E1CC   JSR $FFC3
E1CF   BCC $E194
E1D1   JMP $E0F9


; set parameters for load/verify/save

E1D4   LDA #$00
E1D6   JSR $FFBD
E1D9   LDX #$01
E1DB   LDY #$00
E1DD   JSR $FFBA
E1E0   JSR $E206
E1E3   JSR $E257
E1E6   JSR $E206
E1E9   JSR $E200
E1EC   LDY #$00
E1EE   STX $49
E1F0   JSR $FFBA
E1F3   JSR $E206
E1F6   JSR $E200
E1F9   TXA
E1FA   TAY
E1FB   LDX $49
E1FD   JMP $FFBA


; skip comma and get integer in X

E200   JSR $E20E
E203   JMP $B79E


; get character and check for end of line

E206   JSR $0079
E209   BNE $E20D
E20B   PLA
E20C   PLA
E20D   RTS


; check for comma and skip it

E20E   JSR $AEFD

E211   JSR $0079

E214   BNE $E20D
E216   JMP $AF08


; get open/close parameters

E219   LDA #$00
E21B   JSR $FFBD
E21E   JSR $E211
E221   JSR $B79E
E224   STX $49
E226   TXA
E227   LDX #$01
E229   LDY #$00
E22B   JSR $FFBA
E22E   JSR $E206
E231   JSR $E200
E234   STX $4A
E236   LDY #$00
E238   LDA $49
E23A   CPX #$03
E23C   BCC $E23F
E23E   DEY
E23F   JSR $FFBA
E242   JSR $E206
E245   JSR $E200
E248   TXA
E249   TAY
E24A   LDX $4A
E24C   LDA $49
E24E   JSR $FFBA
E251   JSR $E206
E254   JSR $E20E

E257   JSR $AD9E

E25A   JSR $B6A3
E25D   LDX $22
E25F   LDY $23
E261   JMP $FFBD


; COS function

E264   LDA #$E0   ; low  E2E0
E266   LDY #$E2   ; high E2E0
E268   JSR $B867


; SIN function

E26B   JSR $BC0C
E26E   LDA #$E5   ; low  E2E5
E270   LDY #$E2   ; high E2E5
E272   LDX $6E
E274   JSR $BB07
E277   JSR $BC0C
E27A   JSR $BCCC
E27D   LDA #$00
E27F   STA $6F
E281   JSR $B853
E284   LDA #$EA   ; low  E2EA
E286   LDY #$E2   ; high E2EA
E288   JSR $B850
E28B   LDA $66
E28D   PHA
E28E   BPL $E29D
E290   JSR $B849
E293   LDA $66
E295   BMI $E2A0
E297   LDA $12
E299   EOR #$FF
E29B   STA $12

E29D   JSR $BFB4

E2A0   LDA #$EA   ; low  E2EA
E2A2   LDY #$E2   ; high E2EA
E2A4   JSR $B867
E2A7   PLA
E2A8   BPL $E2AD
E2AA   JSR $BFB4
E2AD   LDA #$EF
E2AF   LDY #$E2
E2B1   JMP $E043


; TAN function

E2B4   JSR $BBCA
E2B7   LDA #$00
E2B9   STA $12
E2BB   JSR $E26B
E2BE   LDX #$4E   ; low  004E
E2C0   LDY #$00   ; high 004E
E2C2   JSR $E0F6
E2C5   LDA #$57   ; low  005F
E2C7   LDY #$00   ; high 005F
E2C9   JSR $BBA2
E2CC   LDA #$00
E2CE   STA $66
E2D0   LDA $12
E2D2   JSR $E2DC
E2D5   LDA #$4E   ; low  004E
E2D7   LDY #$00   ; high 004E
E2D9   JMP $BB0F


E2DC   PHA

E2DD   JMP $E29D


; float numbers for SIN, COS and TAN

; 0.5 * PI
E2E0   .byte $81,$49,$0F,$DA,$A2
; 2 * PI
E2E5   .byte $83,$49,$0F,$DA,$A2
; 0,25
E2EA   .byte $7F,$00,$00,$00,$00


; polynomial table

E2EF   .byte $05   ; degree 6
E2F0   .byte $84,$E6,$1A,$2D,$1B
E2F5   .byte $86,$28,$07,$FB,$F8
E2FA   .byte $87,$99,$68,$89,$01
E2FF   .byte $87,$23,$35,$DF,$E1
E304   .byte $86,$A5,$5D,$E7,$28
E309   .byte $83,$49,$0F,$DA,$A2


; ATN function

E30E   LDA $66
E310   PHA
E311   BPL $E316
E313   JSR $BFB4
E316   LDA $61
E318   PHA
E319   CMP #$81
E31B   BCC $E324
E31D   LDA #$BC   ; low  B9BC
E31F   LDY #$B9   ; high B9BC
E321   JSR $BB0F
E324   LDA #$3E   ; low  E33E
E326   LDY #$E3   ; high E33E
E328   JSR $E043
E32B   PLA
E32C   CMP #$81
E32E   BCC $E337
E330   LDA #$E0   ; low  E2E0
E332   LDY #$E2   ; high E2E0
E334   JSR $B850
E337   PLA
E338   BPL $E33D
E33A   JMP $BFB4
E33D   RTS


; float numbers for ATN
; polynomial table

E33E   .byte $0B   ; degree 12
E33F   .byte $76,$B3,$83,$BD,$D3
E344   .byte $79,$1E,$F4,$A6,$F5
E349   .byte $7B,$83,$FC,$B0,$10
E34E   .byte $7C,$0C,$1F,$67,$CA
E353   .byte $7C,$DE,$53,$CB,$C1
E358   .byte $7D,$14,$64,$70,$4C
E35D   .byte $7D,$B7,$EA,$51,$7A
E362   .byte $7D,$63,$30,$88,$7E
E367   .byte $7E,$92,$44,$99,$3A
E36C   .byte $7E,$4C,$CC,$91,$C7
E371   .byte $7F,$AA,$AA,$AA,$13
E376   .byte $81,$00,$00,$00,$00


; warm start entry

E37B   JSR $FFCC
E37E   LDA #$00
E380   STA $13
E382   JSR $A67A
E385   CLI

E386   LDX #$80

E388   JMP ($0300)   ; normally E38B


; handle error messages

E38B  TXA
E38C  BMI $E391
E38E  JMP $A43A

E391  JMP $A474


; RESET routine

E394   JSR $E453
E397   JSR $E3BF
E39A   JSR $E422
E39D   LDX #$FB
E39F   TXS
E3A0   BNE $E386


; character fetch code for zero page $0073-$008F

E3A2   INC $7A
E3A4   BNE $E3A8
E3A6   INC $7B
E3A8   LDA $EA60
E3AB   CMP #$3A   ; colon
E3AD   BCS $E3B9
E3AF   CMP #$20   ; space
E3B1   BEQ $E3A2
E3B3   SEC
E3B4   SBC #$30   ; 0
E3B6   SEC
E3B7   SBC #$D0
E3B9   RTS


; first RND seed value

E3BA   .byte $80,$4F,$C7,$52,$58


; initialisation of basic

E3BF   LDA #$4C
E3C1   STA $54
E3C3   STA $0310
E3C6   LDA #$48   ; low  B248
E3C8   LDY #$B2   ; high B248
E3CA   STA $0311
E3CD   STY $0312
E3D0   LDA #$91   ; lowh B391
E3D2   LDY #$B3   ; high B391
E3D4   STA $05
E3D6   STY $06
E3D8   LDA #$AA   ; low  B1AA
E3DA   LDY #$B1   ; high B1AA
E3DC   STA $03
E3DE   STY $04
E3E0   LDX #$1C
E3E2   LDA $E3A2,X
E3E5   STA $73,X
E3E7   DEX
E3E8   BPL $E3E2
E3EA   LDA #$03
E3EC   STA $53
E3EE   LDA #$00
E3F0   STA $68
E3F2   STA $13
E3F4   STA $18
E3F6   LDX #$01
E3F8   STX $01FD
E3FB   STX $01FC
E3FE   LDX #$19
E400   STX $16
E402   SEC
E403   JSR $FF9C
E406   STX $2B
E408   STY $2C
E40A   SEC
E40B   JSR $FF99
E40E   STX $37
E410   STY $38
E412   STX $33
E414   STY $34
E416   LDY #$00
E418   TYA
E419   STA ($2B),Y
E41B   INC $2B
E41D   BNE $E421
E41F   INC $2C
E421   RTS


; print BASIC start up messages

E422   LDA $2B
E424   LDY $2C
E426   JSR $A408
E429   LDA #$73   ; low  E473
E42B   LDY #$E4   ; high E473
E42D   JSR $AB1E
E430   LDA $37
E432   SEC
E433   SBC $2B
E435   TAX
E436   LDA $38
E438   SBC $2C
E43A   JSR $BDCD
E43D   LDA #$60   ; low  E460
E43F   LDY #$E4   ; high E460
E441   JSR $AB1E
E444   JMP $A644


; vectors for $0300-$030B

E447   .word $E38B
E449   .word $A483
E44B   .word $A57C
E44D   .word $A71A
E44F   .word $A7E4
E451   .word $AE86


; initialise vectors

E453   LDX #$0B
E455   LDA $E447,X
E458   STA $0300,X
E45B   DEX
E45C   BPL $E455
E45E   RTS


; startup messages

E45F   .byte $00

; basic bytes free

E460   .byte $20,$42,$41,$53,$49,$43
E466   .byte $20,$42,$59,$54,$45,$53
E46C   .byte $20,$46,$52,$45,$45
E471   .byte $0D
E472   .byte $00

; **** commodore 64 basic v2 ****

E473   .byte $93,$0D,$20,$20,$20
E478   .byte $20,$2A,$2A,$2A,$2A
E47D   .byte $20,$43,$4F,$4D,$4D,$4F,$44,$4F,$52,$45
E487   .byte $20,$36,$34
E48A   .byte $20,$42,$41,$53,$49,$43
E490   .byte $20,$56,$32
E493   .byte $20,$2A,$2A,$2A,$2A
E498   .byte $0D,$0D

; 64k ram system

E49A   .byte $20,$36,$34,$4B
E49E   .byte $20,$52,$41,$4D
E4A2   .byte $20,$53,$59,$53,$54,$45,$4D
E4A9   .byte $20,$20
E4AB   .byte $00

E4AC   .byte $81


; set output device

E4AD   PHA
E4AE   JSR $FFC9
E4B1   TAX
E4B2   PLA
E4B3   BCC $E4B6
E4B5   TXA
E4B6   RTS


; unused

E4B7   .byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
E4BF   .byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
E4C7   .byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
E4CF   .byte $AA,$AA,$AA,$AA


E4D3   STA $A9

E4D5   LDA #$01
E4D7   STA $AB
E4D9   RTS


; clear byte in color ram

E4DA   LDA $0286
E4DD   STA ($F3),Y
E4DF   RTS


; pause after finding a file on casette

E4E0   ADC #$02
E4E2   LDY $91
E4E4   INY
E4E5   BNE $E4EB
E4E7   CMP $A1
E4E9   BNE $E4E2
E4EB   RTS


; baud rate factor table

E4EC   .word $2619   ; 50
E4EE   .word $1944   ; 75
E4F0   .word $111A   ; 110
E4F2   .word $0DE8   ; 134.5
E4F4   .word $0C70   ; 150
E4F6   .word $0606   ; 300
E4F8   .word $02D1   ; 600
E4FA   .word $0137   ; 1200
E4FC   .word $00AE   ; 1800
E4FE   .word $0069   ; 2400


; read base address of I/O device into XY

E500   LDX #$00   ; low  DC00
E502   LDY #$DC   ; high DC00
E504   RTS


; read screen size

E505   LDX #$28   ; 40 columns
E507   LDY #$19   ; 25 rows
E509   RTS


; read/set XY cursor position

E50A   BCS $E513
E50C   STX $D6
E50E   STY $D3
E510   JSR $E56C
E513   LDX $D6
E515   LDY $D3
E517   RTS


; initialise screen and keyboard

E518   JSR $E5A0
E51B   LDA #$00
E51D   STA $0291
E520   STA $CF
E522   LDA #$48   ; low  EB48
E524   STA $028F
E527   LDA #$EB   ; high EB48
E529   STA $0290
E52C   LDA #$0A
E52E   STA $0289
E531   STA $028C
E534   LDA #$0E
E536   STA $0286
E539   LDA #$04
E53B   STA $028B
E53E   LDA #$0C
E540   STA $CD
E542   STA $CC

E544   LDA $0288

E547   ORA #$80
E549   TAY
E54A   LDA #$00
E54C   TAX
E54D   STY $D9,X
E54F   CLC
E550   ADC #$28
E552   BCC $E555
E554   INY
E555   INX
E556   CPX #$1A
E558   BNE $E54D
E55A   LDA #$FF
E55C   STA $D9,X
E55E   LDX #$18
E560   JSR $E9FF
E563   DEX
E564   BPL $E560

E566   LDY #$00

E568   STY $D3
E56A   STY $D6


; set address of curent screen line

E56C   LDX $D6
E56E   LDA $D3
E570   LDY $D9,X
E572   BMI $E57C
E574   CLC
E575   ADC #$28
E577   STA $D3
E579   DEX
E57A   BPL $E570
E57C   JSR $E9F0
E57F   LDA #$27
E581   INX
E582   LDY $D9,X
E584   BMI $E58C
E586   CLC
E587   ADC #$28
E589   INX
E58A   BPL $E582
E58C   STA $D5
E58E   JMP $EA24

E591   CPX $C9

E593   BEQ $E598
E595   JMP $E6ED
E598   RTS

E599   NOP


; this code is unused by kernel
; since no other part of the
; rom jumps to this location!

E59A   JSR $E5A0
E59D   JMP $E566


; initialise vic chip

E5A0   LDA #$03
E5A2   STA $9A
E5A4   LDA #$00
E5A6   STA $99
E5A8   LDX #$2F
E5AA   LDA $ECB8,X
E5AD   STA $CFFF,X
E5B0   DEX
E5B1   BNE $E5AA
E5B3   RTS


; get character from keyboard buffer

E5B4   LDY $0277
E5B7   LDX #$00
E5B9   LDA $0278,X
E5BC   STA $0277,X
E5BF   INX
E5C0   CPX $C6
E5C2   BNE $E5B9
E5C4   DEC $C6
E5C6   TYA
E5C7   CLI
E5C8   CLC
E5C9   RTS

; wait for return for keyboard
E5CA   JSR $E716
E5CD   LDA $C6
E5CF   STA $CC
E5D1   STA $0292
E5D4   BEQ $E5CD
E5D6   SEI
E5D7   LDA $CF
E5D9   BEQ $E5E7
E5DB   LDA $CE
E5DD   LDX $0287
E5E0   LDY #$00
E5E2   STY $CF
E5E4   JSR $EA13
E5E7   JSR $E5B4
E5EA   CMP #$83
E5EC   BNE $E5FE
E5EE   LDX #$09
E5F0   SEI
E5F1   STX $C6
E5F3   LDA $ECE6,X
E5F6   STA $0276,X
E5F9   DEX
E5FA   BNE $E5F3
E5FC   BEQ $E5CD
E5FE   CMP #$0D
E600   BNE $E5CA
E602   LDY $D5
E604   STY $D0
E606   LDA ($D1),Y
E608   CMP #$20
E60A   BNE $E60F
E60C   DEY
E60D   BNE $E606
E60F   INY
E610   STY $C8
E612   LDY #$00
E614   STY $0292
E617   STY $D3
E619   STY $D4
E61B   LDA $C9
E61D   BMI $E63A
E61F   LDX $D6
E621   JSR $E591
E624   CPX $C9
E626   BNE $E63A
E628   LDA $CA
E62A   STA $D3
E62C   CMP $C8
E62E   BCC $E63A
E630   BCS $E65D


; get character from device 0 or 3

E632   TYA
E633   PHA
E634   TXA
E635   PHA
E636   LDA $D0
E638   BEQ $E5CD


; get character from current screen line

E63A   LDY $D3
E63C   LDA ($D1),Y
E63E   STA $D7
E640   AND #$3F
E642   ASL $D7
E644   BIT $D7
E646   BPL $E64A
E648   ORA #$80
E64A   BCC $E650
E64C   LDX $D4
E64E   BNE $E654
E650   BVS $E654
E652   ORA #$40
E654   INC $D3
E656   JSR $E684
E659   CPY $C8
E65B   BNE $E674
E65D   LDA #$00
E65F   STA $D0
E661   LDA #$0D
E663   LDX $99
E665   CPX #$03
E667   BEQ $E66F
E669   LDX $9A
E66B   CPX #$03
E66D   BEQ $E672
E66F   JSR $E716
E672   LDA #$0D
E674   STA $D7
E676   PLA
E677   TAX
E678   PLA
E679   TAY
E67A   LDA $D7
E67C   CMP #$DE   ; screen PI code
E67E   BNE $E682
E680   LDA #$FF   ; petscii PI code
E682   CLC
E683   RTS


; check for quote mark and set flag

E684   CMP #$22   ; quote mark
E686   BNE $E690
E688   LDA $D4
E68A   EOR #$01
E68C   STA $D4
E68E   LDA #$22   ; quote mark
E690   RTS


; fill screen at current position

E691   ORA #$40

E693   LDX $C7

E695   BEQ $E699

E697   ORA #$80

E699   LDX $D8
E69B   BEQ $E69F
E69D   DEC $D8
E69F   LDX $0286
E6A2   JSR $EA13
E6A5   JSR $E6B6


; return from output to the screen

E6A8   PLA
E6A9   TAY
E6AA   LDA $D8
E6AC   BEQ $E6B0
E6AE   LSR $D4
E6B0   PLA
E6B1   TAX
E6B2   PLA
E6B3   CLC
E6B4   CLI
E6B5   RTS


; get/insert new line

E6B6   JSR $E8B3
E6B9   INC $D3
E6BB   LDA $D5
E6BD   CMP $D3
E6BF   BCS $E700
E6C1   CMP #$4F
E6C3   BEQ $E6F7
E6C5   LDA $0292
E6C8   BEQ $E6CD
E6CA   JMP $E967

E6CD   LDX $D6
E6CF   CPX #$19
E6D1   BCC $E6DA
E6D3   JSR $E8EA
E6D6   DEC $D6
E6D8   LDX $D6

E6DA   ASL $D9,X

E6DC   LSR $D9,X
E6DE   INX
E6DF   LDA $D9,X
E6E1   ORA #$80
E6E3   STA $D9,X
E6E5   DEX
E6E6   LDA $D5
E6E8   CLC
E6E9   ADC #$28
E6EB   STA $D5

E6ED   LDA $D9,X

E6EF   BMI $E6F4
E6F1   DEX
E6F2   BNE $E6ED
E6F4   JMP $E9F0

E6F7   DEC $D6
E6F9   JSR $E87C
E6FC   LDA #$00
E6FE   STA $D3
E700   RTS


; move backwards over a line boundary

E701   LDX $D6
E703   BNE $E70B
E705   STX $D3
E707   PLA
E708   PLA
E709   BNE $E6A8
E70B   DEX
E70C   STX $D6
E70E   JSR $E56C
E711   LDY $D5
E713   STY $D3
E715   RTS


; put a character to screen

E716   PHA
E717   STA $D7
E719   TXA
E71A   PHA
E71B   TYA
E71C   PHA
E71D   LDA #$00
E71F   STA $D0
E721   LDY $D3
E723   LDA $D7
E725   BPL $E72A
E727   JMP $E7D4

E72A   CMP #$0D   ; return code
E72C   BNE $E731
E72E   JMP $E891

E731   CMP #$20
E733   BCC $E745
E735   CMP #$60
E737   BCC $E73D
E739   AND #$DF
E73B   BNE $E73F
E73D   AND #$3F
E73F   JSR $E684
E742   JMP $E693

E745   LDX $D8
E747   BEQ $E74C
E749   JMP $E697

E74C   CMP #$14    ; delete code
E74E   BNE $E77E
E750   TYA
E751   BNE $E759
E753   JSR $E701
E756   JMP $E773

E759   JSR $E8A1
E75C   DEY
E75D   STY $D3
E75F   JSR $EA24
E762   INY
E763   LDA ($D1),Y
E765   DEY
E766   STA ($D1),Y
E768   INY
E769   LDA ($F3),Y
E76B   DEY
E76C   STA ($F3),Y
E76E   INY
E76F   CPY $D5
E771   BNE $E762

E773   LDA #$20   ; space

E775   STA ($D1),Y
E777   LDA $0286
E77A   STA ($F3),Y
E77C   BPL $E7CB
E77E   LDX $D4
E780   BEQ $E785
E782   JMP $E697

E785   CMP #$12   ;  reverse code
E787   BNE $E78B
E789   STA $C7
E78B   CMP #$13   ; home code
E78D   BNE $E792
E78F   JSR $E566
E792   CMP #$1D   ; csr right
E794   BNE $E7AD
E796   INY
E797   JSR $E8B3
E79A   STY $D3
E79C   DEY
E79D   CPY $D5
E79F   BCC $E7AA
E7A1   DEC $D6
E7A3   JSR $E87C
E7A6   LDY #$00
E7A8   STY $D3
E7AA   JMP $E6A8

E7AD   CMP #$11   ; csr down
E7AF   BNE $E7CE
E7B1   CLC
E7B2   TYA
E7B3   ADC #$28
E7B5   TAY
E7B6   INC $D6
E7B8   CMP $D5
E7BA   BCC $E7A8
E7BC   BEQ $E7A8
E7BE   DEC $D6
E7C0   SBC #$28
E7C2   BCC $E7C8
E7C4   STA $D3
E7C6   BNE $E7C0
E7C8   JSR $E87C
E7CB   JMP $E6A8

E7CE   JSR $E8CB
E7D1   JMP $EC44


; put shifted chars to screen

E7D4   AND #$7F   ; remove shift bit
E7D6   CMP #$7F   ; code for PI
E7D8   BNE $E7DC
E7DA   LDA #$5E   ; screen PI
E7DC   CMP #$20
E7DE   BCC $E7E3
E7E0   JMP $E691

E7E3   CMP #$0D   ; shift return
E7E5   BNE $E7EA
E7E7   JMP $E891
E7EA   LDX $D4
E7EC   BNE $E82D
E7EE   CMP #$14   ; insert
E7F0   BNE $E829
E7F2   LDY $D5
E7F4   LDA ($D1),Y
E7F6   CMP #$20
E7F8   BNE $E7FE
E7FA   CPY $D3
E7FC   BNE $E805
E7FE   CPY #$4F
E800   BEQ $E826
E802   JSR $E965
E805   LDY $D5
E807   JSR $EA24
E80A   DEY
E80B   LDA ($D1),Y
E80D   INY
E80E   STA ($D1),Y
E810   DEY
E811   LDA ($F3),Y
E813   INY
E814   STA ($F3),Y
E816   DEY
E817   CPY $D3
E819   BNE $E80A
E81B   LDA #$20
E81D   STA ($D1),Y
E81F   LDA $0286
E822   STA ($F3),Y
E824   INC $D8
E826   JMP $E6A8

E829   LDX $D8
E82B   BEQ $E832
E82D   ORA #$40
E82F   JMP $E697

E832   CMP #$11   ; csr up
E834   BNE $E84C
E836   LDX $D6
E838   BEQ $E871
E83A   DEC $D6
E83C   LDA $D3
E83E   SEC
E83F   SBC #$28
E841   BCC $E847
E843   STA $D3
E845   BPL $E871
E847   JSR $E56C
E84A   BNE $E871
E84C   CMP #$12    ; reverse off
E84E   BNE $E854
E850   LDA #$00
E852   STA $C7
E854   CMP #$1D   ; csr left
E856   BNE $E86A
E858   TYA
E859   BEQ $E864
E85B   JSR $E8A1
E85E   DEY
E85F   STY $D3
E861   JMP $E6A8

E864   JSR $E701
E867   JMP $E6A8

E86A   CMP #$13   ; clr code
E86C   BNE $E874
E86E   JSR $E544
E871   JMP $E6A8

E874   ORA #$80
E876   JSR $E8CB
E879   JMP $EC4F


; set next line number

E87C   LSR $C9
E87E   LDX $D6
E880   INX
E881   CPX #$19
E883   BNE $E888
E885   JSR $E8EA
E888   LDA $D9,X
E88A   BPL $E880
E88C   STX $D6
E88E   JMP $E56C


; action for return

E891   LDX #$00
E893   STX $D8
E895   STX $C7
E897   STX $D4
E899   STX $D3
E89B   JSR $E87C
E89E   JMP $E6A8


; move cursor to previous line if
; at start of line

E8A1   LDX #$02
E8A3   LDA #$00
E8A5   CMP $D3
E8A7   BEQ $E8B0
E8A9   CLC
E8AA   ADC #$28
E8AC   DEX
E8AD   BNE $E8A5
E8AF   RTS

E8B0   DEC $D6
E8B2   RTS


; move cursor to next line if
; at end of line

E8B3  LDX #$02
E8B5  LDA #$27
E8B7  CMP $D3
E8B9  BEQ $E8C2
E8BB  CLC
E8BC  ADC #$28
E8BE  DEX
E8BF  BNE $E8B7
E8C1  RTS

E8C2  LDX $D6
E8C4  CPX #$19
E8C6  BEQ $E8CA
E8C8  INC $D6
E8CA  RTS


; check for colour change codes

E8CB   LDX #$0F
E8CD   CMP $E8DA,X
E8D0   BEQ $E8D6
E8D2   DEX
E8D3   BPL $E8CD
E8D5   RTS

E8D6   STX $0286
E8D9   RTS


; colour key codes

E8DA   .byte $90,$05,$1C,$9F,$9C,$1E,$1F,$9E
E8E2   .byte $81,$95,$96,$97,$98,$99,$9A,$9B


; scroll screen

E8EA   LDA $AC
E8EC   PHA
E8ED   LDA $AD
E8EF   PHA
E8F0   LDA $AE
E8F2   PHA
E8F3   LDA $AF
E8F5   PHA
E8F6   LDX #$FF
E8F8   DEC $D6
E8FA   DEC $C9
E8FC   DEC $02A5
E8FF   INX
E900   JSR $E9F0
E903   CPX #$18
E905   BCS $E913
E907   LDA $ECF1,X
E90A   STA $AC
E90C   LDA $DA,X
E90E   JSR $E9C8
E911   BMI $E8FF
E913   JSR $E9FF
E916   LDX #$00
E918   LDA $D9,X
E91A   AND #$7F
E91C   LDY $DA,X
E91E   BPL $E922
E920   ORA #$80
E922   STA $D9,X
E924   INX
E925   CPX #$18
E927   BNE $E918
E929   LDA $F1
E92B   ORA #$80
E92D   STA $F1
E92F   LDA $D9
E931   BPL $E8F6
E933   INC $D6
E935   INC $02A5
E938   LDA #$7F
E93A   STA $DC00
E93D   LDA $DC01
E940   CMP #$FB
E942   PHP
E943   LDA #$7F
E945   STA $DC00
E948   PLP
E949   BNE $E956
E94B   LDY #$00
E94D   NOP
E94E   DEX
E94F   BNE $E94D
E951   DEY
E952   BNE $E94D
E954   STY $C6
E956   LDX $D6

E958   PLA

E959   STA $AF
E95B   PLA
E95C   STA $AE
E95E   PLA
E95F   STA $AD
E961   PLA
E962   STA $AC
E964   RTS


; insert blank line in screen

E965   LDX $D6

E967   INX

E968   LDA $D9,X
E96A   BPL $E967
E96C   STX $02A5
E96F   CPX #$18
E971   BEQ $E981
E973   BCC $E981
E975   JSR $E8EA
E978   LDX $02A5
E97B   DEX
E97C   DEC $D6
E97E   JMP $E6DA

E981   LDA $AC
E983   PHA
E984   LDA $AD
E986   PHA
E987   LDA $AE
E989   PHA
E98A   LDA $AF
E98C   PHA
E98D   LDX #$19
E98F   DEX
E990   JSR $E9F0
E993   CPX $02A5
E996   BCC $E9A6
E998   BEQ $E9A6
E99A   LDA $ECEF,X
E99D   STA $AC
E99F   LDA $D8,X
E9A1   JSR $E9C8
E9A4   BMI $E98F
E9A6   JSR $E9FF
E9A9   LDX #$17
E9AB   CPX $02A5
E9AE   BCC $E9BF
E9B0   LDA $DA,X
E9B2   AND #$7F
E9B4   LDY $D9,X
E9B6   BPL $E9BA
E9B8   ORA #$80
E9BA   STA $DA,X
E9BC   DEX
E9BD   BNE $E9AB
E9BF   LDX $02A5
E9C2   JSR $E6DA
E9C5   JMP $E958


; move one screen line

E9C8   AND #$03
E9CA   ORA $0288
E9CD   STA $AD
E9CF   JSR $E9E0
E9D2   LDY #$27
E9D4   LDA ($AC),Y
E9D6   STA ($D1),Y
E9D8   LDA ($AE),Y
E9DA   STA ($F3),Y
E9DC   DEY
E9DD   BPL $E9D4
E9DF   RTS


; set colour and screen addresses

E9E0   JSR $EA24
E9E3   LDA $AC
E9E5   STA $AE
E9E7   LDA $AD
E9E9   AND #$03
E9EB   ORA #$D8
E9ED   STA $AF
E9EF   RTS


; fetch screen addresses

E9F0   LDA $ECF0,X
E9F3   STA $D1
E9F5   LDA $D9,X
E9F7   AND #$03
E9F9   ORA $0288
E9FC   STA $D2
E9FE   RTS


; clear one screen line

E9FF   LDY #$27
EA01   JSR $E9F0
EA04   JSR $EA24
EA07   JSR $E4DA
EA0A   LDA #$20
EA0C   STA ($D1),Y
EA0E   DEY
EA0F   BPL $EA07
EA11   RTS

EA12   NOP


; set cursor flash timing and colour memory addresses

EA13   TAY
EA14   LDA #$02
EA16   STA $CD
EA18   JSR $EA24
EA1B   TYA


; put a char on the screen

EA1C   LDY $D3
EA1E   STA ($D1),Y
EA20   TXA
EA21   STA ($F3),Y
EA23   RTS


; set colour memory adress parallel to screen

EA24   LDA $D1
EA26   STA $F3
EA28   LDA $D2
EA2A   AND #$03
EA2C   ORA #$D8
EA2E   STA $F4
EA30   RTS


; normal IRQ interrupt

EA31   JSR $FFEA   ; do clock
EA34   LDA $CC   ; flash cursor
EA36   BNE $EA61
EA38   DEC $CD
EA3A   BNE $EA61
EA3C   LDA #$14
EA3E   STA $CD
EA40   LDY $D3
EA42   LSR $CF
EA44   LDX $0287
EA47   LDA ($D1),Y
EA49   BCS $EA5C
EA4B   INC $CF
EA4D   STA $CE
EA4F   JSR $EA24
EA52   LDA ($F3),Y
EA54   STA $0287
EA57   LDX $0286
EA5A   LDA $CE
EA5C   EOR #$80
EA5E   JSR $EA1C   ; display cursor
EA61   LDA $01   ; checl cassette sense
EA63   AND #$10
EA65   BEQ $EA71
EA67   LDY #$00
EA69   STY $C0
EA6B   LDA $01
EA6D   ORA #$20
EA6F   BNE $EA79
EA71   LDA $C0
EA73   BNE $EA7B
EA75   LDA $01
EA77   AND #$1F
EA79   STA $01
EA7B   JSR $EA87   ; scan keyboard
EA7E   LDA $DC0D
EA81   PLA
EA82   TAY
EA83   PLA
EA84   TAX
EA85   PLA
EA86   RTI


; scan keyboard

EA87   LDA #$00
EA89   STA $028D
EA8C   LDY #$40
EA8E   STY $CB
EA90   STA $DC00
EA93   LDX $DC01
EA96   CPX #$FF
EA98   BEQ $EAFB
EA9A   TAY
EA9B   LDA #$81
EA9D   STA $F5
EA9F   LDA #$EB
EAA1   STA $F6
EAA3   LDA #$FE
EAA5   STA $DC00
EAA8   LDX #$08
EAAA   PHA
EAAB   LDA $DC01
EAAE   CMP $DC01
EAB1   BNE $EAAB
EAB3   LSR
EAB4   BCS $EACC
EAB6   PHA
EAB7   LDA ($F5),Y
EAB9   CMP #$05
EABB   BCS $EAC9
EABD   CMP #$03
EABF   BEQ $EAC9
EAC1   ORA $028D
EAC4   STA $028D
EAC7   BPL $EACB
EAC9   STY $CB
EACB   PLA
EACC   INY
EACD   CPY #$41
EACF   BCS $EADC
EAD1   DEX
EAD2   BNE $EAB3
EAD4   SEC
EAD5   PLA
EAD6   ROL
EAD7   STA $DC00
EADA   BNE $EAA8
EADC   PLA
EADD   JMP ($028F)

EAE0   LDY $CB

EAE2   LDA ($F5),Y
EAE4   TAX
EAE5   CPY $C5
EAE7   BEQ $EAF0
EAE9   LDY #$10
EAEB   STY $028C
EAEE   BNE $EB26
EAF0   AND #$7F
EAF2   BIT $028A
EAF5   BMI $EB0D
EAF7   BVS $EB42
EAF9   CMP #$7F
EAFB   BEQ $EB26
EAFD   CMP #$14   ; delete
EAFF   BEQ $EB0D
EB01   CMP #$20   ; space
EB03   BEQ $EB0D
EB05   CMP #$1D   ; csr right/left
EB07   BEQ $EB0D
EB09   CMP #$11   ; csr up/down
EB0B   BNE $EB42
EB0D   LDY $028C
EB10   BEQ $EB17
EB12   DEC $028C
EB15   BNE $EB42
EB17   DEC $028B
EB1A   BNE $EB42
EB1C   LDY #$04
EB1E   STY $028B
EB21   LDY $C6
EB23   DEY
EB24   BPL $EB42
EB26   LDY $CB
EB28   STY $C5
EB2A   LDY $028D
EB2D   STY $028E
EB30   CPX #$FF
EB32   BEQ $EB42
EB34   TXA
EB35   LDX $C6
EB37   CPX $0289
EB3A   BCS $EB42
EB3C   STA $0277,X
EB3F   INX
EB40   STX $C6
EB42   LDA #$7F
EB44   STA $DC00
EB47   RTS

EB48   LDA $028D
EB4B   CMP #$03
EB4D   BNE $EB64
EB4F   CMP $028E
EB52   BEQ $EB42
EB54   LDA $0291
EB57   BMI $EB76
EB59   LDA $D018
EB5C   EOR #$02
EB5E   STA $D018
EB61   JMP $EB76


; select keyboard table

EB64   ASL
EB65   CMP #$08
EB67   BCC $EB6B
EB69   LDA #$06
EB6B   TAX
EB6C   LDA $EB79,X
EB6F   STA $F5
EB71   LDA $EB7A,X
EB74   STA $F6

EB76   JMP $EAE0



; table addresses

EB79   .word $EB81   ; standard
EB7B   .word $EBC2   ; shift
EB7D   .word $EC03   ; commodore key
EB7F   .word $EC78   ; control


; standard keyboard table

EB81   .byte $14,$0D,$1D,$88,$85,$86,$87,$11
EB89   .byte $33,$57,$41,$34,$5A,$53,$45,$01
EB91   .byte $35,$52,$44,$36,$43,$46,$54,$58
EB99   .byte $37,$59,$47,$38,$42,$48,$55,$56
EBA1   .byte $39,$49,$4A,$30,$4D,$4B,$4F,$4E
EBA9   .byte $2B,$50,$4C,$2D,$2E,$3A,$40,$2C
EBB1   .byte $5C,$2A,$3B,$13,$01,$3D,$5E,$2F
EBB9   .byte $31,$5F,$04,$32,$20,$02,$51,$03
EBC1   .byte $FF


; shift keyboard table

EBC2   .byte $94,$8D,$9D,$8C,$89,$8A,$8B,$91
EBCA   .byte $23,$D7,$C1,$24,$DA,$D3,$C5,$01
EBD2   .byte $25,$D2,$C4,$26,$C3,$C6,$D4,$D8
EBDA   .byte $27,$D9,$C7,$28,$C2,$C8,$D5,$D6
EBE2   .byte $29,$C9,$CA,$30,$CD,$CB,$CF,$CE
EBEA   .byte $DB,$D0,$CC,$DD,$3E,$5B,$BA,$3C
EBF2   .byte $A9,$C0,$5D,$93,$01,$3D,$DE,$3F
EBFA   .byte $21,$5F,$04,$22,$A0,$02,$D1,$83
EC02   .byte $FF


; commodore key keyboard table

EC03   .byte $94,$8D,$9D,$8C,$89,$8A,$8B,$91
EC0B   .byte $96,$B3,$B0,$97,$AD,$AE,$B1,$01
EC13   .byte $98,$B2,$AC,$99,$BC,$BB,$A3,$BD
EC1B   .byte $9A,$B7,$A5,$9B,$BF,$B4,$B8,$BE
EC23   .byte $29,$A2,$B5,$30,$A7,$A1,$B9,$AA
EC2B   .byte $A6,$AF,$B6,$DC,$3E,$5B,$A4,$3C
EC33   .byte $A8,$DF,$5D,$93,$01,$3D,$DE,$3F
EC3B   .byte $81,$5F,$04,$95,$A0,$02,$AB,$83
EC43   .byte $FF


; check for special petscii codes

EC44   CMP #$0E
EC46   BNE $EC4F
EC48   LDA $D018
EC4B   ORA #$02
EC4D   BNE $EC58

EC4F   CMP #$8E

EC51   BNE $EC5E
EC53   LDA $D018
EC56   AND #$FD
EC58   STA $D018
EC5B   JMP $E6A8


; shift + commodore key check

EC5E   CMP #$08
EC60   BNE $EC69
EC62   LDA #$80
EC64   ORA $0291
EC67   BMI $EC72
EC69   CMP #$09
EC6B   BNE $EC5B
EC6D   LDA #$7F
EC6F   AND $0291
EC72   STA $0291
EC75   JMP $E6A8


; control keyboard table

EC78   .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
EC80   .byte $1C,$17,$01,$9F,$1A,$13,$05,$FF
EC88   .byte $9C,$12,$04,$1E,$03,$06,$14,$18
EC90   .byte $1F,$19,$07,$9E,$02,$08,$15,$16
EC98   .byte $12,$09,$0A,$92,$0D,$0B,$0F,$0E
ECA0   .byte $FF,$10,$0C,$FF,$FF,$1B,$00,$FF
ECA8   .byte $1C,$FF,$1D,$FF,$FF,$1F,$1E,$FF
ECB0   .byte $90,$06,$FF,$05,$FF,$FF,$11,$FF
ECB8   .byte $FF


; default values for VIC chip

ECB9   .byte $00,$00   ; sprite 1 x,y
ECBB   .byte $00,$00   ; sprite 2 x,y
ECBD   .byte $00,$00   ; sprite 3 x,y
ECBF   .byte $00,$00   ; sprite 4 x,y
ECC1   .byte $00,$00   ; sprite 5 x,y
ECC3   .byte $00,$00   ; sprite 6 x,y
ECC5   .byte $00,$00   ; sprite 7 x,y
ECC7   .byte $00,$00   ; sprite 8 x,y
ECC9   .byte $00
ECCA   .byte $9B
ECCB   .byte $37
ECCC   .byte $00
ECCD   .byte $00
ECCE   .byte $00
ECCF   .byte $08
ECD0   .byte $00   ; sprite Y expand
ECD1   .byte $14
ECD2   .byte $0F
ECD3   .byte $00
ECD4   .byte $00
ECD5   .byte $00   ; sprite multi-colour
ECD6   .byte $00   ; sprite X expand
ECD7   .byte $00
ECD8   .byte $00
ECD9   .byte $0E   ; boarder colour
ECDA   .byte $06   ; background colour
ECDB   .byte $01
ECDC   .byte $02
ECDD   .byte $03
ECDE   .byte $04
ECDF   .byte $00   ; sprite colour
ECE0   .byte $01   ; sprite colour
ECE1   .byte $02   ; sprite colour
ECE2   .byte $03   ; sprite colour
ECE3   .byte $04   ; sprite colour
ECE4   .byte $05   ; sprite colour
ECE5   .byte $06   ; sprite colour
ECE6   .byte $07   ; sprite colour


; load

ECE7   .byte $4C,$4F,$41,$44,$0D

; run

ECEC   .byte $52,$55,$4E,$0D


; low bytes of screen line addresses

ECF0   .byte $00,$28,$50,$78,$A0
ECF5   .byte $C8,$F0,$18,$40,$68
ECFA   .byte $90,$B8,$E0,$08,$30
ECFF   .byte $58,$80,$A8,$D0,$F8
ED04   .byte $20,$48,$70,$98,$C0


; send talk on serial bus

ED09   ORA #$40
ED0B   .byte $2C


; send listen on serial bus

ED0C   ORA #$20
ED0E   JSR $F0A4

ED11   PHA

ED12   BIT $94
ED14   BPL $ED20
ED16   SEC
ED17   ROR $A3
ED19   JSR $ED40
ED1C   LSR $94
ED1E   LSR $A3
ED20   PLA
ED21   STA $95
ED23   SEI
ED24   JSR $EE97
ED27   CMP #$3F
ED29   BNE $ED2E
ED2B   JSR $EE85
ED2E   LDA $DD00
ED31   ORA #$08
ED33   STA $DD00

ED36   SEI

ED37   JSR $EE8E
ED3A   JSR $EE97
ED3D   JSR $EEB3


; send byte from $95 on serial bus

ED40   SEI
ED41   JSR $EE97
ED44   JSR $EEA9
ED47   BCS $EDAD
ED49   JSR $EE85
ED4C   BIT $A3
ED4E   BPL $ED5A
ED50   JSR $EEA9
ED53   BCC $ED50
ED55   JSR $EEA9
ED58   BCS $ED55
ED5A   JSR $EEA9
ED5D   BCC $ED5A
ED5F   JSR $EE8E
ED62   LDA #$08
ED64   STA $A5
ED66   LDA $DD00
ED69   CMP $DD00
ED6C   BNE $ED66
ED6E   ASL
ED6F   BCC $EDB0
ED71   ROR $95
ED73   BCS $ED7A
ED75   JSR $EEA0
ED78   BNE $ED7D
ED7A   JSR $EE97
ED7D   JSR $EE85
ED80   NOP
ED81   NOP
ED82   NOP
ED83   NOP
ED84   LDA $DD00
ED87   AND #$DF
ED89   ORA #$10
ED8B   STA $DD00
ED8E   DEC $A5
ED90   BNE $ED66
ED92   LDA #$04
ED94   STA $DC07
ED97   LDA #$19
ED99   STA $DC0F
ED9C   LDA $DC0D
ED9F   LDA $DC0D
EDA2   AND #$02
EDA4   BNE $EDB0
EDA6   JSR $EEA9
EDA9   BCS $ED9F
EDAB   CLI
EDAC   RTS

EDAD   LDA #$80
EDAF   .byte $2C
EDB0   LDA #$03

EDB2   JSR $FE1C

EDB5   CLI
EDB6   CLC
EDB7   BCC $EE03


; send secondary address (listen) on serial bus

EDB9   STA $95
EDBB   JSR $ED36

EDBE   LDA $DD00

EDC1   AND #$F7
EDC3   STA $DD00
EDC6   RTS


; send secondary address (talk) on serial bus

EDC7   STA $95
EDC9   JSR $ED36

EDCC   SEI

EDCD   JSR $EEA0
EDD0   JSR $EDBE
EDD3   JSR $EE85
EDD6   JSR $EEA9
EDD9   BMI $EDD6
EDDB   CLI
EDDC   RTS


; output byte on serial bus

EDDD   BIT $94
EDDF   BMI $EDE6
EDE1   SEC
EDE2   ROR $94
EDE4   BNE $EDEB
EDE6   PHA
EDE7   JSR $ED40
EDEA   PLA
EDEB   STA $95
EDED   CLC
EDEE   RTS


; send talk on serial bus

EDEF   SEI
EDF0   JSR $EE8E
EDF3   LDA $DD00
EDF6   ORA #$08
EDF8   STA $DD00
EDFB   LDA #$5F
EDFD   .byte $2C


; send unlisten on serial bus

EDFE   LDA #$3F
EE00   JSR $ED11
EE03   JSR $EDBE

EE06   TXA

EE07   LDX #$0A
EE09   DEX
EE0A   BNE $EE09
EE0C   TAX
EE0D   JSR $EE85
EE10   JMP $EE97


; input byte on serial bus

EE13   SEI
EE14   LDA #$00
EE16   STA $A5
EE18   JSR $EE85
EE1B   JSR $EEA9
EE1E   BPL $EE1B
EE20   LDA #$01
EE22   STA $DC07
EE25   LDA #$19
EE27   STA $DC0F
EE2A   JSR $EE97
EE2D   LDA $DC0D
EE30   LDA $DC0D
EE33   AND #$02
EE35   BNE $EE3E
EE37   JSR $EEA9
EE3A   BMI $EE30
EE3C   BPL $EE56
EE3E   LDA $A5
EE40   BEQ $EE47
EE42   LDA #$02
EE44   JMP $EDB2

EE47   JSR $EEA0
EE4A   JSR $EE85
EE4D   LDA #$40
EE4F   JSR $FE1C
EE52   INC $A5
EE54   BNE $EE20
EE56   LDA #$08
EE58   STA $A5
EE5A   LDA $DD00
EE5D   CMP $DD00
EE60   BNE $EE5A
EE62   ASL
EE63   BPL $EE5A
EE65   ROR $A4
EE67   LDA $DD00
EE6A   CMP $DD00
EE6D   BNE $EE67
EE6F   ASL
EE70   BMI $EE67
EE72   DEC $A5
EE74   BNE $EE5A
EE76   JSR $EEA0
EE79   BIT $90
EE7B   BVC $EE80
EE7D   JSR $EE06
EE80   LDA $A4
EE82   CLI
EE83   CLC
EE84   RTS


; set serial clock line low

EE85   LDA $DD00
EE88   AND #$EF
EE8A   STA $DD00
EE8D   RTS


; set serial clock line high

EE8E   LDA $DD00
EE91   ORA #$10
EE93   STA $DD00
EE96   RTS


; set serial data line low

EE97   LDA $DD00
EE9A   AND #$DF
EE9C   STA $DD00
EE9F   RTS


; set serial data line high

EEA0   LDA $DD00
EEA3   ORA #$20
EEA5   STA $DD00
EEA8   RTS


EEA9   LDA $DD00

EEAC   CMP $DD00
EEAF   BNE $EEA9
EEB1   ASL
EEB2   RTS


; delay 1 millisecond

EEB3   TXA
EEB4   LDX #$B8
EEB6   DEX
EEB7   BNE $EEB6
EEB9   TAX
EEBA   RTS


; set next bit to transmit on RS-232

EEBB   LDA $B4
EEBD   BEQ $EF06
EEBF   BMI $EF00
EEC1   LSR $B6
EEC3   LDX #$00
EEC5   BCC $EEC8
EEC7   DEX
EEC8   TXA
EEC9   EOR $BD
EECB   STA $BD
EECD   DEC $B4
EECF   BEQ $EED7
EED1   TXA
EED2   AND #$04
EED4   STA $B5
EED6   RTS

EED7   LDA #$20
EED9   BIT $0294
EEDC   BEQ $EEF2
EEDE   BMI $EEFC
EEE0   BVS $EEF6
EEE2   LDA $BD
EEE4   BNE $EEE7
EEE6   DEX
EEE7   DEC $B4
EEE9   LDA $0293
EEEC   BPL $EED1
EEEE   DEC $B4
EEF0   BNE $EED1
EEF2   INC $B4
EEF4   BNE $EEE6
EEF6   LDA $BD
EEF8   BEQ $EEE7
EEFA   BNE $EEE6
EEFC   BVS $EEE7
EEFE   BVC $EEE6
EF00   INC $B4
EF02   LDX #$FF
EF04   BNE $EED1

EF06   LDA $0294

EF09   LSR
EF0A   BCC $EF13
EF0C   BIT $DD01
EF0F   BPL $EF2E
EF11   BVC $EF31
EF13   LDA #$00
EF15   STA $BD
EF17   STA $B5
EF19   LDX $0298
EF1C   STX $B4
EF1E   LDY $029D
EF21   CPY $029E
EF24   BEQ $EF39
EF26   LDA ($F9),Y
EF28   STA $B6
EF2A   INC $029D
EF2D   RTS


; handle RS-232 errors

EF2E   LDA #$40
EF30   .byte $2C
EF31   LDA #$10
EF33   ORA $0297
EF36   STA $0297
EF39   LDA #$01

EF3B   STA $DD0D

EF3E   EOR $02A1
EF41   ORA #$80
EF43   STA $02A1
EF46   STA $DD0D
EF49   RTS


; check control register

EF4A   LDX #$09
EF4C   LDA #$20
EF4E   BIT $0293
EF51   BEQ $EF54
EF53   DEX
EF54   BVC $EF58
EF56   DEX
EF57   DEX
EF58   RTS


; add bit input on RS-232 bus to word being input

EF59   LDX $A9
EF5B   BNE $EF90
EF5D   DEC $A8
EF5F   BEQ $EF97
EF61   BMI $EF70
EF63   LDA $A7
EF65   EOR $AB
EF67   STA $AB
EF69   LSR $A7
EF6B   ROR $AA
EF6D   RTS


; handle end of word for RS-232 input

EF6E   DEC $A8
EF70   LDA $A7
EF72   BEQ $EFDB
EF74   LDA $0293
EF77   ASL
EF78   LDA #$01
EF7A   ADC $A8
EF7C   BNE $EF6D


; enable byte reception

EF7E   LDA #$90
EF80   STA $DD0D
EF83   ORA $02A1
EF86   STA $02A1
EF89   STA $A9
EF8B   LDA #$02
EF8D   JMP $EF3B


; receiver start bit test

EF90   LDA $A7
EF92   BNE $EF7E
EF94   JMP $E4D3


; put received data into RS-232 buffer

EF97   LDY $029B
EF9A   INY
EF9B   CPY $029C
EF9E   BEQ $EFCA
EFA0   STY $029B
EFA3   DEY
EFA4   LDA $AA
EFA6   LDX $0298
EFA9   CPX #$09
EFAB   BEQ $EFB1
EFAD   LSR
EFAE   INX
EFAF   BNE $EFA9
EFB1   STA ($F7),Y
EFB3   LDA #$20
EFB5   BIT $0294
EFB8   BEQ $EF6E
EFBA   BMI $EF6D
EFBC   LDA $A7
EFBE   EOR $AB
EFC0   BEQ $EFC5
EFC2   BVS $EF6D
EFC4   .byte $2C
EFC5   BVC $EF6D
EFC7   LDA #$01
EFC9   .byte $2C
EFCA   LDA #$04
EFCC   .byte $2C
EFCD   LDA #$80
EFCF   .byte $2C
EFD0   LDA #$02
EFD2   ORA $0297
EFD5   STA $0297
EFD8   JMP $EF7E

EFDB   LDA $AA
EFDD   BNE $EFD0
EFDF   BEQ $EFCD


; output of RS-232 device

EFE1   STA $9A
EFE3   LDA $0294
EFE6   LSR
EFE7   BCC $F012
EFE9   LDA #$02
EFEB   BIT $DD01
EFEE   BPL $F00D
EFF0   BNE $F012
EFF2   LDA $02A1
EFF5   AND #$02
EFF7   BNE $EFF2
EFF9   BIT $DD01
EFFC   BVS $EFF9
EFFE   LDA $DD01
F001   ORA #$02
F003   STA $DD01
F006   BIT $DD01
F009   BVS $F012
F00B   BMI $F006

F00D   LDA #$40

F00F   STA $0297
F012   CLC
F013   RTS


; buffer char to output on RS-232

F014   JSR $F028

F017   LDY $029E

F01A   INY
F01B   CPY $029D
F01E   BEQ $F014
F020   STY $029E
F023   DEY
F024   LDA $9E
F026   STA ($F9),Y

F028   LDA $02A1

F02B   LSR
F02C   BCS $F04C
F02E   LDA #$10
F030   STA $DD0E
F033   LDA $0299
F036   STA $DD04
F039   LDA $029A
F03C   STA $DD05
F03F   LDA #$81
F041   JSR $EF3B
F044   JSR $EF06
F047   LDA #$11
F049   STA $DD0E
F04C   RTS


; initalise RS-232 input

F04D   STA $99
F04F   LDA $0294
F052   LSR
F053   BCC $F07D
F055   AND #$08
F057   BEQ $F07D
F059   LDA #$02
F05B   BIT $DD01
F05E   BPL $F00D
F060   BEQ $F084
F062   LDA $02A1
F065   LSR
F066   BCS $F062
F068   LDA $DD01
F06B   AND #$FD
F06D   STA $DD01
F070   LDA $DD01
F073   AND #$04
F075   BEQ $F070
F077   LDA #$90
F079   CLC
F07A   JMP $EF3B

F07D   LDA $02A1
F080   AND #$12
F082   BEQ $F077
F084   CLC
F085   RTS


; get next character from RS-232 input buffer

F086   LDA $0297
F089   LDY $029C
F08C   CPY $029B
F08F   BEQ $F09C
F091   AND #$F7
F093   STA $0297
F096   LDA ($F7),Y
F098   INC $029C
F09B   RTS

F09C   ORA #$08
F09E   STA $0297
F0A1   LDA #$00
F0A3   RTS


; protect serial/casette routine from RS-232 NMI's

F0A4   PHA
F0A5   LDA $02A1
F0A8   BEQ $F0BB
F0AA   LDA $02A1
F0AD   AND #$03
F0AF   BNE $F0AA
F0B1   LDA #$10
F0B3   STA $DD0D
F0B6   LDA #$00
F0B8   STA $02A1
F0BB   PLA
F0BC   RTS


; kernal I/O messages
; I/O error

F0BD   .byte $0D
F0BE   .byte $49,$2F,$4F
F0C1   .byte $20,$45,$52,$52,$4F,$52
F0C7   .byte $20,$A3

; searching for

F0C9   .byte $0D
F0CA   .byte $53,$45,$41,$52,$43,$48,$49,$4E,$47,$A0
F0D4   .byte $46,$4F,$52,$A0

; press play on tape

F0D8   .byte $0D
F0D9   .byte $50,$52,$45,$53,$53
F0DE   .byte $20,$50,$4C,$41,$59
F0E3   .byte $20,$4F,$4E
F0E6   .byte $20,$54,$41,$50,$C5

; press record and play on tape

F0EB   .byte $50,$52,$45,$53,$53
F0F0   .byte $20,$52,$45,$43,$4F,$52,$44
F0F7   .byte $20,$26
F0F9   .byte $20,$50,$4C,$41,$59
F0FE   .byte $20,$4F,$4E
F101   .byte $20,$54,$41,$50,$C5

; loading

F106   .byte $0D
F107   .byte $4C,$4F,$41,$44,$49,$4E,$C7

; saving

F10E   .byte $0D
F10F   .byte $53,$41,$56,$49,$4E,$47,$A0

; verifying

F116   .byte $0D
F117   .byte $56,$45,$52,$49,$46,$59,$49,$4E,$C7

; found

F120   .byte $0D
F121   .byte $46,$4F,$55,$4E,$44,$A0

; ok

F127   .byte $0D
F128   .byte $4F,$4B,$8D


; print kernal message indexed by Y

F12B   BIT $9D
F12D   BPL $F13C

F12F   LDA $F0BD,Y

F132   PHP
F133   AND #$7F
F135   JSR $FFD2
F138   INY
F139   PLP
F13A   BPL $F12F
F13C   CLC
F13D   RTS


; get a character

F13E   LDA $99
F140   BNE $F14A
F142   LDA $C6
F144   BEQ $F155
F146   SEI
F147   JMP $E5B4

F14A   CMP #$02
F14C   BNE $F166

F14E   STY $97

F150   JSR $F086
F153   LDY $97
F155   CLC
F156   RTS


; input a character

F157   LDA $99
F159   BNE $F166
F15B   LDA $D3
F15D   STA $CA
F15F   LDA $D6
F161   STA $C9
F163   JMP $E632

F166   CMP #$03
F168   BNE $F173
F16A   STA $D0
F16C   LDA $D5
F16E   STA $C8
F170   JMP $E632

F173   BCS $F1AD
F175   CMP #$02
F177   BEQ $F1B8
F179   STX $97
F17B   JSR $F199
F17E   BCS $F196
F180   PHA
F181   JSR $F199
F184   BCS $F193
F186   BNE $F18D
F188   LDA #$40
F18A   JSR $FE1C
F18D   DEC $A6
F18F   LDX $97
F191   PLA
F192   RTS

F193   TAX
F194   PLA
F195   TXA
F196   LDX $97
F198   RTS


; read a byte from cassette buffer

F199   JSR $F80D
F19C   BNE $F1A9
F19E   JSR $F841
F1A1   BCS $F1B4
F1A3   LDA #$00
F1A5   STA $A6
F1A7   BEQ $F199
F1A9   LDA ($B2),Y
F1AB   CLC
F1AC   RTS

F1AD   LDA $90
F1AF   BEQ $F1B5
F1B1   LDA #$0D
F1B3   CLC
F1B4   RTS


; read a byte from serial bus

F1B5   JMP $EE13


; read a byte from RS-232 bus

F1B8   JSR $F14E
F1BB   BCS $F1B4
F1BD   CMP #$00
F1BF   BNE $F1B3
F1C1   LDA $0297
F1C4   AND #$60
F1C6   BNE $F1B1
F1C8   BEQ $F1B8


; output a character

F1CA   PHA
F1CB   LDA $9A
F1CD   CMP #$03
F1CF   BNE $F1D5
F1D1   PLA
F1D2   JMP $E716

F1D5   BCC $F1DB
F1D7   PLA
F1D8   JMP $EDDD

F1DB   LSR
F1DC   PLA

F1DD   STA $9E

F1DF   TXA
F1E0   PHA
F1E1   TYA
F1E2   PHA
F1E3   BCC $F208
F1E5   JSR $F80D
F1E8   BNE $F1F8
F1EA   JSR $F864
F1ED   BCS $F1FD
F1EF   LDA #$02
F1F1   LDY #$00
F1F3   STA ($B2),Y
F1F5   INY
F1F6   STY $A6
F1F8   LDA $9E
F1FA   STA ($B2),Y

F1FC   CLC

F1FD   PLA
F1FE   TAY
F1FF   PLA
F200   TAX
F201   LDA $9E
F203   BCC $F207
F205   LDA #$00
F207   RTS

F208   JSR $F017
F20B   JMP $F1FC


; set input device

F20E   JSR $F30F
F211   BEQ $F216
F213   JMP $F701

F216   JSR $F31F
F219   LDA $BA
F21B   BEQ $F233
F21D   CMP #$03
F21F   BEQ $F233
F221   BCS $F237
F223   CMP #$02
F225   BNE $F22A
F227   JMP $F04D

F22A   LDX $B9
F22C   CPX #$60
F22E   BEQ $F233
F230   JMP $F70A

F233   STA $99
F235   CLC
F236   RTS


; set serial bus input device

F237   TAX
F238   JSR $ED09
F23B   LDA $B9
F23D   BPL $F245
F23F   JSR $EDCC
F242   JMP $F248

F245   JSR $EDC7

F248   TXA

F249   BIT $90
F24B   BPL $F233
F24D   JMP $F707


; set output device

F250   JSR $F30F
F253   BEQ $F258
F255   JMP $F701

F258   JSR $F31F
F25B   LDA $BA
F25D   BNE $F262
F25F   JMP $F70D

F262   CMP #$03
F264   BEQ $F275
F266   BCS $F279
F268   CMP #$02
F26A   BNE $F26F
F26C   JMP $EFE1

F26F   LDX $B9
F271   CPX #$60
F273   BEQ $F25F
F275   STA $9A
F277   CLC
F278   RTS


; set serial bus output device

F279   TAX
F27A   JSR $ED0C
F27D   LDA $B9
F27F   BPL $F286
F281   JSR $EDBE
F284   BNE $F289
F286   JSR $EDB9
F289   TXA
F28A   BIT $90
F28C   BPL $F275
F28E   JMP $F707


; close a file

F291   JSR $F314
F294   BEQ $F298
F296   CLC
F297   RTS

F298   JSR $F31F
F29B   TXA
F29C   PHA
F29D   LDA $BA
F29F   BEQ $F2F1
F2A1   CMP #$03
F2A3   BEQ $F2F1
F2A5   BCS $F2EE
F2A7   CMP #$02
F2A9   BNE $F2C8
F2AB   PLA
F2AC   JSR $F2F2
F2AF   JSR $F483
F2B2   JSR $FE27
F2B5   LDA $F8
F2B7   BEQ $F2BA
F2B9   INY
F2BA   LDA $FA
F2BC   BEQ $F2BF
F2BE   INY
F2BF   LDA #$00
F2C1   STA $F8
F2C3   STA $FA
F2C5   JMP $F47D


; close cassette device

F2C8   LDA $B9
F2CA   AND #$0F
F2CC   BEQ $F2F1
F2CE   JSR $F7D0
F2D1   LDA #$00
F2D3   SEC
F2D4   JSR $F1DD
F2D7   JSR $F864
F2DA   BCC $F2E0
F2DC   PLA
F2DD   LDA #$00
F2DF   RTS

F2E0   LDA $B9
F2E2   CMP #$62
F2E4   BNE $F2F1
F2E6   LDA #$05
F2E8   JSR $F76A
F2EB   JMP $F2F1


; close serial bus device

F2EE   JSR $F642

F2F1   PLA



; reorganise file tables

F2F2   TAX
F2F3   DEC $98
F2F5   CPX $98
F2F7   BEQ $F30D
F2F9   LDY $98
F2FB   LDA $0259,Y
F2FE   STA $0259,X
F301   LDA $0263,Y
F304   STA $0263,X
F307   LDA $026D,Y
F30A   STA $026D,X
F30D   CLC
F30E   RTS


; check X against logical file table

F30F   LDA #$00
F311   STA $90
F313   TXA

F314   LDX $98

F316   DEX
F317   BMI $F32E
F319   CMP $0259,X
F31C   BNE $F316
F31E   RTS


; set file parameters depending on X

F31F   LDA $0259,X
F322   STA $B8
F324   LDA $0263,X
F327   STA $BA
F329   LDA $026D,X
F32C   STA $B9
F32E   RTS


; close all files

F32F   LDA #$00
F331   STA $98


; restore I/O to default devices

F333   LDX #$03
F335   CPX $9A
F337   BCS $F33C
F339   JSR $EDFE
F33C   CPX $99
F33E   BCS $F343
F340   JSR $EDEF
F343   STX $9A
F345   LDA #$00
F347   STA $99
F349   RTS


; open a file

F34A   LDX $B8
F34C   BNE $F351
F34E   JMP $F70A

F351   JSR $F30F
F354   BNE $F359
F356   JMP $F6FE

F359   LDX $98
F35B   CPX #$0A
F35D   BCC $F362
F35F   JMP $F6FB

F362   INC $98
F364   LDA $B8
F366   STA $0259,X
F369   LDA $B9
F36B   ORA #$60
F36D   STA $B9
F36F   STA $026D,X
F372   LDA $BA
F374   STA $0263,X
F377   BEQ $F3D3
F379   CMP #$03
F37B   BEQ $F3D3
F37D   BCC $F384
F37F   JSR $F3D5
F382   BCC $F3D3
F384   CMP #$02
F386   BNE $F38B
F388   JMP $F409


; open for cassette device

F38B   JSR $F7D0
F38E   BCS $F393
F390   JMP $F713

F393   LDA $B9
F395   AND #$0F
F397   BNE $F3B8
F399   JSR $F817
F39C   BCS $F3D4
F39E   JSR $F5AF
F3A1   LDA $B7
F3A3   BEQ $F3AF
F3A5   JSR $F7EA
F3A8   BCC $F3C2
F3AA   BEQ $F3D4
F3AC   JMP $F704

F3AF   JSR $F72C
F3B2   BEQ $F3D4
F3B4   BCC $F3C2
F3B6   BCS $F3AC


; open cassette for input

F3B8   JSR $F838
F3BB   BCS $F3D4
F3BD   LDA #$04
F3BF   JSR $F76A
F3C2   LDA #$BF
F3C4   LDY $B9
F3C6   CPY #$60
F3C8   BEQ $F3D1
F3CA   LDY #$00
F3CC   LDA #$02
F3CE   STA ($B2),Y
F3D0   TYA
F3D1   STA $A6
F3D3   CLC
F3D4   RTS


; open for serial bus devices

F3D5   LDA $B9
F3D7   BMI $F3D3
F3D9   LDY $B7
F3DB   BEQ $F3D3
F3DD   LDA #$00
F3DF   STA $90
F3E1   LDA $BA
F3E3   JSR $ED0C
F3E6   LDA $B9
F3E8   ORA #$F0
F3EA   JSR $EDB9
F3ED   LDA $90
F3EF   BPL $F3F6
F3F1   PLA
F3F2   PLA
F3F3   JMP $F707

F3F6   LDA $B7
F3F8   BEQ $F406
F3FA   LDY #$00
F3FC   LDA ($BB),Y
F3FE   JSR $EDDD
F401   INY
F402   CPY $B7
F404   BNE $F3FC
F406   JMP $F654


; open RS-232 device

F409   JSR $F483
F40C   STY $0297
F40F   CPY $B7
F411   BEQ $F41D
F413   LDA ($BB),Y
F415   STA $0293,Y
F418   INY
F419   CPY #$04
F41B   BNE $F40F
F41D   JSR $EF4A
F420   STX $0298
F423   LDA $0293
F426   AND #$0F
F428   BEQ $F446
F42A   ASL
F42B   TAX
F42C   LDA $02A6
F42F   BNE $F43A
F431   LDY $FEC1,X
F434   LDA $FEC0,X
F437   JMP $F440
F43A   LDY $E4EB,X
F43D   LDA $E4EA,X

F440   STY $0296

F443   STA $0295
F446   LDA $0295
F449   ASL
F44A   JSR $FF2E
F44D   LDA $0294
F450   LSR
F451   BCC $F45C
F453   LDA $DD01
F456   ASL
F457   BCS $F45C
F459   JSR $F00D
F45C   LDA $029B
F45F   STA $029C
F462   LDA $029E
F465   STA $029D
F468   JSR $FE27
F46B   LDA $F8
F46D   BNE $F474
F46F   DEY
F470   STY $F8
F472   STX $F7
F474   LDA $FA
F476   BNE $F47D
F478   DEY
F479   STY $FA
F47B   STX $F9

F47D   SEC

F47E   LDA #$F0
F480   JMP $FE2D


; initialise CIA2

F483   LDA #$7F
F485   STA $DD0D
F488   LDA #$06
F48A   STA $DD03
F48D   STA $DD01
F490   LDA #$04
F492   ORA $DD00
F495   STA $DD00
F498   LDY #$00
F49A   STY $02A1
F49D   RTS


; load ram from a device

F49E   STX $C3
F4A0   STY $C4
F4A2   JMP ($0330)   ; normally F4A5


; standard load ram entry

F4A5   STA $93
F4A7   LDA #$00
F4A9   STA $90
F4AB   LDA $BA
F4AD   BNE $F4B2
F4AF   JMP $F713

F4B2   CMP #$03
F4B4   BEQ $F4AF
F4B6   BCC $F533
F4B8   LDY $B7
F4BA   BNE $F4BF
F4BC   JMP $F710

F4BF   LDX $B9
F4C1   JSR $F5AF
F4C4   LDA #$60
F4C6   STA $B9
F4C8   JSR $F3D5
F4CB   LDA $BA
F4CD   JSR $ED09
F4D0   LDA $B9
F4D2   JSR $EDC7
F4D5   JSR $EE13
F4D8   STA $AE
F4DA   LDA $90
F4DC   LSR
F4DD   LSR
F4DE   BCS $F530
F4E0   JSR $EE13
F4E3   STA $AF
F4E5   TXA
F4E6   BNE $F4F0
F4E8   LDA $C3
F4EA   STA $AE
F4EC   LDA $C4
F4EE   STA $AF
F4F0   JSR $F5D2
F4F3   LDA #$FD
F4F5   AND $90
F4F7   STA $90
F4F9   JSR $FFE1
F4FC   BNE $F501
F4FE   JMP $F633

F501   JSR $EE13
F504   TAX
F505   LDA $90
F507   LSR
F508   LSR
F509   BCS $F4F3
F50B   TXA
F50C   LDY $93
F50E   BEQ $F51C
F510   LDY #$00
F512   CMP ($AE),Y
F514   BEQ $F51E
F516   LDA #$10
F518   JSR $FE1C
F51B   .byte $2C
F51C   STA ($AE),Y
F51E   INC $AE
F520   BNE $F524
F522   INC $AF
F524   BIT $90
F526   BVC $F4F3
F528   JSR $EDEF
F52B   JSR $F642
F52E   BCC $F5A9
F530   JMP $F704
F533   LSR
F534   BCS $F539
F536   JMP $F713

F539   JSR $F7D0
F53C   BCS $F541
F53E   JMP $F713
F541   JSR $F817
F544   BCS $F5AE
F546   JSR $F5AF
F549   LDA $B7
F54B   BEQ $F556
F54D   JSR $F7EA
F550   BCC $F55D
F552   BEQ $F5AE
F554   BCS $F530
F556   JSR $F72C
F559   BEQ $F5AE
F55B   BCS $F530
F55D   LDA $90
F55F   AND #$10
F561   SEC
F562   BNE $F5AE
F564   CPX #$01
F566   BEQ $F579
F568   CPX #$03
F56A   BNE $F549
F56C   LDY #$01
F56E   LDA ($B2),Y
F570   STA $C3
F572   INY
F573   LDA ($B2),Y
F575   STA $C4
F577   BCS $F57D
F579   LDA $B9
F57B   BNE $F56C
F57D   LDY #$03
F57F   LDA ($B2),Y
F581   LDY #$01
F583   SBC ($B2),Y
F585   TAX
F586   LDY #$04
F588   LDA ($B2),Y
F58A   LDY #$02
F58C   SBC ($B2),Y
F58E   TAY
F58F   CLC
F590   TXA
F591   ADC $C3
F593   STA $AE
F595   TYA
F596   ADC $C4
F598   STA $AF
F59A   LDA $C3
F59C   STA $C1
F59E   LDA $C4
F5A0   STA $C2
F5A2   JSR $F5D2
F5A5   JSR $F84A
F5A8   .byte $24
F5A9   CLC
F5AA   LDX $AE
F5AC   LDY $AF
F5AE   RTS


; handle messages for loading

F5AF   LDA $9D
F5B1   BPL $F5D1
F5B3   LDY #$0C
F5B5   JSR $F12F
F5B8   LDA $B7
F5BA   BEQ $F5D1
F5BC   LDY #$17
F5BE   JSR $F12F

F5C1   LDY $B7

F5C3   BEQ $F5D1
F5C5   LDY #$00
F5C7   LDA ($BB),Y
F5C9   JSR $FFD2
F5CC   INY
F5CD   CPY $B7
F5CF   BNE $F5C7
F5D1   RTS


; do load/verify message

F5D2   LDY #$49
F5D4   LDA $93
F5D6   BEQ $F5DA
F5D8   LDY #$59
F5DA   JMP $F12B


; save ram to a device

F5DD   STX $AE
F5DF   STY $AF
F5E1   TAX
F5E2   LDA $00,X
F5E4   STA $C1
F5E6   LDA $01,X
F5E8   STA $C2
F5EA   JMP ($0332)   ; normally F5ED


; standard save ram entry

F5ED   LDA $BA
F5EF   BNE $F5F4
F5F1   JMP $F713

F5F4   CMP #$03
F5F6   BEQ $F5F1
F5F8   BCC $F659
F5FA   LDA #$61
F5FC   STA $B9
F5FE   LDY $B7
F600   BNE $F605
F602   JMP $F710

F605   JSR $F3D5
F608   JSR $F68F
F60B   LDA $BA
F60D   JSR $ED0C
F610   LDA $B9
F612   JSR $EDB9
F615   LDY #$00
F617   JSR $FB8E
F61A   LDA $AC
F61C   JSR $EDDD
F61F   LDA $AD
F621   JSR $EDDD
F624   JSR $FCD1
F627   BCS $F63F
F629   LDA ($AC),Y
F62B   JSR $EDDD
F62E   JSR $FFE1
F631   BNE $F63A

F633   JSR $F642

F636   LDA #$00
F638   SEC
F639   RTS

F63A   JSR $FCDB
F63D   BNE $F624
F63F   JSR $EDFE


; close serial bus device

F642   BIT $B9
F644   BMI $F657
F646   LDA $BA
F648   JSR $ED0C
F64B   LDA $B9
F64D   AND #$EF
F64F   ORA #$E0
F651   JSR $EDB9

F654   JSR $EDFE

F657   CLC
F658   RTS

F659   LSR
F65A   BCS $F65F
F65C   JMP $F713


; save ram to cassette

F65F   JSR $F7D0
F662   BCC $F5F1
F664   JSR $F838
F667   BCS $F68E
F669   JSR $F68F
F66C   LDX #$03
F66E   LDA $B9
F670   AND #$01
F672   BNE $F676
F674   LDX #$01
F676   TXA
F677   JSR $F76A
F67A   BCS $F68E
F67C   JSR $F867
F67F   BCS $F68E
F681   LDA $B9
F683   AND #$02
F685   BEQ $F68D
F687   LDA #$05
F689   JSR $F76A
F68C   .byte $24
F68D   CLC
F68E   RTS


; do saving message and filename

F68F   LDA $9D
F691   BPL $F68E
F693   LDY #$51
F695   JSR $F12F
F698   JMP $F5C1


; increment real time clock

F69B   LDX #$00
F69D   INC $A2
F69F   BNE $F6A7
F6A1   INC $A1
F6A3   BNE $F6A7
F6A5   INC $A0
F6A7   SEC
F6A8   LDA $A2
F6AA   SBC #$01
F6AC   LDA $A1
F6AE   SBC #$1A
F6B0   LDA $A0
F6B2   SBC #$4F
F6B4   BCC $F6BC
F6B6   STX $A0
F6B8   STX $A1
F6BA   STX $A2

F6BC   LDA $DC01

F6BF   CMP $DC01
F6C2   BNE $F6BC
F6C4   TAX
F6C5   BMI $F6DA
F6C7   LDX #$BD
F6C9   STX $DC00
F6CC   LDX $DC01
F6CF   CPX $DC01
F6D2   BNE $F6CC
F6D4   STA $DC00
F6D7   INX
F6D8   BNE $F6DC
F6DA   STA $91
F6DC   RTS


; read real time clock

F6DD   SEI
F6DE   LDA $A2
F6E0   LDX $A1
F6E2   LDY $A0


; set real time clock

F6E4   SEI
F6E5   STA $A2
F6E7   STX $A1
F6E9   STY $A0
F6EB   CLI
F6EC   RTS


; test STOP key

F6ED   LDA $91
F6EF   CMP #$7F
F6F1   BNE $F6FA
F6F3   PHP
F6F4   JSR $FFCC
F6F7   STA $C6
F6F9   PLP
F6FA   RTS


; handle I/O errors

F6FB   LDA #$01   ; too many files
F6FD   .byte $2C

F6FE   LDA #$02   ; file open

F700   .byte $2C

F701   LDA #$03   ; file not open

F703   .byte $2C

F704   LDA #$04   ; file not found

F706   .byte $2C

F707   LDA #$05   ; device not present

F709   .byte $2C

F70A   LDA #$06   ; not input file

F70C   .byte $2C

F70D   LDA #$07   ; not output file

F70F   .byte $2C

F710   LDA #$08   ; file name missing

F712   .byte $2C

F713   LDA #$09   ; illegal device no.

F715   PHA
F716   JSR $FFCC
F719   LDY #$00
F71B   BIT $9D
F71D   BVC $F729
F71F   JSR $F12F
F722   PLA
F723   PHA
F724   ORA #$30
F726   JSR $FFD2
F729   PLA
F72A   SEC
F72B   RTS


; get next file header from cassette

F72C   LDA $93
F72E   PHA
F72F   JSR $F841
F732   PLA
F733   STA $93
F735   BCS $F769
F737   LDY #$00
F739   LDA ($B2),Y
F73B   CMP #$05
F73D   BEQ $F769
F73F   CMP #$01
F741   BEQ $F74B
F743   CMP #$03
F745   BEQ $F74B
F747   CMP #$04
F749   BNE $F72C
F74B   TAX
F74C   BIT $9D
F74E   BPL $F767
F750   LDY #$63
F752   JSR $F12F
F755   LDY #$05
F757   LDA ($B2),Y
F759   JSR $FFD2
F75C   INY
F75D   CPY #$15
F75F   BNE $F757
F761   LDA $A1
F763   JSR $E4E0
F766   NOP
F767   CLC
F768   DEY
F769   RTS


; write a special block to cassette with code in A

F76A   STA $9E
F76C   JSR $F7D0
F76F   BCC $F7CF
F771   LDA $C2
F773   PHA
F774   LDA $C1
F776   PHA
F777   LDA $AF
F779   PHA
F77A   LDA $AE
F77C   PHA
F77D   LDY #$BF
F77F   LDA #$20
F781   STA ($B2),Y
F783   DEY
F784   BNE $F781
F786   LDA $9E
F788   STA ($B2),Y
F78A   INY
F78B   LDA $C1
F78D   STA ($B2),Y
F78F   INY
F790   LDA $C2
F792   STA ($B2),Y
F794   INY
F795   LDA $AE
F797   STA ($B2),Y
F799   INY
F79A   LDA $AF
F79C   STA ($B2),Y
F79E   INY
F79F   STY $9F
F7A1   LDY #$00
F7A3   STY $9E
F7A5   LDY $9E
F7A7   CPY $B7
F7A9   BEQ $F7B7
F7AB   LDA ($BB),Y
F7AD   LDY $9F
F7AF   STA ($B2),Y
F7B1   INC $9E
F7B3   INC $9F
F7B5   BNE $F7A5
F7B7   JSR $F7D7
F7BA   LDA #$69
F7BC   STA $AB
F7BE   JSR $F86B
F7C1   TAY
F7C2   PLA
F7C3   STA $AE
F7C5   PLA
F7C6   STA $AF
F7C8   PLA
F7C9   STA $C1
F7CB   PLA
F7CC   STA $C2
F7CE   TYA
F7CF   RTS


; set tape buffer pointer in XY

F7D0   LDX $B2
F7D2   LDY $B3
F7D4   CPY #$02
F7D6   RTS


; set cassette buffer to I/O area

F7D7   JSR $F7D0
F7DA   TXA
F7DB   STA $C1
F7DD   CLC
F7DE   ADC #$C0
F7E0   STA $AE
F7E2   TYA
F7E3   STA $C2
F7E5   ADC #$00
F7E7   STA $AF
F7E9   RTS


; search tape for a file name

F7EA   JSR $F72C
F7ED   BCS $F80C
F7EF   LDY #$05
F7F1   STY $9F
F7F3   LDY #$00
F7F5   STY $9E
F7F7   CPY $B7
F7F9   BEQ $F80B
F7FB   LDA ($BB),Y
F7FD   LDY $9F
F7FF   CMP ($B2),Y
F801   BNE $F7EA
F803   INC $9E
F805   INC $9F
F807   LDY $9E
F809   BNE $F7F7
F80B   CLC
F80C   RTS


; add 1 to tape index and test for overflow

F80D   JSR $F7D0
F810   INC $A6
F812   LDY $A6
F814   CPY #$C0
F816   RTS


; handle messages and
; test cassette buttons for read

F817   JSR $F82E
F81A   BEQ $F836
F81C   LDY #$1B
F81E   JSR $F12F
F821   JSR $F8D0
F824   JSR $F82E
F827   BNE $F821
F829   LDY #$6A
F82B   JMP $F12F


; test sense line for a button
; depressed on cassette

F82E   LDA #$10
F830   BIT $01
F832   BNE $F836
F834   BIT $01
F836   CLC
F837   RTS


; set messages and test cassette line
; for input

F838   JSR $F82E
F83B   BEQ $F836
F83D   LDY #$2E
F83F   BNE $F81E


; read a block from cassette

F841   LDA #$00
F843   STA $90
F845   STA $93
F847   JSR $F7D7

F84A   JSR $F817

F84D   BCS $F86E
F84F   SEI
F850   LDA #$00
F852   STA $AA
F854   STA $B4
F856   STA $B0
F858   STA $9E
F85A   STA $9F
F85C   STA $9C
F85E   LDA #$90
F860   LDX #$0E
F862   BNE $F875


; write a block from cassette

F864   JSR $F7D7

F867   LDA #$14

F869   STA $AB

F86B   JSR $F838

F86E   BCS $F8DC
F870   SEI
F871   LDA #$82
F873   LDX #$08


; common code for cassette read and write

F875   LDY #$7F
F877   STY $DC0D
F87A   STA $DC0D
F87D   LDA $DC0E
F880   ORA #$19
F882   STA $DC0F
F885   AND #$91
F887   STA $02A2
F88A   JSR $F0A4
F88D   LDA $D011
F890   AND #$EF
F892   STA $D011
F895   LDA $0314
F898   STA $029F
F89B   LDA $0315
F89E   STA $02A0
F8A1   JSR $FCBD
F8A4   LDA #$02
F8A6   STA $BE
F8A8   JSR $FB97
F8AB   LDA $01
F8AD   AND #$1F
F8AF   STA $01
F8B1   STA $C0
F8B3   LDX #$FF
F8B5   LDY #$FF
F8B7   DEY
F8B8   BNE $F8B7
F8BA   DEX
F8BB   BNE $F8B5
F8BD   CLI

F8BE   LDA $02A0

F8C1   CMP $0315
F8C4   CLC
F8C5   BEQ $F8DC
F8C7   JSR $F8D0
F8CA   JSR $F6BC
F8CD   JMP $F8BE


; handle stop key during cassette operations

F8D0   JSR $FFE1
F8D3   CLC
F8D4   BNE $F8E1
F8D6   JSR $FC93
F8D9   SEC
F8DA   PLA
F8DB   PLA
F8DC   LDA #$00
F8DE   STA $02A0
F8E1   RTS


; schedule CIA1 timer A depending on X

F8E2   STX $B1
F8E4   LDA $B0
F8E6   ASL
F8E7   ASL
F8E8   CLC
F8E9   ADC $B0
F8EB   CLC
F8EC   ADC $B1
F8EE   STA $B1
F8F0   LDA #$00
F8F2   BIT $B0
F8F4   BMI $F8F7
F8F6   ROL
F8F7   ASL $B1
F8F9   ROL
F8FA   ASL $B1
F8FC   ROL
F8FD   TAX
F8FE   LDA $DC06
F901   CMP #$16
F903   BCC $F8FE
F905   ADC $B1
F907   STA $DC04
F90A   TXA
F90B   ADC $DC07
F90E   STA $DC05
F911   LDA $02A2
F914   STA $DC0E
F917   STA $02A4
F91A   LDA $DC0D
F91D   AND #$10
F91F   BEQ $F92A
F921   LDA #$F9
F923   PHA
F924   LDA #$2A
F926   PHA
F927   JMP $FF43
F92A   CLI
F92B   RTS


; cassette read IRQ routine

F92C   LDX $DC07
F92F   LDY #$FF
F931   TYA
F932   SBC $DC06
F935   CPX $DC07
F938   BNE $F92C
F93A   STX $B1
F93C   TAX
F93D   STY $DC06
F940   STY $DC07
F943   LDA #$19
F945   STA $DC0F
F948   LDA $DC0D
F94B   STA $02A3
F94E   TYA
F94F   SBC $B1
F951   STX $B1
F953   LSR
F954   ROR $B1
F956   LSR
F957   ROR $B1
F959   LDA $B0
F95B   CLC
F95C   ADC #$3C
F95E   CMP $B1
F960   BCS $F9AC
F962   LDX $9C
F964   BEQ $F969
F966   JMP $FA60

F969   LDX $A3
F96B   BMI $F988
F96D   LDX #$00
F96F   ADC #$30
F971   ADC $B0
F973   CMP $B1
F975   BCS $F993
F977   INX
F978   ADC #$26
F97A   ADC $B0
F97C   CMP $B1
F97E   BCS $F997
F980   ADC #$2C
F982   ADC $B0
F984   CMP $B1
F986   BCC $F98B
F988   JMP $FA10

F98B   LDA $B4
F98D   BEQ $F9AC
F98F   STA $A8
F991   BNE $F9AC
F993   INC $A9
F995   BCS $F999

F997   DEC $A9

F999   SEC
F99A   SBC #$13
F99C   SBC $B1
F99E   ADC $92
F9A0   STA $92
F9A2   LDA $A4
F9A4   EOR #$01
F9A6   STA $A4
F9A8   BEQ $F9D5
F9AA   STX $D7
F9AC   LDA $B4
F9AE   BEQ $F9D2
F9B0   LDA $02A3
F9B3   AND #$01
F9B5   BNE $F9BC
F9B7   LDA $02A4
F9BA   BNE $F9D2
F9BC   LDA #$00
F9BE   STA $A4
F9C0   STA $02A4
F9C3   LDA $A3
F9C5   BPL $F9F7
F9C7   BMI $F988
F9C9   LDX #$A6
F9CB   JSR $F8E2
F9CE   LDA $9B
F9D0   BNE $F98B
F9D2   JMP $FEBC

F9D5   LDA $92
F9D7   BEQ $F9E0
F9D9   BMI $F9DE
F9DB   DEC $B0
F9DD   .byte $2C
F9DE   INC $B0
F9E0   LDA #$00
F9E2   STA $92
F9E4   CPX $D7
F9E6   BNE $F9F7
F9E8   TXA
F9E9   BNE $F98B
F9EB   LDA $A9
F9ED   BMI $F9AC
F9EF   CMP #$10
F9F1   BCC $F9AC
F9F3   STA $96
F9F5   BCS $F9AC
F9F7   TXA
F9F8   EOR $9B
F9FA   STA $9B
F9FC   LDA $B4
F9FE   BEQ $F9D2
FA00   DEC $A3
FA02   BMI $F9C9
FA04   LSR $D7
FA06   ROR $BF
FA08   LDX #$DA
FA0A   JSR $F8E2
FA0D   JMP $FEBC


FA10   LDA $96

FA12   BEQ $FA18
FA14   LDA $B4
FA16   BEQ $FA1F
FA18   LDA $A3
FA1A   BMI $FA1F
FA1C   JMP $F997

FA1F   LSR $B1
FA21   LDA #$93
FA23   SEC
FA24   SBC $B1
FA26   ADC $B0
FA28   ASL
FA29   TAX
FA2A   JSR $F8E2
FA2D   INC $9C
FA2F   LDA $B4
FA31   BNE $FA44
FA33   LDA $96
FA35   BEQ $FA5D
FA37   STA $A8
FA39   LDA #$00
FA3B   STA $96
FA3D   LDA #$81
FA3F   STA $DC0D
FA42   STA $B4
FA44   LDA $96
FA46   STA $B5
FA48   BEQ $FA53
FA4A   LDA #$00
FA4C   STA $B4
FA4E   LDA #$01
FA50   STA $DC0D
FA53   LDA $BF
FA55   STA $BD
FA57   LDA $A8
FA59   ORA $A9
FA5B   STA $B6
FA5D   JMP $FEBC


; receive next byte from cassette

FA60   JSR $FB97
FA63   STA $9C
FA65   LDX #$DA
FA67   JSR $F8E2
FA6A   LDA $BE
FA6C   BEQ $FA70
FA6E   STA $A7
FA70   LDA #$0F
FA72   BIT $AA
FA74   BPL $FA8D
FA76   LDA $B5
FA78   BNE $FA86
FA7A   LDX $BE
FA7C   DEX
FA7D   BNE $FA8A
FA7F   LDA #$08
FA81   JSR $FE1C
FA84   BNE $FA8A
FA86   LDA #$00
FA88   STA $AA
FA8A   JMP $FEBC

FA8D   BVS $FAC0
FA8F   BNE $FAA9
FA91   LDA $B5
FA93   BNE $FA8A
FA95   LDA $B6
FA97   BNE $FA8A
FA99   LDA $A7
FA9B   LSR
FA9C   LDA $BD
FA9E   BMI $FAA3
FAA0   BCC $FABA
FAA2   CLC
FAA3   BCS $FABA
FAA5   AND #$0F
FAA7   STA $AA
FAA9   DEC $AA
FAAB   BNE $FA8A
FAAD   LDA #$40
FAAF   STA $AA
FAB1   JSR $FB8E
FAB4   LDA #$00
FAB6   STA $AB
FAB8   BEQ $FA8A
FABA   LDA #$80
FABC   STA $AA
FABE   BNE $FA8A
FAC0   LDA $B5
FAC2   BEQ $FACE
FAC4   LDA #$04
FAC6   JSR $FE1C
FAC9   LDA #$00
FACB   JMP $FB4A

FACE   JSR $FCD1
FAD1   BCC $FAD6
FAD3   JMP $FB48
FAD6   LDX $A7
FAD8   DEX
FAD9   BEQ $FB08
FADB   LDA $93
FADD   BEQ $FAEB
FADF   LDY #$00
FAE1   LDA $BD
FAE3   CMP ($AC),Y
FAE5   BEQ $FAEB
FAE7   LDA #$01
FAE9   STA $B6
FAEB   LDA $B6
FAED   BEQ $FB3A
FAEF   LDX #$3D
FAF1   CPX $9E
FAF3   BCC $FB33
FAF5   LDX $9E
FAF7   LDA $AD
FAF9   STA $0101,X
FAFC   LDA $AC
FAFE   STA $0100,X
FB01   INX
FB02   INX
FB03   STX $9E
FB05   JMP $FB3A

FB08   LDX $9F
FB0A   CPX $9E
FB0C   BEQ $FB43
FB0E   LDA $AC
FB10   CMP $0100,X
FB13   BNE $FB43
FB15   LDA $AD
FB17   CMP $0101,X
FB1A   BNE $FB43
FB1C   INC $9F
FB1E   INC $9F
FB20   LDA $93
FB22   BEQ $FB2F
FB24   LDA $BD
FB26   LDY #$00
FB28   CMP ($AC),Y
FB2A   BEQ $FB43
FB2C   INY
FB2D   STY $B6
FB2F   LDA $B6
FB31   BEQ $FB3A
FB33   LDA #$10
FB35   JSR $FE1C
FB38   BNE $FB43

FB3A   LDA $93

FB3C   BNE $FB43
FB3E   TAY
FB3F   LDA $BD
FB41   STA ($AC),Y
FB43   JSR $FCDB
FB46   BNE $FB8B

FB48   LDA #$80


FB4A   STA $AA

FB4C   SEI
FB4D   LDX #$01
FB4F   STX $DC0D
FB52   LDX $DC0D
FB55   LDX $BE
FB57   DEX
FB58   BMI $FB5C
FB5A   STX $BE
FB5C   DEC $A7
FB5E   BEQ $FB68
FB60   LDA $9E
FB62   BNE $FB8B
FB64   STA $BE
FB66   BEQ $FB8B
FB68   JSR $FC93
FB6B   JSR $FB8E
FB6E   LDY #$00
FB70   STY $AB
FB72   LDA ($AC),Y
FB74   EOR $AB
FB76   STA $AB
FB78   JSR $FCDB
FB7B   JSR $FCD1
FB7E   BCC $FB72
FB80   LDA $AB
FB82   EOR $BD
FB84   BEQ $FB8B
FB86   LDA #$20
FB88   JSR $FE1C
FB8B   JMP $FEBC


; move save/load address into $AC/$AD

FB8E   LDA $C2
FB90   STA $AD
FB92   LDA $C1
FB94   STA $AC
FB96   RTS


; initalise cassette read/write variables

FB97   LDA #$08
FB99   STA $A3
FB9B   LDA #$00
FB9D   STA $A4
FB9F   STA $A8
FBA1   STA $9B
FBA3   STA $A9
FBA5   RTS


; schedule CIA1 timer B and
; invert casette write line

FBA6   LDA $BD
FBA8   LSR
FBA9   LDA #$60
FBAB   BCC $FBAF

FBAD   LDA #$B0


FBAF   LDX #$00


FBB1   STA $DC06

FBB4   STX $DC07
FBB7   LDA $DC0D
FBBA   LDA #$19
FBBC   STA $DC0F
FBBF   LDA $01
FBC1   EOR #$08
FBC3   STA $01
FBC5   AND #$08
FBC7   RTS


; IRQ routine for cassette write B

FBC8   SEC
FBC9   ROR $B6
FBCB   BMI $FC09

FBCD   LDA $A8

FBCF   BNE $FBE3
FBD1   LDA #$10
FBD3   LDX #$01
FBD5   JSR $FBB1
FBD8   BNE $FC09
FBDA   INC $A8
FBDC   LDA $B6
FBDE   BPL $FC09
FBE0   JMP $FC57

FBE3   LDA $A9
FBE5   BNE $FBF0
FBE7   JSR $FBAD
FBEA   BNE $FC09
FBEC   INC $A9
FBEE   BNE $FC09
FBF0   JSR $FBA6
FBF3   BNE $FC09
FBF5   LDA $A4
FBF7   EOR #$01
FBF9   STA $A4
FBFB   BEQ $FC0C
FBFD   LDA $BD
FBFF   EOR #$01
FC01   STA $BD
FC03   AND #$01
FC05   EOR $9B
FC07   STA $9B
FC09   JMP $FEBC

FC0C   LSR $BD
FC0E   DEC $A3
FC10   LDA $A3
FC12   BEQ $FC4E
FC14   BPL $FC09
FC16   JSR $FB97
FC19   CLI
FC1A   LDA $A5
FC1C   BEQ $FC30
FC1E   LDX #$00
FC20   STX $D7
FC22   DEC $A5
FC24   LDX $BE
FC26   CPX #$02
FC28   BNE $FC2C
FC2A   ORA #$80
FC2C   STA $BD
FC2E   BNE $FC09
FC30   JSR $FCD1
FC33   BCC $FC3F
FC35   BNE $FBC8
FC37   INC $AD
FC39   LDA $D7
FC3B   STA $BD
FC3D   BCS $FC09
FC3F   LDY #$00
FC41   LDA ($AC),Y
FC43   STA $BD
FC45   EOR $D7
FC47   STA $D7
FC49   JSR $FCDB
FC4C   BNE $FC09
FC4E   LDA $9B
FC50   EOR #$01
FC52   STA $BD
FC54   JMP $FEBC


FC57   DEC $BE

FC59   BNE $FC5E
FC5B   JSR $FCCA
FC5E   LDA #$50
FC60   STA $A7
FC62   LDX #$08
FC64   SEI
FC65   JSR $FCBD
FC68   BNE $FC54


; IRQ routine for cassette write A

FC6A   LDA #$78
FC6C   JSR $FBAF
FC6F   BNE $FC54
FC71   DEC $A7
FC73   BNE $FC54
FC75   JSR $FB97
FC78   DEC $AB
FC7A   BPL $FC54
FC7C   LDX #$0A
FC7E   JSR $FCBD
FC81   CLI
FC82   INC $AB
FC84   LDA $BE
FC86   BEQ $FCB8
FC88   JSR $FB8E
FC8B   LDX #$09
FC8D   STX $A5
FC8F   STX $B6
FC91   BNE $FC16


; switch from cassette IRQ to default IRQ

FC93   PHP
FC94   SEI
FC95   LDA $D011
FC98   ORA #$10
FC9A   STA $D011
FC9D   JSR $FCCA
FCA0   LDA #$7F
FCA2   STA $DC0D
FCA5   JSR $FDDD
FCA8   LDA $02A0
FCAB   BEQ $FCB6
FCAD   STA $0315
FCB0   LDA $029F
FCB3   STA $0314
FCB6   PLP
FCB7   RTS


; terminate cassette I/O

FCB8   JSR $FC93
FCBB   BEQ $FC54


; set IRQ vector depending on X

FCBD   LDA $FD93,X
FCC0   STA $0314
FCC3   LDA $FD94,X
FCC6   STA $0315
FCC9   RTS


; stop cassette motor

FCCA   LDA $01
FCCC   ORA #$20
FCCE   STA $01
FCD0   RTS


; compare $AC/$AD with $AE/$AF

FCD1   SEC
FCD2   LDA $AC
FCD4   SBC $AE
FCD6   LDA $AD
FCD8   SBC $AF
FCDA   RTS


; increment $AC/$AD

FCDB   INC $AC
FCDD   BNE $FCE1
FCDF   INC $AD
FCE1   RTS


; RESET routine

FCE2   LDX #$FF
FCE4   SEI
FCE5   TXS
FCE6   CLD
FCE7   JSR $FD02
FCEA   BNE $FCEF
FCEC   JMP ($8000)   ; start cartridge

FCEF   STX $D016
FCF2   JSR $FDA3
FCF5   JSR $FD50
FCF8   JSR $FD15
FCFB   JSR $FF5B
FCFE   CLI
FCFF   JMP ($A000)   ; start basic


; check for a cartridge

FD02   LDX #$05
FD04   LDA $FD0F,X
FD07   CMP $8003,X
FD0A   BNE $FD0F
FD0C   DEX
FD0D   BNE $FD04
FD0F   RTS


; CBM80

FD10   .byte $C3,$C2,$CD,$38,$30


; restore I/O vectors

FD15   LDX #$30   ; low  FD30
FD17   LDY #$FD   ; high FD30
FD19   CLC


; set I/O vectors depending on XY

FD1A   STX $C3
FD1C   STY $C4
FD1E   LDY #$1F
FD20   LDA $0314,Y
FD23   BCS $FD27
FD25   LDA ($C3),Y
FD27   STA ($C3),Y
FD29   STA $0314,Y
FD2C   DEY
FD2D   BPL $FD20
FD2F   RTS


; vectors for OS at $0314-$0333

FD30   .word $EA31   ; IRQ
FD32   .word $FE66   ; BRK
FD34   .word $FE47   ; NMI
FD36   .word $F34A   ; open
FD38   .word $F291   ; close
FD3A   .word $F20E   ; set input dev
FD3C   .word $F250   ; set output dev
FD3E   .word $F333   ; restore I/O
FD40   .word $F157   ; input
FD42   .word $F1CA   ; output
FD44   .word $F6ED   ; test stop key
FD46   .word $F13E   ; get
FD48   .word $F32F   ; abort I/O
FD4A   .word $FE66   ; unused (BRK)
FD4C   .word $F4A5   ; load ram
FD4E   .word $F5ED   ; save ram


; initalise memory pointers

FD50   LDA #$00
FD52   TAY
FD53   STA $0002,Y
FD56   STA $0200,Y
FD59   STA $0300,Y
FD5C   INY
FD5D   BNE $FD53
FD5F   LDX #$3C
FD61   LDY #$03
FD63   STX $B2
FD65   STY $B3
FD67   TAY
FD68   LDA #$03
FD6A   STA $C2
FD6C   INC $C2
FD6E   LDA ($C1),Y
FD70   TAX
FD71   LDA #$55
FD73   STA ($C1),Y
FD75   CMP ($C1),Y
FD77   BNE $FD88
FD79   ROL
FD7A   STA ($C1),Y
FD7C   CMP ($C1),Y
FD7E   BNE $FD88
FD80   TXA
FD81   STA ($C1),Y
FD83   INY
FD84   BNE $FD6E
FD86   BEQ $FD6C
FD88   TYA
FD89   TAX
FD8A   LDY $C2
FD8C   CLC
FD8D   JSR $FE2D
FD90   LDA #$08
FD92   STA $0282
FD95   LDA #$04
FD97   STA $0288
FD9A   RTS


; IRQ vectors

FD9B   .word $FC6A   ; cassette write A
FD9D   .word $FBCD   ; cassette write B
FD9F   .word $EA31   ; standard IRQ
FDA1   .word $F92C   ; cassette read


; initaliase I/O devices

FDA3   LDA #$7F
FDA5   STA $DC0D
FDA8   STA $DD0D
FDAB   STA $DC00
FDAE   LDA #$08
FDB0   STA $DC0E
FDB3   STA $DD0E
FDB6   STA $DC0F
FDB9   STA $DD0F
FDBC   LDX #$00
FDBE   STX $DC03
FDC1   STX $DD03
FDC4   STX $D418
FDC7   DEX
FDC8   STX $DC02
FDCB   LDA #$07
FDCD   STA $DD00
FDD0   LDA #$3F
FDD2   STA $DD02
FDD5   LDA #$E7
FDD7   STA $01
FDD9   LDA #$2F
FDDB   STA $00


; initalise TAL1/TAH1 fpr 1/60 of a second

FDDD   LDA $02A6
FDE0   BEQ $FDEC
FDE2   LDA #$25
FDE4   STA $DC04
FDE7   LDA #$40
FDE9   JMP $FDF3

FDEC   LDA #$95
FDEE   STA $DC04
FDF1   LDA #$42

FDF3   STA $DC05

FDF6   JMP $FF6E


; initalise file name parameters

FDF9   STA $B7
FDFB   STX $BB
FDFD   STY $BC
FDFF   RTS


; inatalise file parameters

FE00   STA $B8
FE02   STX $BA
FE04   STY $B9
FE06   RTS


; read I/O status word

FE07   LDA $BA
FE09   CMP #$02
FE0B   BNE $FE1A
FE0D   LDA $0297
FE10   PHA
FE11   LDA #$00
FE13   STA $0297
FE16   PLA
FE17   RTS


; control kernel messages

FE18   STA $9D


; read ST

FE1A   LDA $90


; add A to ST

FE1C   ORA $90
FE1E   STA $90
FE20   RTS


; set timeout on serail bus

FE21   STA $0285
FE24   RTS


; read/set top of memory

FE25   BCC $FE2D

FE27   LDX $0283

FE2A   LDY $0284

FE2D   STX $0283

FE30   STY $0284
FE33   RTS


; read/set bottom of memory

FE34   BCC $FE3C
FE36   LDX $0281
FE39   LDY $0282
FE3C   STX $0281
FE3F   STY $0282
FE42   RTS


; NMI entry

FE43   SEI
FE44   JMP ($0318)   ; normally FE47


; standard NMI routine

FE47   PHA
FE48   TXA
FE49   PHA
FE4A   TYA
FE4B   PHA
FE4C   LDA #$7F
FE4E   STA $DD0D
FE51   LDY $DD0D
FE54   BMI $FE72
FE56   JSR $FD02
FE59   BNE $FE5E
FE5B   JMP ($8002)   ; cartridge warm start

FE5E   JSR $F6BC
FE61   JSR $FFE1
FE64   BNE $FE72


; BRK routine

FE66   JSR $FD15
FE69   JSR $FDA3
FE6C   JSR $E518
FE6F   JMP ($A002)


; internal NMI

FE72   TYA
FE73   AND $02A1
FE76   TAX
FE77   AND #$01
FE79   BEQ $FEA3
FE7B   LDA $DD00
FE7E   AND #$FB
FE80   ORA $B5
FE82   STA $DD00
FE85   LDA $02A1
FE88   STA $DD0D
FE8B   TXA
FE8C   AND #$12
FE8E   BEQ $FE9D
FE90   AND #$02
FE92   BEQ $FE9A
FE94   JSR $FED6
FE97   JMP $FE9D

FE9A   JSR $FF07

FE9D   JSR $EEBB

FEA0   JMP $FEB6

FEA3   TXA
FEA4   AND #$02
FEA6   BEQ $FEAE
FEA8   JSR $FED6
FEAB   JMP $FEB6

FEAE   TXA
FEAF   AND #$10
FEB1   BEQ $FEB6
FEB3   JSR $FF07

FEB6   LDA $02A1

FEB9   STA $DD0D

FEBC   PLA

FEBD   TAY
FEBE   PLA
FEBF   TAX
FEC0   PLA
FEC1   RTI


; baud rate tables

FEC2   .word $27C1   ; 50
FEC4   .word $1A3E   ; 75
FEC6   .word $11C5   ; 110
FEC8   .word $0E74   ; 134.5
FECA   .word $0CED   ; 150
FECC   .word $0645   ; 300
FECE   .word $02F0   ; 600
FED0   .word $0146   ; 1200
FED2   .word $00B8   ; 1800
FED4   .word $0071   ; 2400


; input next bit on RS-232 and schedule TB2

FED6   LDA $DD01
FED9   AND #$01
FEDB   STA $A7
FEDD   LDA $DD06
FEE0   SBC #$1C
FEE2   ADC $0299
FEE5   STA $DD06
FEE8   LDA $DD07
FEEB   ADC $029A
FEEE   STA $DD07
FEF1   LDA #$11
FEF3   STA $DD0F
FEF6   LDA $02A1
FEF9   STA $DD0D
FEFC   LDA #$FF
FEFE   STA $DD06
FF01   STA $DD07
FF04   JMP $EF59


; schedule TB2 using baud rate factor

FF07   LDA $0295
FF0A   STA $DD06
FF0D   LDA $0296
FF10   STA $DD07
FF13   LDA #$11
FF15   STA $DD0F
FF18   LDA #$12
FF1A   EOR $02A1
FF1D   STA $02A1
FF20   LDA #$FF
FF22   STA $DD06
FF25   STA $DD07
FF28   LDX $0298
FF2B   STX $A8
FF2D   RTS


; continuation of baud rate calculation

FF2E   TAX
FF2F   LDA $0296
FF32   ROL
FF33   TAY
FF34   TXA
FF35   ADC #$C8
FF37   STA $0299
FF3A   TYA
FF3B   ADC #$00
FF3D   STA $029A
FF40   RTS

FF41   NOP
FF42   NOP


FF43   PHP

FF44   PLA
FF45   AND #$EF
FF47   PHA


; IRQ entry point

FF48   PHA
FF49   TXA
FF4A   PHA
FF4B   TYA
FF4C   PHA
FF4D   TSX
FF4E   LDA $0104,X
FF51   AND #$10
FF53   BEQ $FF58
FF55   JMP ($0316)   ; normally FE66

FF58   JMP ($0314)   ; normally EA31


; addition to I/O device initalisation

FF5B   JSR $E518
FF5E   LDA $D012
FF61   BNE $FF5E
FF63   LDA $D019
FF66   AND #$01
FF68   STA $02A6
FF6B   JMP $FDDD


; end of scheduling TA for 1/60 second IRQ's

FF6E   LDA #$81
FF70   STA $DC0D
FF73   LDA $DC0E
FF76   AND #$80
FF78   ORA #$11
FF7A   STA $DC0E
FF7D   JMP $EE8E

FF80   .byte $03   ; kernal version number


; kernal vectors

FF81   JMP $FF5B   ; initalise screen and keyboard
FF84   JMP $FDA3   ; initalise I/O devices
FF87   JMP $FD50   ; initalise memory pointers
FF8A   JMP $FD15   ; restore I/O vectors
FF8D   JMP $FD1A   ; set I/O vectors from XY

FF90   JMP $FE18   ; control kernal messages

FF93   JMP $EDB9   ; read secondary address after listen
FF96   JMP $EDC7   ; read secondary address after talk

FF99   JMP $FE25   ; read/set top of memory


FF9C   JMP $FE34   ; read/set bottom of memory

FF9F   JMP $EA87   ; scan keyboard
FFA2   JMP $FE21   ; set timout for serial bus
FFA5   JMP $EE13   ; input on serial bus
FFA8   JMP $EDDD   ; output byte on serial bus
FFAB   JMP $EDEF   ; send untalk on serial bus
FFAE   JMP $EDFE   ; send unlisten on serial bus
FFB1   JMP $ED0C   ; send listen on serial bus
FFB4   JMP $ED09   ; send talk on serial bus

FFB7   JMP $FE07   ; read I/O status word


FFBA   JMP $FE00   ; set file parameters


FFBD   JMP $FDF9   ; set filename parameters


FFC0   JMP ($031A)   ; (F34A) open a file


FFC3   JMP ($031C)   ; (F291) close a file


FFC6   JMP ($031E)   ; (F20E) set input device


FFC9   JMP ($0320)   ; (F250) set output device


FFCC   JMP ($0322)   ; (F333) restore I/O devices to default


FFCF   JMP ($0324)   ; (F157) input char on current device


FFD2   JMP ($0326)   ; (F1CA) output char on current device


FFD5   JMP $F49E   ; load ram from device


FFD8   JMP $F5DD   ; save ram to device


FFDB   JMP $F6E4   ; set real time clock


FFDE   JMP $F6DD   ; read real time clock


FFE1   JMP ($0328)   ; (F6ED) check stop key


FFE4   JMP ($032A)   ; (F13E) get a character


FFE7   JMP ($032C)   ; (F32F) close all channels and files


FFEA   JMP $F69B   ; increment real time clock

FFED   JMP $E505   ; read organisation of screen into XY

FFF0   JMP $E50A   ; read/set XY cursor position


FFF3   JMP $E500   ; read base address of I/O devices



; unused

FFF6   .byte $52,$52,$42,$59

FFFA   .word $FE43   ; NMI vector
FFFC   .word $FCE2   ; RESET vector
FFFE   .word $FF48   ; IRQ/BRK vector

