.data 

radice: .word n00
n00:	.word 0, n01, n02
n01: 	.word 0, n03, 0
n02:	.word 0, n04, 0
n03:	.word 1, 0, 0
n04:	.word 1, 0, n05
n05:	.word 0, 0, 0


.text	
	
	lw a1, radice #carica in a1 l'indirizzo della radice
	addi s0, zero, 0	#false		#per un fattore completamente mnemonico ho usato s0 e s1 per indicare true e falso. 
	addi s1, zero, 1	#true
	addi a3, zero, -1
	jal fun
	add a0, a3, zero
	addi a7, zero, 1
	ecall
	addi a7, zero, 10
	ecall
	
	#a1 = puntatore
	#a2 = true o false
	#a3 = passi
	
	

fun:	bne a1, zero, base2				#caso base. Albero vuoto. return con a2 = false
	add a2, zero, s0				#false
	jalr zero, ra, 0				#return
base2:	lw t0, 0(a1)					#carico lo status del nodo
	beq t0, zero, rico				#caso base. Albero malato. return con true
	addi a3, zero, 0		#iiii
	add a2, zero, s1				#true
	jalr zero, ra, 0				#return
rico:	addi sp, sp, -24	#ii				#passo ricorsivo: Controllo a sx. Se sx = false allora controllo a destra.
	sw ra, 0(sp)
	sw a1, 4(sp)						
	sw a5, 8(sp)					#Se sx è uguale a true mi controllo pure dx e confronto a3 come è stato modificato.
	sw a6, 12(sp)
	sw s5, 16(sp)##
	sw s6, 20(sp)##
					#in a5 ci vanno a finire i passi di sx
	add a5, zero,zero						#in a6 ci vanno a finire i passi di dx
	add a6, zero, zero
							#l'idea è di controllare a sx e poi a dx e tornare il minimo dei due in a3
	addi a1, a1, 4      #punto a sx	
	lw a1, 0(a1)

	jal fun
	add a5, zero, a3
	add s5, zero, a2		
	lw a1, 4(sp)		
	addi a1, a1, 8		#punto a dx
	lw a1, 0(a1)
	jal fun
	add a6, zero, a3
	add s6, zero, a2			#a5, a6 passi
				#s5, s6 true o false
				
				#s5 false controlla s6 e nel caso ritotna false se entrambi false
				#se s5 true controllo se s6 true e faccio il confronto senno torno a5 true
				
	beq s5, s1, sxT		#se s5 è false controllo s6
	beq s6, s1, boh		
	add a2, zero, s0	#se sono qui significa che anche s6 è falso
	beq zero, zero, fine
	
	
sxT:				#essendo s5 true controllo se lo è anche s6. 
	
	beq s6, s1, both  
	addi a3, a5, 1			#se sono arrivato fino a qui significa che solo s5 è true
	add a2, zero, s1
	beq zero, zero, fine			
	
boh: 	#nel caso in cui solo s6 sia true
	addi a3, a6, 1
	add a2, zero, s1
	beq zero, zero, fine

both:		#entrmbi sono a true

	bge a6, a5, a5V
	addi a3, a6, 1
	add a2, zero, s1
	beq zero, zero, fine
a5V:	addi a3, a5, 1
fine:				#rimetto a posto lo stack "come l'ho trovato"
	lw ra, 0(sp)
	lw a1, 4(sp)
	lw a5, 8(sp)
	lw a6, 12(sp)
	lw s5, 16(sp)##
	lw s6, 20(sp)##
	addi sp, sp, 24
	jalr zero, ra, 0
	
	
	
	
				
