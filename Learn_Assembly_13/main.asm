.model small 
.data 
	array  db   15,-100,50,0 
	len    equ  $ - array 
	min    db   ? 
	imin   dw   ? 

.stack 100h 

.code 
start: 
	
	mov ax, @data 
	mov ds, ax 
	mov cx, len 
	dec cx 
	xor di, di 
	mov si, 1

cycle: 
    
	mov al, array[si] 
	cmp al, array[di] 
	jge next 
	mov di, si 

next: 
    
	inc si 
	loop cycle 
	mov imin, di
	mov al, array[di] 
	mov min, al
    
	mov ah, 4ch 
	int 21h 
end start     