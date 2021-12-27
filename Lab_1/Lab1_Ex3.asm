%include "io.inc"
;Вариант: 7
section .data
aa dq -1        ;    Абцисса точки A
ao dq 6         ;    Ордината точки A
ba dq -11       ;    Абцисса точки B
bo dq 19        ;    Ордината точки B
ca dq 10        ;    Абцисса точки C
co dq 10        ;    Ордината точки C
AB dq 0         ;    Квадрат длины AB
AC dq 0         ;    Квадрат длины AC
BC dq 0         ;    Квадрат длины BC
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
; Считаем расстояние между точками
; Между A и B:
    ; Вычисляем квадрат длины катета на оси OX
    xor eax, eax
    mov eax, [aa]
    sub eax, [ba]
    mul eax
    add [AB], eax; Запишем полученное значение в переменную AB
    ; Вычисляем квадрат длины между точками  
    xor eax, eax
    mov eax, [ao]
    sub eax, [bo]
    mul eax
    add [AB], eax; Запишем квадрат длины в переменную AB
;   Между A и C:
;   Вычисляем квадрат длины катета на оси OX
    xor eax, eax
    mov eax, [aa]
    sub eax, [ca]
    mul eax
    mov [AC], eax; Запишем полученное значение в регистр AC
    ; Вычисляем квадрат длины между точками  
    xor eax, eax
    mov eax, [ao]
    sub eax, [co]
    mul eax
    add [AC], eax; Запишем квадрат длины в переменную AC
;   Между B и C:
;   Вычисляем квадрат длины катета на оси OX
    xor eax, eax
    mov eax, [ba]
    sub eax, [ca]
    mul eax
    mov [BC], eax; Запишем полученное значение в переменную BC
;   Вычисляем квадрат длины между точками  
    xor eax, eax
    mov eax, [bo]
    sub eax, [co]
    mul eax
    add [BC], eax; Запишем полученное значение в переменную BC
    mov eax, [AB]
    mov ebx, [AC]
    mov ecx, [BC]
    cmp eax, ecx
    jl final_1;     При AB < BC
    ja final_2;     При AB > BC
    je final_2;     При AB = BC
    final_1:
        cmp ecx, ebx
        jl Big_AC
        ja Big_BC
        je Big_BC
    final_2:
        cmp eax, ebx
        jl Big_AC
        ja Big_AB
        je Big_AB
    Big_AB:
        fld DWORD [AB]
        fsqrt
        fstp DWORD [AB]
        ret
    Big_AC:
        fld DWORD [AC]
        fsqrt
        fstp DWORD [AC]
        ret
    Big_BC:
        fld DWORD [BC]
        fsqrt
        fstp DWORD [BC]
        ret
    ret
