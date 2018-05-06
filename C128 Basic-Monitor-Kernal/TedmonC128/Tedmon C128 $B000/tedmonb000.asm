* = $B000 ; Desired memory address where TEDMON should be located

TEDMON = *

; If the memory location is changed, monlo/monhi should be changed
; accordingly.

monlo	= <TEDMON ;$00
monhi	= >TEDMON ;$20

.include "tedmon128.asm"
.end
