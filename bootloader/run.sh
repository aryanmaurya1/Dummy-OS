#!/bin/sh
rm -rf boot.bin;
echo $1;
nasm -f bin $1 -o boot.bin;
qemu-system-x86_64 -hda boot.bin;
