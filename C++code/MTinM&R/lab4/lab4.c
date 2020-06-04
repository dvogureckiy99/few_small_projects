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
ADCSRA |=    _BV(ADSC);          //_BV(ADFR)
// Ожидание завершения преобразования
while(BIT_IS_CLEAR(ADCSRA, ADIF));
// Сброс флага прерывания АЦП
ADCSRA |= _BV(ADIF);
return ADCL+(ADCH<<8);
}

// Макроопределение значения регистра ICR1
#define ICR_VALUE 1382400 / 50     //27648
// Макроопределения значений регистров OCR1A и OCR1B
// Соответствующих крайним положениям
#define MAX_POS ICR_VALUE / 10     //2764.8
#define MIN_POS ICR_VALUE / 20    //1382.4     
#define PROPORTIONAL (MAX_POS-MIN_POS)/1023     //1.351
void main(void)
{
    float val;   
    init_segments();
    ADMUX = _BV(REFS0) |  3 ;  // Выбор канала с потенциометром
    ADCSRA |=   _BV(ADEN)  ;   //инициализация АЦП
     
    // Инициализация портов ввода/вывода  для управления сервомашнками
    //  PORTB5 (OC1A) —  Servo 1
    //  PORTB6 (OC1B) —  Servo 2
    DDRB |= _BV(5) | _BV(6);
    // Инициализация таймера №1
    //Сброс OC1A при совпадении значения TCNT3 с OCR3A (установка 0)   
    //Сброс OC1B при совпадении значения TCNT3 с OCR3B (установка 0)     
    TCCR1A = _BV(COM1A1) | _BV(COM1B1) | _BV(WGM11);
    // быстрая ШИМ , верхний предел ICRn
    // Ftimer = Fcpu / 8
    TCCR1B = _BV(WGM12) | _BV(WGM13) | _BV(CS11);
    // Установка верхнего предела для таймера №1
    ICR1 = ICR_VALUE;
    OCR1A=MIN_POS;
    OCR1B=MIN_POS;

    while(1)
    {    
        val=readAdc();
        // преобразование значения к диапазону регулирования 
        val*=1.351;    
        val+=MIN_POS ;
        
        indic_int(val);   
        // Задание положения сервомашинок 
        OCR1A=(int)val;   
        OCR1B=(int)val;
        delay_ms(20);
    }
}
