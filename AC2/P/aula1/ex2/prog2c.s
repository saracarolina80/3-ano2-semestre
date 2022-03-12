 # Teste do system call "inkey()".
 
 # int main(void)  
 # {  
 #    char c;
 #     
 #    do
 #    {
 #       while( (c = inkey()) == 0 );
 #       if( c != '\n' )
 #         putChar( c );        
 #    } while( c != '\n' ); 
 #    return 0;
 # } 
 
 	.equ inkey , 1
 	.equ putChar , 3
 	.data
 	
 	.text
 	.globl main

main:

do:	
	  li $v0 , inkey
	  syscall   
	  move $a0 , $v0       # c = inkey()

	  beqz $a0 , do  
	
if:	  beq $a0 , '\n' , while
	  
	  li $v0 , putChar
	  syscall                    # putChar(c)
	  
while:  bne $a0 , '\n' , do

	 li $v0 , 0                # return 0
	 
	 jr $ra
		
	  
