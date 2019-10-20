# Base-N Calculation
#  N = 26 + (02839083 % 11)
#  N = 26 + 5
#  N = 31
#  M = N - 10
#  M = 21

.data
	base_N:  	.word 31	# base-N number from calculation
	Mth_num: 	.word 21	# Mth number from calculation
	str:	 	.space 6	# 5 bytes for base-N chars, 1 byte for newline and NULL chars
	_word:	 	.space 5	# 4 bytes for each int, 1 byte for newline and NULL chars
	#inputCount: 	.word 0

.text
	addi $s0, $zero, 0	#register for tracking input loop value

	main:
		
#		li $v0, 8	# read_string command
#		la $a0, str	# load value of str into $a0
#		li $a1, 12	# 10 base-N chars, 1 newline char, && 1 NULL char
#		syscall

#		li $v0, 4	# print_string command
#		la $a0, str	# load value of str into $a0
#		syscall

		
	getInput:
		li $v0, 5	#read_int
		syscall

		move $t0, $v0	# move integer to $t0
		
		li $v0, 1	# print_int command
		move $a0, $t0	# move integer to $a0
    		syscall

	exit:
		li $v0, 10	# exit_program
		syscall