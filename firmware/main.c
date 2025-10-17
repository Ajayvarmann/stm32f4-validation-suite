#include "stm32f4xx.h"

static void uart4_init(void)
{
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOCEN;
    RCC->APB1ENR |= RCC_APB1ENR_UART4EN;

    GPIOC->MODER &= ~((3U<<(10*2)) | (3U<<(11*2)));
    GPIOC->MODER |=  ((2U<<(10*2)) | (2U<<(11*2)));
    GPIOC->AFR[1] &= ~((0xF<<(2*4)) | (0xF<<(3*4)));
    GPIOC->AFR[1] |=  ((8U<<(2*4)) | (8U<<(3*4)));

    UART4->BRR = 16000000/115200;
    UART4->CR1 = USART_CR1_TE | USART_CR1_UE;
}

static void uart4_putc(char c)
{
    while(!(UART4->SR & USART_SR_TXE));
    UART4->DR = c;
}

static void uart4_puts(const char *s)
{
    while(*s) uart4_putc(*s++);
}

int main(void)
{
    uart4_init();
    uart4_puts("Hello, Renode!\r\n");

    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    GPIOD->MODER |= (1U<<(12*2));
    for(;;){
        GPIOD->ODR ^= (1U<<12);
        for(volatile int i=0;i<500000;i++);
    }
}
