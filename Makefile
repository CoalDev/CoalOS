os.bin:	boot/bootsector.asm
	nasm -f bin boot/bootsector.asm -o os.bin

qemu: os.bin
	qemu-system-x86_64 os.bin

clean:
	rm *.bin
