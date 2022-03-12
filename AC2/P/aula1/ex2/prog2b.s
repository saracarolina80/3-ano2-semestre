# Teste dos system calls "getChar()" e "putChar(c + 1)"

#int main(void)
#{
#  char c;
#  do
#  {
#     c = getChar();
#     if( c != '\n' )
#	putChar( c + 1 );
#  } while( c != '\n' );
# return 0;
#}

# MAPA DE REGISTOS
#  c -> $t0

	.data
	.equ getChar , 2
	.equ putChar , 3
	.text
	.globl main

main:	li $v0 , getChar  
	syscall		# getChar();
	
	move $t0 , $v0		#  c = getChar();

if:	beq $t0 , '\n' , endIf
	addi $t0 , $t0 , 1	# c + 1
	move $a0 , $t0 
	li $v0 , putChar
	syscall 		# putChar( c + 1 );

endIf:
while:	bne $t0 , '\n' , main
	
	li $v0 , 0	# return 0
	jr $ra
