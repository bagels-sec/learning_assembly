;file.asm

section .data
        ;Expressions used for conditional assembly
        CREATE    equ 1
        OVERWRITE equ 1
        APPEND    equ 1
        O_WRITE   equ 1
        READ      equ 1
        O_READ    equ 1
        DELETE    equ 1

        ;Symbol syscalls
        NR_read   equ 0
        NR_write  equ 1
        NR_open   equ 2
        NR_close  equ 3
        NR_lseek  equ 8
        NR_create equ 85
        NR_unlink equ 87

        ;Creation and status flags
        O_CREAT   equ 00000100q
        O_APPEND  equ 000002000q

        ;Access mode
        O_RDONLY  equ 000000q
        O_WRONLY  equ 000001q
        O_RDWR    equ 000002q

        ;Create mode (permissions)
        S_IRUSR   equ 00400q ;user read permission
        S_IWUSR   equ 00200q ;user write permission
        NL        equ 0xa    ;newline
        bufferlen equ 64     ;buffer length

        fileName  db  "test.txt",0 ;define test filename
        FD        equ 0            ;file descriptor
        text1     db  "1. Hello..to everyone",NL,0
        len1      dq  $-text1-1    ; remove 0
        text2     db  "2. Here I am",NL,0 ;second line
        len2      dq  $-text2-1 ;text 2 without 0
        text3     db  "3. Alive and kicking", NL,0 ;third line
        len3      dq  $-text3-1 ;text3 without 0
        text4     db  "Adios",NL,0 ;line4
        len4      dq  $-text4-1 ;line4 minus the 0

        error_Create db "Error creating file",NL,0
        error_Close  db "Error closing file",NL,0
        error_Write  db "Error Writing file",NL,0
        error_Open   db "Error Opening file",NL,0
        error_Append db "Error Appending file",NL,0
        error_Delete db "Error Deleting file",NL,0
        error_Read   db "Error Reading file",NL,0
        error_Print  db "Error Printing string",NL,0
        error_Pos    db "Error Positioning in file",NL,0

        success_Create db "File created and opened",NL,0
        success_Close  db "File closed",NL,0
        success_Write  db "Written to file",NL,0
        success_Open   db "File Opened",NL,0
        success_Append db "File openened for appending",NL,0
        success_Delete db "File deleted",NL,0
        success_Read   db "File read",NL,0
        success_Pos    db "File position successful",NL,0

section .bss
        buffer resb bufferlen
section .text
        global main
main:

        push rbp
        mov rbp,rsp ;Prologue

        %IF CREATE
        ;Macro, create and open a file,then close
        ;create and open file

        mov rdi,fileName
        call createFile ;call createfile function
        mov qword[FD], rax ;save the file descriptor

        ;Write to file #1
        mov rdi, qword[FD]   ;copy file descriptor to rdi
        mov rsi, text1        ;copy text1 to rsi register 
        mov rdx, qword[len1] ;copy lenght of text1 to rdx
        call writeFile

        ;close file 
        mov rdi, qword[FD]   ;copy file descriptor to rdi
        call closeFile
        %ENDIF

        %IF OVERWRITE
        ;Open and overwrite a file, then close
        ;open file
        mov rdi, fileName     ;copy filename to rdi
        call openFile         ;call openfile function
        mov qword[FD], rax   ;save file descriptor

        ;write to file #2 overwrite
        mov rdi, qword[FD]    ;copy file descriptor to rdi
        mov rsi, text2        ;copy text2 to rsi
        mov rdx, qword[len2] ;copy text2 len to rdx
	        call writeFile        ;call write file function

        ;close file
        mov rdi, qword[FD]   ;copy file descriptor to rdi
        call closeFile        ;call closefile function
        %ENDIF

        %IF APPEND
        ;open and append to a file, then close
        ;open file to append
        mov rdi, fileName     ;copy filename to rdi
	call appendFile       ;call appendfile function
	mov qword[FD], rax   ;save file descriptor
	
	;write to file #3 append
	mov rdi, qword[FD]
	mov rsi, text3 
	mov rdx, qword[len3]
	call writeFile

	;close file
	mov rdi, qword[FD]
	call closeFile
	%ENDIF

	%IF O_WRITE
	;Open and overwrite at an offset
	mov rdi, fileName
	call openFile
	mov qword[FD], rax
	
	;position file at offset
	mov rdi, qword[FD]
	mov rsi, qword[len2] ;offset at this location
	mov rdx, 0
	call positionFile

	;write to file at offset
	mov rdi, qword[FD]
	mov rsi, text4
	mov rdx, qword[len4]
	call writeFile

	;close file
	mov rdi, qword[FD]
	call closeFile
	%ENDIF

	%IF READ
	;open and read from a file, then close
	;open the file to read
	mov rdi, fileName
	call openFile
	mov qword[FD], rax

	;read from file
	mov rdi, qword[FD]
	mov rsi, buffer
	mov rdx, bufferlen
	call readFile
	mov rdi, rax
	call printString

	;close file
	mov rdi, qword[FD]
	call closeFile
	%ENDIF

	%IF O_READ
	;open and read at an offset from a file, then close
	mov rdi, fileName
	call openFile
	mov qword[FD], rax

	;position file at offset
	mov rdi, qword[FD]
	mov rsi, qword[len2]
	mov rdx, 0
	call positionFile

	;read from file
	mov rdi, qword[FD]
	mov rsi, buffer
	mov rdx, 10 ;number of chars to read
	call readFile
	mov rdi, rax
	call printString

	;close file
	mov rdi, qword[FD]
	call closeFile
	%ENDIF

	%IF DELETE
	mov rdi, fileName
	call deleteFile
	%ENDIF

global readFile
readFile:
	mov rax, NR_read
	syscall ;rax has # of chars read
	cmp rax, 0
	jl readerror
	mov byte[rsi+rax],0 ;add a terminating zero
	mov rax,rsi
	
	mov rdi, success_Read
	push rax ;caller saved
	call printString
	pop rax
	ret

readerror:
	mov rdi, error_Read
	call printString
	ret

global deleteFile
deleteFile:
	mov rax, NR_unlink
	syscall
	cmp rax, 0
	jl deleteerror
	mov rdi, success_Delete
	call printString
	ret
deleteerror:
	mov rdi, error_Delete
	call printString
	ret

global appendFile
appendFile:
	mov rax, NR_open
	mov rsi, O_RDWR|O_APPEND
	syscall
	cmp rax, 0
	jl appenderror
	mov rdi, success_Append
	push rax
	call printString
	pop rax
	ret

appenderror:
	mov rdi, error_Append
	call printString
	ret

global openFile
openFile:
	mov rax, NR_open
	mov rsi, O_RDWR
	syscall
	cmp rax, 0
	jl openerror
	mov rdi, success_Open
	push rax
	call printString
	pop rax
	ret

openerror:
	mov rdi, error_Open
	call printString
	ret

global writeFile
writeFile:
	mov rax, NR_write
	syscall
	cmp rax, 0
	jl writeerror
	mov rdi, success_Write
	call printString
	ret
writeerror:
	mov rdi, error_Write
	call printString
	ret

global positionFile
positionFile:
	mov rax, NR_lseek
	syscall
	cmp rax,0
	jl positionerror
	mov rdi, success_Position
	call printString
	ret
positionerror:
	mov rdi, error_Position
	call printString
	ret

global closeFile
closeFile:
	mov rax, NR_close
	syscall
	cmp rax,0
	jl closeerror
	mov rdi, success_Close
	call printString
	ret
closeerror:
	mov rdi, error_Close
	call printString
	ret

global createFile
createFile:
	mov rax, NR_create
	mov rsi, S_IRUSR |S_IWUSR
	syscall
	cmp rax, 0
	jl createerror
	mov rdi, success_Create
	push rax
	call printString
	pop rax
	ret
createerror:
	mov rdi, error_Create
	call printString
	ret

global printString
printString:
	mov r12, rdi
	mov rdx, 0
strLoop:
	cmp byte[r12],0
	je strDone
	inc rdx
	inc r12
	jmp strLoop
strDone:
	cmp rdx,0
	je prtDone
	mov rsi,rdi
	mov rax, 1
	mov rdi, 1
	syscall
prtDone:
	ret
