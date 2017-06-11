data segment
    
    string      db   'aaaabbbb$'
    e           dw   $ - string -1
data ends

code segment
    assume cs:code, ds:data

start:
    
    mov ax, data
    mov ds, ax   
    
    mov ah, 9
    mov dx, offset string
    int 21h
    
    mov si, offset string
    mov cx, e

n1:
    
    mov al, byte ptr [si]
    
    cmp al, 60h
    jl next
    sub al, 20h
    mov byte ptr [si], al

next:
    
    inc si
    loop n1
    
    mov ah, 2
    mov dl, 0ah
    int 21h
    
    mov ah, 9
    mov dx, offset string
    int 21h
    
    mov ah, 10h
    int 16h
    mov ah, 4ch
    int 21h

code ends
end start