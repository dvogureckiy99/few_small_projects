import cv2
# ------------------------------- ГРАНИЦЫ -------------------------------------------
# читаем исходное изображение с четкими границами
img1 = cv2.imread('/home/andrew/foto/bird3.jpg', cv2.IMREAD_GRAYSCALE)
cv2.imshow('bird', img1)
# поиск границ оператором Собеля
sob1 = cv2.Sobel(img1, cv2.CV_8U , 1, 0, ksize = 3, scale = 1, delta = 0, borderType = cv2.BORDER_DEFAULT)
cv2.imshow('bird_sob', sob1)
# поиск границ оператором Лапласа
lap1 = cv2.Laplacian(img1, cv2.CV_8U, 3)
cv2.imshow('bird_lap', lap1)
# поиск границ детектором Кенни
# для этого предварительно размыв изображение с помощью фильтра Гаусса
gauss1 = cv2.GaussianBlur(img1, (3, 3), sigmaX = 0, sigmaY = 0, borderType = cv2.BORDER_DEFAULT)
can1 = cv2.Canny(gauss1, threshold1 = 150, threshold2 = 220, apertureSize = 3, L2gradient = True)
cv2.imshow('bird_can', can1)
cv2.waitKey(0)

# читаем исходное изображение с нечеткими границами
img2 = cv2.imread('/home/andrew/foto/build2.jpg', cv2.IMREAD_GRAYSCALE)
cv2.imshow('build', img2)
# поиск границ оператором Собеля
sob2 = cv2.Sobel(img2, cv2.CV_8U , 1, 0, ksize = 3, scale = 1, delta = 0, borderType = cv2.BORDER_DEFAULT)
cv2.imshow('build_sob', sob2)
# поиск границ оператором Лапласа
lap2 = cv2.Laplacian(img2, cv2.CV_8U, 3)
cv2.imshow('build_lap', lap2)
# поиск границ детектором Кенни
# для этого предварительно размыв изображение с помощью фильтра Гаусса
gauss2 = cv2.GaussianBlur(img2, (3, 3), sigmaX = 0, sigmaY = 0, borderType = cv2.BORDER_DEFAULT)
can2 = cv2.Canny(gauss2, threshold1 = 150, threshold2 = 220, apertureSize = 3, L2gradient = True)
cv2.imshow('build_can', can2)
cv2.waitKey(0)

# ------------------- ПОИСК КОНТУРОВ ------------------------------------
# поиск контуров с помощью функции threshold
img = cv2.imread('/home/andrew/foto/real.jpg', cv2.IMREAD_GRAYSCALE)
threshold, img_thr = cv2.threshold(img, 170, 255, cv2.THRESH_BINARY) 
cv2.imshow('Real_threshold', img_thr)
cv2.waitKey(0)

contours_thr, hierarchy_thr = cv2.findContours(img_thr, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
print('Contours threshold =', len(contours_thr))

# поиск контуров с помощью детектора границ Кенни
gauss = cv2.GaussianBlur(img, (3, 3), sigmaX = 0, sigmaY = 0, borderType = cv2.BORDER_DEFAULT)
img_can = cv2.Canny(gauss, threshold1 = 150, threshold2 = 250, apertureSize = 3, L2gradient = True)
cv2.imshow('Real_Canny', img_can)
cv2.waitKey(0)

contours_can, hierarchy_can = cv2.findContours(img_can, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
print('Contours Canny =', len(contours_can))

# -------------------------  ОКРУЖНОСТИ -------------------------------------
# читаем изображение с окружностью
rings = cv2.imread('/home/andrew/foto/rings.jpg')
rings_gray = cv2.cvtColor(rings, cv2.COLOR_BGR2GRAY)
# используем пороговый фильтр BINARY
threshold_rings, rings_thr = cv2.threshold(rings_gray, 170, 250, cv2.THRESH_BINARY) 
# находим контура 
contours, hierarchy = cv2.findContours(rings_thr, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
outside = contours[1]
inside = contours[2]
print('Contours Rings =', len(contours))

# рисуем внутреннюю(зеленая) и внешнюю(синяя) окружность 
cv2.drawContours(rings, contours, 1, (255, 0, 0), 2)
cv2.drawContours(rings, contours, 2, (0, 255, 0), 2)
cv2.imshow('rings2', rings)

# Выводим значение длины окружности и ее площадь
print('P inside = ', cv2.arcLength(inside, True))
print('S inside = ', cv2.contourArea(inside))
print('P out = ', cv2.arcLength(outside, True))
print('S out = ', cv2.contourArea(outside))

# ------------- ограничивающий прямоугольник ----------------
# Находим координаты вершины левого верхнего угла ограничивающего прямоугольника, его ширину и высоту
x1, y1, w1, h1 = cv2.boundingRect(inside)
x2, y2, w2, h2 = cv2.boundingRect(outside)
# Рисуем ограничивающий внешний и внутренний прямоугольник
cv2.rectangle(rings, (x1, y1), (x1+w1, y1+h1), (0, 0, 255), 2)
cv2.rectangle(rings, (x2, y2), (x2+w2, y2+h2), (0, 255, 255), 2)
cv2.imshow('rectangle', rings)
cv2.waitKey(0)
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
cv2.circle(rings, center1, radius1, (0, 0, 255), 2)
cv2.circle(rings, center2, radius2, (0, 255, 255), 2)

cv2.imshow('circle', rings)
cv2.waitKey(0)
# Вычисляем площадь ограничивающих окружностей
S_in_circle = 3.14*(radius1**2)
S_out_circle = 3.14*(radius2**2)
print('S inside circle = ', S_in_circle)
print('S outside circle = ', S_out_circle)