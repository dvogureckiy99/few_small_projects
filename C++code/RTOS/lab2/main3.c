#include "stm32f4xx.h"                  // Device header
#include "FreeRTOSConfig.h"             // ARM.FreeRTOS::RTOS:Config
#include "FreeRTOS.h"                   // ARM.FreeRTOS::RTOS:Core
#include "task.h"                       // ARM.FreeRTOS::RTOS:Core
void task_one_diod_blinking(void* pvParameters)
{
	char m = 0;
	for(;;)
	{		
		GPIOA -> ODR ^= GPIO_ODR_ODR_10; 
		vTaskDelay(500);
		m++;
		if (m == 2*2)
			{
				m = 0;
				vTaskDelay(100);
			}
	}
}
void task_running_fire(void* pvParameters)
{	
	char m = 0;
	int OD_R = GPIO_ODR_ODR_8|GPIO_ODR_ODR_9;
	for(;;)
	{
		GPIOA -> ODR |= OD_R;
		vTaskDelay(50);
		GPIOA -> ODR &= ~OD_R;
		OD_R = OD_R >> 1;
		if (OD_R == 0)
		{
			OD_R = GPIO_ODR_ODR_8|GPIO_ODR_ODR_9;		
			m++;
			if (m == 2)
			{
				m = 0;
				vTaskDelay(5);
			}
		}
	}
}
int main(void)
{
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN; //Turning on GPIOA
	GPIOA->MODER |= GPIO_MODER_MODER0_0; //turning A0 to output
	GPIOA->MODER |= GPIO_MODER_MODER1_0; //turning A1 to output
	GPIOA->MODER |= GPIO_MODER_MODER2_0; //turning A2 to output
	GPIOA->MODER |= GPIO_MODER_MODER3_0; //turning A3 to output
	GPIOA->MODER |= GPIO_MODER_MODER4_0; //turning A4 to output
	GPIOA->MODER |= GPIO_MODER_MODER5_0; //turning A5 to output
	GPIOA->MODER |= GPIO_MODER_MODER8_0; //turning A8 to output
	GPIOA->MODER |= GPIO_MODER_MODER9_0; //turning A9 to output
	GPIOA->MODER |= GPIO_MODER_MODER10_0; //turning A10 to output for one diod
 
	xTaskCreate(task_one_diod_blinking, "task_one_diod_blinking", configMINIMAL_STACK_SIZE, NULL, 3, NULL);
	xTaskCreate(task_running_fire, "task_running_fire", configMINIMAL_STACK_SIZE, NULL, 5, NULL);
	vTaskStartScheduler();
	while(1);
}
