%include "io.inc"
section .data
A: db 7, 341, 54, 985, 3, 0, 0, 0, 74, 1007
section .text
;Вариант 7: посчитать кол-во ненулевых элементов массива
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    lea     ebx, [A]    ;       Загрузим индекс первого элемента массива в регистр ebx
    mov     ecx, 10     ;       Задаем счетчику цикла ecx количество элементов массива
    xor     dl, dl      ;       Обнулим счётчик ненулевых элементов массива
finder:    
    mov     al, [ebx]   ;       Загрузим значение элемента массива
    cmp     al, 0       ;       Cравниваем его с нулем
    je      next        ;       Если он равен нулю, то пропустим 
    add     dl, 1       ;       Если он больше, то увеличиваем счетчик   
next:
    inc     ebx         ;       Увеличим индекс, чтобы рассмотреть следующие значения массива
    loop    finder      ;       Вводим цикл для перебора всех элементов массива
    PRINT_STRING 'Number of elements: '
    PRINT_UDEC 4, dl    ;       Выводим число элементов массива, не равных нулю
    ret
