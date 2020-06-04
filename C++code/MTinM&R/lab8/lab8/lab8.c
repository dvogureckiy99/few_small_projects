/*
* lab8 
 * Created: 11.09.2019 11:46:22
 * Author: Student   
 * 
 * Variant 8 
 * Нужно добавить проверку кнопку энкодера     
 * 
  По нажатию на кнопку энкодера можно менять параметр для настройки.
   Светодиод индицирует параметр, который выбран в данный момент:
   — green Kd       
   — red Kp  
   - blue control
 * 3 10
 */
 
#include <define.h>

interrupt [EXT_INT2] void NameIsr(void)
{
    if (BIT_IS_CLEAR(PIND, 2))
    {     
        button++;         
        switch (button) {
        case 1:
            f_Kp=1;
            count=Kp;
        break;
        case 2:  //начать управление
            flag_control=1;
            f_Kp=0;
            PORTE = _BV(3);
        break;          
        case 3:       //вернуться в режим настройки
            PORTE=0;
            button=0;      
            count=Kd;
            flag_control=0;        
        break;
        default:
        };

    }


}

interrupt [EXT_INT1] void int1Isr(void)
{
    // Если прерывание по фронту
    if(BIT_IS_SET(PIND, 1))
    {
        // Настраиваем прерывание на срез 
        EICRA &= ~_BV(ISC10);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {   
            count+=1;
        }
        else    // Если на второй ножке высокий уровень
        {
            count-=1;
        }
    }
    else
    {
        // Если прерывание по срезу
        // Настраиваем прерывание на фронт
        EICRA |= _BV(ISC11) | _BV(ISC10);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {
            count-=1;
        }
        else        // Если на второй ножке высокий уровень
        {
            count+=1;
        }
    }                  
}


unsigned long readAdc(unsigned char channel)
{
    ADMUX = MUX | channel;
    delay_us(10);
    ADCSRA |= _BV(ADSC); // Запуск преобразования
    while(BIT_IS_CLEAR(ADCSRA, ADIF));   // Ожидание завершения преобразования
    ADCSRA |= _BV(ADIF);   // Сброс флага прерывания АЦП
    return ADCL+(ADCH<<8);
}

void main(void)
{
    int field; // Значение с датчика Холла
    unsigned long ref; // Задание 
    int error = 0; // Ошибка управления
    int control; // Сигнал управления 
    int error_last=0; //   Ошибка управления последнее   
    init_segments();   
    #asm("sei");  //разрешение прерываний
    EICRA |= _BV(ISC11) | _BV(ISC10) ;//на фронт
    EIMSK |= _BV(INT1); 
    // Инициализация портов ввода/вывода
    DDRB |= _BV(5) ;//ШИМ управления
    DDRG |= _BV(3);//направление тока 
    DDRD &= ~_BV(2); //кнопка
    //прерывание кнопки
    EICRA |= _BV(ISC21) ;//| _BV(ISC20) ;
    EIMSK |= _BV(INT2) ;
    DDRE |= _BV(5) | _BV (4) | _BV(3) ;
    PORTE  = 0;   
    // Инициализация АЦП
    ADCSRA = _BV(ADEN) | _BV(ADPS2) | _BV(ADPS1) | _BV(ADPS0); //freq=11.0529/128=0,08635078125 MHz T=11.58 us/tick 
    // Инициализация таймера 1
    // Быстрая ШИМ 8 бит
    TCCR1A = _BV(COM1A1) | _BV(WGM10);
    TCCR1B = _BV(WGM12) | _BV(CS10);
    while(1)
    {      
        if(flag_control)
        {
            //управления
            // Получение и фильтрация сигнала с датчика
            // магнитного поля
            field = (readAdc(1) + readAdc(1) +
            readAdc(1) + readAdc(1) + readAdc(1)) / 5;
            //field -= 512;   //если  показания датчика равны 512, то field равно 0
            
            ref = readAdc(3)*182;
            ref = ref/1023+508;  // Получение задания с ручки потенциомера
            if(field<=2) //магнит лежит
            {
                ref=559;//подбрасываем магнит, чтобы он нележал
            } 
            
            // Расчёт ошибки управления
            error = ref - field ;
            // Расчёт сигнала управления
            control = error/Kp+(error-error_last)*Kd;
            error_last=error;
            
            if(field>=460)  //прилипание, нужно "отпустить магнит"
            {
                control=-255;
            }

            
            // Ограничение сигнала управления
            if(control > 255)
            {
                control = 255;
            }
            if(control < -255)
            {
                control = -255;
            }  
            
            // Установка сигнала управления
            if(control >= 0)
            {
                PORTG &= ~_BV(3); //установка положительного тока
                OCR1AL = (unsigned char)control; 
            }
            else
            {                                
                PORTG |= _BV(3); //установка отрицательного тока
                OCR1AL = (unsigned char)(-control);
            }              
            indic_int( field );
        }else //настройка коэффиентов
        {      
            if(f_Kp){  Kp=count; }else{ Kd=count; };
            BitClr(PORTE,4);
            BitClr(PORTE,5);    
            BitSet(PORTE,(f_Kp ?  5 : 4 ));        
            indic_uint( f_Kp ? Kp : Kd ); 
        }    
    }
}