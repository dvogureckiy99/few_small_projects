import cv2
name_file="lab5_circle"
img1 = cv2.imread(name_file+'.jpg', cv2.IMREAD_GRAYSCALE)
cv2.imshow("ishodn",img1)

#1-ая часть задания
end_img = cv2.Sobel(img1, cv2.CV_16U , 1, 1 , 0, ksize = 3, scale = 1, delta = 0, borderType=1 )
cv2.imshow(name_file+'_after_Sobel' ,cv2.convertScaleAbs(end_img) )
end_img = cv2.Laplacian(img1, cv2.CV_16U , 0, ksize = 3, scale = 1, delta = 0, borderType=1)
cv2.imshow(name_file+'_after_Laplacian' ,cv2.convertScaleAbs(end_img) )
end_img = cv2.GaussianBlur(img1, ksize = (3, 3), sigmaX = 0, sigmaY = 0, borderType=1)
cv2.imshow(name_file+'_after_Gaus' ,end_img)
end_img = cv2.Canny(end_img, threshold1 = 100, threshold2 = 255, apertureSize = 3, L2gradient = 1)
cv2.imshow(name_file+'_after_Canny' ,end_img)

#2-ая часть задания 
#после обработки детектором Канни
img,contours, hierarchy = cv2.findContours(cv2.convertScaleAbs(end_img), cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
#вывод количества контуров найденных
print("contours count="+str(len(contours)))
print("points count of counturs[0]:"+str(len(contours[0])))
#после обработки тресхолдом
end_img = cv2.threshold(img1, 127 ,255,cv2.THRESH_BINARY)
cv2.imshow(name_file+'_after_threshold' ,cv2.convertScaleAbs(end_img[1]) )
img,contours, hierarchy = cv2.findContours(cv2.convertScaleAbs(end_img[1]),cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
#вывод количества контуров найденных
print("contours count="+str(len(contours)))
print("points count of counturs[0]:"+str(len(contours[0])))

#3-я часть
threshold_rings, rings = cv2.threshold(img1, 170, 255, cv2.THRESH_BINARY) 
img,contours, hierarchy = cv2.findContours(rings, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
outside = contours[0]
inside = contours[1]
print('Contours Rings =', len(contours))
# рисуем внутреннюю(зеленая) и внешнюю(синяя) окружность 
imgc = cv2.imread(name_file+'.jpg')
rings = cv2.drawContours(imgc, contours, 0, (255, 0, 0), 2)
rings = cv2.drawContours(rings, contours, 1, (0, 255, 0), 2)
cv2.imshow('rings2', rings)
# Выводим значение длины окружности и ее площадь
print('P inside = ', cv2.arcLength(inside, True))
print('S inside = ', cv2.contourArea(inside))
print('P out = ', cv2.arcLength(outside, True))
print('S out = ', cv2.contourArea(outside))

x1, y1, w1, h1 = cv2.boundingRect(inside)
x2, y2, w2, h2 = cv2.boundingRect(outside)
# Рисуем ограничивающий внешний и внутренний прямоугольник
imgc = cv2.imread(name_file+'.jpg')
cv2.rectangle(imgc, (x1, y1), (x1+w1, y1+h1), (0, 0, 255), 2)
cv2.rectangle(imgc, (x2, y2), (x2+w2, y2+h2), (0, 255, 255), 2)
cv2.imshow('rectangle', imgc)
# Рассчитываем площадь ограничивающих прямоугольников
S_in_rectangle = w1*h1
S_out_rectangle = w2*h2
print('S inside rectangle = ', S_in_rectangle)
print('S outside rectangle = ', S_out_rectangle)

# ------------- ограничивающая окружность ----------------
# Находим координаты центра и радиус ограничивающих окружностей
(x1, y1), r1 = cv2.minEnclosingCircle(inside)
(x2, y2), r2 = cv2.minEnclosingCircle(outside)
# Преобразуем полученные значения в int
center1 = (int(x1), int(y1))
radius1 = int(r1)
center2 = (int(x2), int(y2))
radius2 = int(r2)
# Рисуем внешнюю(красный) и внутреннюю(желтый) ограничивающие окружности
rings = cv2.imread(name_file+'.jpg')
cv2.circle(rings, center1, radius1, (0, 0, 255), 2)
cv2.circle(rings, center2, radius2, (0, 255, 255), 2)
cv2.imshow('circle', rings)
cv2.waitKey(0)
# Вычисляем площадь ограничивающих окружностей
S_in_circle = 3.14*(radius1**2)
S_out_circle = 3.14*(radius2**2)
print('S inside circle = ', S_in_circle)
print('S outside circle = ', S_out_circle)

while 1:
    if cv2.waitKey(100)==27: #esc
        break