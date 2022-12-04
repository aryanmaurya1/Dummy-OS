ORG 0                           
BITS 16 			
_start:
        jmp short start
        nop
times 33 db 0

start:          		
        mov ax, 0x7c0
        mov ds, ax
        mov es, ax
        jmp 0x7c0:read
read:
        mov ah, 0x2 ; READ SECTOR COMMAND
        mov al, 0x1 ; NUMBER OF SECTORS TO READ
        mov ch, 0x0 ; LOWER 8 BITS OF CYLINDER NUMBER
        mov cl, 0x2 ; SECTOR NUMBER
        mov dh, 0x0 ; HEAD NUMBER
        mov bx, buffer
        int 0x13
        jc error ; JUMP IF CARRY

        mov si, buffer
        call print
        
        jmp $		
error:
        mov si, error_message
        call print
        jmp $
print:				
        mov bx, 0
.loop:				
        lodsb			
        cmp al, 0 		
        je .done		
        call print_char		
        jmp .loop		
.done:				
        ret			
print_char:			
        mov ah, 0xe		
        int 0x10		
        ret			

error_message: db 'Failed to load sector', 0

times 510-($ - $$) db 0         
dw 0xAA55

buffer: