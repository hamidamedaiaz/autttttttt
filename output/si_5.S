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
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e0:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e3				 @ saut si condition fausse
	mov	r1,	#3	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e2				 @ saut vers la fin
e3:
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
e2:
	mov	r0,	#0	
	pop	{fp, pc}		
