/*
 * lab_2.c
 *V9
 * Created: 24.09.2018 12:50:38
 * Author: Student
 */

#include <mega128a.h>  
#include <delay.h>

#define Time_1 3  // время вывода рис. в сек


void main(void)
{
    int i = 0;   
    int counter = 0;
    int stolb[8]= 
    { 
        0xFF, 
        0b00000011,
        0b00111111,
        0b00000011,
        0b00011111,
        0b00000011,
        0b00001111,
        0b00000011
    }   ;
    DDRA=0xFF;
    DDRD=0xF0;
    DDRC=0xFF;     
while (1)
    {   
        while(counter <= Time_1/0.0001 )  
        {  
            for(i = 0 ; i<=7 ; i++)      
            {
                PORTD = (i<<4)  ; // выбор столбца    
                PORTA = stolb[i]; //диоды, в столбце 
                delay_us(100); 
                counter++;
            }  
                   
        }  
        counter = 0;   
         while(counter <= Time_1/0.0001 )  
        {  
            for(i = 0 ; i<=7 ; i++)      
            {
                PORTD = (i<<4)  ; // выбор столбца    
                PORTA = ~stolb[i]; //диоды, в столбце 
                delay_us(100); 
                counter++;
            }  
                   
        }
//        PORTA=0;   
        counter = 0; 
          
        
//        delay_ms(1000);
    }


   
}
