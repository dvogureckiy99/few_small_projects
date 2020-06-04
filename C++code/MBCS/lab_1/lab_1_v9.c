/*
 * lab_1.c
 *
 * Created: 24.09.2018 10:10:32
 * Author: Ogureckiy  v9
 */

#include <mega128a.h>  
#include <delay.h>

unsigned char Digit (unsigned int, unsigned char) ;

void main(void)
{
    unsigned char i;      //счетчик  индикаторов
    unsigned int  sum = 4; //накопленная сумма   ряда
    unsigned char number;  //цифра числа 
    unsigned int step = 0; //количество членов ряда   
    unsigned char flag_first_num = 0 ; //  флаг появления первой цифры в разрядах группы индикаторов
       
    const unsigned char chisla[10]={  //комбинация зажженных светодиодов для каждой цифры
                0x3F,
                0x06,
                0x5B,
                0x4F,
                0x66,
                0x6D,
                0x7D,
                0x47,
                0x7F,
                0x6F
            };
    DDRA=0xFF;  //на выход
    DDRC=0xFF;  //на выход   
    
while (1)
    {        
        sum += 2;
        //------------вывод числа---------
        for(i=1; i<=5; i++)
        {                         
            number = Digit(sum,i);
            
            if(number != 0)
            {
               flag_first_num = 1; // ставим флаг в 1, т.к. появилась первая цифры в разрядах группы индикаторов             
            }
            if(flag_first_num == 0)
            {                       
                PORTC=0x00; 
                //--------отправляем код цифры на диоды индикатора--------------
                PORTA|=(1<<i);     
                delay_us(1);
                PORTA&=~(1<<i);
                //--------------------------------------------------------------         
            }          
                
            if(flag_first_num == 1)   
            {              
                PORTC=chisla[number];//помещаем в порт код для нужной цифры 
                //--------отправляем код цифры на диоды индикатора--------------
                PORTA|=(1<<i);     
                delay_us(1);
                PORTA&=~(1<<i);
                //--------------------------------------------------------------  
            }          
        }    
        //-------------------------  
        flag_first_num = 0;       
        step++;
        //проверяем, достигли ли мы нужного количества членов ряда
        if(step >= 20 ) 
        {
            sum = 4;
            step = 0;
        }      
        delay_ms(1000);
    }
}

unsigned char Digit (unsigned int d, unsigned char m)
{
//[]-----------------------------------------------------[]
//| Назначение: выделение цифр из разрядов пятиразрядного |
//| десятичного положительного числа |
//| Входные параметры: |
//| d - целое десятичное положительное число |
//| m - номер разряда (от 1 до 5, слева направо) |
//| Функция возвращает значение цифры в разряде m числа d |
//[]-----------------------------------------------------[]
unsigned char i = 5, a;
while(i)
{ 
    // цикл по разрядам числа
    a = d%10; // выделяем очередной разряд
    if(i-- == m) break; // выделен заданный разряд - уходим
    d /= 10; // уменьшаем число в 10 раз
}
return(a);
}
