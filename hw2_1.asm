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
    a db -5
    b db -10
    c db 1
    d dw 5

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(10*a-5*b)+(d-5*c)
        ;a,b,c byte and d word
        
        mov al, 10
        imul byte[a]
        mov bx, ax
        mov al, 5
        imul byte[b]
        sub bx, ax
        mov al, 5
        imul byte[c]
        mov cx, ax
        mov ax, [d]
        sub ax, cx
        add ax, bx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
