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
    a dd 10
    b db 7
    c db -94
    d db -2
    x dq 33

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;a-(7+x)/(b*b-c/d+2)
        ;a double and b,c,d byte and x quad
        
        mov al, [b]
        imul byte[b] ; ax = b*b
        mov bx, ax ; bx = b*b
        movsx ax, byte[c] ; ax = c
        idiv byte[d] ; al = c/d
        
        cbw
        sub bx, ax
        add bx, 2 ; bx=b*b+2
        
        mov ax, bx
        cwde
        mov ebx, eax
        ;(b*b-c/d+2)
        mov edx, dword[x+4]
        mov eax, dword[x+0]
        clc
        add eax, 7
        adc edx, 0
        idiv ebx
        ;(7+x)/(b*b-c/d+2)
        mov edx, dword[a]
        sub edx, eax
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
