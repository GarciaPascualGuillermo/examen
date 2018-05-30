segment .data
	msg1 db "ingrese un numero", 0xA,0xD
	len1 equ $- msg1
	msg3 db "",0xA,0xD 
	len3 equ $- msg3
	arre db 0
	len equ $-arre
	
segment .bss
	datos resb 4

section  .text
	global _start 
    _start:  
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80



	mov eax, 3
	mov ebx, 0
	mov ecx, datos
	mov edx, 2
	int 80h

	mov eax, [datos+0]
	sub eax, 48
	mov ebx, [datos+1]
	sub ebx, 48
	mov edi, 10
	mul edi
	add eax,ebx
	mov [arre+0], eax
;Termina la lectura

	mov ebp,arre
	mov edi,0

ciclo:
	mov ah,0
	mov al, [ebp+0]
	mov dl, 100
	div dl
	mov [datos+0], al
	mov [datos+1], ah
	mov ah,0
	mov al,[datos+1]
	mov dl,10
	div dl
	mov [datos+1], al
	mov [datos+2], ah

	mov ax,[datos+0]
	mul ax ;ax=ax*ax
	mov cx,ax

	mov ax,[datos+1]
	mul ax ;ax=ax*ax
	mov bx,ax

	mov ax,[datos+2]
	mul ax ;ax=ax*ax

	add ax,bx
	add ax,cx
	mov[ebp+0],ax
	;
	mov ah,0
	mov al, [ebp+0]
	mov dl, 100       ;mov dl,100
	div dl
	add al, '0'
	mov [datos+0], al ;centena
	mov [datos+1],ah
	mov ah,0
	mov al,[datos+1]
	mov dl,10
	div dl
	add al,'0'
	mov [datos+1],al  ;decena
	add ah, '0'
	mov [datos+2], ah ;unidad 


	mov eax, 4
	mov ebx, 1
	mov ecx, datos
	mov edx, 3
	int 0x80


	jmp endciclo

endciclo:
	mov ax,[datos+2]
	sub ax,'0'
	cmp ax, 1
	jne ciclo

salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80