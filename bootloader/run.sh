#!/bin/sh
rm -rf boot.bin;
export msgfile="message.txt"
export outputfilename="boot.bin"
echo $1;
nasm -f bin $1 -o $outputfilename;
cat $msgfile >> $outputfilename;
dd if=/dev/zero bs=512 count=1 >> $outputfilename
qemu-system-x86_64 -hda $outputfilename;
