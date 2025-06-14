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
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e1				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e0				 @ saut vers la fin
e1:
	mov	r1,	#0	
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
	mov	r1,	#7	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e0:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e4				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e3				 @ saut vers la fin
e4:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e5				 @ saut si condition fausse
	mov	r1,	#8	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e3				 @ saut vers la fin
e5:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e3:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e7				 @ saut si condition fausse
	mov	r1,	#9	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e6				 @ saut vers la fin
e7:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e8				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e6				 @ saut vers la fin
e8:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e6:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e10				 @ saut si condition fausse
	mov	r1,	#10	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e9				 @ saut vers la fin
e10:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e11				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e9				 @ saut vers la fin
e11:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e9:
	mov	r0,	#0	
	pop	{fp, pc}		
