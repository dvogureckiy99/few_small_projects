import cv2 
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Button

name_file= 'lab4_3'
imggrey = cv2.imread(name_file+'.jpg', cv2.IMREAD_GRAYSCALE)
threshold_max = 255
threshold = 0
param = 10
maxVal1 = 255  
title_window = name_file + 'after_tresh_bin'


cv2.namedWindow(title_window, cv2.WINDOW_AUTOSIZE )
cv2.namedWindow("setting", cv2.WINDOW_AUTOSIZE )

def on_trackbar(threshold):
    global param
    param = threshold
trackbar_name = 'threshold'
cv2.createTrackbar(trackbar_name, "setting", threshold , threshold_max, on_trackbar )

height,width=250,50
method = 0
method_max = 4
method_name=["THRESH_BINARY","THRESH_BINARY_INV","THRESH_TRUNC","THRESH_TOZERO","THRESH_TOZERO_INV"]
method_num=[cv2.THRESH_BINARY,cv2.THRESH_BINARY_INV,cv2.THRESH_TRUNC,cv2.THRESH_TOZERO,cv2.THRESH_TOZERO_INV]
def on_trackbar1(x):
    global method
    method = x
    img = np.zeros((width,height))
    cv2.putText(img,"method="+ method_name[method]  , (0,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
    cv2.imshow("setting",img)
trackbar_name = 'method'
cv2.createTrackbar(trackbar_name, "setting", method , method_max , on_trackbar1 )

while 1:
    img=cv2.threshold(imggrey, param ,maxVal1 ,method_num[method] )
    
    cv2.imshow(title_window,img[1])
    if cv2.waitKey(100)==27: #esc
        break