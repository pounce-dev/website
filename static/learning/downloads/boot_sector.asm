[bits 16]
[org 0x7c00]

mov [BOOT_DRIVE], dl

; ---- DO NOT CHANGE THINGS ABOVE THIS ---- ;

start: ; your start code goes here
    mov bx, osdev_string
    call String.print_string

    mov dl, [BOOT_DRIVE]
    mov bx, 0x7e00
    mov cl, 2
    call Storage.get_sector


    mov dl, [BOOT_DRIVE]
    mov bx, 0x7e00
    mov cl, 3
    call Storage.save_sector

    mov dl, [BOOT_DRIVE]
    mov bx, 0x8000
    mov cl, 3
    call Storage.get_sector

    mov bx, 0x8000
    call String.print_string

loop: ; your loop code goes here
    call Keyboard.get_key
    call String.print_char
    jmp loop

; your constants and data go here:

osdev_string: db "Hello, OSDev!", 10, 13, 0

; ---- DO NOT CHANGE THINGS BELOW THIS ---- ;

%include "./boot_functions.asm"

BOOT_DRIVE: db 0

times 510 - ($ - $$) db 0
dw 0xAA55
SECTOR_TWO:

; ---- YOU MAY STORE MORE DATA OR CODE HERE! ---- ;

string_two: db "Hello, sector 2!", 10, 13, 0


; ---- DO NOT CHANGE THINGS BELOW THIS ---- ;
times 512 - ($ - SECTOR_TWO) db 0
SECTOR_THREE:

times 512 - ($ - SECTOR_THREE) db 0