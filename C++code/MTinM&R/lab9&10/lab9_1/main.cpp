// Подключение заголовочного файла графического интерфейса
#include "opencv2/highgui.hpp"

int main()
{
    // Создание объекта для хранения изображения
    cv::Mat frame;
    // Создание объекта для управления камерой
    // и открытие камеры по умолчанию
    cv::VideoCapture camera(0);

    uint x=500, y=300;

   //  "бесконечный" цикл получения изображения с камеры
    for(;;)
    {
        // Получение изображения с камеры
        camera >> frame;

       // обработка изображения
        for(y=0; y<frame.rows ; y++)
        {
            for(x=0; x<frame.cols ; x++ )
            {
                //синий субпиксель
                  uchar blue = *(frame.data + x * frame.elemSize() + y * frame.step);
                *(frame.data + x * frame.elemSize() + y * frame.step) = 255-blue;
                // Зелёный субпиксель
                  uchar green = *(frame.data + x * frame.elemSize() + y * frame.step+1);
                *(frame.data + x * frame.elemSize() + y * frame.step + 1) = 255-green;
                // Красный субпиксель
                  uchar red = *(frame.data + x * frame.elemSize() + y * frame.step+2);
                *(frame.data + x * frame.elemSize() + y * frame.step + 2) = 255-red;
           }
        }

        // Вывод изображения на экран
        cv::imshow("Frame", frame);
        // Выход из цикла если нажата клавиша
        // наклавиатуре
        if(cv::waitKey(1) >= 0) break;
    }

    return 0;
}
