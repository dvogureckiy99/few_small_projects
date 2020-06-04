//var 7

#include <mega128a.h>  
#include <delay.h>

#define Time_1 100  // максимальное время задержки в мсек
#define Time_step 500 //время через которое изменяется задержка в мсек
#define STEP_ENGINE 5 //изменение времени задержки в мсек
#define time_pause 3000 // время между повторением алгоритма (мс)
#define Time_2 50 // минимальное время задержки в мсек

void main(void)
{
    int i=0;
    int time ; //время задержки
    int step_engine[4] = { //0b0000DCBA
    0b00000011,
    0b00000110, 
    0b00001100,
    0b00001001
    };
    int counter = 0;
    DDRC=0x0F;
     
    while (1)
    {   
        time = Time_1;
        //------прямое включение направления--------------
        while(time >= Time_2 )    //разгон двигателя 
        {
            for(i=0;i <= 3; i++)//
            {
                PORTC |= step_engine[i];     // сформировать фронт импульса
                delay_ms(time);              // задать длительность импульса
                PORTC &= ~step_engine[i]; 
            }
            
            
            if(counter >=  Time_step/(4*time) ) 
            {
                time -= STEP_ENGINE;
                counter = 0;
            }
            counter ++;
            
        }
        time = Time_2 ;
        while(time <= Time_1 )    //замедление  двигателя 
        {
            for(i=0;i <= 3; i++)//
            {
                PORTC |= step_engine[i];     // сформировать фронт импульса
                delay_ms(time);              // задать длительность импульса
                PORTC &= ~step_engine[i]; 
            }
            
            if(counter >=  Time_step/(4*time)) 
            {
                time += STEP_ENGINE;
                counter = 0;
            }
            counter ++;       
        }
        //------------------------------------------------------    
         time = Time_1;
        //------прямое включение направления--------------
        while(time >= Time_2 )    //разгон двигателя 
        {
            for(i=0;i <= 3; i++)//
            {
                PORTC |= step_engine[i];     // сформировать фронт импульса
                delay_ms(time);              // задать длительность импульса
                PORTC &= ~step_engine[i]; 
            }
            
            
            if(counter >=  Time_step/(4*time) ) 
            {
                time -= STEP_ENGINE;
                counter = 0;
            }
            counter ++;
            
        }
        time = Time_2 ;
        while(time <= Time_1 )    //замедление  двигателя 
        {
            for(i=0;i <= 3; i++)//
            {
                PORTC |= step_engine[i];     // сформировать фронт импульса
                delay_ms(time);              // задать длительность импульса
                PORTC &= ~step_engine[i]; 
            }
            
            if(counter >=  Time_step/(4*time)) 
            {
                time += STEP_ENGINE;
                counter = 0;
            }
            counter ++;       
        }
        //------------------------------------------------------  
        time = Time_1; 
        //----------обратное включение направления----------------------
        while(time >= Time_2 )    //разгон двигателя 
        {
            for(i = 3 ;i >= 0; i--)//
            {
                PORTC |= step_engine[i];     // сформировать фронт импульса
                delay_ms(time);              // задать длительность импульса
                PORTC &= ~step_engine[i]; 
            }
            
            
            if(counter >=  Time_step/(4*time) ) 
            {
                time -= STEP_ENGINE;
                counter = 0;
            }
            counter ++;
            
        }
        time = Time_2 ;
        while(time <= Time_1 )    //замедление  двигателя 
        {
            for(i = 3 ;i >= 0; i--)//
            {
                PORTC |= step_engine[i];     // сформировать фронт импульса
                delay_ms(time);              // задать длительность импульса
                PORTC &= ~step_engine[i]; 
            }
           
            
            if(counter >=  Time_step/(4*time) ) 
            {
                time += STEP_ENGINE;
                counter = 0;
            }
            counter ++;       
        } 
        //---------------------------------------------------------------------
        delay_ms(time_pause);// время между переключением направления двигателя  
    }
}
