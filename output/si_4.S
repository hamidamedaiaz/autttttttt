.global __aeabi_idiv
    .global __aeabi_idivmod
.LC0:
    .ascii	"%d\000"
    .align	2
.LC1:
    .ascii	"%d\012\000"
    .text
    .align	2
    .global	main
main:
	push	{fp,lr}		
	add	fp,	sp,	#4
	mov	r1,	#7	
	push	{r1}		
	mov	r1,	#45	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	ble	e2				 @ saut si <= est vrai
	mov	r0,	#0			 @ résultat faux
	b	e3				 @ saut vers fin
e2:
	mov	r0,	#1			 @ résultat vrai
e3:
	push	{r0}				 @ empile le résultat
	mov	r1,	#48	
	push	{r1}		
	mov	r1,	#47	
	push	{r1}		
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ effectue l'opération r0+r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	beq	e4				 @ saut si == est vrai
	mov	r0,	#0			 @ résultat faux
	b	e5				 @ saut vers fin
e4:
	mov	r0,	#1			 @ résultat vrai
e5:
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ ou logique: r0 + r1
	cmp	r0,	#2			 @ compare avec 2
	blt	e6				 @ saut si < 2
	mov	r0,	#1			 @ si >= 2, mettre 1
e6:
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e1				 @ saut si condition fausse
	mov	r1,	#3	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e0				 @ saut vers la fin
e1:
e0:
	mov	r1,	#7	
	push	{r1}		
	mov	r1,	#45	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	bne	e9				 @ saut si != est vrai
	mov	r0,	#0			 @ résultat faux
	b	e10				 @ saut vers fin
e9:
	mov	r0,	#1			 @ résultat vrai
e10:
	push	{r0}				 @ empile le résultat
	mov	r1,	#48	
	push	{r1}		
	mov	r1,	#47	
	push	{r1}		
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ effectue l'opération r0+r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	beq	e11				 @ saut si == est vrai
	mov	r0,	#0			 @ résultat faux
	b	e12				 @ saut vers fin
e11:
	mov	r0,	#1			 @ résultat vrai
e12:
	push	{r0}				 @ empile le résultat
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	#0			 @ compare à 0
	moveq	r0,	#1			 @ si égal à 0 -> 1
	movne	r0,	#0			 @ sinon -> 0
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e8				 @ saut si condition fausse
	mov	r1,	#4	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e7				 @ saut vers la fin
e8:
e7:
	mov	r0,	#0	
	pop	{fp, pc}		
