.data

.text

.globl _start
_start:
	ldr	%r1, =0x9000000 /* UART address */
	ldr     %r2, =0x41 /* first letter A */
	ldr	%r3, =0x1 /* increment */
print_char:
	cmp     r2, #90
	bgt	nothing
	STRB 	r2, [r1]
	add	%r2, %r2, %r3 /* increment */
	b	print_char
nothing:
	b 	nothing
