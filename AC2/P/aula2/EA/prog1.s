# MAPA DE REGISTOS:
# curCount -> $t0
# retValue -> $t1
# ms -> $t2
# reset -> $a1

        .equ resetCoreTimer , 12
        .equ readCoreTimer , 11
        .data
        .text
        .globl main

main:                                           # int main(void) {
                addiu   $sp, $sp, -4            #       abrir espaco na pilha
                sw      $ra, 0($sp)             #       salvaguardar o valor de $ra

                lw      $ra, 0($sp)             #       repor o valor de $ra
                addiu   $sp, $sp, 4             #       repor o espaco na pilha
                jr      $ra                     # }
 
timeDone:       li $t1 , 0                      # retValue = 0;

if:             ble $a1 , $0 , else
                li $v0 , resetCoreTimer
                syscall
                j endIf
else:           
                li $v0 , readCoreTimer
                syscall
                move $t0 , $v0
                mul $t2 , $a0 , 20000
if2:            ble $t0 , $t2 , endIf
                div $t1 , $t0 , 20000
endIf:
                move $v0 , $t0
                jr $ra
                