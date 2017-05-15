.MODEL SMALL
.STACK 100h
.DATA
    HelloMessage    db 'Fylypiv', 13, 10, '$'
.CODE
Start:  push    ds              
    xor ax,ax
    push    ax
    mov ax,@data
    mov ds,ax               
    mov ah,9                
    mov dx,OFFSET HelloMessage  
    int 21h 
    mov ah,4ch          
    int     21h         
end Start
END