Include irvine32.inc

.data
    strtingmsg byte "              TIC TAC TOE            ",0
ticticmsg0 byte"--------------------------------------------------------------------------------  ", 0  
ticmsg1 byte " |  ______   0    _---       _____           _---        _____    ____     ____   | ", 0
ticmsg2 byte " |    |      |    |            |     //\\    |             |     |    |   |       | ", 0
ticmsg3 byte " |    |      |    |            |    //--\\   |             |     |    |   |----   | ", 0
ticmsg4 byte " |    |      |    -___         |   //    \\  -___          |     |____|   |____   | ", 0
ticmsg5 byte " |--------------------------------------------------------------------------------| ", 0
    brdmsg byte "Enter the value between 1-9 according to the above table",0
    horizontalLine BYTE '-----------',0
    row1 BYTE ' 1 ', '|', ' 2 ', '|', ' 3 ' ,0
    row2 BYTE ' 4 ', '|', ' 5 ', '|', ' 6 ' ,0
    row3 BYTE ' 7 ', '|', ' 8 ', '|', ' 9 ' ,0
    player1 byte 'X'
    player2 byte 'O'
    value byte ?
    value2 byte ?
    againmsg byte " The place is already filled please select another place ",0
    againmsg2 byte " wrong input!!! Enter the correct number ",0
    winmsg byte " Player Win ",0
    drawmsg byte " Match draw ",0
    plmsg byte " PLAYER's TURN ",0

.code
boxprinter PROC
    call crlf
    call crlf
     mov edx, OFFSET row1
     call WriteString
     call crlf
     mov edx, OFFSET horizontalLine
     call WriteString
     call crlf
     mov edx, OFFSET row2
     call WriteString
     call crlf
     mov edx, OFFSET horizontalLine
     call WriteString
     call crlf
     mov edx, OFFSET row3
     call WriteString
     call crlf
     mov edx, OFFSET horizontalLine
     call WriteString
     call crlf
     mov edx,offset brdmsg
     call WriteString
     call crlf
     ret
boxprinter ENDP

inputPlayer PROC uses eax
    mov edx,offset player1
    call writechar
    mov edx,offset plmsg
    call WriteString
    call readchar
    call writechar
    mov value,al
    call crlf
    ret
inputPlayer ENDP

updatetable PROC 
    cmp value,'1'
    je replace1
    cmp value,'2'
    je replace2
    cmp value,'3'
    je replace3
    cmp value,'4'
    je replace4
    cmp value,'5'
    je replace5
    cmp value,'6'
    je replace6
    cmp value,'7'
    je replace7
    cmp value,'8'
    je replace8
    cmp value,'9'
    je replace9
    jmp again2
replace1:
    mov esi, offset row1
    mov value2, 'X'
    mov bl, [esi+1]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row1
    mov [esi+1],al 
    jmp rr
replace2:
    mov esi, offset row1
    mov value2, 'X'
    mov bl, [esi+5]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row1
    mov [esi+5],al 
    jmp rr
replace3:
    mov esi, offset row1
    mov value2, 'X'
    mov bl, [esi+9]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row1
    mov [esi+9],al 
    jmp rr
replace4:
    mov esi, offset row2
    mov value2, 'X'
    mov bl, [esi+1]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row2
    mov [esi+1],al 
    jmp rr
replace5:
    mov esi, offset row2
    mov value2, 'X'
    mov bl, [esi+5]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row2
    mov [esi+5],al 
    jmp rr
replace6:
    mov esi, offset row2
    mov value2, 'X'
    mov bl, [esi+9]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row2
    mov [esi+9],al 
    jmp rr
replace7:
    mov esi, offset row3
    mov value2, 'X'
    mov bl, [esi+1]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row3
    mov [esi+1],al 
    jmp rr
replace8:
    mov esi, offset row3
    mov value2, 'X'
    mov bl, [esi+5]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row3
    mov [esi+5],al 
    jmp rr
replace9:
    mov esi, offset row3
    mov value2, 'X'
    mov bl, [esi+9]
    cmp bl, value2
    je again

    mov value2, 'O'
    cmp bl, value2
    je again

    mov esi,offset row3
    mov [esi+9],al 
   
rr:
    call clrscr
    call boxprinter
    ret
again2:
call clrscr
    call boxprinter
    mov edx, offset againmsg2
    call WriteString
    call crlf
    call inputPlayer
    jmp updatetable
again:
    call clrscr
    call boxprinter
    mov edx, offset againmsg
    call WriteString
    call crlf
    call inputPlayer
    jmp updatetable
updatetable endp

changeturn PROC
    cmp al, player1
    je chng
    mov al, player1
    call writechar
    jmp e
chng:
    mov al, player2
    call writechar
e:
    ret
changeturn ENDP


win PROC uses eax
    ; Check rows
    mov esi, offset row1
    mov bl, [esi+1]
    cmp bl, [esi+5]
    jne x
    cmp bl, [esi+9]
    je w

x:
    mov esi, offset row2
    mov bl, [esi+1]
    cmp bl, [esi+5]
    jne y
    cmp bl, [esi+9]
    je w

y:
    mov esi, offset row3
    mov bl, [esi+1]
    cmp bl, [esi+5]
    jne check_columns
    cmp bl, [esi+9]
    je w

check_columns:
    ; Check columns
    mov esi, offset row1
    mov bl, [esi+1]
    cmp bl, [esi+1 + 12]  ; Check same column in row2
    jne check_column2
    cmp bl, [esi+1 + 24]  ; Check same column in row3
    je w

check_column2:
    mov esi, offset row1
    mov bl, [esi+5]
    cmp bl, [esi+5 + 12]  ; Check same column in row2
    jne check_column3
    cmp bl, [esi+5 + 24]  ; Check same column in row3
    je w

check_column3:
    mov esi, offset row1
    mov bl, [esi+9]
    cmp bl, [esi+9 + 12]  ; Check same column in row2
    jne check_diagonals
    cmp bl, [esi+9 + 24]  ; Check same column in row3
    je w

check_diagonals:
    ; Check diagonals
    mov esi, offset row1
    mov bl, [esi+1]
    cmp bl, [esi+5 + 12]  ; Check middle of the diagonal
    jne check_diagonal2
    cmp bl, [esi+9 + 24]  ; Check end of the diagonal
    je w

check_diagonal2:
    mov esi, offset row1
    mov bl, [esi+9]
    cmp bl, [esi+5 + 12]  ; Check middle of the other diagonal
    jne e
    cmp bl, [esi+1 + 24]  ; Check end of the other diagonal
    je w
    jne e

w:
    mov edx, offset winmsg
    call writechar
    call WriteString
    call crlf
    mov eax, 0
    exit

e:
    ret
win ENDP



main PROC
     mov al,player1
     movzx ebx,al
     mov ecx,9
    
     l1:
     call clrscr
     mov edx,offset ticmsg0
     call WriteString
     call crlf
    mov edx,offset ticmsg1
     call WriteString
     call crlf
     mov edx,offset ticmsg2
     call WriteString
     call crlf
     mov edx,offset ticmsg3
     call WriteString
     call crlf
     mov edx,offset ticmsg4
     call WriteString
     call crlf
     mov edx,offset ticmsg5
     call WriteString
     call crlf
     call boxprinter
     call inputPlayer
     call updatetable
     
     call clrscr
     call boxprinter
     call win
     call changeturn
     loop l1
    jnz r
    call clrscr 
    call boxprinter
     
     mov edx, offset drawmsg
     call WriteString
     call crlf
r:  
     exit   
main ENDP
invoke ExitProcess, 0
end main