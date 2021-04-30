print:
    pusha
start:
    mov al, [bx]    ; reading the string to be printed from memory
    cmp al, 0       ; check if we read everything (string is null terminated)
    je done

    mov ah, 0x0e    ; tell the BIOS to get into tty mode
    int 0x10
    add bx, 1       ; incremanting the pointer by 1 to read all the string
    jmp start
done:
    popa
    ret

print_nl:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a    ; new line
    int 0x10
    mov al, 0x0d    ; carriadge return
    int 0x10
    
    popa
    ret