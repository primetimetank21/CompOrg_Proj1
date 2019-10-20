# Base-N Calculation
#  N = 26 + (02839083 % 11)
#  N = 26 + 5
#  N = 31
#  M = N - 10
#  M = 21

.data
	base_N:  	.word 31	# base-N number from calculation
	Mth_num: 	.word 21	# Mth number from calculation
	#str:	 	.space 6	# 5 bytes for base-N chars, 1 byte for newline and NULL chars
	_word:	 	.space 5	# 4 bytes for each int, 1 byte for newline and NULL chars
	array:		.space 6	# 5 bytes for char values, 1 byte for NULL char (only need 4 bits) 
	#inputCount: 	.word 0

.text
	addi $s0, $zero, 0	#register for tracking input loop value

	main:
		li $v0, 12		# read_char command
		syscall

		addi $s0, $s0, 1	#increments counter	

		bne $s0, 10, main	#exit condition
		j exit

	exit:
		li $v0, 10		# exit_program
		syscall