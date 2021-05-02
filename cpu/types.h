#ifndef H_TYPES
#define H_TYPES

typedef unsigned int u32;
typedef unsigned short u16;
typedef unsigned char u8;

typedef int s32;
typedef short s16;
typedef char s8;

#define low_16_bits(addr) (u16)((addr) & 0xffff)
#define high_16_bits(addr) (u16)(((addr) >> 16) & 0xffff)

#endif