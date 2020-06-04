#ifndef _LCD_INCLUDED_
#define _LCD_INCLUDED_

#pragma used+

void LCD_pos(char pos, char line);
    //��������� ������ DDRAM (������� �������)
unsigned char Code(unsigned char symb);  
    //[]------------------------------------------------[]
    //| ����������: ������������� �������� ��������� |
    //| ������� ���������: symb � ������ ASCII |
    //| ������� ���������� ��� ����������� ������� |
    //[]------------------------------------------------[]  
unsigned char Digit (unsigned int d, unsigned char m);
//��������� ������� ��� ������ � �������� 
void LCD_message(char message,int type );
    //[]--------------------------------------------------[]
    //| ����������: ������ ����� � ������� ������ ��� |
    //| ������� ���������: message - ��������� |  
    //| ������� ���������: type - ��� ��������� (��� ��� ������) |
    //[]--------------------------------------------------[]
void clear_display()      ;
    //�������� ������� � ���������� ������ � ������� �������(����� 0 ) 
void default_display() ;
    //���������� ������ � ������� �������, ������� ������������ ������ DDRAM � ��������� �������
void shift_direction(int ID,int S);
    //���������� ����������� ������ ������� ��� ������ ���� � DDRAM
    // � ���������(���������) ����� ���� ������ � ��������
    // ID = RHIGHT
    // ID = LEFT
    // S = ON ��������� ����� ���� ������ � ��������
    // S = OFF ��������� ����� ���� ������ � ��������
void switch_display(int B,int D,int C);
    //��������(���������) ���������,������(��������) ������.������� ������ ��������
    // B = ON  ������ ������
    // B = OFF ������ ��  ������
    // D = ON  �������� ���������
    // D = OFF ��������� ���������
    // C = ON  ������ ������
    // C = OFF �������� ������
void shift(int choose,int direction);
    //����� ������� ��� ������� ������ ��� �����
    // choose = DISPLAY
    // choose = CURSOR
    // direction = RHIGHT
    // direction = LEFT
void display_setting(int data_bus_width,int line_number,int font);
    //���������� ����������� ���� ������, ���������� �����, �����
    //data_bus_width = EIGHT 8 ���
    //data_bus_width = FOUR 4 ���
    //line_number = ONE 1 ������
    //line_number = TWO 2 ������
    //font = LOWERCASE  ��������
    ////font = UPPERCASE  ���������
void LCD_init(void) ;
    //[]--------------------------------------------------[]
    //| ����������: ������������� ��� |
    //[]--------------------------------------------------[]
void LCD_string(unsigned char *str);
    //����� ��������� ���������� �� �������
void LCD_uint(int value);
    //����� ��������� �������� (max 5 ���������� �������� � ������ ����)

#pragma used-

#include <lib\LCD.c>  
  
#endif