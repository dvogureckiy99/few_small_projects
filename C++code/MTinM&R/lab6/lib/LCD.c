
#include <io.h>
#include <mega128a.h>
#include <delay.h>

#define CMD 1
#define DATA 0
#define DISPLAY 1
#define CURSOR 0
#define RHIGHT 1
#define LEFT   0
#define ON 1
#define OFF 0
#define EIGHT 1
#define FOUR 0 
#define ONE 0
#define TWO 1
#define LOWERCASE  0
#define UPPERCASE  1
#define RS 7 // ����� ��������
#define E 6 // ����� ��������

//��������� ������ DDRAM (������� �������)
//pos = 0 ... 39
//line = 0 � first line
//line = 1 � second line
void LCD_pos(char pos, char line)
{
   LCD_message(((1<<7)|(pos+line*64)),CMD);
} 

//����� ��������� �������� (max 5 ���������� �������� � ������ ����)
void LCD_uint(int value)
{
    int i ;
    unsigned char flag_first_num = 0 ;
    unsigned char number; 
    if (value<0) LCD_message(0b10010110,DATA);//������� �����
    for(i=1; i<=5; i++)
    {                         
        number = Digit(value,i);    
        if(number != 0)   //��������� �������� �������
        {
           flag_first_num = 1;             
        }          
                
        if(flag_first_num == 1) 
        {   
                       
            LCD_message(number+'0',DATA);//������� ����� 
        }
            
    }     
}

void LCD_message(char message,int type) 
{
    //[]--------------------------------------------------[]
    //| ����������: ������ ����� � ������� ������ ��� |
    //| ������� ���������: message - ��������� |  
    //| ������� ���������: type - ��� ��������� (��� ��� ������) |
    //[]--------------------------------------------------[]
        
    if(type) // 1
    PORTD &= ~(1<<RS); // ����� �������� ������ RS=0
    else
    PORTD |= (1<<RS); // ����� �������� ������ RS=1 
    PORTC=message; // �������� ������� � ���� PORTC
    PORTD|= (1<<E); // \ ��������������
    delay_us(5); // |������ E ����� 1-0
    PORTD&= ~(1<<E); // / �������� �������
    delay_ms(3); // �������� ��� ���������� ������

}

void LCD_init(void) 
{
    //[]--------------------------------------------------[]
    //| ����������: ������������� ��� |
    //[]--------------------------------------------------[] 
    DDRC = 0xFF;            // ��� ������� PORTC �� �����
    DDRD|= ((1<<E)|(1<<RS));// ������� PORTD �� ����� 
    delay_ms (100); // �������� ��� ������������
                    // ���������� �������                         
    LCD_message(0x30,CMD); // \ �����
    LCD_message(0x30,CMD); //| ����
    LCD_message(0x30,CMD); // / ������ 0x30
    LCD_message(0x38,CMD); //8 ����.����, 2 ������, 5 ? 7 �����
    LCD_message(0x0E,CMD); // �������� ��� � ������, ��� ��������
    LCD_message(0x06,CMD); //��������� �������, ��� ������ ������
    LCD_message(0x01,CMD); // �������� �����, ������ � ������
}

//����� ��������� ���������� �� �������
void LCD_string(unsigned char* str) 
{
    while(*str != '\0')
    {
        LCD_message(Code(*str++),DATA);  
        //*str ���������� �������� �� ������ � ��������� str
        //str++ ���������� �������� ��������� �� 1 (�.�. ������� � ���������� �������� �������)     
    }
}

unsigned char Digit (unsigned int d, unsigned char m)
{
    //[]-----------------------------------------------------[]
    //| ����������: ��������� ���� �� �������� �������������� |
    //| ����������� �������������� ����� |
    //| ������� ���������: |
    //| d - ����� ���������� ������������� ����� |
    //| m - ����� ������� (�� 1 �� 5, ����� �������) |
    //| ������� ���������� �������� ����� � ������� m ����� d |
    //[]-----------------------------------------------------[]
    unsigned char i = 5, a;
    while(i)
    { 
        a = d%10; //���� d < 0 �� a<0 
        if(i-- == m) break; 
        d /= 10; 
    }
    return(a);
}

unsigned char Code(unsigned char symb) 
{
    //[]------------------------------------------------[]
    //| ����������: ������������� �������� ��������� |
    //| ������� ���������: symb � ������ ASCII |
    //| ������� ���������� ��� ����������� ������� |
    //[]------------------------------------------------[]      
      unsigned char TabCon[] =
    {0x41,0xA0,0x42,0xA1,0xE0,0x45,0xA3,0xA4,0xA5,0xA6,0x4B, 0xA7,0x4D,0x48,0x4F,0xA8,0x50,0x43,0x54,0xA9,0xAA,0x58,
    0xE1,0xAB,0xAC,0xE2,0xAD,0xAE,0x62,0xAF,0xB0,0xB1,0x61,
    0xB2,0xB3,0xB4,0xE3,0x65,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,
    0xBC,0xBD,0x6F,0xBE,0x70,0x63,0xBF,0x79,0x5C,0x78,0xE5,
    0xC0,0xC1,0xE6,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7};//���� �������� � ���������
    return (symb >= 192 ? TabCon[symb-192]: symb);
}

//�������� ������� � ���������� ������ � ������� �������(����� 0 )    
void clear_display()
{
    LCD_message(1,CMD); 
};

//���������� ������ � ������� �������, ������� ������������ ������ DDRAM � ��������� �������
void default_display() 
{
    LCD_message(2,CMD); 
};

//���������� ����������� ������ ������� ��� ������ ���� � DDRAM
// � ���������(���������) ����� ���� ������ � ��������
// ID = RIGHT
// ID = LEFT
// S = ON ��������� ����� ���� ������ � ��������
// S = OFF ��������� ����� ���� ������ � ��������
void shift_direction(int ID,int S)
{   
  LCD_message((1<<2)|(ID<<1)|S,CMD);  
}
    
//��������(���������) ���������,������(��������) ������.������� ������ ��������
// B = ON  ������ ������
// B = OFF ������ ��  ������
// D = ON  �������� ���������
// D = OFF ��������� ���������
// C = ON  ������ ������
// C = OFF �������� ������
void switch_display(int B,int D,int C) 
{
    LCD_message((1<<3)|(D<<2)|(C<<1)|B,CMD);  
}    

//����� ������� ��� ������� ������ ��� �����
// choose = DISPLAY
// choose = CURSOR
// direction = RIGHT
// direction = LEFT
void shift(int choose,int direction)
{
    LCD_message((1<<4)|(choose<<3)|(direction<<2),CMD); 
}

//���������� ����������� ���� ������, ���������� �����, �����
//data_bus_width = EIGHT 8 ���
//data_bus_width = FOUR 4 ���
//line_number = ONE 1 ������
//line_number = TWO 2 ������
//font = LOWERCASE  ��������
////font = UPPERCASE  ���������
void display_setting(int data_bus_width,int line_number,int font)
{
    LCD_message((1<<5)|(data_bus_width<<4)|(line_number<<3)|(font<<2),CMD);
}
