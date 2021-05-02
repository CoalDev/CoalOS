#include "../drivers/screen.h"
#include "../cpu/isr.h"

void kmain(){
    clear_screen();

    isr_init();
    __asm__ __volatile__("int $2");
    __asm__ __volatile__("int $4");
}
