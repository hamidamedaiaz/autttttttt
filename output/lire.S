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
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mov	r2,	r0			 @ copie r0 dans r2
	mul	r0,	r1,	r2		 @ r0 = r1 * r2
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ effectue l'opération r0+r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	sub	r0,	r0,	r1		 @ effectue l'opération r0-r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	mov	r1,	#3	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	mov	r2,	r0			 @ copie r0 dans r2
	mul	r0,	r1,	r2		 @ r0 = r1 * r2
	push	{r0}				 @ empile le résultat
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	bl	__aeabi_idiv				 @ division entière
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	mov	r1,	#5	
	push	{r1}		
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	add	r0,	r0,	r1		 @ effectue l'opération r0+r1 et met le résultat dans r0
	push	{r0}				 @ empile le résultat
	ldr	r0,	=.LC0			 @ adresse du format %d
	sub	sp,	sp,	#4		 @ réserver 4 octets sur la pile
	mov	r1,	sp			 @ adresse où stocker l'entier lu
	bl	scanf				 @ appel à scanf
	ldr	r0,	[sp]			 @ charger l'entier lu
	add	sp,	sp,	#4		 @ libérer la pile
	push	{r0}				 @ empiler la valeur lue
	pop	{r1}				 @ dépile exp2 dans r1
	pop	{r0}				 @ dépile exp1 dans r0
	bl	__aeabi_idivmod				 @ appel à la division modulaire, reste dans r1
	mov	r0,	r1			 @ copie le reste de r1 vers r0
	push	{r0}				 @ empile le résultat
	pop	{r1}		
	ldr	r0,	=.LC1	
	bl	printf		
	mov	r0,	#0	
	pop	{fp, pc}		
