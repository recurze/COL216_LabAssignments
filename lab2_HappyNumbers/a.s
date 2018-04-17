zero:
one:
  .word 1
  .word 0
  .word 0
  .word 0
copy_bcd:
  str fp, [sp, #-4]!
  add fp, sp, #0
  sub sp, sp, #20
  str r0, [fp, #-16]
  str r1, [fp, #-20]
  mov r3, #0
  str r3, [fp, #-8]
  b .L2
.L3:
  ldr r3, [fp, #-8]
  mov r3, r3, lsl #2
  ldr r2, [fp, #-16]
  add r3, r2, r3
  ldr r2, [fp, #-8]
  mov r2, r2, lsl #2
  ldr r1, [fp, #-20]
  add r2, r1, r2
  ldr r2, [r2, #0]
  str r2, [r3, #0]
  ldr r3, [fp, #-8]
  add r3, r3, #1
  str r3, [fp, #-8]
.L2:
  ldr r3, [fp, #-8]
  cmp r3, #3
  movgt r3, #0
  movle r3, #1
  and r3, r3, #255
  cmp r3, #0
  bne .L3
  add sp, fp, #0
  ldmfd sp!, {fp}
  bx lr
square_digit:
  stmfd sp!, {fp, lr}
  add fp, sp, #4
  sub sp, sp, #8
  str r0, [fp, #-8]
  str r1, [fp, #-12]
  ldr r0, [fp, #-8]
  ldr r1, =.L7
  bl copy_bcd
  ldr r3, [fp, #-12]
  ldr r2, [fp, #-12]
  mul r2, r3, r2
  ldr r3, [fp, #-8]
  str r2, [r3, #0]
  b .L5
.L6:
  ldr r3, [fp, #-8]
  ldr r3, [r3, #0]
  sub r2, r3, #10
  ldr r3, [fp, #-8]
  str r2, [r3, #0]
  ldr r3, [fp, #-8]
  add r3, r3, #4
  ldr r2, [r3, #0]
  add r2, r2, #1
  str r2, [r3, #0]
.L5:
  ldr r3, [fp, #-8]
  ldr r3, [r3, #0]
  cmp r3, #9
  movle r3, #0
  movgt r3, #1
  and r3, r3, #255
  cmp r3, #0
  bne .L6
  sub sp, fp, #4
  ldmfd sp!, {fp, pc}
.L7:
  .word zero
add_BCD:
  str fp, [sp, #-4]!
  add fp, sp, #0
  sub sp, sp, #28
  str r0, [fp, #-16]
  str r1, [fp, #-20]
  str r2, [fp, #-24]
  mov r3, #0
  str r3, [fp, #-8]
  mov r3, #0
  str r3, [fp, #-12]
  b .L10
.L12:
  ldr r3, [fp, #-12]
  mov r3, r3, lsl #2
  ldr r2, [fp, #-16]
  add r3, r2, r3
  ldr r2, [fp, #-12]
  mov r2, r2, lsl #2
  ldr r1, [fp, #-20]
  add r2, r1, r2
  ldr r1, [r2, #0]
  ldr r2, [fp, #-12]
  mov r2, r2, lsl #2
  ldr r0, [fp, #-24]
  add r2, r0, r2
  ldr r2, [r2, #0]
  add r1, r1, r2
  ldr r2, [fp, #-8]
  add r2, r1, r2
  str r2, [r3, #0]
  mov r3, #0
  str r3, [fp, #-8]
  ldr r3, [fp, #-12]
  mov r3, r3, lsl #2
  ldr r2, [fp, #-16]
  add r3, r2, r3
  ldr r3, [r3, #0]
  cmp r3, #9
  ble .L11
  ldr r3, [fp, #-12]
  mov r3, r3, lsl #2
  ldr r2, [fp, #-16]
  add r3, r2, r3
  ldr r2, [fp, #-12]
  mov r2, r2, lsl #2
  ldr r1, [fp, #-16]
  add r2, r1, r2
  ldr r2, [r2, #0]
  sub r2, r2, #10
  str r2, [r3, #0]
  mov r3, #1
  str r3, [fp, #-8]
.L11:
  ldr r3, [fp, #-12]
  add r3, r3, #1
  str r3, [fp, #-12]
.L10:
  ldr r3, [fp, #-12]
  cmp r3, #3
  movgt r3, #0
  movle r3, #1
  and r3, r3, #255
  cmp r3, #0
  bne .L12
  add sp, fp, #0
  ldmfd sp!, {fp}
  bx lr
sum_square:
  stmfd sp!, {fp, lr}
  add fp, sp, #4
  sub sp, sp, #32
  str r0, [fp, #-32]
  str r1, [fp, #-36]
  ldr r0, [fp, #-32]
  ldr r1, =.L16
  bl copy_bcd
  mov r3, #0
  str r3, [fp, #-8]
  b .L14
.L15:
  ldr r3, [fp, #-8]
  mov r3, r3, lsl #2
  ldr r2, [fp, #-36]
  add r3, r2, r3
  ldr r3, [r3, #0]
  sub r2, fp, #24
  mov r0, r2
  mov r1, r3
  bl square_digit
  sub r3, fp, #24
  ldr r0, [fp, #-32]
  ldr r1, [fp, #-32]
  mov r2, r3
  bl add_BCD
  ldr r3, [fp, #-8]
  add r3, r3, #1
  str r3, [fp, #-8]
.L14:
  ldr r3, [fp, #-8]
  cmp r3, #3
  movgt r3, #0
  movle r3, #1
  and r3, r3, #255
  cmp r3, #0
  bne .L15
  sub sp, fp, #4
  ldmfd sp!, {fp, pc}
.L16:
  .word zero
chec_gt1:
  str fp, [sp, #-4]!
  add fp, sp, #0
  sub sp, sp, #12
  str r0, [fp, #-8]
  ldr r3, [fp, #-8]
  add r3, r3, #4
  ldr r2, [r3, #0]
  ldr r3, [fp, #-8]
  add r3, r3, #8
  ldr r3, [r3, #0]
  orr r2, r2, r3
  ldr r3, [fp, #-8]
  add r3, r3, #12
  ldr r3, [r3, #0]
  orr r3, r2, r3
  cmp r3, #0
  movle r3, #0
  movgt r3, #1
  mov r0, r3
  add sp, fp, #0
  ldmfd sp!, {fp}
  bx lr
check_happy:
  str fp, [sp, #-4]!
  add fp, sp, #0
  sub sp, sp, #12
  str r0, [fp, #-8]
  ldr r3, [fp, #-8]
  cmp r3, #1
  beq .L20
  ldr r3, [fp, #-8]
  cmp r3, #7
  bne .L21
.L20:
  mov r3, #1
  b .L22
.L21:
  mov r3, #0
.L22:
  mov r0, r3
  add sp, fp, #0
  ldmfd sp!, {fp}
  bx lr
.LC0:
  .ascii "number[%i] = %i%i%i%i \012\000"
main:
  stmfd sp!, {fp, lr}
  add fp, sp, #4
  sub sp, sp, #64
  mov r3, #0
  str r3, [fp, #-8]
  sub r3, fp, #28
  mov r0, r3
  ldr r1, =.L29
  bl copy_bcd
  mov r3, #1
  str r3, [fp, #-12]
  b .L24
.L28:
  sub r2, fp, #60
  sub r3, fp, #28
  mov r0, r2
  mov r1, r3
  bl copy_bcd
  b .L25
.L26:
  sub r2, fp, #44
  sub r3, fp, #60
  mov r0, r2
  mov r1, r3
  bl sum_square
  sub r2, fp, #60
  sub r3, fp, #44
  mov r0, r2
  mov r1, r3
  bl copy_bcd
.L25:
  sub r3, fp, #60
  mov r0, r3
  bl chec_gt1
  mov r3, r0
  cmp r3, #0
  moveq r3, #0
  movne r3, #1
  and r3, r3, #255
  cmp r3, #0
  bne .L26
  ldr r3, [fp, #-60]
  mov r0, r3
  bl check_happy
  mov r3, r0
  cmp r3, #0
  moveq r3, #0
  movne r3, #1
  and r3, r3, #255
  cmp r3, #0
  beq .L27
  ldr r3, [fp, #-8]
  add r3, r3, #1
  str r3, [fp, #-8]
  ldr r2, [fp, #-16]
  ldr r3, [fp, #-20]
  ldr r0, [fp, #-24]
  ldr r1, [fp, #-28]
  str r0, [sp, #0]
  str r1, [sp, #4]
  ldr r0, =.output
  ldr r0, =.L29+4
  ldr r1, [fp, #-8]
  swi 0x6b
.L27:
  sub r2, fp, #28
  sub r3, fp, #28
  mov r0, r2
  mov r1, r3
  ldr r2, =.L29
  bl add_BCD
  ldr r3, [fp, #-12]
  add r3, r3, #1
  str r3, [fp, #-12]
.L24:
  ldr r2, [fp, #-12]
  ldr r3, =.L29+8
  cmp r2, r3
  movgt r3, #0
  movle r3, #1
  and r3, r3, #255
  cmp r3, #0
  bne .L28
  mov r3, #0
  mov r0, r3
  sub sp, fp, #4
  ldmfd sp!, {fp, pc}
.L29:
  .word one
  .word .LC0
  .word 9998
.output: .ascii "o"
 