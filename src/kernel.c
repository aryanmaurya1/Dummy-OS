#include <stdint.h>
#include <stddef.h>
#include "kernel.h"


uint16_t* video_memory_2byte = 0x0;
uint16_t terminal_row = 0;
uint16_t terminal_col = 0;

uint16_t terminal_make_char(char c, char color) {
  return (color << 8) | c;
}

size_t strlen(const char* str) {
  size_t i = 0;
  while (str[i]) {
    i++;
  }
  return i;
}

void terminal_putchar(int x, int y, char c, char color) {
  video_memory_2byte[(y * VGA_WIDTH) + x] = terminal_make_char(c, color);
}

void terminal_writechar(char c, char color) {
  terminal_putchar(terminal_col, terminal_row, c, color);
  terminal_col += 1;
  if (terminal_col > VGA_WIDTH) {
    terminal_col = 0;
    terminal_row += 1;
  }
}

void terminal_writestr(const char* msg, char color) {
  int i = 0;
  while(msg[i]) {
    terminal_writechar(msg[i++], color);
  }
}

void terminal_initialize() {
  // Resetting global variables.
  terminal_row = 0;
  terminal_col = 0;
  video_memory_2byte = (uint16_t*)(0xb8000);

  // Clearning screen.
  for(int y = 0; y < VGA_HEIGHT; y++) {
    for(int x  = 0; x < VGA_WIDTH; x++) {
      terminal_putchar(x, y, ' ', 0);
    }
  }
}

void kernel_main() {
  char* video_memory = (char*)(0xb8000);  // Location of video memory in RAM
  video_memory[0] = 'A';                  // ASCII character to print
  video_memory[1] = 3;                    // Color of the character

  uint16_t* video_memory_2byte = (uint16_t*)(video_memory);
  video_memory_2byte[0] = 0x0341;         // 0x<color_byte><ascii_char_byte> --> Read like 0x<ascii_char_byte><color_byte>
                                          // Written in reverse order to take care of Endianess

  char* msg = "HELLO WORLD FROM MY KERNEL !!";
  terminal_initialize();
  terminal_writestr(msg, 10);
}
