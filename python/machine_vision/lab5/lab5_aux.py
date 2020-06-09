import cv2
import numpy as np
# читаем исходное изображение с четкими границами
# поиск границ оператором Собеля
name_file="5_1"
img1 = cv2.imread(name_file+'.jpg', cv2.IMREAD_GRAYSCALE)
shape = img1.shape
title_window = name_file + '_ended_image'
cv2.imshow("ishodn",img1)

threshold_rings, img1 = cv2.threshold(img1, 177, 255, cv2.THRESH_BINARY) 
img,contours, hierarchy = cv2.findContours(img1, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
img = np.empty((shape[0], shape[1], 3 ),np.uint8)

EMPTY = -1 
def draw_contour(node,color):
    if color:
        cv2.drawContours(img, contours, node, (0, 0, 255), 1)
    else:
        cv2.drawContours(img, contours, node, (255, 0, 0), 1) 

#color индикатор цвета 0-синий 1-красный 
#node индекс следующего контура
def get_node(node,color):
    dc,uc = hierarchy[0][node][2],hierarchy[0][node][3]
    if uc!=EMPTY: #проверяем, что узел не является корнем, 
    #так как корень окрашивать не нужно, это рамка рисунка
        draw_contour(node,color) #чтобы окрасить внутренний поменять node на dc
        #нужно перейти к следующиему контуру, как будто мы его окрасили
        #следующий контур будет сыном к текущему всегда
        dc=hierarchy[0][dc][2]      
    if dc != EMPTY:
        #у узла есть дети 
        child_node = dc
        rc = hierarchy[0][child_node][0]
        while 1: #пока не пройдемся по всем сыновьям узла node
            get_node(child_node,not color)#вызываем, но окрашиваем в противоположный цвет
            if rc!=EMPTY: # есть ли следующий сын?
                #переход к следующему сыну узла первоначального node
                child_node = rc
                rc = hierarchy[0][child_node][0]
            else:
                break 
#окраска по нашим правилам 
#начинаем с первого контура,но так как первый это рамка рисунка
#то окрашивать его не надо
#но ставим, как будто мы окрашиваем его в синий
get_node(0,0)
cv2.imshow('all_countours',img)
while 1:
    if cv2.waitKey(100)==27: #esc
        break