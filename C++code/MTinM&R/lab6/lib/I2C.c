
#define SDA 1
#define SCL 0
#define DDRX_I2C DDRG
#define HIGH(pin) (DDRX_I2C &= (~_BV(pin)))
#define LOW(pin) (DDRX_I2C |= _BV(pin))
#define PULSE 50 //us время импульса, определяет скорость передачи

void I2C_Start(void)
{
     HIGH(SDA);
     HIGH(SCL);
     delay_us(PULSE);
     LOW(SDA);
     delay_us(PULSE);    
}

void I2C_SendByte(unsigned char data)
{   //время на передачу 1 бита 3*PULSE  1 байт 24*PULSE
    unsigned char i; 
    LOW(SCL);
    delay_us(PULSE);
    for(i=(1<<7);i>0;i=(i>>1))
    {        
        if(data & i){HIGH(SDA);}else{LOW(SDA);}  
        delay_us(PULSE);         
        HIGH(SCL);
        delay_us(PULSE);
        LOW(SCL);
        delay_us(PULSE);
    }                          
        LOW(SDA); //чтобы при подтверждении не произошла отправка стоп-состояния   
        delay_us(PULSE);  //ждем пока ACK бит ведомого станет 1  
        //подтверждаем ACK бит
        HIGH(SCL);
        delay_us(PULSE);
        LOW(SCL);
        delay_us(PULSE);
}

void I2C_Stop(void) { HIGH(SCL); delay_us(PULSE); HIGH(SDA); delay_us(PULSE); }

unsigned char I2C_ReadByte(unsigned char ack)
{
   unsigned char i,readbyte =  0;  
   HIGH(SDA);
   for(i=(1<<7) ; i > 0 ; i = (i >>1))
   {    
        HIGH(SCL);   
        delay_us(PULSE);
        if(BIT_IS_SET(PING,SDA)) 
        readbyte |= i;
        LOW(SCL);
        delay_us(PULSE); 
   } 
   if(ack){HIGH(SDA);}else{LOW(SDA);}  //отправляем ACK-бит      
   delay_us(PULSE);   
   HIGH(SCL);
   delay_us(PULSE);
   LOW(SCL);
   delay_us(PULSE);      
   //для окончания приема
   LOW(SDA); 
   delay_us(PULSE);
   return readbyte;
}