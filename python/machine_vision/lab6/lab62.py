import cv2
import numpy as np
import math

# читаем исходное изображение
img = cv2.imread('6_2.png')

img2 = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

img2 = cv2.bitwise_not(img2)

# находим линии на изображении
linesP = cv2.HoughLines(img2, 1, np.pi/5, 200, min_theta=0, max_theta=np.pi)
print(linesP)
def draw_line(rho, theta, img, color=(0, 0, 255),thickness=1, lineType=cv2.LINE_AA):
    cos_t = math.cos(theta)
    sin_t = math.sin(theta)
    x0 = cos_t * rho
    y0 = sin_t * rho
    pt1 = int(x0 - 1000 * sin_t), int(y0 + 1000 * cos_t)
    pt2 = int(x0 + 1000 * sin_t), int(y0 - 1000 * cos_t)
    cv2.line(img, pt1, pt2, color, thickness, lineType)

for line in linesP:
    rho,theta = line[0]
    # замазываем все линии белым, оставляя только цифры на изображении
    draw_line(rho, theta, img, color=(0, 0, 255),thickness=1, lineType=cv2.LINE_AA)

#cv2.imwrite('Result4.png',img)
cv2.imshow('Result3', img)

while 1:
    if cv2.waitKey(100)==27: #esc
        break