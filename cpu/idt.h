#ifndef H_IDT
#define H_IDT

#include "types.h"

#define KERNEL_CS 0x8

typedef struct {
    u16 low_offset_bits;
    u16 selector;
    u8 zero;
    u8 flags;
    u16 high_offset_bits;
} __attribute__((packed)) idt_gate_t;

typedef struct {
    u16 limit;
    u32 base;
} __attribute__((packed)) idt_reg_t;

#define IDT_NUM_ENTRIES 256

extern idt_gate_t idt[IDT_NUM_ENTRIES];
extern idt_reg_t idt_reg;

void set_idt_gate(int gate, u32 handler);
void set_idt();

#endif