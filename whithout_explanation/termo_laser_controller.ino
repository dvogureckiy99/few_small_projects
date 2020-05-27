#include <PID_v1.h>
//We always have to include the library
#include "LedControl.h"

//Define Variables we'll be connecting to
double Setpoint, Input, Output,temp;

//Specify the links and initial tuning parameters
PID myPID(&Input, &Output, &Setpoint,40,100,0, DIRECT);


LedControl lc=LedControl(12,11,10,1);
unsigned long delaytime=10;
double zad = 0;
double zadcel=0;
double cel=0;
double ed=0;
double sot=0;
long timer;




void setup()
{


  lc.shutdown(0,false);
  lc.setIntensity(0,8);
  lc.clearDisplay(0);

  
  Serial.begin(9600);
  //initialize the variables we're linked to
  Input = analogRead(0);
  pinMode(8,OUTPUT);
  digitalWrite(8,LOW);




  

  //turn the PID on
  myPID.SetMode(AUTOMATIC);
}

void loop()
{
timer=millis();
if (timer>120000)
{digitalWrite(8,HIGH);}
  zad=analogRead(A1);
  

  
  zadcel=(zad-512)/32;
  Serial.println(zad);
  Serial.println(zadcel);
  Setpoint = zadcel;
  //Вывод знака (сравнение с нулем)
    if (zadcel<0)
      {lc.setChar(0,7,'-',false);}
    else
      {lc.setChar(0,7,' ',false);}
  //Вывод десятков (сравнение с десяткой (если больше, то выводим 1)
   if ( abs(zadcel)>=10)
      {lc.setDigit(0,6,1,false);}
    else
      {lc.setChar(0,6,' ',false);}
   //Вывод единиц (вычитаем 10, округляем)   
    if ( abs(zadcel)>=10)
      {ed=floor(abs(zadcel)-10);
        lc.setDigit(0,5,ed,true);}
    else
      {ed=floor(abs(zadcel));
        lc.setDigit(0,5,ed,true);}
   //Вывод десятой части
    sot=floor(10*(abs(zadcel)-floor(abs(zadcel))));
    lc.setDigit(0,4,sot,false);







  
  temp = analogRead(0);
  Input=36*(temp-275)/(630-275);
  myPID.Compute();
  Serial.println(Output);
  analogWrite(3,255-Output);
  Serial.println(Input);

  zadcel=Input;
  //Вывод знака (сравнение с нулем)
    if (zadcel<0)
      {lc.setChar(0,3,'-',false);}
    else
      {lc.setChar(0,3,' ',false);}
  //Вывод десятков (сравнение с десяткой (если больше, то выводим 1)
   if ( abs(zadcel)>=10)
      {lc.setDigit(0,2,1,false);}
    else
      {lc.setChar(0,2,' ',false);}
   //Вывод единиц (вычитаем 10, округляем)   
    if ( abs(zadcel)>=10)
      {ed=floor(abs(zadcel)-10);
        lc.setDigit(0,1,ed,true);}
    else
      {ed=floor(abs(zadcel));
        lc.setDigit(0,1,ed,true);}
   //Вывод десятой части
    sot=floor(10*(abs(zadcel)-floor(abs(zadcel))));
    lc.setDigit(0,0,sot,false);

    
     delay(200); 







  
  delay(500);
  //Serial.println(Output);
}
