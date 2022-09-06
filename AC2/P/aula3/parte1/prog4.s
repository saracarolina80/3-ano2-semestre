        
        .equ SFR_BASE_HI , 0xBF88
		
		.equ TRISB, 0x6040
		.equ PORTB, 0x6050
		.equ LATB, 0x6060
		.equ TRISE, 0x6100
		.equ PORTE, 0x6110
		.equ LATE, 0x6120
        .equ TRISD,0x60C0
        .equ PORTD , 0x60D0
        .equ LATD, 0x60E0

		.data
		.text
		.globl main


main:
        lui $t1 , SFR_BASE_HI

        #  portos RB0 a RB3 como entradas 
        lw $t2 , TRISB($t1)
		ori $t2 , $t2 , 0x000F		# bit0 a bit3 = 1 -> entrada
		sw $t2 , TRISB ($t1)

         #  portos RE0 a RE3 como saídas
        lw $t2 , TRISE($t1)
        andi $t2 , $t2 , 0xFFF0   # bit0 a bit3 = 0 -> saída
        sw $t2 , TRISE($t1)

loop:   

        lw $t2 , PORTB($t1)
        andi    $t2, $t2, 0x000F    #RB ler(PORT)
    
        lw      $t3, LATE($t1)
        andi    $t3, $t3, 0xFFF0    #RE= 0
        xori    $t2, $t2, 0x0009    #RE0 = RB0\, RE1 = RB1, RE2 = RB2 e RE3 = RB3\
        or      $t3, $t2, $t3      
        sw      $t3, LATE($t1)      #RE = RB

        j       loop

        
        li      $v0, 0              #return 0;
        jr      $ra