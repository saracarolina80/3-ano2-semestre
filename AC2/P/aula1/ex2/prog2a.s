# Teste dos system calls "getChar()" e "putChar()"

#int main(void)
#{
#  char c;
#  do
#  {
#     c = getChar();
#     if( c != '\n' )
#	putChar( c );
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
	move $a0 , $t0 
	li $v0 , putChar
	syscall 		# putChar( c );

endIf:
while:	bne $t0 , '\n' , main
	
	li $v0 , 0	# return 0
	jr $ra
