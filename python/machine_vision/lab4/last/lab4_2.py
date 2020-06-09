import cv2 
import numpy as np

#Применение порогового фильтра к изображению (порог задаетсявручную):
road1 = cv2.imread('lab4_1.jpg', cv2.IMREAD_GRAYSCALE)
maxVal1 = 255  
threshold1 = 170
new_threshold, road1_1 = cv2.threshold(road1, threshold1 ,maxVal1 , cv2.THRESH_BINARY)
cv2.imwrite(f"lab4_1_THRESH_BINARY_{threshold1}_{maxVal1}.jpg",road1_1)
new_threshold, road1_1 = cv2.threshold(road1, threshold1 ,maxVal1 , cv2.THRESH_BINARY_INV)
cv2.imwrite(f"lab4_1_THRESH_BINARY_INV_{threshold1}_{maxVal1}.jpg",road1_1)
new_threshold, road1_1 = cv2.threshold(road1, threshold1 ,maxVal1 , cv2.THRESH_TRUNC)
cv2.imwrite(f"lab4_1_THRESH_TRUNC_{threshold1}_{maxVal1}.jpg",road1_1)
new_threshold, road1_1 = cv2.threshold(road1, threshold1 ,maxVal1 , cv2.THRESH_TOZERO)
cv2.imwrite(f"lab4_1_THRESH_TOZERO_{threshold1}_{maxVal1}.jpg",road1_1)
new_threshold, road1_1 = cv2.threshold(road1, threshold1 ,maxVal1 , cv2.THRESH_TOZERO_INV)
cv2.imwrite(f"lab4_1_THRESH_TOZERO_INV_{threshold1}_{maxVal1}.jpg",road1_1)
