	.equ RESET_CORE_TIMER, 12
        .equ READ_CORE_TIMER, 11
        .equ putChar, 3
        .equ printInt, 6
        .data
        .text
        .globl main

main:                                   # int main(void) {
        addiu   $sp, $sp, -16           #       abrir espaco na pilha
        sw      $ra, 0($sp)             #       guardar o $ra
        sw      $s0, 4($sp)             #       guardar o $s0
        sw      $s1, 8($sp)             #       guardar o $s1
        sw      $s2, 12($sp)            #       guardar o $s2
        li      $s0, 0                  #       cnt10 = 0;
        li      $s1, 0                  #       cnt5 = 0;
        li      $s2, 0                  #       cnt1 = 0;
while:                                  #       while(1) {
        li      $a0, 100                #               $a0 = 100;
        jal     delay                   #               delay(100);
                                        #
        li      $a0, '\r'               #               $a0 = '\r'
        li      $v0, putChar            #               $v0 = 3;
        syscall                         #               putChar('\r');
                                        #
        addi    $s0, $s0, 1             #               cnt10++;
        move    $a0, $s0                #               $a0 = ++cnt10;
        li      $a1, 0x0005000A         #               $a1 = 10 | 4 << 16
        li      $v0, printInt           #               $v0 = 6;
        syscall                         #               printInt(++cnt10, 10 | 5 << 16);

if:     rem     $t0, $s0, 2             #               if(cnt10 % 2 == 0) {
        bne     $t0, 0, endif           #
        addi    $s1, $s1, 1             #                       cnt5++;
endif:                                  #               }

if2:    rem     $t0, $s0, 10            #               if(cnt10 % 10 == 0) {
        bne     $t0, 0, endif2          #
        addi    $s2, $s2, 1             #                       cnt1++;
endif2:                                 #               }
                                        #
        li      $a0, ' '                #               $a0 = ' '
        li      $v0, putChar            #               $v0 = 3;
        syscall                         #               putChar(' ');
        move    $a0, $s1                #
        li      $a1, 0x0005000A         #               $a1 = 10 | 4 << 16
        li      $v0, printInt           #               $v0 = 6;
        syscall                         #               printInt(cnt5, 10 | 5 << 16);

	j while
	li $v0 , 0
	lw $ra , 0($sp)
	lw $s0 , 4($sp)
	lw $s1 , 8($sp)
	lw $s2 , 12($sp)
	lw $s3 , 16($sp)
	lw $s4 , 20($sp)
	
	addiu $sp , $sp , 24
	jr $ra 

delay:
for:
	ble $a0 , 0 , endF
	li $v0 , RESET_CORE_TIMER
	syscall
wait:	li $v0 , READ_CORE_TIMER
	syscall
	blt $v0 , 20000 , wait
	addi $a0 , $a0 , -1
	j for

endF:	
	jr $ra
