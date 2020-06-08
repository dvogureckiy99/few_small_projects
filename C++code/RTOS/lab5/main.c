#include "stm32f4xx.h"                  // Device header
#include "FreeRTOSConfig.h"             // ARM.FreeRTOS::RTOS:Config
#include "FreeRTOS.h"                   // ARM.FreeRTOS::RTOS:Core
#include "task.h"                       // ARM.FreeRTOS::RTOS:Core
#include "semphr.h"                     // ARM.FreeRTOS::RTOS:Core

xQueueHandle xQueue; //global queue
SemaphoreHandle_t xSemaphore; // initializing semaphore's handle

void  EXTI10_IRQHandler()
{
    BaseType_t needCS = pdFALSE;
			/* Clear interrupt flag */
		EXTI->PR &= ~(EXTI_PR_PR0);//This bit is set when the selected edge event arrives on the external interrupt line. 
    xSemaphoreGiveFromISR(xSemaphore, &needCS);
    portYIELD_FROM_ISR(needCS);
}


void Blinking(void* xSemaphore)
{	
	int n ;
	#define f2HZ 0
	#define f10HZ 1
	char flag_mode = f2HZ; //
	
	while(1)
	{
		xQueueReceive(xQueue,&flag_mode,pdMS_TO_TICKS(0));
		if(flag_mode==f2HZ)			 {n=pdMS_TO_TICKS(250);}
		else if(flag_mode==f10HZ){n=pdMS_TO_TICKS(50);}
		GPIOA -> ODR ^= GPIO_ODR_ODR_5; // switching LED 
		vTaskDelay(n);
	} 
}
 
void change_mode(void* xSemaphore)
{
	  #define fHz 0 
		char flag_mode = 0; 
		while(1)
		{
			if(xSemaphoreTake(xSemaphore, 0))
			{		
				flag_mode ^= (1 << fHz); //change mode
				xQueueSendToFront(xQueue,&flag_mode,pdMS_TO_TICKS(0));
			}	
			vTaskDelay(pdMS_TO_TICKS(1000));
		}
}	

int main(void)
{
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN; // turning on GPIOA
	GPIOA->MODER |= GPIO_MODER_MODER5_0; // setting A5 to output
	GPIOA->MODER |= GPIO_MODER_MODER5_0; // setting A5 to output
	//GPIOA->MODER |= GPIO_MODER_MODER0_1; //  A0 default input
	RCC->APB2ENR |=RCC_APB2ENR_SYSCFGEN ; //System configuration controller clock enable
	SYSCFG->EXTICR[0] |= SYSCFG_EXTICR1_EXTI0_PA ;//These bit 0 are written by software to select the source input for the EXTIx external interrupt. 
	EXTI->IMR |= EXTI_IMR_MR0; // Interrupt request from line 0 is not masked
	EXTI->RTSR |= EXTI_RTSR_TR0 ;//  Rising trigger enabled (for Event and Interrupt) for input line
	NVIC_EnableIRQ(EXTI0_IRQn); //Enables a Device specific interrupt number in the NVIC interrupt controller 
	__enable_irq();
	
	//create xQueue
	xQueue = xQueueCreate(1, sizeof(char));
	if(xQueue == NULL) return 1;	//memory empty
 
	xSemaphore = xSemaphoreCreateBinary();
	if(xSemaphore == NULL) return 1; //memory empty
	
	xTaskCreate(Blinking, "Task1", configMINIMAL_STACK_SIZE, xSemaphore, 2, NULL); 
	xTaskCreate(change_mode, "Task2", configMINIMAL_STACK_SIZE,xSemaphore, 3, NULL);
	vTaskStartScheduler();
	
	while(1)
	{
	}
}
