import cv2
import numpy as np
# читаем исходное изображение с четкими границами
# поиск границ оператором Собеля
name_file="5_1"
img1 = cv2.imread(name_file+'.jpg', cv2.IMREAD_GRAYSCALE)
title_window = name_file + '_ended_image'
cv2.imshow("ishodn",img1)
cv2.namedWindow(title_window, cv2.WINDOW_AUTOSIZE )

#setting window
cv2.namedWindow("setting", cv2.WINDOW_AUTOSIZE )
height,width=500,150
method = 0
method_max = 1
method_name=["threshold","Gauss>>canny"]
def on_trackbar1(x):
    global method,ksize
    method = x
    cv2.destroyWindow("setting")
    cv2.destroyWindow(name_file+'_after_Gaus')
    cv2.destroyWindow(name_file+'_after_Canny')
    cv2.destroyWindow(name_file+'_after_threshold')
    cv2.namedWindow("setting", cv2.WINDOW_AUTOSIZE )
    trackbar_name = 'method'
    cv2.createTrackbar(trackbar_name, "setting", method , method_max , on_trackbar1 )
    trackbar_name = 'findcountursmethod'
    cv2.createTrackbar(trackbar_name, "setting", findcountursmethod , findcountursmethod_max , on_trackbar11 )
    trackbar_name = 'findcounturs_mode'
    cv2.createTrackbar(trackbar_name, "setting", findcounturs_mode , findcounturs_mode_max , on_trackbar12 )
    if x==0:
        cv2.namedWindow(name_file+'_after_threshold')
        trackbar_name = 'threshold'
        cv2.createTrackbar(trackbar_name, "setting", threshold , threshold_max, on_trackbar9 )
        trackbar_name = 'method_type'
        cv2.createTrackbar(trackbar_name, "setting", method_type , method_type_max , on_trackbar10 )
    elif x==1:
        ksize=1
        cv2.namedWindow(name_file+'_after_Gaus', cv2.WINDOW_AUTOSIZE )
        cv2.namedWindow(name_file+'_after_Canny', cv2.WINDOW_AUTOSIZE )
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
ksize = 1
ksize_max = 3
ksize_name=["1","3","5","7"]
ksize_num=[1,3,5,7]
def on_trackbar5(x):
    global ksize
    if method==0:
        ksize = x
    elif method==1:
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
threshold = 0
threshold_max = 255
maxVal1 = 255 
def on_trackbar9(x):
    global threshold
    threshold= x
    update_settting()
trackbar_name = 'threshold'
cv2.createTrackbar(trackbar_name, "setting", threshold , threshold_max, on_trackbar9 )
method_type = 0
method_type_max = 4
method_type_name=["THRESH_BINARY","THRESH_BINARY_INV","THRESH_TRUNC","THRESH_TOZERO","THRESH_TOZERO_INV"]
method_type_num=[cv2.THRESH_BINARY,cv2.THRESH_BINARY_INV,cv2.THRESH_TRUNC,cv2.THRESH_TOZERO,cv2.THRESH_TOZERO_INV]
def on_trackbar10(x):
    global method_type
    method_type = x
    update_settting()
trackbar_name = 'method_type'
cv2.createTrackbar(trackbar_name, "setting", method_type , method_type_max , on_trackbar10 )
findcountursmethod = 0
findcountursmethod_max = 3
findcountursmethod_name=["CHAIN_APPROX_NONE","CHAIN_APPROX_SIMPLE","CHAIN_APPROX_TC89_L1","CHAIN_APPROX_TC89_KCOS"]
findcountursmethod_num=[cv2.CHAIN_APPROX_NONE,cv2.CHAIN_APPROX_SIMPLE,cv2.CHAIN_APPROX_TC89_L1,cv2.CHAIN_APPROX_TC89_KCOS]
def on_trackbar11(x):
    global findcountursmethod
    findcountursmethod = x
    update_settting()
trackbar_name = 'findcountursmethod'
cv2.createTrackbar(trackbar_name, "setting", findcountursmethod , findcountursmethod_max , on_trackbar11 )
findcounturs_mode = 0
findcounturs_mode_max = 3
findcounturs_mode_name=["RETR_EXTERNAL","RETR_LIST","RETR_CCOMP","RETR_TREE"]
findcounturs_mode_num=[cv2.RETR_EXTERNAL,cv2.RETR_LIST,cv2.RETR_CCOMP,cv2.RETR_TREE]
def on_trackbar12(x):
    global findcounturs_mode
    findcounturs_mode = x
    update_settting()
trackbar_name = 'findcounturs_mode'
cv2.createTrackbar(trackbar_name, "setting", findcounturs_mode , findcounturs_mode_max , on_trackbar12 )


def update_settting():
    #global ksize,bordertype
    img = np.zeros((width,height))
    if method==0:
        cv2.putText(img,"method=" + method_name[method]  , (0,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"method_type="+method_type_name[method_type], (0,20*2), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"method_type in findContours="+findcountursmethod_name[findcountursmethod], (0,20*3), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"mode in findContours="+findcounturs_mode_name[findcounturs_mode], (0,20*4), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
    elif method==1:
        cv2.putText(img,"method=" + method_name[method]  , (0,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"bordertype="+ bordertype_name[bordertype]  , (0,20*2), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"ksize="+ ksize_name[ksize]  , (0,20*3), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"L2gradient="+ L2gradient_name[L2gradient]  , (0,20*4), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"method_type in findContours="+findcountursmethod_name[findcountursmethod], (0,20*5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
        cv2.putText(img,"mode in findContours="+findcounturs_mode_name[findcounturs_mode], (0,20*6), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255 , 1)
    cv2.imshow("setting",img)

while 1:
    if method==0:
        thr,end_img = cv2.threshold(img1, threshold ,maxVal1 ,method_type_num[method_type] )
        cv2.imshow(name_file+'_after_threshold' ,cv2.convertScaleAbs(end_img) )
    elif method==1:
        end_img = cv2.GaussianBlur(img1, ksize = (3, 3), sigmaX = 0, sigmaY = 0, borderType=bordertype_num[bordertype])
        cv2.imshow(name_file+'_after_Gaus' ,end_img)
        end_img = cv2.Canny(end_img, threshold1 = threshold1, threshold2 = threshold2, apertureSize = ksize_num[ksize], L2gradient = L2gradient)
        cv2.imshow(name_file+'_after_Canny' ,end_img)
        print(end_img)
    if cv2.waitKey(50)==27: #esc
        break
    elif cv2.waitKey(150)==32: #space
        img,contours, hierarchy = cv2.findContours(image=end_img, mode=findcounturs_mode_num[findcounturs_mode],  method=findcountursmethod_num[findcountursmethod])
        #cv2.imshow(title_window ,end_img )
        
        print("contours count="+str(len(contours)))
        print("points count of countur[0]:"+str(len(contours[0])))
        print("with "+method_name[method]+";")
        print("with mode in findContours="+findcounturs_mode_name[findcounturs_mode]+" and method_type in findContours="+findcountursmethod_name[findcountursmethod]+".")
        #print("hierarchy="+str(hierarchy))