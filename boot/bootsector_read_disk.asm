disk_load:
    pusha
    push dx         ; push dx as we will change it (will change dh) and we need to make a cmp

    mov ah, 0x02    ; telling BIOS to read form memory
    mov al, dh      ; number of sectors to read

    mov cl, 0x02    ; sector number
    mov ch, 0x00    ; track/cylinder number
                    ; dl = drive number set automatically by the BIOS
    mov dh, 0x00    ; head number

    int 0x13        ; BIOS interrupt for memory stuff
    jc disk_error   ; if the carry bit is set than there was an error

    pop dx
    cmp al, dh      ; al = number of sectors read -> checking if we read the correct number of sectors
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl

    mov dh, ah
    call print_hex
    call print_nl

sectors_error:
    mov bx, SECTOR_ERROR
    call print
    call print_nl

DISK_ERROR:
    db "Read error from disk", 0
SECTOR_ERROR:
    db "Read wrong number of sectors", 0