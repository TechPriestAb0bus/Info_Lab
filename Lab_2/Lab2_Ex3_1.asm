%include "io.inc"
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    LEA     EBX, [A]    ; загружаем индекс первого элемента массива 
    MOV     ESI, EBX    ; сохраняем первый индекс для поочередного прохода
    MOV     EDI, EBX    ; сохраняем индекс для вывода массива
    MOV     DL, 0       ; присваиваем самый маленький элемент массива
    MOV     CX, 10      ; задаем счетчику значение количества элементов массива
next:
    MOV     AL, [EBX]   ; вытаскваем значение n-го элемента
    INC     EBX         ; увеличиваем индекс, чтобы потом работать со следующими элементами
    CMP     AL, DL      ;сравниваем n-ый элемент с наименьшим
    JNZ  next  ;если не совпадает, и рассматриваем следующий элемент, если совпадает, то делаем замену
    MOV     AH, [ESI]   ;сохраняем n-ый элемент
    MOV     [ESI], AL   ;записываем на его место наименьший
    SHR     AX, 8       ;сдвигаем значени регистра для получения n-го элемента
    MOV     [EBX -1], AL ; записываем n-ый элемент на бывшее место наименьшего 
    INC     ESI         ;сужаем круг неотсортированного массива
    MOV     EBX, ESI    ;задаем индекс первого элемента неотсортированного массива
    INC     DL          ;увеличиваем значение самого маленького элемента
    DEC     CX          ;уменьшаем счетчик
    CMP     CX, 0       ;если 0, то завершаем сортировку
    JA  next            ;если нет, то переходим к следующему шагу
    
;выведем отсортированный массив 
MOV EBX, EDI
MOV ECX, 10
XOR ESI, ESI
prar: 
MOV AL, [EBX + ESI]
PRINT_DEC 2, AL 
INC ESI 
LOOP prar 

    ret
section .data
A: DB 2, 4, 5, 2, 1, 4, 5, 1, 9, 0