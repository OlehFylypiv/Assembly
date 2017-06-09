model   small
.data
a   dw  -10
b   dw  200
c   dw  -300
.stack  256
.code
begin:  
    
    mov ax, @data
    mov ds, ax
    mov ax, a
    add ax, b
    add ax, c

    mov si, 10
    mov di, 3
    xor cx, cx

    push ax
    shl ax, 1
    pop ax
    jnc @@01
    not ax
    inc ax
    push ax
    mov al, '-'
    int 29h
    pop ax

@@01:
    
    xor dx, dx
    div di
    push dx

@@02:
    
    xor dx, dx
    div si
    push dx
    inc cx
    or  ax, ax
    jnz @@02

@@03:
    
    pop ax
    or ax, '0'
    int 29h
    loop @@03
    
    pop ax
    or ax, ax
    jz  @@05
    push ax
    mov al, '.'
    int 29h
    mov cx, 50

@@04:
    
    pop ax
    or ax, ax
    jz  @@05
    dec cx
    jz  @@05
    xor dx, dx
    mul si
    div di
    push dx
    or  ax, '0'
    int 29h
    jmp @@04

@@05:
    
    xor ax, ax
    int 16h
    mov ax, 4c00h
    int 21h
end begin