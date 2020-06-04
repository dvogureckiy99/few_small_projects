#ifndef _I2C_INCLUDED_
#define _I2C_INCLUDED_

#pragma used+
void I2C_SendByte(unsigned char data);
void I2C_Start(void);
void I2C_Stop(void);
unsigned char I2C_ReadByte(unsigned char ack);
#pragma used-

#include <lib\I2C.c>  
  
#endif
