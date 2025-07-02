boot.bin: boot.o
	ld -melf_i386 -Ttext 0x7c00 --oformat binary -nostdlib -o boot.bin boot.o

boot.o: boot.s
	as --32 -o boot.o boot.s

all:: qemu

clean::
	rm -f boot.bin boot.o

qemu: boot.bin
	qemu-system-x86_64 -drive file=boot.bin,format=raw -no-reboot -vga none -net none -boot order=c -nographic -device isa-debug-exit,iobase=0xf4,iosize=0x04 || (echo "qemu failed $$?"; exit 1)