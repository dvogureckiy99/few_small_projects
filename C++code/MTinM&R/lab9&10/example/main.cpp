#include <opencv2/highgui.hpp>

using namespace std;

int main()
{
    cv::Mat sample_image = cv::imread("C:\\program\\opencv-3.4.7\\samples\\data\\lena.jpg");

    cv::imshow("sample_window", sample_image);
    cv::waitKey(0);

    return 0;
}
