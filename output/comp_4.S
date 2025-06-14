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
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	blt	e0				 @ saut si < est vrai
	mov	r0,	#0			 @ résultat faux
	b	e1				 @ saut vers fin
e0:
	mov	r0,	#1			 @ résultat vrai
e1:
	push	{r0}				 @ empile le résultat
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	bne	e2				 @ saut si != est vrai
	mov	r0,	#0			 @ résultat faux
	b	e3				 @ saut vers fin
e2:
	mov	r0,	#1			 @ résultat vrai
e3:
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	blt	e4				 @ saut si < est vrai
	mov	r0,	#0			 @ résultat faux
	b	e5				 @ saut vers fin
e4:
	mov	r0,	#1			 @ résultat vrai
e5:
	push	{r0}				 @ empile le résultat
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	bne	e6				 @ saut si != est vrai
	mov	r0,	#0			 @ résultat faux
	b	e7				 @ saut vers fin
e6:
	mov	r0,	#1			 @ résultat vrai
e7:
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
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	bne	e8				 @ saut si != est vrai
	mov	r0,	#0			 @ résultat faux
	b	e9				 @ saut vers fin
e8:
	mov	r0,	#1			 @ résultat vrai
e9:
	push	{r0}				 @ empile le résultat
	mov	r1,	#2	
	push	{r1}		
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	ble	e10				 @ saut si <= est vrai
	mov	r0,	#0			 @ résultat faux
	b	e11				 @ saut vers fin
e10:
	mov	r0,	#1			 @ résultat vrai
e11:
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	mov	r1,	#2	
	push	{r1}		
	mov	r1,	#3	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	beq	e12				 @ saut si == est vrai
	mov	r0,	#0			 @ résultat faux
	b	e13				 @ saut vers fin
e12:
	mov	r0,	#1			 @ résultat vrai
e13:
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
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#28	
	push	{r1}		
	mov	r1,	#10	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mov	r2,	r0			 @ copie r0 dans r2
	mul	r0,	r1,	r2		 @ r0 = r1 * r2
	push	{r0}				 @ empile le résultat
	mov	r1,	#120	
	push	{r1}		
	mov	r1,	#20	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ effectue l'opération r0+r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	bl	__aeabi_idiv				 @ division entière
	push	{r0}				 @ empile le résultat
	mov	r1,	#2	
	push	{r1}		
	mov	r1,	#3	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mov	r2,	r0			 @ copie r0 dans r2
	mul	r0,	r1,	r2		 @ r0 = r1 * r2
	push	{r0}				 @ empile le résultat
	mov	r1,	#57	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ effectue l'opération r0+r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	mov	r1,	#24	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	sub	r0,	r0,	r1		 @ effectue l'opération r0-r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	blt	e14				 @ saut si < est vrai
	mov	r0,	#0			 @ résultat faux
	b	e15				 @ saut vers fin
e14:
	mov	r0,	#1			 @ résultat vrai
e15:
	push	{r0}				 @ empile le résultat
	mov	r1,	#75	
	push	{r1}		
	mov	r1,	#47	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	beq	e16				 @ saut si == est vrai
	mov	r0,	#0			 @ résultat faux
	b	e17				 @ saut vers fin
e16:
	mov	r0,	#1			 @ résultat vrai
e17:
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
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	cmp	r0,	r1			 @ compare r0 et r1
	blt	e18				 @ saut si < est vrai
	mov	r0,	#0			 @ résultat faux
	b	e19				 @ saut vers fin
e18:
	mov	r0,	#1			 @ résultat vrai
e19:
	push	{r0}				 @ empile le résultat
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r0,	#0	
	pop	{fp, pc}		
