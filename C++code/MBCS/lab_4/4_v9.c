/*
Developers: Murashko A.,Ogureckiy D.V.
Variant 9 
- синий . фиолетовый
Частота 900 гц, отсюда период 1110 мксек
-----------------------------------
пример исполняемый код (ni e)
-/.,./. ., (каждый символ представляет собой задержку)
пример  выполнения кода с задержками 
TIME_DASH DELAY_BETWEEN_CHARACTERS TIME_DOT DELAY_BETWEEN_LETTERS TIME_DOT DELAY_BETWEEN_CHARACTERS TIME_DOT DELAY_BETWEEN_WORDS TIME_DOT 
*/

#include <mega128a.h>  
#include <delay.h>
#include <string.h>
#include <stdio.h>  
#include <ctype.h>


#define OUTPUT_STRING "MY NAME IS DIMA" //Выводимая строка 
#define HALF_PERIOD 555 // Т/2 в мксек
#define TIME_DOT 500 // длительность точки в мс  (·)
#define TIME_DASH 1500 //длительность тире в мс  (-)
#define DELAY_BETWEEN_CHARACTERS 500 // интервал между выводом символов кода морзе в мс (/)слэш
#define DELAY_BETWEEN_LETTERS 1000// задержка между выводом букв в слове в мс (  )      (,)
#define DELAY_BETWEEN_WORDS 2000 //задержка между выводом слов в строке в мс            ( )пробел
#define MAX_SIZE_CODE 100 // максимальный размер кодировкой азбукой морза в байтах  
#define PAUSE 5000 //пауза между повторением  азбуки морза 5 сек



void main(void)
{    
    int i;
    char j;
    int time_dot = (TIME_DOT*1000)/(HALF_PERIOD*2) ; //количество итераций цикла , соответсвующее необходимому  времени 
    int time_dash = (TIME_DASH*1000)/(HALF_PERIOD*2)  ; //количество итераций цикла , соответсвующее необходимому  времени 
    //в переменной массива последний символ "\0" !!!
    char output_string[] = OUTPUT_STRING ; //входная строка
    char coded_string[MAX_SIZE_CODE] = "" ; // кодировка азбукой морза 
    char mrz[]=""; //хранит кодировку символа морза 
    //----------перевод строки в кодировку азбукой Морза----------
    for (i = 0; i < strlen(output_string); i++) 
    {
        output_string[i] = tolower(output_string[i]);
        switch (output_string[i])
		{
		case 'a': sprintf(mrz, "./-"); break;
		case 'b': sprintf(mrz, "-/././."); break;
		case 'w': sprintf(mrz, "./-/-"); break;
		case 'g': sprintf(mrz, "-/-/."); break;
		case 'd': sprintf(mrz, "-/./."); break;
		case 'e': sprintf(mrz, "."); break;
		case 'v': sprintf(mrz, "./././-"); break;
		case 'z': sprintf(mrz, "-/-/./."); break;
		case 'i': sprintf(mrz, "./."); break;
		case 'j': sprintf(mrz, "./-/-/-"); break;
		case 'k': sprintf(mrz, "-/./-"); break;
		case 'l': sprintf(mrz, "./-/./."); break;
		case 'm': sprintf(mrz, "-/-"); break;
		case 'n': sprintf(mrz, "-/."); break;
		case 'o': sprintf(mrz, "-/-/-"); break;
		case 'p': sprintf(mrz, "./-/-/."); break;
		case 'r': sprintf(mrz, "./-/."); break;
		case 's': sprintf(mrz, "././."); break;
		case 't': sprintf(mrz, "-"); break;
		case 'u': sprintf(mrz, "././-"); break;
		case 'f': sprintf(mrz, "././-/."); break;
		case 'h': sprintf(mrz, "./././."); break;
		case 'c': sprintf(mrz, "-/./-/."); break;
		case 'q': sprintf(mrz, "-/-/./-"); break;
		case 'y': sprintf(mrz, "-/./-/-"); break;
		case 'x': sprintf(mrz, "-/././-"); break;
		case '1': sprintf(mrz, "./-/-/-/-"); break;
		case '2': sprintf(mrz, "././-/-/-"); break;
		case '3': sprintf(mrz, "./././-/-"); break;
		case '4': sprintf(mrz, "././././-"); break;
		case '5': sprintf(mrz, "././././."); break;
		case '6': sprintf(mrz, "-/./././."); break;
		case '7': sprintf(mrz, "-/-/././."); break;
		case '8': sprintf(mrz, "-/-/-/./."); break;
		case '9': sprintf(mrz, "-/-/-/-/."); break;
		case '0': sprintf(mrz, "-/-/-/-/-"); break;
		case '.': sprintf(mrz, "./././././."); break;
		case ',': sprintf(mrz, "./-/./-/./-"); break;
		case ':': sprintf(mrz, "-/-/-/././."); break;
		case ';': sprintf(mrz, "-/./-/./-/."); break;
		case '(': sprintf(mrz, "-/./-/-/./-"); break;
		case ')': sprintf(mrz, "-/./-/-/./-"); break;
		case '"': sprintf(mrz, "./-/././-/."); break;
		case '-': sprintf(mrz, "-/././././-"); break;
		case '/': sprintf(mrz, "-/././-/."); break;
		case '?': sprintf(mrz, "././-/-/./."); break;
		case '!': sprintf(mrz, "-/-/././-/-"); break;
		case ' ': sprintf(mrz, " "); break; //пробел между словами
		case '@': sprintf(mrz, "./-/-/./-/."); break;
		default: sprintf(mrz, ""); break;

		}
		strcat(coded_string, mrz); //добавляем к конечной строке код символа в азбуке морза
		if ((output_string[i] != ' ' )&&(output_string[i+1] != ' '))//условие для устранения лишних задержек при пробеле
		{
			strcat(coded_string, ",");// указывает на задержка между выводом букв в слове
		}
    }
    //-----------------------------------------------------
    
    //обработка кодировки морзой
    DDRB |= 1<<4;
    DDRE |= (1<<3)|(1<<4)|(1<<5);       
    while (1)
    {    
         delay_ms(PAUSE);//пауза между повторением  азбуки морза 5 сек
         for( i = 0; i < strlen(coded_string) ; i++)   //перебираем кодировку строки, последний символ отбрасываем, так как он является запятой, после  которой не следует символов
         {     
            switch(coded_string[i])
            {
                case '.': //при появлении точки
                {   
                    PORTE |= (1<<3)|(1<<5); //зажигаем светодиод фиолетовым цветом
                    //формирование звукового сигнала определенное время
                     for(j=0; j <= time_dot;j++)//звуковой сигнал длится нужное время
                     { 
                         PORTB |= 1<<4;  //передний фронт сигнала      
                         delay_us(HALF_PERIOD);  //время импульса          
                         PORTB &= ~(1<<4) ;  //задний фронт сигнала
                         delay_us(HALF_PERIOD);     //время паузы между импульсами  
                     }
                    PORTE &= ~((1<<3)|(1<<5)) ; //тушим светодиод
                    break;
                }
                case '-':
                {
                     PORTE |= (1<<3); //зажигаем светодиод синим цветом
                    //формирование звукового сигнала определенное время
                     for(j=0; j <= time_dash ;j++)//звуковой сигнал длится нужное время
                     { 
                         PORTB |= 1<<4;  //передний фронт сигнала      
                         delay_us(HALF_PERIOD);  //время импульса          
                         PORTB &= ~(1<<4) ;  //задний фронт сигнала
                         delay_us(HALF_PERIOD);     //время паузы между импульсами  
                     }
                    PORTE &= ~(1<<3) ; //тушим светодиод
                    //delay_ms(DELAY_BETWEEN_LETTERS);//  интервал между выводом символов кода морзе в мс 
                    break;  
                }
                case '/': //при появлении интервал между выводом символов кода морзе 
                {   
                    delay_ms(DELAY_BETWEEN_CHARACTERS);
                    break;
                }
                case ',': //задержка между выводом букв в слове в мс 
                {   
                    delay_ms(DELAY_BETWEEN_LETTERS);
                    break;
                }
                case ' ': //задержка между выводом слов в строке 
                {   
                    delay_ms(DELAY_BETWEEN_WORDS);
                    break;
                }
            }        
         }
    }
}
