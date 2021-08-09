arguments: arguments.o
	gcc -o arguments arguments.o -no-pie
arguments.o: arguments.asm
	nasm -f elf64 -g -F dwarf arguments.asm -l arguments.lst
