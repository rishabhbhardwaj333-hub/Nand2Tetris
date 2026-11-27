// Roll number: 2501730355; K=55
// Box: starts at row 55, height 20 rows, width 64 pixels (4 words).
// While any key is pressed, paint black; otherwise clear the same area.
// Start address = SCREEN + 55*32 = SCREEN + 1760

(LOOP)
    @KBD
    D=M
    @BLACK
    D;JGT

    // No key pressed -> white
    @COLOR
    M=0
    @PAINT
    0;JMP

(BLACK)
    @COLOR
    M=-1

(PAINT)
    @SCREEN
    D=A
    @1760
    D=D+A
    @PTR
    M=D            // PTR = address of row 55, word 0

    @20
    D=A
    @ROWS
    M=D            // 20 rows

(ROW)
    @4
    D=A
    @COLS
    M=D            // 4 words per row

(COL)
    @COLOR
    D=M
    @PTR
    A=M
    M=D            // RAM[PTR] = COLOR

    @PTR
    M=M+1          // next word

    @COLS
    MD=M-1
    @COL
    D;JGT          // repeat for 4 words

    @28            // PTR is at start+4; need start+32
    D=A
    @PTR
    M=D+M

    @ROWS
    MD=M-1
    @ROW
    D;JGT          // repeat for 20 rows

    @LOOP
    0;JMP