# Implementação de um contador up/down de 8 bits

#void wait(int);
#
#int main(void)
#{
#  int s = 0;
#  int cnt = 0;
#  char c;
#  do
#  {
#     putChar('\r');   // Carriage return character
#     printInt( cnt, 10 | 3 << 16 ); // 0x0003000A: decimal w/ 3 digits
#     putChar('\t');  // Tab character
#     printInt( cnt, 2 | 8 << 16 ); // 0x00080002: binary w/ 8 bits
#     wait(5);
#     c = inkey();
#     if( c == '+' )
#	s = 0;
#     if( c == '-' )
#	s = 1;
#     if( s == 0 )
#	cnt = (cnt + 1) & 0xFF;
#     else
#	cnt = (cnt - 1) & 0xFF;
#   } while( c != 'q' );
# return 0;
#}
#
#void wait(int ts)
#{
#  int i;
#  for( i=0; i < 515000 * ts; i++ );
#}


# MAPA DE REGISTOS
#  s -> $t0
#  cnt -> $t1
#  temp -> $t2
#  temp -> $t3
#  temp -> $t4
#  i -> $t5
#  c -> $t7

	.data
	.equ putChar , 3
	.equ printInt , 6
	.equ inkey , 1
	
	.text
	.globl main
	
main:	li $t0 , 0		# s = 0
	li $t1 , 0 		# cnt = 0

do:	la $a0 , '\r'
	li $v0 , putChar
	syscall		# putChar('\r');
	
	li $t2 , 3
	sll $t3 , $t2 , 4          # 3 << 16
	ori $t4 , $t3 , 10	   # 10 | 3<<16
	move $a0 , $t1
	move $a1 , $t4
	li $v0 , printInt
	syscall 		# printInt( cnt, 10 | 3 << 16 )
	
	la $a0 , '\t'
	li $v0 , putChar 
	syscall		# putChar('\t');
	
	li $t2 , 8
	sll $t3, $t2 , 4	# 8 << 16
	ori $t4 , $t3 , 2 	# 2 | 8<<16
	move $a0 , $t1
	move $a1 , $t4
	li $v0 , printInt
	syscall		# printInt( cnt, 2 | 8 << 16 );
	
	li $a0 , 5
	jal wait

	li $v0 , inkey
	syscall
	move $t7 , $v0 

if:	bne $t7 , '+' , if2
	li $t0 , 0		# s = 0

if2:	bne $t7 , '-' , if3
	li $t0 , 1		# s = 1

if3:	bne $t0 , 0 , else
	add $t1 , $t1 , 1
	and $t1 , $t1 , 0xFF
	
	j while	
	
else:   add $t1 , $t1 , -1
	and $t1 , $t1 , 0xFF
	
while:	beq $t7 , 'q' , do

	li $v0 , 0
	
	jr $ra
	

# Função Wait

wait:	li $t5 , 0
	li $t6 , 515000
	mult $a0 , $t6
	
for:	bge $t5 , $t1 , endFor
	addi $t5 , $t5 , 1	# i++
	
	j for

endFor: jr $ra
	
	


