/*
 SCP1000 Barometric Pressure Sensor Display

 Shows the output of a Barometric Pressure Sensor on a
 Uses the SPI library. For details on the sensor, see:
 http://www.sparkfun.com/commerce/product_info.php?products_id=8161
 http://www.vti.fi/en/support/obsolete_products/pressure_sensors/

 This sketch adapted from Nathan Seidle's SCP1000 example for PIC:
 http://www.sparkfun.com/datasheets/Sensors/SCP1000-Testing.zip

/*
 Схема:
 Датчик SCP1000 подключен к выводам 6, 7, 10 - 13:
 DRDY: вывод 6
 CSB:  вывод 10
 MOSI: вывод 12
 MISO: вывод 11
 SCK:  вывод 13
 */
//Номера выводов
const int  CSB =  10;
//const int  MOSI = 12; 
//const int  MISO = 11;
//const int  SCK =  13;
  

// датчик взаимодействует через шину SPI, поэтому подключаем библиотеку:
#include <SPI.h>

// Адреса регистров памяти датчика 
const int PRESSURE = 0x1F;      //3 старших значащих бита давления
const int PRESSURE_LSB = 0x20;  //16 младших значащих бита давления
const int TEMPERATURE = 0x21;   //16 бит показаний температуры
const int  BYTESTOREAD_TEMPERATURE = 2; //максимальное количество считываемых байт температуры
const byte READ = 0b11111100;   // команда чтения SCP1000
const byte WRITE = 0b00000010;  // команда записи SCP1000

// выводы, используемые для подключения датчика
// остальные контролируются библиотекой SPI:
const int dataReadyPin = 6;
const int chipSelectPin = CSB;

void setup() {
  Serial.begin(9600);

  // запустить библиотеку SPI:
  SPI.begin();

  // настроить выводы готовности данных и выбора чипа:
  pinMode(dataReadyPin, INPUT);
  pinMode(chipSelectPin, OUTPUT);

  // настроить SCP1000 на малошумящую конфигурацию:
  writeRegister(0x02, 0x2D);
  writeRegister(0x01, 0x03);
  writeRegister(0x03, 0x02);
  // дать датчику время для настройки:
  delay(100);
}

void loop() {
  // выбрать режим высокого разрешения
  writeRegister(0x03, 0x0A);

  // ничего не делать, пока на выводе готовности данных не появится лог.1:
  if (digitalRead(dataReadyPin) == HIGH) {

    // прочитать данные температуры
    int tempData = readRegister(TEMPERATURE, BYTESTOREAD_TEMPERATURE);

    // преобразовать температуру в градусы Цельсия и отобразить ее:
    float realTemp = (float)tempData / 20.0;
    Serial.print("Temp[C]=");
    Serial.print(realTemp);


    // прочитать 3 старших бита данных давления:
    byte  pressure_data_high = readRegister(PRESSURE, 1);
    pressure_data_high &= 0b00000111; // нам необходимы биты только с 2 по 0

    // прочитать 16 младших битов данных давления:
    unsigned int pressure_data_low = readRegister(PRESSURE_LSB, 2);
    // объединить две части в одно 19-разрядное число:
    long pressure = ((pressure_data_high << 16) | pressure_data_low) / 4;

    // display the temperature:
    Serial.println("\tPressure [Pa]=" + String(pressure));
  }
}

//считывание данных 
// прочитать или записать регистр SCP1000:
unsigned int readRegister(byte thisRegister, int bytesToRead) {

  byte inByte = 0;           // входящий байт от SPI
  unsigned int result = 0;   // результат для возврата

  Serial.print(thisRegister, BIN);
  Serial.print("\t");

  // SCP1000 ждет имя регистра в старших 6 битах байта.
  // Поэтому сдвигаем биты влево на два разряда:
  thisRegister = thisRegister << 2;
  // теперь объединяем адрес и команду в один байт
  byte dataToSend = thisRegister & READ;   //0d######00
  Serial.println(thisRegister, BIN);
  // установить на выводе выбора чипа лог. 0, чтобы выбрать датчик:
  digitalWrite(chipSelectPin, LOW);

  // отправить устройству регистр, который мы хотим прочитать:
  SPI.transfer(dataToSend);
  // отправить значение 0 для чтения первого возвращенного байта:
  result = SPI.transfer(0x00);

  // уменьшить количество байтов, оставшихся для чтения:
  bytesToRead--;
  // если мы должны прочитать еще байт:
  if (bytesToRead > 0) {
    // сдвинуть первый байт влево, а затем получить второй байт:
    result = result << 8;
    inByte = SPI.transfer(0x00);
    // объединить байт, который только что получили, с предыдущим:
    result = result | inByte;
    // уменьшить количество байтов, оставшихся для чтения:
    bytesToRead--;
  }

  // установить на выводе выбора чипа лог. 1, чтобы отменить выбор датчика:
  digitalWrite(chipSelectPin, HIGH);
  // вернуть результат:
  return (result);
}

//отправка данных
// Отправить команду записи на SCP1000 в регистр с именем thisRegister и 1 байт данных в параметре thisValue
void writeRegister(byte thisRegister, byte thisValue)
{

  // SCP1000 ждет имя регистра в старших 6 битах байта.
  // Поэтому сдвигаем биты влево на два разряда:
  thisRegister = thisRegister << 2;
  // теперь объединяем адрес регистра с командой в один байт:
  byte dataToSend = thisRegister | WRITE;

  // установить на выводе выбора чипа лог. 0, чтобы выбрать датчик:
  digitalWrite(chipSelectPin, LOW);

  SPI.transfer(dataToSend); // отправить расположение регистра
  SPI.transfer(thisValue);  // отправить значение для записи в регистр

  // установить на выводе выбора чипа лог. 1, чтобы отменить выбор датчика:
  digitalWrite(chipSelectPin, HIGH);
}
