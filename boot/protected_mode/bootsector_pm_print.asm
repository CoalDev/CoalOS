[bits 32]

    VIDEO_MEMORY equ 0xb8000    ; Video memory for VGA starts at 0xb8000 as seen in Page 14 (https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
    WHITE_ON_BLACK equ 0x0a     ; Attribute describing some flags like backgroud, foreground, if the char blinks or not, etc....

pm_print:
    pusha
    mov edx, VIDEO_MEMORY       ; Starting EDX as the pointer in the Video Memory

pm_print_loop:
    mov al, [ebx]               ; The first char of our string (We store the string in EBX before calling the function)
    mov ah, WHITE_ON_BLACK      ; Storing the attribute in ah so we have a full 2 byte value to put in memory

    cmp al, 0                   ; Checking if we got to the null terminator
    je pm_print_done

    mov [edx], ax               ; Moving the 2 byte value to Video Memory so it'll get printed
    add ebx, 1                  ; Moving to the next char in the string
    add edx, 2                  ; Progressing the pointer 2 bytes (as the value is 2 bytes) to the next memory slot

    jmp pm_print_loop

pm_print_done:
    popa
    ret
    