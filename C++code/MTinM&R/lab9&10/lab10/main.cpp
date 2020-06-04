#include <opencv2/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

using namespace std;

int main()
{
    // Создание объекта для хранения изображения
    cv::Mat frame1 = cv::imread("C:\\program\\Qt\\projects\\lab10\\balls.bmp");
    cv::Mat frame ;
    // Создание окна
    cv::namedWindow("Frame" ,  CV_WINDOW_AUTOSIZE );
    // Переменные, изменяемая ползунком
    int var1=100,var2=100,var3=100,var4=200,var5=200,var6=200;
    // Создание ползунков
    cv::createTrackbar(" Hue lower threshold", // Имя ползунка
    "Frame", // Имя окна
    &var1, // Адрес переменной
    255 // Максимальное значение
    );
    cv::createTrackbar("Saturation lower threshold", // Имя ползунка
    "Frame", // Имя окна
    &var2, // Адрес переменной
    255 // Максимальное значение
    );
    cv::createTrackbar("Brightness lower threshold", // Имя ползунка
    "Frame", // Имя окна
    &var3, // Адрес переменной
    255 // Максимальное значение
    );
    cv::createTrackbar(" Hue upper threshold", // Имя ползунка
    "Frame", // Имя окна
    &var4, // Адрес переменной
    255 // Максимальное значение
    );
    cv::createTrackbar("Saturation upper threshold", // Имя ползунка
    "Frame", // Имя окна
    &var5, // Адрес переменной
    255 // Максимальное значение
    );
    cv::createTrackbar("Brightness upper threshold", // Имя ползунка
    "Frame", // Имя окна
    &var6, // Адрес переменной
    255 // Максимальное значение
    );

    //  "бесконечный" цикл изменения изображения
     for(;;)
     {
        cv::cvtColor(frame1, // Исходное изображение
        frame, // Получаемое изображение
        CV_BGR2HSV // Тип преобразования
        );

        cv::inRange(frame, // исходное изображение
        cv::Scalar(var1, var2, var3), // нижняя граница цвета
        cv::Scalar(var4, var5, var6), // верхняя граница цвета
        frame // получаемое изображение
        );

        // Вывод изображения на экран
        cv::imshow("Frame", frame);
        // Выход из цикла если нажата клавиша
        // наклавиатуре
        if(cv::waitKey(1) >= 0) break;
     }

    return 0;
}
