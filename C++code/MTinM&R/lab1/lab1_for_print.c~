/*
 * lab1.c
 *
 * Created: 11.09.2019 11:46:22
 * Author: Student   
 * Выводит от -180 до 180 без зацикливания. Накопленная сумма при заходе за пределы обнуляется.
 */

#include <define.h>

interrupt [EXT_INT1] void int1Isr(void)
{
    // Если прерывание по фронту
    if(BIT_IS_SET(PIND, 1))
    {
        // Настраиваем прерывание на срез
        EICRA = _BV(ISC11);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {
            angle+=9;
        }
        else    // Если на второй ножке высокий уровень
        {
            angle-=9;
        }
    }
    else
    {
        // Если прерывание по срезу
        // Настраиваем прерывание на фронт
        EICRA = _BV(ISC11) | _BV(ISC10);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {
            angle-=9;
        }
        else        // Если на второй ножке высокий уровень
        {
            angle+=9;
        }
    }      
    if(angle>180)
    {
        angle=180;
    }           
     if(angle<-180)
    {
        angle=-180;
    } 
    
}



void main(void)
{    
    init_segments()   ;
    #asm("sei");  //разрешение прерываний
    EICRA = _BV(ISC11) | _BV(ISC10) ;//на фронт
    EIMSK = _BV(INT1); 

while (1)
    {     
        indic_int(angle);
        delay_ms(20);     
    // Please write your application code here
    }
}
