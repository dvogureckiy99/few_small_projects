#include "stm32f4xx.h"                  // Device header
#include "FreeRTOSConfig.h"             // ARM.FreeRTOS::RTOS:Config
#include "FreeRTOS.h"                   // ARM.FreeRTOS::RTOS:Core
#include "task.h"                       // ARM.FreeRTOS::RTOS:Core

void task1(void* pvParameters)
{
	// blinking of diode 
	while(1)
	{
		GPIOA->ODR |= GPIO_ODR_ODR_5;
		for(int i = 0; i < 1000000; i++);
		GPIOA->ODR &= ~GPIO_ODR_ODR_5;
		
		vTaskDelay(500); // delay 1 sec
	}
}

int main(void)
{
	// we use diode A5
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN; // turn on GPIOA
	GPIOA->MODER |= GPIO_MODER_MODER5_0; // set A5 output
	
	xTaskCreate(task1, "task1", configMINIMAL_STACK_SIZE, NULL, 4, NULL);
	vTaskStartScheduler();
	
	// in case of error in Scheduler
	while(1)
	{
	}
}
