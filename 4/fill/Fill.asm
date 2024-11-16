// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.

(LISTEN_LOOP)
	// get keyboard input
	@KBD
	D=M
	// if input greater than 0 means some key is pressed
	@BLACK_SCREEN
	D;JGT

	// come here means no key pressed
	(WHITE_SCREEN)
		@R0
		M=0
		@SET_SCREEN_LOOP // jump to set screen to bypass BLACK_SCREEN
		0;JMP

	(BLACK_SCREEN)
		@R0
		M=-1

	// R0 stores the 16 bit value to set the screen memory.
	// 0 for white, -1 (all 1s) for black

	(SET_SCREEN_LOOP)
		// pixel stores the current screen memory location
		@SCREEN
		D=A
		@pixel
		M=D
	(SET_SCREEN_LOOP_CONDITION)
		// if the pixel value reaches keyboard, stop.
		@KBD
		D=A
		@pixel
		D=D-M
		@LISTEN_LOOP
		D;JEQ
	(SET_SCREEN_LOOP_BODY)
		// set the next 16 bits pixel to R0 (0 or -1 for white or black)
		@R0
		D=M
		@pixel
		A=M
		M=D
	(SET_SCREEN_LOOP_INCREMENT)
		@pixel
		M=M+1
		@SET_SCREEN_LOOP_CONDITION
		0;JMP
	(SET_SCREEN_LOOP_END)

@LISTEN_LOOP
0;JMP
