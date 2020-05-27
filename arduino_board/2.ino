//С помощью сообщения в arduino  задавать частоту мерцания светодиода
#include <TimerOne.h>


const int LED_1_PIN = 2;     
long inPeriod;
int n;

void  timerInterupt()
{
  digitalWrite(LED_1_PIN, digitalRead(LED_1_PIN) ^ 1); 
}

void setup()   
{    
 pinMode(LED_1_PIN, OUTPUT);   
 Serial.begin(9600);  
 Serial.println("please write period in msec"); 
 Timer1.initialize();         // инициализировать timer1
 Timer1.attachInterrupt(timerInterupt);  
    
}   
void loop()   
{    
   n = Serial.available();      
   if(n > 0)   
   {           
       // Далем что то с поступившими данными
   inPeriod =  Serial.parseInt();  // get the new byte
   if (inPeriod != 0) // так как если нет цифры , то будет 0 
   {
     Serial.print("Period: ");  Serial.print(inPeriod); Serial.println(" ms");
     Serial.print("Freq: ");  Serial.print(1000/inPeriod); Serial.println(" Hz");
   inPeriod =  inPeriod*1000 ;
   Timer1.setPeriod(inPeriod);
   }       
   delay(50);       
   } 
}

