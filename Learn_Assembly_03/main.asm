STACK SEGMENT PARA STACK 'STACK'
    db 100h DUP (?)
STACK ENDS

DATA SEGMENT    WORD 'DATA'
    HelloMessage    db 'Fylypiv',13,10,'$'
    A   dt  100000000003021998h
    B   db  01101001b
    C   dw  0ABCDh, 0FFFFh
DATA    ENDS

DATA1 SEGMENT   PARA 'DATA'
LBL LABEL BYTE
    D   dt  3.14e8
    E   dw  22FFh
    F   dq  0003021998h
    K   equ     21h
DATA1   ENDS

CODE SEGMENT    PARA 'CODE'
    ASSUME  cs:CODE, ds:DATA
ProgramStart:
    push    ds      	;initialize stack segment
    sub     ax,ax       ;initialize stack segment
    push    ax      	;initialize stack segment

    mov     ax,Data     ;initialize data segment
    mov     ds,ax       ;initialize data segment

    mov     ah,09       ;display message
    mov     dx,OFFSET HelloMessage
    int     21h

    mov     ah,4Ch      ;DOS terminate program function
    int     21h         ;end of the program

CODE    ENDS
    END ProgramStart
