#ifndef SCREEN_H
#define SCREEN_H

#define VIDEO_MEM_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f
#define RED_ON_BLACK 0x04

#define CRTC_ADDR_REG 0x3d4
#define CRTC_DATA_REG 0x3d5
// https://web.stanford.edu/class/cs140/projects/pintos/specs/freevga/vga/portidx.htm

void clear_screen();
void kprint_pos(char* msg, int col, int row);
void kprint(char* msg);

#endif
