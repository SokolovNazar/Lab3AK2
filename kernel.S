.syntax unified
.cpu cortex-m4
.thumb
#define A #5
#define B #2
#define C #3

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    final: .asciz "Value in register #4: "
.section .text
__kernel_reset__:
    ldr r0, =data
    bl dbgput_line

    
//calculation start
	mov r0, #1
	mov r1, A
	mov r2, B
	mov r3, C
	mov r4, #3

	lsl r0, r0, r3
	sub r1, r2
	mla r0, r1, r4, r0
	mov r2, r0
//calculation end

ldr r0, =final
    bl dbgput
    mov r0, r2
    bl dbgput_num
    
    end:
    b end
