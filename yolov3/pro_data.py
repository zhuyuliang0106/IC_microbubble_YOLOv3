import cv2
import os
#用于看label的location和image是否对应，是否准确

path = './dataset'

img_path = './dataset/Label_image/Label1.jpg'
lab = './dataset/Label_location/Label1.txt'
img = cv2.imread(img_path)
info = open(lab, 'r').readlines()
for i in range(len(info)):
    coord = info[i].split(' ')
    cx = int(float(coord[0])+64)
    cy = int(float(coord[1])+64)
    img = cv2.circle(img, (cx, cy), 1, (255, 0, 0), 2, 0)

cv2.imwrite('0.png', img)
print('ok')