gdt_start:
    dq 0                            ; GDT starts with 8 null bytes segment, for error checking with the CPU
gdt_code:
    dw 0xffff                       ; Segment length (bits 0-15)
    dw 0x0                          ; Segment base (bits 0-15)
    db 0x0                          ; Segment base (bits 16-23)
    db 10011010b                    ; Flags (8 bits) -> Page 34 & 35 & 36 in https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
    db 11001111b                    ; Flags (4 bits) -> Page 34 & 35 & 36 in https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf + Segment length (bits 16-19)
    db 0x0                          ; Segment base (bits 24-31)
gdt_data:
    dw 0xffff                       ; Segment length (bits 0-15)
    dw 0x0                          ; Segment base (bits 0-15)
    db 0x0                          ; Segment base (bits 16-23)
    db 10010010b                    ; Flags (8 bits) -> Page 34 & 35 & 36 in https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
    db 11001111b                    ; Flags (4 bits) -> Page 34 & 35 & 36 in https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf + Segment length (bits 16-19)
    db 0x0                          ; Segment base (bits 24-31)
gdt_end:                            ; Here so we can calculate offsets like CODE_SEG & DATA_SEG

gdt_descriptor:
    dw gdt_end - gdt_start - 1      ; Size (16 bits or 2 bytes), always one less of its true size
    dd gdt_start                    ; Start address of the GDT (32 bits or 4 bytes)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start