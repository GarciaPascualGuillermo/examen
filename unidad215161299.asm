SYS_SALIDA equ 1
SYS_READ equ 3
SYS_PRINT equ 4
STDIN equ 0 
STDOUT equ 1

segment data.

	msg1 db "Ingrese numero(0..9):", 0xA,0xD
	len1 equ $- msg1
    msg2 db " "
	len2 equ $- msg2

	

segment .bss
	
	num1 resb 2
	num2 resb 1
    resul resb 2
    

section .text

	global _start

_start:

	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80
     
    mov eax, SYS_READ 
	mov ebx, STDIN 
	mov ecx, num2 
	mov edx, 1
	int 0x80 


	
	mov ax, [num2]
	sub ax, '0'

	mov di, 2
    mov si,3


while:
        cmp ax, 1
	je salir

        mov [num1],ax

	mov dx, 0
	div di
	cmp dx, 0
	je EsPar

        mov ax,[num1]
        mul si
        add ax,1
        mov [num1],ax
        add ax,48
        mov [resul],ax

	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, resul
	mov edx, 2
	int 0x80

        mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg2
	mov edx, len2
	int 0x80
       mov ax,[num1]
jmp while

EsPar:
        mov [num1],ax
        add ax,48
        mov [resul],ax
        
	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, resul
	mov edx, 2
	int 0x80


    mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg2
	mov edx, len2
	int 0x80
    mov ax,[num1]
jmp while


salir:
	
mov eax, SYS_SALIDA
xor ebx, ebx
int 0x80