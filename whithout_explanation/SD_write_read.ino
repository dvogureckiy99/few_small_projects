#include <SD.h>
#include <TimeLib.h>
#include <stdint.h>
File myFile;



String name_txt = "" ;
unsigned int minute_1 = 0; //номер файла 
#define TIME_OPEN_FILE 4 //hour
#define TIME_SAMPLE 16 //msec на самом деле запись производится раз в 16051 мксек и за 1 мин происходит запись 3700 знач.
#define TIME_SAVE 1 //min
time_t start  = TIME_OPEN_FILE*3600;
time_t save = now() ;//последнее время сохранения данных
#define potent  A0 
uint16_t massive[100];

void setup()
{

Serial.begin(9600);

 //инициализация
  Serial.print("Initializing SD card...");
  // на Ethernet шилде CS соответствует 4 пину. По умолчанию он установлен в режим output
  // обратите внимание, что если он не используется в качестве CS пина, SS пин на оборудовании
  // (10 на большинстве плат Arduino, 53 на Arduino Mega) надо оставить в режиме output.
  // иначе функции библиотеки SD library не будут работать.
  pinMode(10, OUTPUT);
  while (!SD.begin(10)) 
  {
    Serial.println("initialization failed!");
  }
  Serial.println("initialization done.");
  
  start = TIME_OPEN_FILE*3600;//последнее время создания файла
  randomSeed(analogRead(A0));//инициализация генератора псевдослучайных чисел

}

void loop()

{
    
    static unsigned int i = 1 ;
// после setup ничего не происходит
//создание нового файла раз в мин
    time_t t = now();
    if( (get_hour(t)-get_hour(start)) >= TIME_OPEN_FILE ) //прошло 4  часа
    {
        myFile.close();
        name_txt = "";
        name_txt = (String)(minute_1);
        name_txt += ".txt";
        Serial.print("Writing to ...");
        Serial.print(name_txt);
        Serial.println("...");
        // открываем файл. Обратите внимание, что открывать несколько файлов параллельно нельзя.
        // перед открытием нового файла, старый надо закрыть
        myFile = SD.open(name_txt, FILE_WRITE);//создаём новый файл
        minute_1++;
        i=1;
        start = now();
    }
    
    // сохраняем данные 
    if( (get_minute(t)-get_minute(save)) >= TIME_SAVE ) 
    { 
      myFile.close(); //закрыли  и сохранили
      Serial.print("Save ...");
      Serial.print(name_txt);
      Serial.println("...");
      myFile = SD.open(name_txt, FILE_WRITE);//открываем
      save = now();
    }

    //считывание в массив
    static uint8_t j = 0;
    massive[j]= random(0, 1024) ;
    if(j>=99) {j=0;} //перезапись значения, записанного раньше всего
    else {j++;}
    // если удалось открыть файл, записываем в него:
    if (myFile)
    {   
      static unsigned long last_time = millis(); //последнее время заупска алгоритма
        if( (millis()-last_time)>= TIME_SAMPLE ) 
        {   
            uint16_t value = 0;
            for(int k = 0; k < 100;k++)
            {
              value += massive[k];
              Serial.print("value += massive[");
              Serial.print(k);
              Serial.print("] == value +=");
              Serial.println(massive[k]);
            }
            value /= 100;
            myFile.println(value); //запсись
          //  myFile.println(analogRead(potent));
            last_time = millis();
            Serial.print(i);
            Serial.print(".done.");
            Serial.println(value); //рандомные значения
            i++;
            j=0;
            //очистка
            for(int k = 0; k < 100;k++)
            {
              massive[k]=0;
            }
        }
        
    } 
    else
    {
        // если файл не открылся, выводим сообщение об ошибке
        Serial.print(i);
        Serial.println(" error opening ");
        i++;
    }

}
