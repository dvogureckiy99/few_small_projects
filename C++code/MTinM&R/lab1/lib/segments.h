#ifndef _SEGMENTS_INCLUDED_
#define _SEGMENTS_INCLUDED_

//дословно:
//директива #pragma предотвратит появление предупреждение о том, что функция была объявлена, но не используется в программе
//а директива #pragma used-"закрывает" область кода, на которую эта директива распространяется

/* this #pragma directive will prevent the compiler from generating a
  warning that the function was declared, but not used in the program */
#pragma used+

unsigned char Digit (unsigned int val, unsigned char m);
void indic_int (int val);
void init_segments();

#pragma used-

#include <lib\segments.c>  
  
#endif 
