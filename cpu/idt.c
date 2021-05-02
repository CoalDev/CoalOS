#include "idt.h"
#include "../utils/utils.h"

idt_gate_t idt[IDT_NUM_ENTRIES];
idt_reg_t idt_reg;

void set_idt_gate(int gate, u32 handler){
    idt[gate].low_offset_bits = low_16_bits(handler);
    idt[gate].selector = KERNEL_CS;
    idt[gate].zero = 0;
    idt[gate].flags = 0x8e; // 10001110b
    idt[gate].high_offset_bits = high_16_bits(handler);
}

void set_idt(){
    idt_reg.base = (u32)&idt;
    idt_reg.limit = IDT_NUM_ENTRIES * sizeof(idt_reg_t) - 1;

    asm volatile("lidtl (%0)": :"r"(&idt_reg));
}