/*
 * project_1.c
 *
 * Created: 12.09.2018 10:24:56
 * Author: Student
 */

#include <mega128a.h>
#include <delay.h>   //задержка

void main(void)
{
    signed char i;
    DDRA = 0xFF; //состояния на выход
    DDRC = 0xFF;   //уровень сигнала
    
while (1)
    {
    // Please write your application code here
        for(i=0; i<=7; i++)
        {
            PORTA = (1<<i);  
            
            delay_ms(100);   
            
        }  
        PORTA = 0 ;
         for(i=0; i<=7; i++)
        {
            PORTC = (1<<i);  
            
            delay_ms(100);   
            
        } 
        //PORTC = 0 ;     
        
        for(i=7; i>=0; i--)
        {
            PORTC = (1<<i);  
            
            delay_ms(100);   
            
        }  
        PORTC = 0 ;
         for(i=7; i>=0; i--)
        {
            PORTA = (1<<i);  
            
            delay_ms(100);   
            
        } 
        //PORTA = 0 ;
    }
}
