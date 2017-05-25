DOSSEG
.model small
.stack 100h

.data
	
	max_len EQU 1000
	str_revers DB max_len dup(?)
	revers_str DB max_len dup(?)

.code
	
start :
	
	mov	ax, @data     
	mov	ds, ax
	
	mov	ah, 3fh       
	mov	bx, 0
	mov	cx, max_len
	mov	dx, offset str_revers
	int 21h
	
	sub ax, 2 
	cmp ax, 0
	jz	done	
	mov cx, 3
	mov bx, ax
	mov al, ah
	shr al, 4
	call draw_al
	mov al, bh
	call draw_al
	mov al, bl
	shr al, 4
	call draw_al
	mov al, bl
	call draw_al

done:	
	
	mov al, 0
	mov	ah, 4ch       
	int	21h

draw_al :
	
	and al,0Fh
	cmp al,0Ah
	jc nondig
	add al,7

nondig:	
	
	add al,30h
	mov dl,al
	mov ah,2
	int 21h
	
	ret

end start