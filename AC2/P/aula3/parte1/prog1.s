# Configurar o porto RE0 como saída e o porto RB0 como entrada

	.data
	.text
	.globl main

main:	lui $t1 , SFR_BASE_HI

	lw $t2 , TRISE($t1)		# READ (Read TRISE register)
	andi $t2 , $t2 , 0xFFFE		# MODIFY (bit 0 = 0)
	sw $t2 , TRISE($t1)		# WRITE (Write TRISE register)

	lw $t2 , TRISB ($t1)		# READ (Read TRISB register )
	andi $t2 , $t2 , 0x0001		# WRITE (bit 0 = 1)
	sw $t2 , TRISB ($t1)		# WRITE (Write TRISB register)

while:	lw $t0 , PORTB($t1)
	andi $t0 , $t0 , 0x0001		# Reads only bit 0
	
	lw $t2 , LATE($t1)
	andi $t2 , $t2 , 0xFFFE

	or $t2 , $t2 , $t0		# RE0 = RB0
	sw $t2 , LATE($t1)	

	j while

	jr $ra