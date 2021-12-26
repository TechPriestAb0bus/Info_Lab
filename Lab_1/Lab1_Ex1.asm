%include "io.inc"
section .text
global CMAIN
CMAIN:
mov ebp, esp    ; for correct debugging
mov cl, -23     ; Значение переменной a
mov ax, -28     ; Значение переменной b
mov bl, -8      ; Значение переменной c
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
