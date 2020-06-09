import cv2
import numpy as np
import math as m
name_file="5_2"
img1 = cv2.imread(name_file+'.png', cv2.IMREAD_GRAYSCALE)
shape = img1.shape
threshold_rings, img1 = cv2.threshold(img1, 122, 255, cv2.THRESH_BINARY) 
img,contours, hierarchy = cv2.findContours(img1, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
img = np.empty((shape[0], shape[1], 3 ),np.uint8)
for con_ind in range(1,len(contours),2):
    [a,r] = cv2.minEnclosingCircle(contours[con_ind])
    S=m.pi*r*r
    [vv,ww,v,w]=cv2.boundingRect(contours[con_ind])
    P_kv = v*4
    MIST=800
    if cv2.contourArea(contours[con_ind],True)-S<MIST and cv2.contourArea(contours[con_ind],True)-S>-MIST:
        #рисуем окружность
        cv2.drawContours(img,contours,contourIdx=con_ind,color=(0,0,255),thickness=3,lineType=cv2.LINE_4)
    elif cv2.arcLength(contours[con_ind],True) - P_kv <50 and cv2.arcLength(contours[con_ind],True) - P_kv > -50:
        #рисуем квадрат
        cv2.drawContours(img, contours ,contourIdx=con_ind, color=(0 , 255, 0), thickness=3, lineType=cv2.LINE_4)
    else:
        #рисуем треугольник
        cv2.drawContours(img, contours ,contourIdx=con_ind, color=(255 , 0, 0), thickness=3, lineType=cv2.LINE_4)
cv2.imwrite("img.jpg",img)
