use16
org 0x7C00

BS_jmpBoot      jmp   start
                db    0x90

BS_OEMName      db    "CCOSV587"

; OEM name / 8 B
BPB_BytsPerSec  dw    512               ; 一个扇区512字节
BPB_SecPerClus  db    1                 ; 每个簇一个扇区
BPB_RsvdSecCnt  dw    1                 ; 保留扇区数, 必须为1
BPB_NumFATs     db    2                 ; FAT表份数
BPB_RootEntCnt  dw    224               ; 根目录项数
BPB_TotSec16    dw    2880              ; RolSec16, 总扇区数
BPB_Media       db    0xf0              ; 介质种类: 移动介质
BPB_FATSz16     dw    9                 ; FATSz16 分区表占用扇区数
BPB_SecPerTrk   dw    18                ; SecPerTrk, 磁盘
BPB_NumHeads    dw    2                 ; 磁头数
BPB_HiddSec     dd    0                 ; HiddSec
BPB_TotSec32    dd    2880              ; 卡容量
BS_DrvNum       db    0                 ; DvcNum
BS_Reserved1    db    0                 ; NT保留
BS_BootSig      db    0x29              ; BootSig扩展引导标记
BS_VolD         dd    0xffffffff        ; VolID
BS_VolLab       db    "FLOPPYCDDS "     ; 卷标
BS_FileSysType  db    "FAT12   "        ; FilesysType


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
    call print
    mov si, initsec
    call printd

print:
    lodsb
    cmp al, 0
    je initd
    mov ah, 0x0E
    int 0x10
    jmp print

printd:
    lodsb
    cmp al, 0
    je initd
    mov ah, 0x0E
    int 0x10
    jmp printd

initd:
    ret

initm: db "OK: Init operation started successfully.",0Dh,0Ah,0

initsec: db "Katze come with ABSOLUTELY NO WARRANTY!",0Dh,0Ah,0

buffer db 16
bufpos db 0

shell:
    mov byte [bufpos], 0

shrd:
    mov ah, 0
    int 0x16
    cmp al, 13
    je shexec
    mov bl, [bufpos]
    mov bh, 0
    mov [buffer + bx], al
    inc byte [bufpos]
    mov ah, 0x0E
    int 0x10
    jmp shrd

shexec:
    mov bl, [bufpos]
    mov bh, 0
    mov byte [buffer + bx], 0   ; null terminate


shhl:
    mov si, msgd
    call print
    jmp shell_done

shby:
    mov si, bymsg
    call print
    jmp shell_done

shell_katze:
    mov si, katze_msg
    call print
    jmp shell_done

shell_done:
    ret

msgd db "HELLO",0Dh,0Ah,0
bymsg   db "BYE",0Dh,0Ah,0
katze_msg db "KATZE",0Dh,0Ah,0

entry:
  mov ah, 0x02
  mov al, 1
  mov ch, 0
  mov cl, 2
  mov dh, 0
  mov dl, 0
  mov bx, 0x1000
  int 0x13

jmp 0x1000
    times 510 - ($-$$) db 0
    dw 0xAA55
