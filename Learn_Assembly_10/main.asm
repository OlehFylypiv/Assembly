DOSSEG
.model small

.stack 100h

.data
	
	max_len    EQU 1000
	str_revers DB max_len dup(?)
	revers_str DB max_len dup(?)

.code
start:
	
	mov	ax, @data
	mov	ds, ax
	mov	ah, 3fh 
	mov	bx, 0
	mov	cx, max_len
	mov	dx, offset str_revers
	int 21h
	
	and	ax, ax  
	jz done	
	mov	cx, ax
	push cx	 
	mov	bx, offset str_revers 
	mov	si, offset revers_str
	add	si, cx 
	dec	si 

revers_loop:
	
	mov	al, [bx]
	mov	[si], al
	inc	bx
	dec	si
	loop revers_loop
	pop	cx
	mov	ah, 40h	
	mov	bx, 1
	mov dx, offset revers_str 
	int 21h	

done:
	
	mov al, 0
	mov	ah, 4ch 
	int	21h

end start