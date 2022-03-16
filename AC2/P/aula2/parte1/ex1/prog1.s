	.equ read_core_timer,11
	.equ reset_core_timer,12
	.equ put_char,3
	.equ print_int,6

	.data
	.text
	.globl main

main:  li $t0,0

while:  li $v0,read_core_timer 	 # while(1) {
	syscall						
	
	blt $v0,200000, while	    	# while(readCoreTimer()<200000);
	li $v0,reset_core_timer		#
	syscall			        	# resetCoreTimer();
	
	li $a0,'\r' 					#
	li $v0,put_char				#
	syscall						# putchar('\r');
	
	addi $t0,$t0,1				#
	move $a0,$t0				#
	li $a1,10					#
	li $v0,print_int			#
	syscall						# printInt(++counter,10);
	
	j while
	
	li $v0 , 0							#}
	jr $ra						#
