%include "io.inc"
section .data
array: db 2, 4, 5, 2, 1, 4, 5, -1, -9, 0
section .text
global CMAIN
CMAIN:
    mov ebp, esp            ; for correct debugging
    lea ebx, [array]        ; Загружаем в ebx индекс первого элемента массива 
    mov esi, ebx            ; Загружаем первый индекс для поочередного прохода
    mov edi, ebx            ; Загружаем индекс для вывода массива
    mov dl, 0               ; Загружаем наименьший элемент массива
    mov cx, 10              ; Загружаем кол-во элементов, лежащих в массиве    
front:
    mov al, [ebx]           
    inc ebx                 
    cmp al, dl              ; Проверяем, кто больше
    jnz front
    mov ah, [esi]   
    mov [esi], al   
    shr ax, 8       
    mov [ebx - 1], al  
    inc esi         
    mov ebx, esi    
    inc dl          
    dec cx          
    cmp cx, 0       
    ja  front            
 
MOV ebx, edi
MOV ecx, 10
XOR esi, esi
vivod: 
MOV al, [ebx + esi]
PRINT_DEC 2, al 
inc esi 
LOOP vivod 
ret
