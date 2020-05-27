 char* numbers[10] = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };
 int in; 
 #define NUMBRE_LENGTH 10
 char buffer[NUMBRE_LENGTH];
void setup()   
{     
 Serial.begin(9600);  
 Serial.println("please write something");    
}   
void loop()   
{         
   if(Serial.available() > 0)   
   {           
      in = Serial.readBytes(buffer, NUMBRE_LENGTH );  // get the new number
      
       for (int j = 0; j < in; j++)
      {
        Serial.print(buffer[j]);
      }
       Serial.println();
      for (int j = 0; j < in; j++)
      {
        if((buffer[j]<='9') && (buffer[j]>='0')) 
        {
          for (int i = 0; i < 10;i++)
          {    
              if (i == (buffer[j]& 15) )
              {            
                Serial.print(numbers[i]); 
                Serial.print(" "); 
              }
          }
        }
      }
      Serial.println();
   }
   delay(50);       
} 