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
	mov	r1,	#0	
	push	{r1}		
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ ou logique: r0 + r1
	cmp	r0,	#2			 @ compare avec 2
	blt	e0				 @ saut si < 2
	mov	r0,	#1			 @ si >= 2, mettre 1
e0:
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#0	
	push	{r1}		
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ ou logique: r0 + r1
	cmp	r0,	#2			 @ compare avec 2
	blt	e1				 @ saut si < 2
	mov	r0,	#1			 @ si >= 2, mettre 1
e1:
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ ou logique: r0 + r1
	cmp	r0,	#2			 @ compare avec 2
	blt	e2				 @ saut si < 2
	mov	r0,	#1			 @ si >= 2, mettre 1
e2:
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ ou logique: r0 + r1
	cmp	r0,	#2			 @ compare avec 2
	blt	e3				 @ saut si < 2
	mov	r0,	#1			 @ si >= 2, mettre 1
e3:
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#0	
	push	{r1}		
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#0	
	push	{r1}		
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r1,	#1	
	push	{r1}		
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mul	r0,	r0,	r1		 @ et booléen = multiplication
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r0,	#0	
	pop	{fp, pc}		
