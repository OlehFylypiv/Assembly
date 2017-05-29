DOSSEG
.model small

.stack 100h

.data

	max_len 	EQU 	12	
	str_inp 	DB 		max_len dup(?)

.code
start:
	
	mov		ax, @data    
	mov 	ds, ax
	mov  	ah, 3fh   
	mov  	bx, 0
	mov  	cx, max_len
	mov  	dx, offset str_inp
	int  	21h

	sub  	ax, 2       
	jz  	done
	mov  	cx, ax
	mov  	si, offset str_inp
	mov 	dx, 0

S1:
	mov 	ah, 0
	mov 	al, [si]
	adc 	al, dl
	aaa
	adc 	dh, 0
	mov 	dl, al
	inc 	si
	loop 	S1

	or 		dh, 30h
	or 		dl, 30h
	mov 	ah, 2
	mov 	bl, dl
	mov 	dl, dh
	int 	21h

	mov 	dl, bl
	int 	21h

done:

	mov  	al, 0
	mov  	ah, 4ch
	int  	21h

end start