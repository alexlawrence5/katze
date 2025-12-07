use16
org 0x7C00

start:
    mov ah, 0x0E
    mov al, 'K'
    int 0x10
    mov al, 'A'
    int 0x10
    mov al, 'T'
    int 0x10
    mov al, 'Z'
    int 0x10
    mov al, 'E'
    int 0x10

call init

hang:
    hlt
    jmp hang

init:
    mov ah, 0x0E
    mov al, 10
    int 0x10
    mov si, initm
print:
    lodsb
    cmp al, 0
    je initd
    mov ah, 0x0E
    int 0x10
    jmp print
initd:
    ret

initm: db "OK: Init operation started successfully.",0

times 510 - ($-$$) db 0
dw 0xAA55

; ----------------------------
; an simple shell runner
; ----------------------------

    mov bx, 0x8000
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0
    int 0x13

    jmp 0x8000

hang:
    hlt
    jmp hang
