#ifndef _SEGMENTS_INCLUDED_
#define _SEGMENTS_INCLUDED_

#pragma used+

unsigned char Digit (unsigned int val, unsigned char m);
void indic_int (int val);
void init_segments();
void indic_uint (unsigned int val); 
void indic_5bit(char byte);

#pragma used-

#include <lib\segments.c>  
  
#endif 
