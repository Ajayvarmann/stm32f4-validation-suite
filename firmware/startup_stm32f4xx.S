.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

/* -----------------------------------------------------------------
 * STM32F407 Minimal Startup Code
 * ----------------------------------------------------------------- */

.section .isr_vector, "a", %progbits
.global _estack
.global Reset_Handler

.word _estack            /* Initial stack pointer */
.word Reset_Handler      /* Reset handler */
.word NMI_Handler
.word HardFault_Handler
.word MemManage_Handler
.word BusFault_Handler
.word UsageFault_Handler
.word 0, 0, 0, 0         /* Reserved */
.word SVC_Handler
.word DebugMon_Handler
.word 0
.word PendSV_Handler
.word SysTick_Handler

/* -----------------------------------------------------------------
 * Default handlers
 * ----------------------------------------------------------------- */
.thumb_func
.global Default_Handler
Default_Handler:
Infinite_Loop:
    b Infinite_Loop

/* -----------------------------------------------------------------
 * Weak aliases for exception handlers
 * ----------------------------------------------------------------- */
.thumb_func
.weak NMI_Handler
NMI_Handler:
    b Default_Handler

.thumb_func
.weak HardFault_Handler
HardFault_Handler:
    b Default_Handler

.thumb_func
.weak MemManage_Handler
MemManage_Handler:
    b Default_Handler

.thumb_func
.weak BusFault_Handler
BusFault_Handler:
    b Default_Handler

.thumb_func
.weak UsageFault_Handler
UsageFault_Handler:
    b Default_Handler

.thumb_func
.weak SVC_Handler
SVC_Handler:
    b Default_Handler

.thumb_func
.weak DebugMon_Handler
DebugMon_Handler:
    b Default_Handler

.thumb_func
.weak PendSV_Handler
PendSV_Handler:
    b Default_Handler

.thumb_func
.weak SysTick_Handler
SysTick_Handler:
    b Default_Handler

/* -----------------------------------------------------------------
 * Reset Handler
 * ----------------------------------------------------------------- */
.section .text.Reset_Handler, "ax", %progbits
.thumb_func
.type Reset_Handler, %function
Reset_Handler:
    /* Copy .data section from flash to SRAM */
    ldr r0, =_sidata
    ldr r1, =_sdata
    ldr r2, =_edata
1:
    cmp r1, r2
    ittt lt
    ldrlt r3, [r0], #4
    strlt r3, [r1], #4
    blt 1b

    /* Zero fill the .bss section */
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0
2:
    cmp r0, r1
    itt lt
    strlt r2, [r0], #4
    blt 2b

    /* Call main() */
    bl main

    /* If main returns, loop forever */
3:  b 3b

.size Reset_Handler, . - Reset_Handler
