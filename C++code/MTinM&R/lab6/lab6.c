/*
 * Created: 11.09.2019 11:46:22
 * Author: Student   
 * lab6
 * Variant 8 
 *  
 */
   
#include <define.h>
 
// Коды команд
#define START_CONVERT_T 0x51     //байт управления с битом записи,
#define READ_TEMPERATURE 0xAA    // байт управления с битом записи
#define ACCESS_CONFIG 0xAC       // байт  управления с битом записи
// Биты регистра конфигурации
#define R1 3   //разрядность предоставляемого результата и 
//время единичного измерения
#define R0 2
#define SHOT 0   // режим одиночного измерения. Если этот 
//бит сброшен, то датчик работает в режиме постоянного измерения. 
#define W 0     //запись
#define R 1     //чтение

// Запуск измерения температуры
void startConvert(unsigned char address)
{
  I2C_Start();
  I2C_SendByte( 0b10010000 |(address<<1) | W);
  I2C_SendByte(START_CONVERT_T);
  I2C_Stop();
}

// Функция чтения температуры с датчика
int readTemperature(unsigned char address)
{
  int result;
  I2C_Start();
  I2C_SendByte( 0b10010000 |(address<<1) | W);
  I2C_SendByte(READ_TEMPERATURE);
  I2C_Start();
  I2C_SendByte( 0b10010000 |(address<<1) | R);
  result = I2C_ReadByte(0);
  result <<= 8;
  result += I2C_ReadByte(1);
  I2C_Stop();
  return result/256;
}

// Настройка датчика температуры на одиночное
// измерение и 9-и битный результат
void setDs1631(unsigned char address)
{
  I2C_Start();
  I2C_SendByte(  0b10010000 |(address<<1) | W);  //
  I2C_SendByte(ACCESS_CONFIG);
  I2C_SendByte(_BV(SHOT));
  I2C_Stop();
} 

void main(void)
{
    LCD_init();
    LCD_string("temp(0) = ");
    LCD_pos(0,1); //перенос курсора в 0 позицию второй строки 
    LCD_string("temp(7) = ");
    while(1)
    {                                                                       
        setDs1631(0);
        startConvert(0);
        //вывод результата на дисплей
        LCD_pos(10,0); 
        LCD_uint(readTemperature(0));
        setDs1631(7);
        startConvert(7); 
        //вывод результата на дисплей 
        LCD_pos(10,1);
        LCD_uint(readTemperature(7));
        delay_ms(200); 
    }
}

