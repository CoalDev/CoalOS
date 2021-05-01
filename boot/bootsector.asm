[ORG 0x7c00]

KERNEL_OFFSET equ 0x1000

    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov [BOOT_DRIVE], dl    ; Saving the drive number as BIOS loads it into dl

    mov bp, 0x9000          ; Setting the stack at 0x9000 away from the bootsector
    mov sp, bp              ; setting the stack pointer to the top of the stack which is empty
    
    call load_kernel        ; Read the kernel from memory and load it
    call switch_pm          ; Starting the switch to protected mode

    jmp $

%include "boot/bootsector_print.asm"
%include "boot/bootsector_print_hex.asm"
%include "boot/bootsector_read_disk.asm"
%include "boot/gdt/gdt.asm"
%include "boot/protected_mode/bootsector_pm_print.asm"
%include "boot/protected_mode/pm_switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET
    mov dl, [BOOT_DRIVE]
    mov dh, 16               ; The kernel will be large
    call disk_load
    ret

[bits 32]
begin_pm:
    mov ebx, MSG_PROT_MODE
    call pm_print
    call KERNEL_OFFSET

    jmp $

BOOT_DRIVE db 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading Kernel into memory", 0

times 510-($-$$) db 0
dw 0xaa55
