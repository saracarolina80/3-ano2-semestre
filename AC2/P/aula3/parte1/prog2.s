# Configurar o porto RE0 como saída e o porto RB0 como entrada
# Ler o valor do porto de entrada e escreva esse valor negado no porto de saída

# 1º definir os endereços dos portos (através do mapa de registos)
		.equ SFR_BASE_HI , 0xBF88
		
		.equ TRISB, 0x6040
		.equ PORTB, 0x6050
		.equ LATB, 0x6060
		.equ TRISE, 0x6100
		.equ PORTE, 0x6110
		.equ LATE, 0x6120

		.data
		.text
		.globl main

# 2º configurar o porto de saída e o porto de entrada
main:
		lui $t1 , SFR_BASE_HI
		lw $t2, TRISE($t1)
		andi $t2 , $t2 , 0xFFFE    # bit0 = 0  -> saída
		sw $t2 , TRISE($t1)

		lw $t2 , TRISB($t1)
		ori $t2 , $t2 , 0x0001		# bit0 = 1 -> entrada
		sw $t2 , TRISB ($t1)

# 3º ler o valor do porto de entrada e escreva esse valor no porto de saída
loop:	
		lw $t2 , PORTB ($t1)
		andi $t2 , $t2 , 0x0001

		lw $t3 , LATE($t1)
		andi $t3 , $t3 , 0xFFFE
		xor $t3 , $t2 , $t3             # VALOR NEGADO
		sw $t3 , LATE($t1)

		j loop


		li $v0 , 0
		jr $ra
