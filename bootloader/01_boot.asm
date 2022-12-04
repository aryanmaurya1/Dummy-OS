ORG 0X7c00
BITS 16
start:
    mov ah, 0xe
    mov al, 'A'
    mov bx, 0
    int 0x10
    jmp $

times 510-($ - $$) db 0
dw 0xAA55
