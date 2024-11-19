bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 1111_1111_1111_1111b
    b dw 1010_1010_1010_1010b
    
    c dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
            mov cx, 1111_1111_1111_1111b
            mov ax, [a]
            and ax, 0000_0000_0000_0111b
            shl ax, 7
            mov bx, [b]
            and bx, 0011_1111_0000_0000b
            shl bx, 2
            or ax, bx
            mov word[c+0], ax
            mov word[c+2], cx
            mov eax, [c]
            
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
