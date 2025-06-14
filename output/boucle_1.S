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
e0:
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	mov	r1,	#2	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	bl	__aeabi_idivmod				 @ appel à la division modulaire, reste dans r1
	mov	r0,	r1			 @ copie le reste de r1 vers r0
	push	{r0}				 @ empile le résultat
	mov	r1,	#0	
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
	pop	{r1}				 @ dépile la condition
	cmp	r1,	#0			 @ teste si condition == 0 (faux)
	beq	e1				 @ saut si condition fausse
	mov	r1,	#0	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	b	e0				 @ retour au début de la boucle
e1:
	mov	r1,	#1	
	push	{r1}		
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r0,	#0	
	pop	{fp, pc}		
