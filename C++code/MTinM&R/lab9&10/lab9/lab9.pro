OPENCV_DIR=C:\opencv-build\install

INCLUDEPATH += $${OPENCV_DIR}\include
LIBS += -L$${OPENCV_DIR}\x64\mingw\lib \
        -lopencv_core347        \
        -lopencv_highgui347     \
        -lopencv_imgcodecs347   \
        -lopencv_imgproc347     \
        -lopencv_features2d347  \
        -lopencv_calib3d347

SOURCES += \
    lab9.cpp


