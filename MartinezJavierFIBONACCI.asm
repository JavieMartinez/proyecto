# Programa: Serie Fibonacci
# Descripción: Generamos N números de la serie Fibonacci y su suma.

.data
msg_n:    .asciiz "¿Cuántos números de la serie Fibonacci deseas generar?: "
msg_res:  .asciiz "La serie es: "
msg_sum:  .asciiz "\nLa suma es: "
salto:    .asciiz "\n"

.text
.globl main

main:
    # Pedir cantidad
    li $v0, 4
    la $a0, msg_n
    syscall

    li $v0, 5
    syscall
    move $t0, $v0    # N en $t0

    # Inicializar
    li $t1, 0        # a = 0
    li $t2, 1        # b = 1
    li $t3, 0        # contador
    li $t4, 0        # suma

    # Imprimimos encabezado
    li $v0, 4
    la $a0, msg_res
    syscall

fib_loop:
    bge $t3, $t0, fin

    # Imprimimos término actual ($t1)
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, salto
    syscall

    # Acumulamos en suma
    add $t4, $t4, $t1

    # Calcularmos el siguiente término
    add $t5, $t1, $t2
    move $t1, $t2
    move $t2, $t5

    addi $t3, $t3, 1
    j fib_loop

fin:
    # Imprimimos suma
    li $v0, 4
    la $a0, msg_sum
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, salto
    syscall

    li $v0, 10
    syscall
