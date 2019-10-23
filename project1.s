# Base-N Calculation
#  N = 26 + (02839083 % 11)
#  N = 26 + 5
#  N = 31
#  M = N - 10
#  M = 21

.data
	array:		.space 40	#10 element array (1 NULL space)
	array_size:	.word 10	#10 elements in array
	char: 		.space 2	#1 byte for char, 1 byte for NULL
	newline:	.asciiz "\n"	#newline character

.text
	main:				#main label
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

	convert:			#converts each char from ascii => decimal (based on my base-N number)
		li $v0, 4		#print_string command
		la $a0, newline		#loads address of newline
		syscall			#prints '\n'
		
		move $s0, $zero		#reset counter to 0
		lw $t4, array_size	#$t4 = size
		la $t0, array		#$t0 = address of array[0] (aka &array[0])
		sll $t1, $t4, 2		#$t1 = size * 4
		add $t2, $t0, $t1	#$t2 = address of array[size] (aka &array[size])
		move $s1, $zero		#$s1 = 0 (and will serve as a total sum)

		add_char:			#adds each char to the total sum (after converting the char)
			beq $s0, 10, exit	#if $s0 == 10, jump to exit
			lw $t3, 0($t0)		#$t3 = array[i]
			blt $t3, 48, _zero	#if array[i] < 48, jump to _zero
			bgt $t3, 57, check_upper#if array[i] > 57, jump to check_upper
			addi $t3, $t3, -48	#else, $t3 = array[i] - 48
			add $s1, $s1, $t3	#adds $t3 to total sum

			
			_return:			#increments counter && address
			addi $t0, $t0, 4		#$t0 = $t0 + 4
			addi $s0, $s0, 1		#increment counter
			j add_char			#jump back to add_char		
		

				_zero:				#sets values to zero
					move $t3, $zero  	#array[i] = 0
					j _return	  	#jumps to _return

				check_upper:			#checks if char's ascii value is within the uppercase alphabet range
					blt $t3, 65, _zero	#if array[i] < 65, jump to _zero 
					bgt $t3, 85, check_lower#if array[i] > 85, jump to check_lower
					addi $t3, $t3, -64	#else, $t3 = array[i] - 64
					addi $t3, $t3, 9	#$t3 = $t3 + 9
					add $s1, $s1, $t3	#adds $t3 to total sum
					j _return	  	#jumps to _return

				check_lower:			#checks if char's ascii value is within the lowercase alphabet range
					blt $t3, 97,  _zero	#if array[i] < 97, jump to _zero 
					bgt $t3, 117, _zero	#if array[i] > 117, jump to _zero 
					addi $t3, $t3, -96	#else, $t3 = array[i] - 96
					addi $t3, $t3, 9	#$t3 = $t3 + 9				
					add $s1, $s1, $t3	#adds $t3 to total sum
					j _return		#jumps to _return
	
	exit:				#finishes the program
		li $v0, 1		#print_int command
		move $a0, $s1		#$a0 = total sum
		syscall			#prints total sum
		li $v0, 10		#exit_program command
		syscall			#terminates program