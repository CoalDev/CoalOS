[ORG 0x7c00]

    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov bp, 0x8000      ; Setting the stack at 0x8000 away from the bootsector
    mov sp, bp          ; setting the stack pointer to the top of the stack which is empty
    
    call switch_pm      ; Starting the switch to protected mode

    jmp $

%include "boot/bootsector_print.asm"
%include "boot/gdt/gdt.asm"
%include "boot/protected_mode/bootsector_pm_print.asm"
%include "boot/protected_mode/pm_switch.asm"

[bits 32]
begin_pm:
    mov ebx, MSG_PROT_MODE
    call pm_print

    jmp $

MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

times 510-($-$$) db 0
dw 0xaa55
