[bits 16]
switch_pm:
    cli                     ; Stop BIOS interrupts
    lgdt [gdt_descriptor]   ; Load the GDT

    mov eax, cr0            ; Moving the CR0 register to eax because we can't
    or eax, 0x1             ; set CR0 with a value, only with another register so doing an 
    mov cr0, eax            ; or with 1 to turn on the first bit which is (Enable Protected Mode)

    jmp CODE_SEG:start_pm   ; Need to make a far jump to flush the CPU's pipeline of anything
                            ; that will crash the CPU as we switched to 32 bit from 16 bit
                            ; And so we can register the new Segments descriptors, instead of using
                            ; the old SS, DS, etc.... we have to use the new segments descriptors

[bits 32]
start_pm:
    mov ax, DATA_SEG        ; moving the pointer of every segment register
    mov ds, ax              ; to the new data segment we described in the GDT
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; remapping the stack to 32 bit
    mov esp, ebp

    call begin_pm           ; finally switching to 32 bit in the bootsector