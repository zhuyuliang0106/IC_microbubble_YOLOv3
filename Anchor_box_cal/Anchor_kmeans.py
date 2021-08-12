import os
import math
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns; sns.set()

Aktxt = './Label_location_V10'
Akfiles = os.listdir(Aktxt)

w,h = [], []
for i in range(len(Akfiles)):
    cur_txt = open(os.path.join(Aktxt, Akfiles[i]), 'r').readlines()

    for j in range(len(cur_txt)):
        coord = cur_txt[j].split(' ')

        width = float(coord[2])
        height = float(coord[3])
        w.append(width)
        h.append(height)

w = np.asarray(w)
h = np.asarray(h)

x = [w,h]
x = np.asarray(x)
x = x.transpose()
#print(x)

##############################  K-means

from sklearn.cluster import KMeans
kmeans3 = KMeans(n_clusters=9)
kmeans3.fit(x)  # 计算9个聚类中心
y_kmeans3 = kmeans3.predict(x)   # 预测每一组box框大小属于哪个聚类
#print(kmeans3.labels_)
#print('Kmeans over')

###############################
centers3 = kmeans3.cluster_centers_  # 给出9个聚类中心的坐标
#print(centers3)
#print('cut')
# Centers3 == yolo_anchor_average

yolo_anchor_average=[]
for ind in range (9):
    yolo_anchor_average.append(np.mean(x[y_kmeans3==ind],axis=0))

yolo_anchor_average=np.array(yolo_anchor_average)
#print(yolo_anchor_average)

plt.scatter(x[:, 0], x[:, 1], c=y_kmeans3, s=2, cmap='viridis')
plt.scatter(yolo_anchor_average[:, 0], yolo_anchor_average[:, 1], c='red', s=50);
yoloV3anchors = yolo_anchor_average
yoloV3anchors[:, 0] =yolo_anchor_average[:, 0] #/1280 *128
yoloV3anchors[:, 1] =yolo_anchor_average[:, 1] #/720 *128
#yoloV3anchors = np.rint(yoloV3anchors) # 取整数
fig, ax = plt.subplots()


for ind in range(9):
    rectangle= plt.Rectangle((15-yoloV3anchors[ind,0]/2,15-yoloV3anchors[ind,1]/2), yoloV3anchors[ind,0],yoloV3anchors[ind,1] , fc='b',edgecolor='b',fill = None)
    ax.add_patch(rectangle)
ax.set_aspect(1.0)
plt.axis([0,30,0,30])
plt.show()
#yoloV3anchors.sort(axis=0) # sort 方式不对
print("Your custom anchor boxes are {}".format(yoloV3anchors))

F = open("YOLOV3_BDD_Anchors.txt", "w")
F.write("{}".format(yoloV3anchors))
F.close()