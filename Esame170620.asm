.data

vettore: 	.word 2,2,2,2,5,6,7,8,9,10
n:		.word 10

x:		.word 2
y:		.word 8

.text

		la t0, vettore	#puntatore
		lw t1, n	#numero elementi
		lw s1, x
		lw s0, y
		add a0, a0, zero	#registro dove mi salvo le occorrenze
loop:	beq t1, zero, fine
		addi t1, t1, -1
		lw t2, 0(t0)
		addi t0, t0, 4
		bne t2, s1, Y
		addi a0, a0, 1
		beq zero, zero, loop
Y:		bne t2, s0, loop
		addi a0, a0, 1
		beq zero, zero, loop	
fine:	addi a7, zero, 1
		ecall
		addi a7, zero, 10
		ecall	
	