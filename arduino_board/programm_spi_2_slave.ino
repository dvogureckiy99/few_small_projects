// Chip type ATmega168 at 16 MHz
// Пример реализации протокола SPI slave
//модель MSBFIRST
//mode 0
//передача 8 бит
//если передача состоялась, то лампочка загорается

// датчик взаимодействует через шину SPI, поэтому подключаем библиотеку:
#include <SPI.h>



// пропишем пины
//slave
#define spi_cs     3 // это D6  ардуино считывание данных chipselect  
#define spi_MOSI      7 // это D7  ардуино считывание данных MOSI
#define spi_MISO      8 // это D8 ардуино MISO управление состоянием порта 
#define spi_clk     2 // D9 ардуино  считывание данных

#define  Interrupt_PIN_2 0 //PIN 2 это Clk slave устройства
#define  Interrupt_PIN_3 1 //PIN 3 это CS slave устройства
#define TRANSM_BYTE_SLAVE  0xBD //байт, который мы передает слэйв

//master
#define TRANSM_BYTE_MASTER 0xA5//байт, который мы передает master 
const int  CS =  10;
const int LED_1_PIN = 19;     // для тестовой лампочки


char transm_byte_slave = TRANSM_BYTE_SLAVE ; //байт, который мы передает слэйв и храниит, полученное значение
char transm_byte_master = TRANSM_BYTE_MASTER;
char result = 0;// результат для возврата master
int i=0;

void setup() 
{
  Serial.begin(9600);
  initSpi_slave ();
    // запустить библиотеку SPI:
  SPI.beginTransaction(SPISettings(10000, MSBFIRST, SPI_MODE0));
  SPI.begin();
 pinMode(CS, OUTPUT);
 digitalWrite(CS, HIGH);
  digitalWrite(LED_1_PIN, LOW); // лампочка не горит
}


void loop() 
{
  // установить на выводе выбора чипа лог. 0, чтобы выбрать датчик:
 

 
 

  attachInterrupt(Interrupt_PIN_2, clk_on, CHANGE); // разрешаем прерывание
  attachInterrupt(Interrupt_PIN_3, activ_spi_slave, FALLING); // разрешаем прерывание
  delay(100);
  digitalWrite(CS, LOW);
   Serial.println("start");
  result = SPI.transfer( transm_byte_master); 
  Serial.println("End");
  
  digitalWrite(CS, HIGH);
  SPI.end();
  detachInterrupt(Interrupt_PIN_2);
 detachInterrupt(Interrupt_PIN_3);
 
 
  //сравнение полученных результатов с ожидаемыми 
  if ((result == TRANSM_BYTE_SLAVE )&&(transm_byte_slave == TRANSM_BYTE_MASTER ))
  {
    Serial.println("OK");
    digitalWrite(LED_1_PIN, HIGH); // лампочка  горит
  }
  
  
}

 
void initSpi_slave () 
{
    // инициализация линий.....
  pinMode(LED_1_PIN, OUTPUT);  
  
  pinMode( spi_MOSI, INPUT);
  pinMode(spi_MISO , OUTPUT);

  delay(1); // ждем устаканивания питания

}

//иммитация работы slave устройства
//с помощью прерываний

//при выборе устройства 
void activ_spi_slave()
{
     if (transm_byte_slave & 0x80) digitalWrite(spi_MISO, HIGH); else digitalWrite(spi_MISO, LOW) ; // выставляем один бит   
    //  0b########
    //& 0b10000000
    //  0b#0000000 т.е. byte & 0x80 — оставляет старший разряд , условие не сработает, если страший разряд будет равен 0
      transm_byte_slave<<=1;  
       Serial.print("отпраляем первый  бит "); 
}

//при зменение фронта clk
void clk_on()
{
  if(digitalRead(spi_clk)) 
  {
     if (digitalRead(spi_MOSI)) transm_byte_slave++;   // читаем бит и записываем его
      Serial.print("Читаем бит "); Serial.println(i+1);
  }
   else
   {
    Serial.print("отпраляем бит "); Serial.println(i+1);
    if (transm_byte_slave & 0x80) digitalWrite(spi_MISO, HIGH); else digitalWrite(spi_MISO, LOW); // выставляем один бит
     if (i!=7) transm_byte_slave<<=1;
     i++;
   }
}
