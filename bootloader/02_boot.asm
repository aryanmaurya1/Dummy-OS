ORG 0X7c00                      ; Set the origin address of the program.
BITS 16 			; Tell the assembler that it is 16 BIT code.
start:				; A simple routine.
        mov si, message 	; Moving address of message data byte into 'si' register.
        call print		; Calling print routine.
        jmp $			; keep jumping to the same line.
print:				; Defining the print routine.
        mov bx, 0		; mov byte 0 into 'bx' register.
.loop:				; setting loop label.
        lodsb			; lodsb --> load byte at the address pointed by 'si' register into 'al' register and increment value in 'si' register.
        cmp al, 0 		; compare the value in 'al' register to byte 0.
        je .done		; if al == 0, jump to the address pointed by .done label.
        call print_char		; Call print char routine.
        jmp .loop		; Jump to address pointed by .loop label.
.done:				; setting .done label.
        ret			; Return from routine.
print_char:			; Defining print_char routine.
        mov ah, 0eh		; Moving byte '0eh' into 'ah' register.
        int 0x10		; Calling interrupt 0x10
        ret			; Return from the routine.

message: db 'Hello World!', 0	; Write data byte and ending with byte 0.

times 510-($ - $$) db 0         ; Writing data byte 0 times(510 - (current_addr - origin_addr))
dw 0xAA55			; Writing data word '0xAA55' (actual bytes 0x55AA because intel processors are reverse Endian).
