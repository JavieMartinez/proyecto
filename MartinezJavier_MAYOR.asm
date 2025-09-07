# Numero mayor entre N numeros
# Descripción: Pediremos entre 3 y 5 numeros de los cuales mostraremos el mayor 

.data
msg_n:     .asciiz "¿Cuantos numeros deseas comparar? (minimo 3 - maximo 5): "
msg_err:   .asciiz "ERROR: Solo se permiten entre 3 y 5 numeros.\n"
msg_num:   .asciiz "Ingresa un numero: "
msg_res:   .asciiz "El numero mayor es: "
salto:     .asciiz "\n"

.text 
.globl main

main:
  # Pedimos la cantidad de numeros 
  li $v0, 4
  la $a0, msg_n
  syscall 
  
  li $v0, 5          # Leemos entero
  syscall 
  move $t0, $v0      # Guardamos cantidad en $t0

  # Validar rango: si t0 < 3 o t0 > 5 -> error
  blt $t0, 3, error
  bgt $t0, 5, error
  
  # Inicializamos contador y maximo 
  li $t1, 0
  li $t2, -2147483648   # valor minimo posible
  
loop:
   bge $t1, $t0, fin    # Si contador >= cantidad, salir 
   
   # Pedir numero
   li $v0, 4
   la $a0, msg_num
   syscall 
   
   li $v0, 5
   syscall 
   move $t3, $v0        # Guardar numero ingresado 
   
   # Comparamos con maximo 
   ble $t3, $t2, no_cambia
   move $t2, $t3        # Actualizamos maximo 
   
no_cambia:
   addi $t1, $t1, 1
   j loop
   
fin:
   # Imprimimos resultado
   li $v0, 4
   la $a0, msg_res
   syscall 
   
   li $v0, 1
   move $a0, $t2
   syscall 
   
   li $v0, 4
   la $a0, salto
   syscall 
   
   li $v0, 10
   syscall

# Mensaje de error si el rango no es válido
error:
   li $v0, 4
   la $a0, msg_err
   syscall

   li $v0, 10
   syscall
