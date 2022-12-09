[BITS 32]
global _start

CODE_SEG equ 0x08
DATA_SEG equ 0x10

_start:
        mov ax, DATA_SEG
        mov ds, ax
        mov es, ax
        mov fs, ax
        mov gs, ax
        mov ss, ax
        mov ebp, 0x00200000
        mov esp, ebp

        ; Enable A20 line
        in al, 0x92
        or al, 2
        out 0x92, al

        call print_char
        jmp $

print_char:
        mov ax, 'A'
        mov ah, 0x0c
        mov [0xb8000], ax
        ret

times 510-($ - $$) db 0