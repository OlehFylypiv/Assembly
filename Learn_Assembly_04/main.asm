DOSSEG 
.286
.model  small
.386
.STACK 100h 

.DATA 
	K EQU 616h 
	A dw 55h 
	B dw 620h 
	F db 2h 
	D db 30h 
	E dw 40h 
	Temp1 dw 0000h 
	Temp2 dw 0000h 
	Temp3 dw 0000h 
	Temp4 db 00h 
	X dw 0000h 

.CODE 
	ProgramStart: 	;X=(A4-B3-K)*D1+E4/F2 

	mov ax, @data 
	mov ds, ax 

	mov ax, B 
	mov bx, K 
	sub ax, bx 
	mov Temp1, ax 
	mov ax, 0 
	mov bx, 0 

	mov ax, A
	mov bx, Temp1
	sub ax, bx 
	mov Temp2, ax 
	mov ax, 0 
	mov bx, 0 

	mov al, D 
	mul Temp2
	mov Temp2, 0 
	mov Temp2, ax 
	mov ax, 0   

	mov ax, E 
	mov cl, F
	div cl 
	mov Temp4, al 
	mov cl, 0

	movsx ax,al
	mov bx, Temp2 
	add bx, ax 
	mov X, bx 
	mov ax, 0 
	mov bx, 0 

	mov al, 00
    mov ah, 09
    mov dx, OFFSET X
    int 21h

	mov ah,4Ch 
	int 21h 

CODE ENDS 
	END ProgramStart