import cv2 
import numpy as np
import matplotlib.pyplot as plt

name_file="LR_4_3"
lr41 = cv2.imread(name_file+'.png', cv2.IMREAD_REDUCED_GRAYSCALE_2)
#преобразование стандартным методом
lr41_new=cv2.equalizeHist(lr41)
# найти частоту пикселей в диапазоне 0-255
histr = cv2.calcHist([lr41_new],[0],None,[256],[0,256])
# показать графическое изображение изображения
plt.plot(histr) 
cv2.imshow(name_file+"_after_default_method",lr41_new)

# найти частоту пикселей в диапазоне 0-255
histr = cv2.calcHist([lr41],[0],None,[256],[0,256])
# показать графическое изображение изображения
plt.plot(histr) 
cv2.imshow(name_file+"_before",lr41)

max_ind = lr41.max().max()
min_ind = lr41.min().min()
for i in range(len(lr41)):
    for j in range(len(lr41[1])):
        lr41[i,j] = lr41[i,j] - min_ind
        lr41[i,j] = lr41[i,j] / (max_ind - min_ind) * 255
# найти частоту пикселей в диапазоне 0-255
histr = cv2.calcHist([lr41],[0],None,[256],[0,256])
# показать графическое изображение изображения
plt.plot(histr) 
cv2.imshow(name_file+"_after_my_method",lr41)
plt.show()

while 1:
    if cv2.waitKey(100)==27: #esc
        break