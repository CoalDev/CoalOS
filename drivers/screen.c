#include "ports.h"
#include "screen.h"
#include "../utils/utils.h"

int get_curser_offset();
void set_curser_offset(int offset);
int print_char(char c, int col, int row, char attr);

int get_offset(int col, int row);
int get_offset_row(int offset);
int get_offset_col(int offset);

void kprint_pos(char* msg, int col, int row){
    int offset;
    if (col >= 0 && row >= 0){
        offset = get_offset(col, row);
    } else {
        offset = get_curser_offset();
        row = get_offset_row(offset);
        col = get_offset_col(offset);
    }

    int i = 0;
    while(msg[i] != 0){
        offset = print_char(msg[i++], col, row, WHITE_ON_BLACK);
        row = get_offset_row(offset);
        col = get_offset_col(offset);
    }
}

void kprint(char* msg){
    kprint_pos(msg, -1, -1);
}

int print_char(char c, int col, int row, char attr){
    char* vid_mem = (char*) VIDEO_MEM_ADDRESS;
    if (!attr){
        attr = WHITE_ON_BLACK;
    }

    if(col >= MAX_COLS || row >= MAX_ROWS){
        vid_mem[2 * MAX_ROWS * MAX_COLS - 2] = 'E';
        vid_mem[2 * MAX_ROWS * MAX_COLS - 1] = RED_ON_BLACK;
        return get_offset(col, row);
    }

    int offset;
    if(col >= 0 && row >= 0){
        offset = get_offset(col, row);
    } else {
        offset = get_curser_offset();
    }

    if(c == '\n'){
        row = get_offset_row(offset);
        offset = get_offset(0, row + 1);
    } else {
        vid_mem[offset] = c;
        vid_mem[offset+1] = attr;
        offset += 2;
    }

    if(offset >= MAX_COLS * MAX_ROWS * 2){
        int i;
        for(i = 1; i < MAX_ROWS; i++){
            memcpy((char *)(get_offset(0, i) + VIDEO_MEM_ADDRESS), (char *)(get_offset(0, i-1) + VIDEO_MEM_ADDRESS), MAX_COLS * 2);
        }

        char* last_line = (char *)(get_offset(0, MAX_ROWS-1) + VIDEO_MEM_ADDRESS);
        for(i = 0; i < MAX_COLS * 2; i++){
            last_line[i] = 0;
        }
        
        offset -= MAX_COLS * 2;
    }

    set_curser_offset(offset);
    return offset;
}

int get_curser_offset(){
    int vga_offset;
    
    port_byte_out(CRTC_ADDR_REG, 14);
    vga_offset = port_byte_in(CRTC_DATA_REG) << 8;

    port_byte_out(CRTC_ADDR_REG, 15);
    vga_offset += port_byte_in(CRTC_DATA_REG);

    return vga_offset * 2;
}

void set_curser_offset(int offset){
    offset /= 2;
    port_byte_out(CRTC_ADDR_REG, 14);
    port_byte_out(CRTC_DATA_REG, (unsigned char)(offset >> 8));
    port_byte_out(CRTC_ADDR_REG, 15);
    port_byte_out(CRTC_DATA_REG, (unsigned char)(offset & 0xff));
}


void clear_screen(){
    int screen_size = MAX_COLS * MAX_ROWS;
    char* vid_mem = (char*) VIDEO_MEM_ADDRESS;
    int i;
    for(i = 0; i < screen_size; i++){
        vid_mem[i * 2] = ' ';
        vid_mem[(i * 2) + 1] = WHITE_ON_BLACK;
    }

    set_curser_offset(get_offset(0, 0));
}

int get_offset(int col, int row){
    return 2 * (row * MAX_COLS + col);
}

int get_offset_row(int offset){
    return offset / (2 * MAX_COLS);
}

int get_offset_col(int offset){
    return (offset - (get_offset_row(offset) * 2 * MAX_COLS))/2;
}
