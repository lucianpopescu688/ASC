bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 0000_0000_1111_1111b
    b dw 0000_0000_1010_1100b
    c db 1111_1111b
    d dd 0                   
    
segment data use32 class=code
start:
    
    mov cl, [c]
    mov bx, [b]
    mov ax, [a]
    
    mov byte[d+0], bh
    mov byte[d+1], cl
    mov byte[d+2], ah
    mov byte[d+3], al
    mov eax, [d]

    ; Program exit
    push 0
    call [exit]