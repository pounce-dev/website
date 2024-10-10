; Collection of null-terminated string functions.
String:
    ; Print a null-terminated string.
    ; Params:
    ; bx - character array pointer
    .print_string:
        pusha

        .print_loop:
            mov al, [bx]
            cmp al, 0
            je .exit_print

            mov ah, 0x0e
            int 10h
            add bx, 1
            jmp .print_loop
        .exit_print:
            popa
            ret
    ; Print a character.
    ; Params:
    ; al - character (ASCII)
    .print_char:
        pusha
        mov ah, 0x0e
        int 10h
        popa
        ret


; Collection of storage operation functions.
Storage:
    ; Get a sector (512 Bytes) from the hard drive, and put it in memory.
    ; Params:
    ; dl - drive number.
    ; bx - pointer to buffer to store data at.
    ; cl - sector number (starts at 1)
    .get_sector:
        pusha
        xor ax, ax
        mov ds, ax
        mov es, ax
        cld
        mov ah, 0x02
        mov al, 1
        mov dh, 0
        mov ch, 0
        int 0x13
        popa
        ret
    ; Save a sector (512 Bytes) from memory, and put it onto the hard drive.
    ; Params:
    ; dl - drive number.
    ; bx - pointer to buffer to store data at.
    ; cl - sector number (starts at 1)
    .save_sector:
        pusha
        xor ax, ax
        mov ds, ax
        mov es, ax
        cld
        mov ah, 0x03
        mov al, 1
        mov dh, 0
        mov ch, 0
        int 0x13
        popa
        ret

; Collection of keyboard operation functions.
Keyboard:
    ; Get a keystroke.
    ; This function waits until a key is received.
    ; Returns:
    ; ah - scan code
    ; al - character of the button pressed
    .get_key:
        mov ah, 0x00
        int 0x16
        ret