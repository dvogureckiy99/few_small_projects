/*
* lab8 
 * Created: 11.09.2019 11:46:22
 * Author: Student   
 * 
 * Variant 8 
 * ����� �������� �������� ������ ��������     
 * 
  �� ������� �� ������ �������� ����� ������ �������� ��� ���������.
   ��������� ���������� ��������, ������� ������ � ������ ������:
   � green Kd       
   � red Kp  
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
        case 2:  //������ ����������
            flag_control=1;
            f_Kp=0;
            PORTE = _BV(3);
        break;          
        case 3:       //��������� � ����� ���������
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
    // ���� ���������� �� ������
    if(BIT_IS_SET(PIND, 1))
    {
        // ����������� ���������� �� ���� 
        EICRA &= ~_BV(ISC10);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {   
            count+=1;
        }
        else    // ���� �� ������ ����� ������� �������
        {
            count-=1;
        }
    }
    else
    {
        // ���� ���������� �� �����
        // ����������� ���������� �� �����
        EICRA |= _BV(ISC11) | _BV(ISC10);
        
        if(BIT_IS_CLEAR(PIND, 0))
        {
            count-=1;
        }
        else        // ���� �� ������ ����� ������� �������
        {
            count+=1;
        }
    }                  
}


unsigned long readAdc(unsigned char channel)
{
    ADMUX = MUX | channel;
    delay_us(10);
    ADCSRA |= _BV(ADSC); // ������ ��������������
    while(BIT_IS_CLEAR(ADCSRA, ADIF));   // �������� ���������� ��������������
    ADCSRA |= _BV(ADIF);   // ����� ����� ���������� ���
    return ADCL+(ADCH<<8);
}

void main(void)
{
    int field; // �������� � ������� �����
    unsigned long ref; // ������� 
    int error = 0; // ������ ����������
    int control; // ������ ���������� 
    int error_last=0; //   ������ ���������� ���������   
    init_segments();   
    #asm("sei");  //���������� ����������
    EICRA |= _BV(ISC11) | _BV(ISC10) ;//�� �����
    EIMSK |= _BV(INT1); 
    // ������������� ������ �����/������
    DDRB |= _BV(5) ;//��� ����������
    DDRG |= _BV(3);//����������� ���� 
    DDRD &= ~_BV(2); //������
    //���������� ������
    EICRA |= _BV(ISC21) ;//| _BV(ISC20) ;
    EIMSK |= _BV(INT2) ;
    DDRE |= _BV(5) | _BV (4) | _BV(3) ;
    PORTE  = 0;   
    // ������������� ���
    ADCSRA = _BV(ADEN) | _BV(ADPS2) | _BV(ADPS1) | _BV(ADPS0); //freq=11.0529/128=0,08635078125 MHz T=11.58 us/tick 
    // ������������� ������� 1
    // ������� ��� 8 ���
    TCCR1A = _BV(COM1A1) | _BV(WGM10);
    TCCR1B = _BV(WGM12) | _BV(CS10);
    while(1)
    {      
        if(flag_control)
        {
            //����������
            // ��������� � ���������� ������� � �������
            // ���������� ����
            field = (readAdc(1) + readAdc(1) +
            readAdc(1) + readAdc(1) + readAdc(1)) / 5;
            //field -= 512;   //����  ��������� ������� ����� 512, �� field ����� 0
            
            ref = readAdc(3)*182;
            ref = ref/1023+508;  // ��������� ������� � ����� ������������
            if(field<=2) //������ �����
            {
                ref=559;//������������ ������, ����� �� �������
            } 
            
            // ������ ������ ����������
            error = ref - field ;
            // ������ ������� ����������
            control = error/Kp+(error-error_last)*Kd;
            error_last=error;
            
            if(field>=460)  //����������, ����� "��������� ������"
            {
                control=-255;
            }

            
            // ����������� ������� ����������
            if(control > 255)
            {
                control = 255;
            }
            if(control < -255)
            {
                control = -255;
            }  
            
            // ��������� ������� ����������
            if(control >= 0)
            {
                PORTG &= ~_BV(3); //��������� �������������� ����
                OCR1AL = (unsigned char)control; 
            }
            else
            {                                
                PORTG |= _BV(3); //��������� �������������� ����
                OCR1AL = (unsigned char)(-control);
            }              
            indic_int( field );
        }else //��������� �����������
        {      
            if(f_Kp){  Kp=count; }else{ Kd=count; };
            BitClr(PORTE,4);
            BitClr(PORTE,5);    
            BitSet(PORTE,(f_Kp ?  5 : 4 ));        
            indic_uint( f_Kp ? Kp : Kd ); 
        }    
    }
}