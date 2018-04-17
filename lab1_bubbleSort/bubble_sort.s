	.data
AA: .word 4,10,6,19,3,12,67,35
	.text
	.global _start

_start:
	ldr r0, =AA
	mov r1, #28
	mov r2, r1
	add r2, r2, #4

outer_loop:
	sub r2, r2, #4
	cmp r2, #0
	beq end
	mov r3, #0

inner_loop:
	ldr r5, [r0,r3]
	add r3, r3, #4
	ldr r6, [r0,r3]
	sub r3, r3, #4
	cmp r5,r6
	ble increment

swapping:
	mov r4, r5
	mov r8, r6
	str r8, [r0,r3]
	add r3, r3, #4
	str r4, [r0,r3]
	sub r3, r3, #4

increment:
	add r3, r3, #4
	cmp r3, r2
	bge outer_loop
	b inner_loop

end:
	swi 0x11
	.end