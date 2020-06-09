import cv2 
import numpy as np

#адаптивного вычисления порога
name_file= 'lab4_3'
road1 = cv2.imread(name_file+'.jpg', cv2.IMREAD_GRAYSCALE)
maxVal1 = 255  
blocksize = int(21/2)*2+1
blocksize_max=50
C = 1
C_max=50
param=[blocksize,C]
title_window = name_file + 'ADAPTIVE_THRESH_GAUSSIAN_C'

cv2.namedWindow(title_window, cv2.WINDOW_AUTOSIZE )

def on_trackbar_C(C):
    global param
    param[1]=C
trackbar_name = 'C'
cv2.createTrackbar(trackbar_name, title_window, C, C_max, on_trackbar_C )  

def on_trackbar_blocksize(blocksize):
    global param
    if blocksize!=1 and blocksize!=0:
        blocksize = int(blocksize/2)*2+1
    else:
        blocksize=3
    param[0]=blocksize
trackbar_name = 'blocksize'
cv2.createTrackbar(trackbar_name, title_window, blocksize, blocksize_max, on_trackbar_blocksize ) 

while 1:
    img=cv2.adaptiveThreshold(road1, maxVal1 , cv2.ADAPTIVE_THRESH_GAUSSIAN_C  ,cv2.THRESH_BINARY , param[0] , param[1])
    cv2.putText(img,f"maxVal={maxVal1}_blocksize={param[0]}_C={param[1]}"  , (20,30), cv2.FONT_HERSHEY_SIMPLEX, 1, 125 , 2)
    cv2.imshow(title_window,img)
    if cv2.waitKey(100)==27: #esc
        break
