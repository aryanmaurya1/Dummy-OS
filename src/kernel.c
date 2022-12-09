#include <stdint.h>
#include "kernel.h"

const char* msg = "HELLO WORLD FROM MY KERNEL !!";

uint16_t terminal_make_char(char c, char color) {
  return (color << 8) | c;
}

void kernel_main() {
  char* video_memory = (char*)(0xb8000);  // Location of video memory in RAM
  video_memory[0] = 'A';                  // ASCII character to print
  video_memory[1] = 3;                    // Color of the character

  uint16_t* video_memory_2byte = (uint16_t*)(video_memory);
  video_memory_2byte[0] = 0x0341;         // 0x<color_byte><ascii_char_byte> --> Read like 0x<ascii_char_byte><color_byte>
                                          // Written in reverse order to take care of Endianess
 
  int i = 0;
  while(msg[i] != '\0') {
    video_memory_2byte[i] = terminal_make_char(msg[i], 10);
    i++;
  }
}
