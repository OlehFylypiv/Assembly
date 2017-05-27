dosseg
.model small
.stack 100h

.data
	
	dig dd 0FFFFFFFDh

.code
start:
	
	mov ax, @data
	mov ds, ax
	mov dx, 0
	mov si, 0
	mov cx, 4

L1:	

	mov al, byte ptr dig[si]
	mov ah, al
	and al, 0fh
	and ah, 0f0h
	shr ah, 4
	adc bl, al
	adc bl, ah
	inc si
	loop L1
	
	mov dl, bl
	and dl, 0F0h
	shr dl, 4
	cmp dl, 10
	jb is_d
	add dl, 7h

is_d:

	add dl, 30h
	mov ah, 02h
	int 21h
	mov dl, bl
	and dl, 0Fh
	cmp dl, 10
	jb is_d1
	add dl, 7h

is_d1:

	add dl, 30h
	mov ah, 02h
	int 21h

	mov	ah, 4ch       
	int	21h

end start