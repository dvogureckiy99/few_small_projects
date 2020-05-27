// обмен данными по uart : отправка сообщения цифры от 1 до 5 , анализ этого сообщения и возврат ответа в пк
void setup()   
{    
 
 Serial.begin(9600);  
 Serial.println("please write something");    
}   
void loop()   
{     
   if(Serial.available() > 0)   
   {           
         // Далем что то с поступившими данными 
     char inChar = Serial.read();  // get the new byte
     switch (inChar) 
     {
        case '1':
         Serial.println("one"); 
        break;
        case '2':
        Serial.println("two"); 
        break;
         case '3':
        Serial.println("three"); 
        break;
         case '4':
        Serial.println("four"); 
        break;
         case '5':
        Serial.println("five"); 
        break;
        default:
        Serial.println("You write somthing else"); 
     }     
   }  
   delay(50);       
} 
