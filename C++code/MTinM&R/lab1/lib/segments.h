#ifndef _SEGMENTS_INCLUDED_
#define _SEGMENTS_INCLUDED_

//��������:
//��������� #pragma ������������ ��������� �������������� � ���, ��� ������� ���� ���������, �� �� ������������ � ���������
//� ��������� #pragma used-"���������" ������� ����, �� ������� ��� ��������� ����������������

/* this #pragma directive will prevent the compiler from generating a
  warning that the function was declared, but not used in the program */
#pragma used+

unsigned char Digit (unsigned int val, unsigned char m);
void indic_int (int val);
void init_segments();

#pragma used-

#include <lib\segments.c>  
  
#endif 