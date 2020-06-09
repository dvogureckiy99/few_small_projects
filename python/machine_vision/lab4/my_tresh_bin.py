import cv2 
import numpy as np

name_file= 'lab4_2'
imggrey = cv2.imread(name_file+'.jpg', cv2.IMREAD_GRAYSCALE)
title_window = name_file + 'after_my_tresh_bin'
threshold_max = 255
threshold = 0

def THRESH_BINARY_MY(in_img,threshold):
    shape = in_img.shape
    img = np.empty(shape,np.uint8)
    for y in range(shape[1]):
        for x in range(shape[0]):
            if in_img[x][y]>threshold:
                img[x][y]=255
            else:
                img[x][y]=0
    return img

cv2.namedWindow(title_window, cv2.WINDOW_AUTOSIZE )

def on_trackbar(threshold):
    img=THRESH_BINARY_MY(imggrey,threshold)
    cv2.imshow(title_window,img)

trackbar_name = 'threshold'
cv2.createTrackbar(trackbar_name, title_window, threshold , threshold_max, on_trackbar )
        
while 1:
    if cv2.waitKey(0)==27: #esc
        break