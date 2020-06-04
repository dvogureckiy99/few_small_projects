/*
 * Created: 11.09.2019 11:46:22
 * Author: Student   
 * 
 * Variant 8 
 *  
 */
   
 
#include <define.h>

int readAdc()
{
// Запуск преобразования
ADCSRA |=    _BV(ADSC);          
// Ожидание завершения преобразования
while(BIT_IS_CLEAR(ADCSRA, ADIF));
// Сброс флага прерывания АЦП
ADCSRA |= _BV(ADIF);
return ADCL+(ADCH<<8);
}

void main(void)
{   
    int val; 
    init_segments();            
    ADMUX = _BV(REFS0) |  3 ;   // Выбор канала
    ADCSRA |=   _BV(ADEN)  ;    //инициализация АЦП   

    DDRE = _BV(4) | _BV(5);     // Инициализация портов ввода/вывода    4-green,  5-red
     
    // Инициализация таймера №3  без предделителя
    // режим "10-ти разрядный быстрый ШИМ", 13/11/2019 20:21:18ерхний предел 0x03FF
    //Сброс     OC3B при совпадении значения TCNT3 с OCR3B (установка 0)     GREEN
    //установка OC3C при совпадении значения TCNT3 с OCR3C (установка 1)     RED
    TCCR3A =  _BV(COM3B1) | _BV(COM3C1) | _BV(COM3C0) | _BV(WGM31) | _BV(WGM30);
    TCCR3B = _BV(WGM32) | _BV(CS30);

while (1)
    {  
         val=readAdc();
         indic_int(val); 
         // установка новых значений в регистры сравнения
         OCR3CH = high(val); 
         OCR3CL = low(val); 
         OCR3BH = high(val) ;
         OCR3BL = low(val) ;
         delay_ms(20);
    }
}
