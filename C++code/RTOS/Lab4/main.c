#include "stm32f4xx.h"                  // Device header
#include "FreeRTOSConfig.h"             // ARM.FreeRTOS::RTOS:Config
#include "FreeRTOS.h"                   // ARM.FreeRTOS::RTOS:Core
#include "task.h"                       // ARM.FreeRTOS::RTOS:Core
#include "semphr.h"                     // ARM.FreeRTOS::RTOS:Core
 
void Blinking(void* xSemaphore)
{	
	while(1)
	{
		if(xSemaphoreTake(xSemaphore, 0))
		{			// blinking 4 sec
			for(int count = 0; count < 4 ; count++)
			{
				GPIOA -> ODR |= GPIO_ODR_ODR_5; // turning LED on
				vTaskDelay(500);
				GPIOA -> ODR &= ~GPIO_ODR_ODR_5;
				vTaskDelay(500);				
			}
			xSemaphoreGive(xSemaphore);	
		}	
		vTaskDelay(1);	// time need to give chance	for check Mutex for SOS task	
	}
}
 
void SOS(void* xSemaphore)
{
		int n = pdMS_TO_TICKS(50);
		int m = 0;
		while(1)
		{
			if(xSemaphoreTake(xSemaphore, 0))
			{	
				for(int count = 0; count < 18 ; count++)
				{ // blinking 4 sec
					if (m == 3)
						n = pdMS_TO_TICKS(233);
					if (m == 6)
						n =pdMS_TO_TICKS(50);
					if (m == 9){
						m = 0;
						n = pdMS_TO_TICKS(50);}
					GPIOA -> ODR |= GPIO_ODR_ODR_5; 
					vTaskDelay(n);
					GPIOA -> ODR &= ~GPIO_ODR_ODR_5;
					vTaskDelay(n);
					m++;
				}
				xSemaphoreGive(xSemaphore);
			}
			vTaskDelay(1); // time need to give chance	for check Mutex for Blinking task	
		}
}	
 
int main(void)
{
 
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN; // turning on GPIOA
	GPIOA->MODER |= GPIO_MODER_MODER5_0; // setting A5 to output
	
	SemaphoreHandle_t xSemaphore = NULL; // initializing semaphore's handle
	xSemaphore = xSemaphoreCreateMutex(); // creating Mutex
	
	xTaskCreate(Blinking, "Task1", configMINIMAL_STACK_SIZE, xSemaphore, 8, NULL); 
	xTaskCreate(SOS, "Task2", configMINIMAL_STACK_SIZE, xSemaphore, 8, NULL);
	vTaskStartScheduler();
	
	while(1)
	{
	}
}
