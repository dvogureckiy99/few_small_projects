/*
 * Created: 11.09.2019 11:46:22
 * Author: Student   
 * 
 * Variant 8 
 *  
 */
   
 
#include <define.h>
         
interrupt [EXT_INT7] void extIntIsr(void)
{
    // ���� ������� ������� �� �����, ��
    // ��� ������ ��������
    if(BIT_IS_SET(PINE, 7))
    { 
        // �������� ������� ������� ������� �3
        TCNT3H = 0;
        TCNT3L = 0;
    }
    else
    { 
        // ���� ������ ������� �� �����, ��
        // ��� ����� ��������
        // ��������� ������� �������� �������� ��������
        // ������� �3
        impulseWidth = TCNT3L;         //tick
        impulseWidth += (TCNT3H) << 8; //tick   
    }
}

void main(void)
{
    unsigned int length;    

    init_segments();
    DDRE = _BV(DDE6); // PORTE6 ��� ������ �������� �� ���� �������  
          
    EICRB = _BV(ISC70) ; //��������� �������� ���������� �� ����� ��������� �������� �������
    EIMSK = _BV(INT7);   //���������� ����������
    #asm("sei");  //���������� ����������        
    
    // ������������� ������� �3
    TCCR3B =  _BV(CS31);    //freq=11.0529/8=1.382 MHz T=724 ns/tick            
    
    while(1)        
    {   
        length =impulseWidth*prop; //cm  �������������� �������� �������   
        BitSet(PORTE,DDE6);   
        delay_us(10); 
        BitClr(PORTE,DDE6);
        delay_ms(50);    //����� ��� �������� ��������� ���������
        indic_uint(length);     //����� �������� �� 
    }
}

