

// Массив кодов цифр
const unsigned char segments[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D,0x7D, 0x07, 0x7F, 0x6F, 0x40, 0x00};
unsigned char Digit (unsigned int val, unsigned char m)
{
    //[]-----------------------------------------------------[]
    //| Назначение: выделение цифр из разрядов пятиразрядного |
    //| десятичного положительного числа  |
    //| Входные параметры: |
    //| d - целое десятичное положительное число |
    //| m - номер разряда (от 1 до 5, слева направо) |
    //| Функция возвращает значение цифры в разряде m числа d |
    //[]-----------------------------------------------------[]
    unsigned char i = 5, a ;
    unsigned int d = val ;       
    while(i)
    { // цикл по разрядам числа
        a = d%10; // выделяем очередной разряд
        if(i-- == m) break; // выделен заданный разряд - уходим
        d /= 10; // уменьшаем число в 10 раз
    }
    return(a);
}

void indic_int (int val)
{
    unsigned char i = 1;
    int flag_first_digit = 0; 
    int var = val;
    if(val<0)
    {    
        var = abs(val); ///перевод в прямой код отрицательного числа  
    }
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
       {     if(val<0)  
             {
                 if(flag_first_digit==0)
                 {
                     PORTC = segments[SIGN];
                     BitSet(PORTA,i-1) ;    
                     delay_us(1)     ;
                     BitClr(PORTA,i-1) ;    
                 }  
             }
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

void init_segments()
{
    PORTA &=  ~(_BV(1) | _BV(2) | _BV(3) | _BV(4) | _BV(5) )  ;
    PORTC = 0 ;           
    DDRA = _BV(DDA1) | _BV(DDA2) | _BV(DDA3) | _BV(DDA4) | _BV(DDA5)  ;
    DDRC = _BV(DDC0) | _BV(DDC1) | _BV(DDC2) | _BV(DDC3) | _BV(DDC4) | _BV(DDC5) | _BV(DDC6) | _BV(DDC7); 
}

