import os
import random

#从Label_location中提取数据并写入train/test_annotation作为训练和测试时的label
#用了length=2固定了label_bounding_box的大小，后续可改动
ptxt = './dataset/Label_location'
#length = 2
files = os.listdir(ptxt)
ftrain = open('./data/train_annotation.txt', 'w')
ftest = open('./data/test_annotation.txt', 'w')
random.shuffle(files)
for i in range(len(files)):
    cur_txt = open(os.path.join(ptxt, files[i]), 'r').readlines()
    cur_name = './dataset/CEUS/CEUS{}.jpg '.format(files[i].replace('Label', '').replace('.txt', ''))
    coord_info = ''
    for j in range(len(cur_txt)):
        coord = cur_txt[j].split(' ')
        top = int(float(coord[1]) + 64 - 0.5*float(coord[3])) #- length      #y1
        left = int(float(coord[0]) + 64 - 0.5*float(coord[2])) #- length     #x1
        down = int(float(coord[1]) + 64 + 0.5*float(coord[3])) #+ length
        right = int(float(coord[0]) + 64 + 0.5*float(coord[2])) #+ length
        coord_info += '{},{},{},{},0 '.format(left, top, right, down)
    cur_lab = cur_name + coord_info[:-1] + '\n'
    if i < 2400:         # train的数量
        ftrain.writelines(cur_lab)
    else:
        ftest.writelines(cur_lab)
