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
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e1				 @ saut si condition fausse
	mov	r1,	#11	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e0				 @ saut vers la fin
e1:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e2				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e0				 @ saut vers la fin
e2:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e3				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e0				 @ saut vers la fin
e3:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e0:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e5				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e4				 @ saut vers la fin
e5:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e6				 @ saut si condition fausse
	mov	r1,	#12	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e4				 @ saut vers la fin
e6:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e7				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e4				 @ saut vers la fin
e7:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e4:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e9				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e8				 @ saut vers la fin
e9:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e10				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e8				 @ saut vers la fin
e10:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e11				 @ saut si condition fausse
	mov	r1,	#13	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e8				 @ saut vers la fin
e11:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e8:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e13				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e12				 @ saut vers la fin
e13:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e14				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e12				 @ saut vers la fin
e14:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e15				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e12				 @ saut vers la fin
e15:
	mov	r1,	#14	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e12:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e17				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e16				 @ saut vers la fin
e17:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e18				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e16				 @ saut vers la fin
e18:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e19				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e16				 @ saut vers la fin
e19:
e16:
	mov	r0,	#0	
	pop	{fp, pc}		
