/*
 * Created: 17.10.2019 11:46:22
 * Author: Student   
 * lab7
 * Variant 8 
 *  
 */  
#include <define.h>

void SPI_init()
{    //MOSI � PORTG3 �� ����� 
     //MISO � PORTG1 �� ����
     //SCLK � PORTG0 �� ����
     DDRG = _BV(MOSI) | _BV(SCLK) ; 
     BitSet(PORTG, SCLK) ; 
}

#define pulse 10

void SPI_Write(char byte)
{
    unsigned char i ; 
    for(i = (1 << 7) ; i > 0 ; i = (i>>1))
    {   
        if(byte & i )
            BitSet(PORTG, MOSI);
        else
            BitClr(PORTG, MOSI); 
        //������� ��� ������
        BitSet(PORTG, SCLK) ;
        delay_us(pulse);
        BitClr(PORTG, SCLK) ; 
        delay_us(pulse); 
    }
}

unsigned int SPI_Read()
{
    unsigned char i, byte = 0 ; 
    for(i = (1 << 7) ; i > 0 ; i = (i>>1))
    {    
        BitClr(PORTG, SCLK) ;
        delay_us(pulse);
        BitSet(PORTG, SCLK) ; 
        delay_us(pulse); 
        if( BIT_IS_SET(PING,MISO))
        byte |= i ;
    }
    return byte ;
}

unsigned long readAD7798()
{
    unsigned char byte1, byte2, byte3;
    unsigned long result;
    while(BIT_IS_SET(PING, MISO)); //�������� ������ ��������
    byte1 = SPI_Read();
    byte2 = SPI_Read();
    byte3 = SPI_Read();
    result = ((unsigned long)byte1 << 15) + ((unsigned long)byte2 << 7) + (unsigned long)byte3;
    return result;
}

void setAd7798()
{
    SPI_Write(CONFIG_REG); 
    delay_us(90);
    SPI_Write(_BV(G1) | _BV(G2) | _BV(UB));
    SPI_Write(_BV(BUF));
    delay_us(90);
    SPI_Write(MODE_REG);
    delay_us(90);
    SPI_Write(_BV(MD2));
    SPI_Write(_BV(FS0) | _BV(FS1) | _BV(FS2) | _BV(FS3));

    delay_us(90);
    SPI_Write(MODE_REG);
    delay_us(90);
    SPI_Write(0x00);
    SPI_Write(_BV(FS0) | _BV(FS1) | _BV(FS2) | _BV(FS3));
    delay_us(90);
    SPI_Write(_BV(RW) | _BV(RS1) | _BV(RS0) | _BV(CREAD));
}

void resetAD7798()
{
    unsigned char i;
    
    for(i = 0; i < 4; ++i)
    {
        SPI_Write(0xFF);
    }
}   

#define TIMER_FREQ (_BV(CS02) | _BV(CS01))
void initTimer()
{   // ������� ���,  ����� PORTB4 �� ��������� � OCR0
    TCCR0 = _BV(WGM01) | _BV(WGM00) | _BV(COM01);
    DDRB |= _BV(4);
    OCR0 = 128;
}
void startAlarm()
{   //clkI/O/1024 (From prescaler)
    TCCR0 |= TIMER_FREQ;
}
void stopAlarm()
{   //���������� �������
    TCCR0 &= ~TIMER_FREQ;
}

void main(void)
{
    unsigned long data;
    init_segments(); 
    initTimer(); 
    SPI_init(); 
    resetAD7798();//  ����� ���
    setAd7798();  //��������� �� ���������� ��������� 
    while(1)
    { 
       data = (char)(readAD7798()>>16); //���������� �������� ����� ���������                                                                    
       indic_5bit(data); 
       //��������� ��������� ��������� � ���������� 16 
       if(data>16) {startAlarm();}else{stopAlarm();}    
       delay_ms(200);        
    }
}

