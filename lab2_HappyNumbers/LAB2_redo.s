.equ SWI_Exit, 0x11
.equ SWI_PrInt,0x6b
.equ SWI_Open, 0x66
.equ SWI_Close,0x68
.equ Stdout, 1
	
	.text
	.global main
main:
	ldr r0,=filename
	mov r1,#1
	swi 0x66
	;ldr r1,=nl
	swi 0x69
	swi SWI_Close
	mov r0,#1
	mov r1,#0
	mov r2,#0
	mov r3,#0
	mov r5,#2000
	add r5,r5,#2000
	add r5,r5,#2000
	add r5,r5,#2000
	add r5,r5,#2000
	sub r5,r5,#1
	mov r4,#1 @ i=1
loop:
	stmdb sp!,{r0-r3}
	bl copy_original @ func
	ldmia sp!,{r0-r3}
	cmp r1,#0
	bgt while_loop
	cmp r2,#0
	bgt while_loop
	cmp r3,#0
	bgt while_loop
	while_loop_done:
	b check_happy
	checking_done:
	add r4,r4,#1
	bl add_one
	mov r0,r6
	mov r1,r7
	mov r2,r8
	mov r3,r9
	cmp r4,r5
	blt loop
	b exit


while_loop:
	stmdb sp!,{r6-r9}
	bl sum_square @ func
	ldmia sp!,{r6-r9}
	cmp r1,#0
	bgt while_loop
	cmp r2,#0
	bgt while_loop
	cmp r3,#0
	bgt while_loop
	b while_loop_done

sum_square:
	mov r6,#0
	mov r7,#0
	mov r8,#0
	mov r9,#0
	mul r6,r0,r0
	mul r7,r1,r1
	mul r8,r2,r2
	mul r9,r3,r3
	mov r0,r6
	add r0,r0,r7
	add r0,r0,r8
	add r0,r0,r9
	mov r1,#0
	mov r2,#0
	mov r3,#0
	cmp r0,#9
	bgt adjust_1
	b adjust_done

adjust_1:
	sub r0,r0,#10
	add r1,r1,#1
	cmp r0,#9 @ check for carry
	bgt adjust_1
	cmp r1,#9
	bgt adjust2
	b adjust_done

adjust2:
	sub r1,r1,#10
	add r2,r2,#1
	cmp r1,#9
	bgt adjust2
	b adjust_done

adjust_done:
	bx lr




check_happy:
	cmp r0,#1
	beq print_int
	cmp r0,#7
	beq print_int
printing_done:
	b checking_done

add_one:
	add r6,r6,#1
	cmp r6,#9
	bgt carry_1
	carry_over:
	mov r0,r6
	mov r1,r7
	mov r2,r8
	mov r3,r9
	bx lr
carry_1:
	sub r6,r6,#10
	add r7,r7,#1
	cmp r7,#9
	bgt carry_2
	b carry_over

carry_2:
	sub r7,r7,#10
	add r8,r8,#1
	cmp r8 ,#9
	bgt carry_3
	b carry_over

carry_3:
	sub r8,r8,#10
	add r9,r9,#1
	b carry_over

copy_original:
	mov r6,r0
	mov r7,r1
	mov r8,r2
	mov r9,r3
	bx lr

print_int:
	ldr r0,=filename
	mov r1,#2
	swi 0x66
	mov r1,r9
	swi SWI_PrInt
	mov r1,r8
	swi SWI_PrInt
	mov r1,r7
	swi SWI_PrInt
	mov r1,r6
	swi SWI_PrInt
	ldr r1, =nl
	swi 0x69
	swi SWI_Close
	b printing_done
	
exit:
	swi SWI_Exit

.data
filename: .asciz "o"
nl: .ascii "\n"
