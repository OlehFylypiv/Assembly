DOSSEG
.286
.model  small
.386

MY_MUL  MACRO   X, Y, Z  
    
    mov z, 0
    mov z + 2, 0  
    mov AX, X  
    mul Y     
    mov Z, AX   
    mov Z + 2, DX 
    mov AX, X + 2
    mul Y     
    add Z + 2, AX 
    mov ax, Z
    mov dx, Z + 2
                  
ENDM  

.STACK 100h

.DATA

    K_low       EQU  000Ah

    B           dw   00h
    C           dw   00h
    D           db   00h
    E           dw   00h
    F           db   00h
    
    Temp1       dw   00h, 00h
    Temp2       dw   00h
    Temp3       dw   00h
    Temp4       db   00h
    
    X           dw   0000h 

    X_Str       db   10 dup (0)
    TempStr     db   10 dup (0)
    TempBin     dw   0, 0
    MaxLen      dw   0
    X_div2      dw   0, 0
    Y_div2      dw   0

    MESSG_X     db   13, 10, 'X = (C4 - B3 + K) * D1 + E4 / F2    К = 10 (Ah)', '$'
    MESSG_B     db   13, 10, 'B = ', '$'
    MESSG_C     db   13, 10, 'C = ', '$'
    MESSG_D     db   13, 10, 'D = ', '$'
    MESSG_E     db   13, 10, 'E = ', '$'
    MESSG_F     db   13, 10, 'F = ', '$'

    MESSG_X1    DB   13, 10, 'X = ', '$'
    erStr1      db   13, 10, 'Data not input_variable',   13, 10, '$'
    erStr2      db   13, 10, 'Incorrectly data ',         13, 10, '$'
    erStr2_1    db   13, 10, 'D = 0 --> divide by zero',  13, 10, '$'
    erStr3      db   13, 10, 'Data is too long',          13, 10, '$'

    Mult10      dw   1, 0
    my_z        dw   0, 0

.CODE   

    Start:      
    
        mov ax, @data        
        mov ds, ax

        call input
        call calculation
        call output

        mov ah,01
        int 21h        

        mov ah,4Ch
        int 21h

input proc 
        
    lea DX, MESSG_X    
    mov AH, 09
    int 21H 
    lea DX, MESSG_B    
    mov AH, 09
    int 21H 
    mov di, offset B
    mov MaxLen, 3
    mov cx, MaxLen
    call input_variable
        
    lea DX, MESSG_C    
    mov AH, 09
    int 21H 
    mov di, offset C
    mov MaxLen, 5
    mov cx, MaxLen
    call input_variable 

    lea DX, MESSG_D    
    mov AH, 09
    int 21H 
    mov di, offset D
    mov MaxLen, 3
    mov cx, MaxLen
    call input_variable
        
    cmp D, 0
    jne dali
    mov ah, 09
    mov dx, offset erStr2_1 
    int 21h
    mov ah, 4Ch
    int 21h

    dali:   

        lea DX, MESSG_E    
        mov AH, 09
        int 21H 
        mov di, offset E
        mov MaxLen, 3
        mov cx, MaxLen
        call input_variable
        
        lea DX, MESSG_F    
        mov AH, 09
        int 21H 
        mov di, offset F
        mov MaxLen, 3
        mov cx, MaxLen
        call input_variable
        
        ret
input endp

calculation proc
    
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ;  X = (C4 - B3 + K) * D1 + E4 / F2    311
    mov ax, @data 
    mov ds, ax 

    mov ax, B 
    mov bx, K_low 
    sub ax, bx 
    mov Temp1, ax 
    mov ax, 0 
    mov bx, 0 

    mov ax, C
    mov bx, Temp1
    sub ax, bx 
    mov Temp2, ax 
    mov ax, 0 
    mov bx, 0 

    mov al, D 
    mul Temp2
    mov Temp2, 0 
    mov Temp2, ax 
    mov ax, 0   

    mov ax, E 
    mov bl, F
    div bl 
    mov Temp4, al 

    movsx ax, al
    add Temp2, ax
    mov bx, Temp2  
    ;  add bx, ax 
    mov X, bx 

    ret
calculation endp

input_variable PROC 
    
    mov si,0                
    
    In_00:  

        mov ah, 01
        int 21h 
        cmp al, 0Dh
        je In_1
    
    In_0:   

        mov dl, al
        call CHECK_BYTE
        mov TempStr[si], dl
        inc si
        loop In_00
    
    In_1:   

        push si
        dec si
        cmp cx, MaxLen
        jne In_2
        call  Err1

    In_2:   

        mov bh, 0
        mov bl,TempStr[si]
        MY_MUL Mult10, bx, my_z
        add TempBin, ax
        adc TempBin + 2, dx
        mov bh, 0
        mov bl, 10
        MY_MUL Mult10, bx, my_z
        mov Mult10, ax
        mov Mult10+2, dx
        dec si
        cmp si, 0
        jge In_2
        mov ax, TempBin
        mov dx, TempBin+2
        pop si
        cmp si, MaxLen
        jl In_3
        cmp MaxLen, 10
        jl In_2_1      
        js In_Err
        cmp dx, 0FFFFh
        ja In_Err
        jmp In_3
    
    In_2_1: 

        cmp MaxLen, 5
        jl In_2_2
        cmp dx, 00
        ja In_Err       
        cmp ah, 0ffh
        ja In_Err
        jmp In_3
    
    In_2_2: 

        cmp ax, 00FFh
        jbe In_3
    
    In_Err: 

        lea DX, erSTR3
        mov AH, 09
        int 21H
        mov ah, 4Ch
        int 21h
        
    In_3:   

        mov [di], ax
        mov [di + 2], dx
        mov TempBin, 0
        mov TempBin + 2, 0
        mov Mult10, 1        
        mov Mult10 + 2, 0
                                            
        ret   
input_variable  endp

Err1 PROC  
    
    PUBLIC Err1
    lea DX, erSTR1
    mov AH, 09
    int 21H
    mov ah, 4Ch
    int 21h

    ret   
Err1  endp

CHECK_BYTE  PROC
    
    PUBLIC CHECK_BYTE
    sub dl, 30h
    cmp dl, 00
    jl ErS
    cmp dl, 0Ah
    jl GO
    
    ErS:    
        
        lea DX, erSTR2
        mov AH, 09
        int 21H
        mov ah, 4Ch
        int 21h
        
    GO: 

        ret
CHECK_BYTE ENDP

MY_DIV2 proc
    
    sub cx, cx
    sub bx, bx
    mov dx, X_div2+2
    mov ax, X_div2
  
    M2_D1:

        cmp dx, Y_div2
        jb M2_D3
        sub ax, Y_div2
        sbb dx, 00
        add cx, 01
        adc bx, 0
        jmp M2_D1
  
    M2_D3:
        
        div Y_div2
        add cx, ax
        adc bx, 00
    
    ret
MY_DIV2 endp
                    
output PROC
    
    mov di, 0
    mov Y_div2, 10
    mov cx, X
    mov bx, X + 2
    
    O_1:    

        mov X_div2, cx
        mov X_div2 + 2, bx
        call my_div2    
        add dl, 30h
        mov X_Str[di], dl
        inc di
        cmp bx, 0
        ja O_1
        cmp cx, 10
        jae O_1
        add cl, 30h
        mov X_Str[di], cl
        mov dx, offset MESSG_X1
        mov ah, 09
        int 21h        
    
    O_2:    
        
        mov dl, X_Str[di]        
        mov ah, 02h
        int 21h
        dec di
        jge O_2
        
        ret
output endp

end Start

end