.model small

.data    
	
	mas db 12, 42, 80, 28, 25, 90, 31, 44, 55, 6          
	len dw $-mas   
        
.code    
start:   
	mov ax, @data     
	mov ds, ax                          
	lea bx, mas     
	mov cx, len     
	mov ah, 0
	mov al, [bx]            

Next:   
	
	cmp al, [bx]    
	jg  Max       
	mov al, [bx]

Max:

	inc bx  
	loop Next
	aam     
	add ax, 3030h   
	mov bx, ax      
	mov ah, 02       
	mov dl, bh       
	int 21h          

	mov dl, bl       
	int 21h              

	mov ax, 4c00h    
	int 21h          
end start