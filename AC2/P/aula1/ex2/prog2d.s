# Teste dos system calls de leitura e impressão de inteiros

# int main(void)      
# {       
#   int value;
#
#   while(1)  
#   {
#       printStr("\nIntroduza um numero (sinal e módulo): ");
#       value = readInt10();  
#       printStr("\nValor lido, em base 2: ");      
#       printInt(value, 2);    
#       printStr("\nValor lido, em base 16: "); 
#       printInt(value, 16);  
#       printStr("\nValor lido, em base 10 (unsigned): ");   
#       printInt(value, 10);      
#       printStr("\nValor lido, em base 10 (signed): ");         
#       printInt10(value);        
#   }        
#   return 0;    
# } 

# Mapa de Registos
# value -> $t0 

	
	
	.equ read_int10 , 5
	.equ print_int  , 6
	.equ print_int10 , 7
	.equ printStr , 8
	
	.data

str1:   .asciiz "\nIntroduza um numero (sinal e módulo): "
base2:  .asciiz "\nValor lido, em base 2: "
base16: .asciiz "\nValor lido, em base 16: "
base10: .asciiz "\nValor lido, em base 10 (unsigned): "
baseS:  .asciiz "\nValor lido, em base 10 (signed): "

	.text
	.globl main

main: 
while:  la $a0 , str1
		li $v0 , printStr
		syscall                      #  printStr("\nIntroduza um numero (sinal e módulo): ");
	
		li $v0 , read_int10
		syscall
		move $t0 , $v0               # value = readInt10()
	
		la $a0 , base2
		li $v0 , printStr
		syscall  			#  printStr("\nValor lido, em base 2: ");      
	
		move $a0 , $t0 
		li $a1 , 2
		li $v0 , print_int
		syscall  		# printInt(value, 2);
	
		la $a0 , base16
		li $v0 , printStr
		syscall                   #  printStr("\nValor lido, em base 16: "); 
	
		move $a0 , $t0 
		li $a1 , 16
		li $v0 , print_int
		syscall 		# printInt(value, 16);  
	
		la $a0 , base10
		li $v0 , printStr
		syscall 		# printStr("\nValor lido, em base 10 (unsigned): ");   
	
		move $a0 , $t0 
		li $a1 , 10
		li $v0 , print_int
		syscall 		#  printInt(value, 10);  
	
		la $a0 , baseS
		li $v0 , printStr
		syscall 		# printStr("\nValor lido, em base 10 (signed): ");   
	
		move $a0 , $t0 
		li $a1 , 10
		li $v0 , print_int
		syscall  		# printInt10(value);  

		j while

		li $v0 , 0
	
	jr $ra
