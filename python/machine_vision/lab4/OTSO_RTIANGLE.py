import cv2 
import numpy as np

#Применение порогового фильтра к изображению (порог одинаковый
#для всех пикселей изображения, но вычисляется автоматически)
file_name='lab4_3'
road1 = cv2.imread(file_name+'.jpg', cv2.IMREAD_GRAYSCALE)
maxVal1 = 255  
threshold1 = 100 
threshold1, road1_1 = cv2.threshold(road1, threshold1 ,maxVal1 , cv2.THRESH_OTSU)
cv2.imwrite(file_name+f"_THRESH_OTSU_{threshold1}_{maxVal1}.jpg",road1_1)
threshold1, road1_1 = cv2.threshold(road1, threshold1 ,maxVal1 , cv2.THRESH_TRIANGLE)
cv2.imwrite(file_name+f"_THRESH_TRIANGLE_{threshold1}_{maxVal1}.jpg",road1_1)


