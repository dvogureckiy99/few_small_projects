import cv2
import numpy as np

#дополнительные
#флаг РФ
RFflag = np.empty((300, 200, 3))
for y in range(300):
    for x in range(200):
            if y<100:
                RFflag[y][x] = (255,255,255)
            elif y<200:
                RFflag[y][x] = (255,0,0) 
            else:
                RFflag[y][x] = (0,0,255) 
cv2.imshow('Rf flag' ,RFflag)
