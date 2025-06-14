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
	mov	r1,	#4	
	push	{r1}		
	pop	{r0}				 @ dépile la valeur de l'expression dans r0
	push	{r0}				 @ stocke la valeur de la variable a
	mov	r1,	#3	
	push	{r1}		
	pop	{r0}				 @ dépile la valeur de l'expression dans r0
	push	{r0}				 @ stocke la valeur de la variable b
