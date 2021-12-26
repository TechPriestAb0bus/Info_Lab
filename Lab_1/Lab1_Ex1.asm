%include "io.inc"
section .text
global CMAIN
CMAIN:
mov ebp, esp        ; for correct debugging
mov cl,  27o        ; Значение переменной a
mov ax,  34o        ; Значение переменной b
mov bl,  10o        ; Значение переменной c
cmp bl, 0
jl negative
cmp ax, 0
jl negative
div bl
xor ah, ah
add al, cl
PRINT_STRING 'AL contain: '
PRINT_UDEC 4, al
ret
negative:
idiv bl
xor ah, ah
add al, cl
PRINT_STRING 'AL contain: '
PRINT_UDEC 4, al
ret
