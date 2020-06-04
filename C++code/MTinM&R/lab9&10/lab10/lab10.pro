TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        main.cpp

OPENCV_DIR=C:\program\opencv-build\install

INCLUDEPATH += $${OPENCV_DIR}\include
LIBS += -L$${OPENCV_DIR}\x64\mingw\lib \
        -lopencv_core347        \
        -lopencv_highgui347     \
        -lopencv_imgcodecs347   \
        -lopencv_imgproc347     \
        -lopencv_features2d347  \
        -lopencv_videoio347  \
        -lopencv_calib3d347
