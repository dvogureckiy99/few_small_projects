#define SIGN 10
#define VOID 11

// ������ ����� ����
const unsigned char segments[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D,0x7D, 0x07, 0x7F, 0x6F, 0x40, 0x00};
unsigned char Digit (unsigned int val, unsigned char m)
{
    //[]-----------------------------------------------------[]
    //| ����������: ��������� ���� �� �������� �������������� |
    //| ����������� �������������� �����  |
    //| ������� ���������: |
    //| d - ����� ���������� ������������� ����� |
    //| m - ����� ������� (�� 1 �� 5, ����� �������) |
    //| ������� ���������� �������� ����� � ������� m ����� d |
    //[]-----------------------------------------------------[]
    unsigned char dig_num = 5, a ;
    unsigned int d = val ;       
    while(dig_num)
    { // ���� �� �������� �����
        a = d%10; // �������� ��������� ������
        if(dig_num-- == m) break; // ������� �������� ������ - ������
        d /= 10; // ��������� ����� � 10 ���
    }
    return(a);
}

void indic_int (int val)
{
    unsigned char dig_num = 1;
    int flag_first_digit = 0; 
    int var = val;
    if(val<0)
    {    
        var = abs(val); ///������� � ������ ��� �������������� �����  
    }
    do  
    {  
       unsigned int digit; 
       digit=Digit(var,dig_num);
       
       if(digit==0)
       {    
            if(flag_first_digit==0)
            {
                PORTC = segments[VOID];  
                if(dig_num==5)
                {
                    PORTC = segments[0];  
                }
            }else
            {  
                PORTC = segments[0];
            }
       }else
       {     if(val<0)  
             {
                 if(flag_first_digit==0)
                 {
                     PORTC = segments[SIGN];
                     BitSet(PORTA,dig_num-1) ;    
                     delay_us(1);
                     BitClr(PORTA,dig_num-1) ;    
                 }  
             }
             flag_first_digit = 1;
             PORTC = segments[digit];
                 
       }      
       BitSet(PORTA,dig_num) ;    
       delay_us(1)     ;
       BitClr(PORTA,dig_num) ;
       dig_num++;
    }
    while (dig_num<=5);
}


void indic_uint (unsigned int val)
{
    unsigned char i = 1;
    int flag_first_digit = 0; 
    int var = val;
    do  
    {  
       unsigned int digit; 
       digit=Digit(var,i);
       
       if(digit==0)
       {    
            if(flag_first_digit==0)
            {
                PORTC = segments[VOID];  
                if(i==5)
                {
                    PORTC = segments[0];  
                }
            }else
            {  
                PORTC = segments[0];
            }
       }else
       {    
             flag_first_digit = 1;
             PORTC = segments[digit];       
       }      
       BitSet(PORTA,i) ;    
       delay_us(1)     ;
       BitClr(PORTA,i) ;
       i++;
    }
    while (i<=5);   
}

void indic_5bit(char byte)
{
    char bit_mask = (1<<4);//����� ��� ������ ������� �����
    char dig_num = 1; //����� ������������� ���������� 
    int flag_first_digit = 0; 
    do  
    {  
       unsigned char digit; 
       if(byte & bit_mask)  //��������� ���� �� �����
       digit=1;  
       else
       digit=0;
       
       if(digit==0)
       {    
            if(flag_first_digit==0)
            { //���� �� �������� ������ �������� ������,������ �� ������� 
                PORTC = segments[VOID];  
                if(dig_num==5)
                {  //����� ���� ���� ����� 0, ������� 0
                    PORTC = segments[0];  
                }
            }else
            { //���������� �������� ������� ����� , ������� ����� 0
                PORTC = segments[0];
            }
       }else
       {    //���������� ������,�������  �� �����  ����
             flag_first_digit = 1;   //�������� �������� ������
             PORTC = segments[digit];       
       }      
       //������� ��� ������ ������������� ����������
       BitSet(PORTA,dig_num) ;    
       delay_us(1)     ;
       BitClr(PORTA,dig_num) ;
       bit_mask=(bit_mask>>1);//������� � ���������� ���� 
       dig_num++;         //������� � ���������� �������
    }
    while (bit_mask>0); //����� �� ���������� �������  
}
//void indic_float (float val)
//{
//    unsigned char i = 1;
//    int flag_first_digit = 0; 
//    flo var = val;
//    if(val<0)
//    {    
//        var = abs(val); ///������� � ������ ��� �������������� �����  
//    }
//    do  
//    {  
//       unsigned int digit; 
//       digit=Digit(var,i);
//       
//       if(digit==0)
//       {    
//            if(flag_first_digit==0)
//            {
//                PORTC = segments[VOID];  
//                if(i==5)
//                {
//                    PORTC = segments[0];  
//                }
//            }else
//            {  
//                PORTC = segments[0];
//            }
//       }else
//       {     if(val<0)  
//             {
//                 if(flag_first_digit==0)
//                 {
//                     PORTC = segments[SIGN];
//                     BitSet(PORTA,i-1) ;    
//                     delay_us(1)     ;
//                     BitClr(PORTA,i-1) ;    
//                 }  
//             }
//             flag_first_digit = 1;
//             PORTC = segments[digit];
//                 
//       }      
//       BitSet(PORTA,i) ;    
//       delay_us(1)     ;
//       BitClr(PORTA,i) ;
//       i++;
//    }
//    while (i<=5);
//    
//}

void init_segments()
{
    PORTA &=  ~(_BV(1) | _BV(2) | _BV(3) | _BV(4) | _BV(5) )  ;
    PORTC = 0 ;           
    DDRA = _BV(DDA1) | _BV(DDA2) | _BV(DDA3) | _BV(DDA4) | _BV(DDA5)  ;
    DDRC = _BV(DDC0) | _BV(DDC1) | _BV(DDC2) | _BV(DDC3) | _BV(DDC4) | _BV(DDC5) | _BV(DDC6) | _BV(DDC7);  
}

