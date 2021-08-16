;strings.asm

extern printf
section .data
	string1 db "This is the first string.",10,0
	string2 db "This is the second string.",10,0
	
section .bss
section .text
	global main
main:
