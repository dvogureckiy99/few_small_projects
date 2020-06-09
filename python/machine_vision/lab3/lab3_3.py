IMPORT CV2
import numpy as np

#палитра
slider_max = 255
title_window = 'Linear Blend'
height,width=200,200
img = np.empty((width,height, 3),np.uint8)
blue = 0
green=0
red=0

cv2.namedWindow(title_window, cv2.WINDOW_AUTOSIZE )

def on_trackbar_blue(blue):
for y in range(height):
for x in range(width):
img[x][y][0] = blue
cv2.imshow(title_window, img)
trackbar_name = 'Blue'
cv2.createTrackbar(trackbar_name, title_window, blue , slider_max, on_trackbar_blue )

def on_trackbar_green(green):
for y in range(height):
for x in range(width):
img[x][y][1] = green
cv2.imshow(title_window, img)
trackbar_name = 'Green'
cv2.createTrackbar(trackbar_name, title_window, green , slider_max, on_trackbar_green )

def on_trackbar_red(red):
for y in range(height):
for x in range(width):
img[x][y][2] = red
cv2.imshow(title_window, img)
trackbar_name = 'Red'
cv2.createTrackbar(trackbar_name, title_window, red , slider_max, on_trackbar_red )

while 1:
if cv2.waitKey(0)==27: #esc
break
