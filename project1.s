# Base-N Calculation
#  N = 26 + (02839083 % 11)
#  N = 26 + 5
#  N = 31
#  M = N - 10
#  M = 21

.data
	array:		.space 40	#10 element array (1 NULL space)
	array_size:	.word 10	#10 elements in array
	base_N:  	.word 31	#base-N number from calculation
	char: 		.space 2	#1 byte for char, 1 byte for NULL
	Mth_num: 	.word 21	#Mth number from calculation
	newline:	.asciiz "\n"	#newline character

.text
	main:
		addi $s0, $zero, 0	#register for tracking input loop value
		la $s1, array       	#set base address of array to s1

	loop:           	    	#start of loop for reading data
		jal getChar           	#jump to getChar, (gets char to store in array)
		lb $t0, char        	#load the char from char buffer into $t0, stripping NULL byte
		sb $t0, 0($s1)      	#store the char into the array
		beq $s0, 10, convert	#if $s0 == 10, jump to convert
		addi $s1, $s1, 4    	#increments base address of array (get to next element location)
		j loop              	#jump to start loop

		getChar:           		#read char from keyboard buffer and return ascii value
			li $v0, 8       	#read_string command
			la $a0, char    	#load address of char for read
			li $a1, 2      		#length of string is 1byte char and 1byte for null
			syscall         	#store the char byte from input buffer into char
			addi $s0, $s0, 1	#increment counter
			jr $ra          	#jump back (into loop label)

	convert:
		move $s0, $zero		#reset counter to 0
		lw $t4, array_size	#$t4 = size
		la $t0, array		#$t0 = address of array[0] (aka &array[0])
		sll $t1, $t4, 2		#$t1 = size * 4
		add $t2, $t0, $t1	#$t2 = address of array[size] (aka &array[size])

		loop2:
			lw $t3, 0($t0)		#$t3 = array[i]
			addi $t0, $t0, 4	#$t0 = $t0 + 4
			li $v0, 11		#print_char command
			move $a0, $t3		#$a0 = $t3
			syscall
			beq $s0, 10, exit	#if $s0 == 10, jump to exit
			addi $s0, $s0, 1	#increment counter
			j loop2			#jump back to loop2		
	
	
	
	exit:
		li $v0, 10		#exit_program
		syscall