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
ADCSRA |=    _BV(ADSC);          //_BV(ADFR)
// �������� ���������� ��������������
while(BIT_IS_CLEAR(ADCSRA, ADIF));
// ����� ����� ���������� ���
ADCSRA |= _BV(ADIF);
return ADCL+(ADCH<<8);
}

// ���������������� �������� �������� ICR1
#define ICR_VALUE 1382400 / 50     //27648
// ���������������� �������� ��������� OCR1A � OCR1B
// ��������������� ������� ����������
#define MAX_POS ICR_VALUE / 10     //2764.8
#define MIN_POS ICR_VALUE / 20    //1382.4     
#define PROPORTIONAL (MAX_POS-MIN_POS)/1023     //1.351
void main(void)
{
    float val;   
    init_segments();
    ADMUX = _BV(REFS0) |  3 ;  // ����� ������ � ��������������
    ADCSRA |=   _BV(ADEN)  ;   //������������� ���
     
    // ������������� ������ �����/������  ��� ���������� �������������
    //  PORTB5 (OC1A) �  Servo 1
    //  PORTB6 (OC1B) �  Servo 2
    DDRB |= _BV(5) | _BV(6);
    // ������������� ������� �1
    //����� OC1A ��� ���������� �������� TCNT3 � OCR3A (��������� 0)   
    //����� OC1B ��� ���������� �������� TCNT3 � OCR3B (��������� 0)     
    TCCR1A = _BV(COM1A1) | _BV(COM1B1) | _BV(WGM11);
    // ������� ��� , ������� ������ ICRn
    // Ftimer = Fcpu / 8
    TCCR1B = _BV(WGM12) | _BV(WGM13) | _BV(CS11);
    // ��������� �������� ������� ��� ������� �1
    ICR1 = ICR_VALUE;
    OCR1A=MIN_POS;
    OCR1B=MIN_POS;

    while(1)
    {    
        val=readAdc();
        // �������������� �������� � ��������� ������������� 
        val*=1.351;    
        val+=MIN_POS ;
        
        indic_int(val);   
        // ������� ��������� ������������ 
        OCR1A=(int)val;   
        OCR1B=(int)val;
        delay_ms(20);
    }
}
