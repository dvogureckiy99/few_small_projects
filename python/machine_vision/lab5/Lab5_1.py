import cv2
import numpy as np
# читаем исходное изображение с четкими границами
# поиск границ оператором Собеля
name_file="lab4_1"
img1 = cv2.imread(name_file+'.jpg', cv2.IMREAD_GRAYSCALE)
title_window = name_file + '_ended_image'
cv2.imshow("ishodn",img1)
cv2.namedWindow(title_window, cv2.WINDOW_AUTOSIZE )

#setting window
cv2.namedWindow("setting", cv2.WINDOW_AUTOSIZE )
height,width=400,150
method = 0
method_max = 2
method_name=["Sobel","Laplacian","Canny"]
def on_trackbar1(x):
    global method,ksize
    method = x
    cv2.destroyWindow("setting")
    cv2.destroyWindow(name_file+'_after_Gaus')
    cv2.destroyWindow(name_file+'_after_Canny')
    cv2.destroyWindow(name_file+'_after_Laplacian')
    cv2.destroyWindow(name_file+'_after_Sobel')
    if x==0:
        cv2.namedWindow(name_file+'_after_Sobel')
        cv2.namedWindow("setting", cv2.WINDOW_AUTOSIZE )
        trackbar_name = 'method'
        cv2.createTrackbar(trackbar_name, "setting", method , method_max , on_trackbar1 )
        trackbar_name = 'bordertype'
        cv2.createTrackbar(trackbar_name, "setting", bordertype , bordertype_max , on_trackbar2 )    
        trackbar_name = 'xorder'
        cv2.createTrackbar(trackbar_name, "setting", xorder , xorder_max , on_trackbar3 )
        trackbar_name = 'yorder'
        cv2.createTrackbar(trackbar_name, "setting", yorder , yorder_max , on_trackbar4 )
        trackbar_name = 'ksize'
        cv2.createTrackbar(trackbar_name, "setting", ksize , ksize_max , on_trackbar5 )
    elif x==1:
        ksize=0
        cv2.namedWindow(name_file+'_after_Laplacian')
        cv2.namedWindow("setting", cv2.WINDOW_AUTOSIZE )
        trackbar_name = 'method'
        cv2.createTrackbar(trackbar_name, "setting", method , method_max , on_trackbar1 )
        trackbar_name = 'bordertype'
        cv2.createTrackbar(trackbar_name, "setting", bordertype , bordertype_max , on_trackbar2 )    
        trackbar_name = 'ksize'
        cv2.createTrackbar(trackbar_name, "setting", ksize , ksize_max , on_trackbar5 )
    elif x==2:
        ksize=1
        cv2.namedWindow("setting", cv2.WINDOW_AUTOSIZE )
        cv2.namedWindow(name_file+'_after_Gaus', cv2.WINDOW_AUTOSIZE )
        cv2.namedWindow(name_file+'_after_Canny', cv2.WINDOW_AUTOSIZE )
        trackbar_name = 'method'
        cv2.createTrackbar(trackbar_name, "setting", method , method_max , on_trackbar1 )
        trackbar_name = 'bordertype'
        cv2.createTrackbar(trackbar_name, "setting", bordertype , bordertype_max , on_trackbar2 )    
        trackbar_name = 'ksize'
        cv2.createTrackbar(trackbar_name, "setting", ksize , ksize_max , on_trackbar5 )
        trackbar_name = 'L2gradient'
        cv2.createTrackbar(trackbar_name, "setting", L2gradient , L2gradient_max , on_trackbar6 )
        trackbar_name = 'threshold1'
        cv2.createTrackbar(trackbar_name, "setting", threshold1 , threshold1_max , on_trackbar7 )
        trackbar_name = 'threshold2'
        cv2.createTrackbar(trackbar_name, "setting", threshold2 , threshold2_max , on_trackbar8 )
    update_settting()
trackbar_name = 'method'
cv2.createTrackbar(trackbar_name, "setting", method , method_max , on_trackbar1 )
bordertype = 1
bordertype_max = 4
bordertype_name=["BORDER_CONSTANT","BORDER_REFLECT","BORDER_REFLECT101","BORDER_ISOLATED","BORDER_REPLICATE"]
bordertype_num=[cv2.BORDER_CONSTANT,cv2.BORDER_REFLECT,cv2.BORDER_REFLECT101,cv2.BORDER_ISOLATED,cv2.BORDER_REPLICATE]
def on_trackbar2(x):
    global bordertype
    bordertype = x
    update_settting()
trackbar_name = 'bordertype'
cv2.createTrackbar(trackbar_name, "setting", bordertype , bordertype_max , on_trackbar2 )
xorder = 0
xorder_max = 2
def on_trackbar3(x):
    global xorder
    #xorder и yorder  не могут равнятся 0 одновременно
    if x!=0:
        xorder = x
    else:
        if yorder!=0:
            xorder=x 
    update_settting()
trackbar_name = 'xorder'
cv2.createTrackbar(trackbar_name, "setting", xorder , xorder_max , on_trackbar3 )
yorder = 1
yorder_max = 2
def on_trackbar4(x):
    global yorder
    if x!=0:
        yorder = x
    else:
        if xorder!=0:
            yorder=x 
    update_settting()
trackbar_name = 'yorder'
cv2.createTrackbar(trackbar_name, "setting", yorder , yorder_max , on_trackbar4 )
ksize = 1
ksize_max = 3
ksize_name=["1","3","5","7"]
ksize_num=[1,3,5,7]
def on_trackbar5(x):
    global ksize
    if method==0:
        ksize = x
    elif method==1:
        if x!=2 and x!=3:
            ksize = x
    elif method==2:
        if x!=0:
            ksize = x
    update_settting()
trackbar_name = 'ksize'
cv2.createTrackbar(trackbar_name, "setting", ksize , ksize_max , on_trackbar5 )
L2gradient = 0
L2gradient_max = 1
L2gradient_name = ["true","false"]
def on_trackbar6(x):
    global L2gradient
    L2gradient=x 
    update_settting()
trackbar_name = 'L2gradient'
cv2.createTrackbar(trackbar_name, "setting", L2gradient , L2gradient_max , on_trackbar6 )
threshold1 = 0
threshold1_max = 1024
def on_trackbar7(x):
    global threshold1
    threshold1=x 
    update_settting()
trackbar_name = 'threshold1'
cv2.createTrackbar(trackbar_name, "setting", threshold1 , threshold1_max , on_trackbar7 )
threshold2 = 0
threshold2_max = 1024
def on_trackbar8(x):
    global threshold2
    threshold2=x 
    update_settting()
trackbar_name = 'threshold2'
cv2.createTrackbar(trackbar_name, "setting", threshold2 , threshold2_max , on_trackbar8 )

def update_settting():
    #global ksize,bordertype
    img = np.zeros((width,height))
    if method==0:
        cv2.putText(img,"method=" + method_name[method]  , (0,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"bordertype="+ bordertype_name[bordertype]  , (0,20*2), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"xorder="+ str(xorder), (0,20*4), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"yorder="+ str(yorder) , (133,20*4), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"ksize="+ ksize_name[ksize]  , (266,20*4), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
    elif method==1:
        cv2.putText(img,"method=" + method_name[method]  , (0,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"bordertype="+ bordertype_name[bordertype]  , (0,20*2), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"ksize="+ ksize_name[ksize]  , (0,20*3), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
    else:
        cv2.putText(img,"method=" + method_name[method]  , (0,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"bordertype="+ bordertype_name[bordertype]  , (0,20*2), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"ksize="+ ksize_name[ksize]  , (0,20*3), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"L2gradient="+ L2gradient_name[L2gradient]  , (0,20*4), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
    cv2.imshow("setting",img)

while 1:
    if method==0:
        end_img = sob1 = cv2.Sobel(img1, cv2.CV_16U , xorder, yorder , 0, ksize = ksize_num[ksize], scale = 1, delta = 0, borderType=bordertype_num[bordertype] )
        cv2.imshow(name_file+'_after_Sobel' ,cv2.convertScaleAbs(end_img) )
    elif method==1:
        end_img = cv2.Laplacian(img1, cv2.CV_16U , 0, ksize = ksize_num[ksize], scale = 1, delta = 0, borderType=bordertype_num[bordertype])
        cv2.imshow(name_file+'_after_Laplacian' ,cv2.convertScaleAbs(end_img) )
    elif method==2:
        end_img = cv2.GaussianBlur(img1, ksize = (3, 3), sigmaX = 0, sigmaY = 0, borderType=bordertype_num[bordertype])
        cv2.imshow(name_file+'_after_Gaus' ,end_img)
        end_img = cv2.Canny(end_img, threshold1 = threshold1, threshold2 = threshold2, apertureSize = ksize_num[ksize], L2gradient = L2gradient)
        cv2.imshow(name_file+'_after_Canny' ,end_img)
        #print(end_img)

    if cv2.waitKey(100)==27: #esc
        break