import os
import shutil

p = './data/train_annotation.txt'
p_test = './data/test_annotation.txt'

f = open(p, 'r').readlines()

for i in range(len(f)):
    name = f[i].split(' ')[0]
    shutil.copy(name, os.path.join('./data/train', name.split('/')[-1]))


f = open(p_test, 'r').readlines()

for i in range(len(f)):
    name = f[i].split(' ')[0]
    shutil.copy(name, os.path.join('./data/test', name.split('/')[-1]))