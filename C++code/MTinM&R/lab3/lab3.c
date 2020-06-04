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
// ������ ��������������
ADCSRA |=    _BV(ADSC);          
// �������� ���������� ��������������
while(BIT_IS_CLEAR(ADCSRA, ADIF));
// ����� ����� ���������� ���
ADCSRA |= _BV(ADIF);
return ADCL+(ADCH<<8);
}

void main(void)
{   
    int val; 
    init_segments();            
    ADMUX = _BV(REFS0) |  3 ;   // ����� ������
    ADCSRA |=   _BV(ADEN)  ;    //������������� ���   

    DDRE = _BV(4) | _BV(5);     // ������������� ������ �����/������    4-green,  5-red
     
    // ������������� ������� �3  ��� ������������
    // ����� "10-�� ��������� ������� ���", 13/11/2019 20:21:18������ ������ 0x03FF
    //�����     OC3B ��� ���������� �������� TCNT3 � OCR3B (��������� 0)     GREEN
    //��������� OC3C ��� ���������� �������� TCNT3 � OCR3C (��������� 1)     RED
    TCCR3A =  _BV(COM3B1) | _BV(COM3C1) | _BV(COM3C0) | _BV(WGM31) | _BV(WGM30);
    TCCR3B = _BV(WGM32) | _BV(CS30);

while (1)
    {  
         val=readAdc();
         indic_int(val); 
         // ��������� ����� �������� � �������� ���������
         OCR3CH = high(val); 
         OCR3CL = low(val); 
         OCR3BH = high(val) ;
         OCR3BL = low(val) ;
         delay_ms(20);
    }
}
