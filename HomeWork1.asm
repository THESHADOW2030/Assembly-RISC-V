.data
a:	.word 7,8,-2,0,12,9,8
n:	.word 7
x:	.word 8

.text	#scrivere un programma che stampa quante volte appare il numero x
	la t0, a	#in t0 metto l'indirizzo del primo elemento
	lw t1, n	# in t1 metto la llunghezza del array
	add a0, zero, zero	#sarà il mio contatore di occorrenza
	lw s0, x		#l numero da cercare
loop:	beq t1, zero,fine
	addi t1, t1, -1
	lw t2, 0(t0)
	addi t0, t0, 4
	bne t2, s0,salta
	addi a0, a0, 1
salta:	beq zero, zero, loop
fine:	addi a7, zero, 1
	ecall
	addi a7, zero, 10
	ecall
