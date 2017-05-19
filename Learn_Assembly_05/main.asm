DOSSEG
.286
.model  small
.386
.STACK 100h

.DATA
    A   db  8
    B   db  2
    X   dw  200
    Q   db  35          ;a
    W   db  1           ;b
    
    Error_A   db    13, 10, 'a > b and a == 0 -->  divide by zero', 13, 10, '$'
    Error_B   db    13, 10, 'a < b and b == 0 -->  divide by zero', 13, 10, '$'
    
    A_B   db 13, 10, 'a == b --> X = -9', 13, 10, '$' 
    Ba    db 13, 10, 'X = 1',             13, 10, '$' 
    Aa    db 13, 10, 'X = 35',            13, 10, '$' 

.CODE   

Start:    
    
    mov ax, @data
    mov ds, ax
    mov al, A 
    cmp al, B
    jne A_n_b
    
    mov X, -9
    mov ah, 09
    mov dx, offset A_B
    int 21h
    jmp exit    

A_n_b:  

    mov al, A 
    cmp al, B
    jg A_g_B            ;a < b
    cmp A, 0
    je exit_A
    
    mov al, 5
    mov bl, B
    mul bl              ;res in ax
    sub ax, 1
    mov cl, A
    div cl              ;al - ah
    cmp al, W 
    je ResB
    jmp exit

A_g_B:                  ;a > b
    
    cmp B, 0
    je exit_B
        
    mov al, A
    sub ah, ah          ;AX = x       
    mov cl, B
    div cl              ;al - ah
    add al, 31
    cmp al, Q 
    je ResA
    jmp exit

exit_B: 

    mov ah, 09
    mov dx, offset Error_B
    int 21h
    jmp exit

exit_A: 
    
    mov ah, 09
    mov dx, offset Error_A
    int 21h
    jmp exit

ResB: 

    mov ah, 09
    mov dx, offset Ba
    int 21h
    jmp exit

ResA: 
    
    mov ah, 09
    mov dx, offset Aa
    int 21h

exit:

    mov ah, 4Ch
    int 21h

end Start