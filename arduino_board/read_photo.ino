#include <SD.h>
#include <stdint.h>
File myFile;

#define TIME_OPEN_FILE 7200000 //ms 
#define TIME_SAMPLE 16 //msec время через которое происходит запись в файл
//на самом деле запись производится раз в 16051 мксек и за 1 мин происходит запись 3700 знач.
#define TIME_SAVE 60000 //ms время, через которое происходит сохрание 
#define TIME_UP 250 //мсек шаг изменения к.з. ШИМ  
#define TIME_START_BACKLIGHT 14400000 //мсек время, через которое запустится подтсветка
#define TIME_RUN_BACKLIGHT  3600000 //мсек время, работы подсветки

// SD-card . порты SPI:  51 (MOSI), 50 (MISO), 52 (SCK)
  #define CS_SD 53 
#define POTENTIOMETER  A0 //выбрать откуда считываются данные
#define DIOD 9 //порт с обязательной возможностью задавать ШИМ

uint32_t start  = TIME_OPEN_FILE+1; //время последнего открытия файла
uint16_t save = millis() ; //последнее время сохранения данных
uint16_t minute_1 = 0; //номер файла 
uint8_t last_time = millis(); //последнее время записи 
uint16_t last_time_4 =  millis();//последнее изменения к.з. ШИМ сигн., подаваемого на диод 
uint8_t flag_run_backlight = 0 ; //флаг работы подсветки
uint8_t flag_start_backlight = 0 ; //флаг запуска подсветки
uint16_t time_start_backlight ; //время начала подсветки 
uint8_t pwm = 0 ;

String name_txt = "" ;

void setup()
{

Serial.begin(9600);

 //инициализация
  Serial.print("Initializing SD card...");
  // на Ethernet шилде CS соответствует 4 пину. По умолчанию он установлен в режим output
  // обратите внимание, что если он не используется в качестве CS пина, SS пин на оборудовании
  // (10 на большинстве плат Arduino, 53 на Arduino Mega) надо оставить в режиме output.
  // иначе функции библиотеки SD library не будут работать.
  pinMode(CS_SD, OUTPUT);
  while (!SD.begin(CS_SD)) 
  {
    Serial.println("initialization failed!");
  }
  Serial.println("initialization done.");
  

}

void loop()
{
    //создание нового файла 
    uint32_t t1 = millis()-start ;
    if( (t1) >= TIME_OPEN_FILE ) //прошло 4  часа
    {
        myFile.close();
        name_txt = "";
        name_txt = (String)(minute_1);
        name_txt += ".txt";
        // открываем файл. Обратите внимание, что открывать несколько файлов параллельно нельзя.
        // перед открытием нового файла, старый надо закрыть
        myFile = SD.open(name_txt, FILE_WRITE);//создаём новый файл
        minute_1++;
        start = millis();
    }

    // сохраняем данные 
    uint16_t t2 = millis()-save;
    if( (t2) >= TIME_SAVE ) 
    { 
      myFile.close(); //закрыли  и сохранили
      myFile = SD.open(name_txt, FILE_WRITE);//открываем
      save = millis();
    }


    // если удалось открыть файл, записываем в него:
    if (myFile)
    {   
        uint8_t  t3 = millis()-last_time ;
        if( (t3)>= TIME_SAMPLE ) 
        {   
            Serial.println(analogRead(POTENTIOMETER));
            myFile.println(analogRead(POTENTIOMETER));//запись
            last_time = millis();
        }  
    } 
    else
    {

    }
         
/*
    //включена выдача возрастающего напряжение на диод с помощью ШИМ .
    if(flag_start_backlight == 0)
    {
      if( millis() >=  TIME_START_BACKLIGHT )
      { 
        flag_run_backlight = 1;
        flag_start_backlight = 1;
        time_start_backlight = millis();
      }
    }
    
    //условие выключение подсветки
    if(flag_run_backlight == 1 )
    {
      uint16_t t5 = millis() - time_start_backlight ;
      if(t5 >=  TIME_RUN_BACKLIGHT)
      { 
        flag_run_backlight = 0;
      }
    }
    
     //алгоритма работы подсветки
    if(flag_run_backlight == 1)
    {
      uint16_t t4 =  millis()-last_time_4 ;
      if( t4 >= TIME_UP)
      {
        analogWrite(DIOD,pwm);
        pwm++; //после переполнения , снова идёт с нуля
        last_time_4 = millis();
      }
    }
    */
   

}
