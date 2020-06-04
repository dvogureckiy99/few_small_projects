/*
 * lab2.c
 *
 * Created: 11.09.2019 11:46:22
 * Author: Student   
 * 
 * Variant 8 
 * 8-�� ����. ������� ��� 0x00FF
 */
#include <define.h>

interrupt [EXT_INT1] void int1Isr(void)
{
    // ���� ���������� �� ������
    if(BIT_IS_SET(PIND, 1))
    {
        // ����������� ���������� �� ����
        EICRA = _BV(ISC11);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {
            angle+=1;
        }
        else    // ���� �� ������ ����� ������� �������
        {
            angle-=1;
        }
    }
    else
    {
        // ���� ���������� �� �����
        // ����������� ���������� �� �����
        EICRA = _BV(ISC11) | _BV(ISC10);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {
            angle-=1;
        }
        else        // ���� �� ������ ����� ������� �������
        {
            angle+=1;
        }
    }      
    if(angle>255)
    {
        angle=255;
    }           
     if(angle<0)
    {
        angle=0;
    } 
    
}

void main(void)
{   
    init_segments();
    
    #asm("sei");  //���������� ����������
    EICRA = _BV(ISC11) | _BV(ISC10) ;//�� �����
    EIMSK = _BV(INT1); 
    
    // ������������� ������ �����/������
    DDRE = _BV(4) | _BV(5);
     
    // ������������� ������� �3
    //  8-�� ����. ������� ���  , ������� ������ � 0x00FF     
    // ����� OC3B ��� ���������� TCNT3 � OCR3B (��������� 0)   � ��������� OC3� ��� ���������� TCNT3 � OCR3C (��������� 1)
    TCCR3A =  _BV(COM3B1) | _BV(COM3C1) | _BV(COM3C0) | _BV(WGM30);   
    TCCR3B = _BV(WGM32) | _BV(CS30);

while (1)
    {    
     indic_int(angle);
     OCR3CL = angle;
     OCR3BL = angle;
     delay_ms(20);
    }
}
