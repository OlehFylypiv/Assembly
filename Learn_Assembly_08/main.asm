dosseg
.model small
.stack 100h

.data
	
	dig dd 00000000h

.code

start:

	mov ax, @data
	mov ds, ax

	mov ah, 08
	int 21h

	mov bl, al
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