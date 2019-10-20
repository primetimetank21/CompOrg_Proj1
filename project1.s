# Base-N Calculation
#  N = 26 + (02839083 % 11)
#  N = 26 + 5
#  N = 31
#  M = N - 10
#  M = 21

.data
	base_N:  .word 31	# base-N number from calculation
	Mth_num: .word 21	# Mth number from calculation
	str:	 .space 6	# 5 bytes for base-N chars, 1 byte for newline and NULL chars

.text
	main:
		li $v0, 8	# read_string command
		la $a0, str	# load value of str into $a0
		li $a1, 12	# 10 base-N chars, 1 newline char, && 1 NULL char
		syscall

		li $v0, 4	#print_string command
		la $a0, str	#load value of str into $a0
		syscall

		li $v0, 10	# exit_program
		syscall