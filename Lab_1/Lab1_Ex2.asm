%include "io.inc"
section .data
a dd -23o       ;   Значение переменной a
b dq -21o       ;   Значение переменной b
c dq -27o       ;   Значение переменной c
p dq 0          ;   Переменная отрицательности числа
pa dq 0         ;   Переменная отрицательности числа "a"
r dd 0          ;   Результат
bm dq 0         ;   Специальная переменная для передачи данных "b" регистры стека
cm dq 0         ;   Специальная переменная для передачи данных "c" в регистры стека
cn dq 1         ;   Специальная переменная для уравнивания значения "a"
mr dq 0         ;   Сцециалная переменная, предназначенная для отрицательного a 
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, [a]
    cmp eax, 0
    jl minus_a
    ja cont
    je cont
    minus_a:
        mov eax, 1
        add [pa], eax
        mov eax, [a]
        mov ebx, -1
        mul ebx
        mov [a], eax
        jmp cont
cont:
    mov ebx, [b]
    mov ecx, [c]
    
    
    cmp ebx, 0; Узнаём отрицательность числа b
    jl module1
    
    cmp ecx, 0; Узнаём отрицательность числа c
    jl module2
    
    mov eax, [b]; В случае, если все числа положительные, добавляем значения b и c в специальные переменные
    mov [bm], eax
    mov eax, [c]
    mov [cm], eax
    jmp continue
; Метки "Модуль" предназначены для снятия отрицательного знака у чисел для упрощения вычислений    
    module1:; Срабатывает при отрицательном b и выполнеться полностью, если c > 0
        cmp ecx, 0
        jl module3; Узнаём отрицательность числа c
        mov eax, 1
        add [p], eax
        mov eax, [b]
        mov ebx, -1
        mul ebx
        mov [bm], eax
        mov eax, [c]
        mov [cm], eax
        jmp continue
    
    module2:; Срабатывает при отрицательном c и положительном b
        mov eax, 1
        add [p], eax
        mov eax, [c]
        mov ebx, -1
        mul ebx
        mov [cm], eax
        mov eax, [b]
        mov [bm], eax
        jmp continue
    
    module3:; Срабатывает при отрицательном b и c 
        mov eax, [b]
        mov ebx, -1
        mul ebx
        mov [bm], eax
        mov eax, [c]
        mov ebx, -1
        mul ebx
        mov [cm], eax
        jmp continue
    continue:; Продолжение основной программы
        FLD DWORD [a];      Делаем "a" переменной типа float
        FLD DWORD [cn]
        
        FDIV
        
        fstp DWORD [a]
        
        FLD QWORD [bm];     Заносим b и c в регистры стека и выполняем операцию деления
        FLD QWORD [cm]

        FDIV
        
        fstp DWORD [r];     Достаём значение из стекового регистра
        
        mov eax, 1;         Проводим проверку на отрицательность числа и добавляем последние части уравнения
        cmp eax, [pa]
        je final_neg_a
    final_neg:
        FLD DWORD [mr]
        FLD DWORD [r]
        FSUB
        fstp DWORD [mr]
        ret  
    final_pos:
        FLD DWORD [mr]
        FLD DWORD [r]
        FADD
        fstp DWORD [mr]
        ret
    final_neg_a:
        FLD DWORD [mr]
        FLD DWORD [a]
        FSUB
        fstp DWORD [mr]
        cmp eax, [p]
        je final_neg
        ja final_pos
        ret
