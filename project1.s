# Base-N Calculation
#  N = 26 + (02839083 % 11)
#  N = 26 + 5
#  N = 31
#  M = N - 10
#  M = 21

.data
	array:		.space 11	#10 element array (1 NULL space)
	base_N:  	.word 31	#base-N number from calculation
	char: 		.space 2	#1 byte for char, 1 byte for NULL
	Mth_num: 	.word 21	#Mth number from calculation
	#_word:	 	.space 5	#4 bytes for each int, 1 byte for newline and NULL chars

.text
	main:
		addi $s0, $zero, 0	#register for tracking input loop value
		la $s1, array       	#set base address of array to s1

	loop:           	    	#start of loop for reading data
		jal getChar           	#jump to getChar, (gets char to store in array)
		lb $t0, char        	#load the char from char buffer into $t0, stripping NULL byte
		sb $t0, 0($s1)      	#store the char into the array
		beq $s0, 10, exit	#if $s0 == 10, jump to exit
		addi $s1, $s1, 1    	#increments base address of array (get to next element location)
		j loop              	#jump to start loop

	getChar:           		#read char from keyboard buffer and return ascii value
		li $v0, 8       	#read_string command
		la $a0, char    	#load address of char for read
		li $a1, 2      		#length of string is 1byte char and 1byte for null
		syscall         	#store the char byte from input buffer into char
		addi $s0, $s0, 1	#increment counter
		jr $ra          	#jump back (into loop label)
		
	exit:
		li $v0, 10		#exit_program
		syscall