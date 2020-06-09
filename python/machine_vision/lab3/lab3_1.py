import cv2
import numpy as np	

cv2.imshow('GRAYSCALE' , imggrey)import cv2
import numpy as np
img = cv2.imread('lab3.png', cv2.IMREAD_COLOR)
imggrey = cv2.imread('lab3.png', cv2.IMREAD_GRAYSCALE)

#1
cv2.imshow('RGB' ,img)
cv2.imshow('GRAYSCALE' , imggrey)
cv2.imwrite('testg.jpg',imggrey)

#Для каждого пикселя инвертируйте его значение 
height, width, _ = imggrey.shape
for y in range(height):
    for x in range(width):
        imggrey[x][y] =  255 - imggrey[x][y]
cv2.imwrite('testinv.jpg',imggrey)

#Поменяйте местами значения красного и зеленого каналов.
for y in range(height):
    for x in range(width):
        imggrey[x][y][1],imggrey[x][y][2] =  imggrey[x][y][2],imggrey[x][y][1]
cv2.imwrite('test3.jpg',imggrey)

cv2.waitKey(0)
