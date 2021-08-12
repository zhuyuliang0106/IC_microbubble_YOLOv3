import os
import re
import matplotlib.pyplot as plt
import cv2

ptxt = './Pred_BBOX'
files = os.listdir(ptxt)

#originalImage = cv2.imread('D:\IC\BioMedical\Individual Project\Code\Pytorch_yolov3\yolov3\yolov3\Extraction\CEUS\CEUS6.jpg',cv2.IMREAD_UNCHANGED)
x_train = []
x_filename = []
for root, dirnames, filenames in os.walk(
        r'D:\IC\BioMedical\Individual Project\Code\Pytorch_yolov3\yolov3\yolov3\Extraction\CEUS'):
    for filename in filenames:
        if re.search("\.(jpg|jpeg|JPEG|png|bmp|tiff)$", filename):
            filepath = os.path.join(root, filename)
            image = plt.imread(filepath)

            x_filename.append(filename)
            x_train.append(image)
#x_train = np.array(x_train)
# x_train = x_train.reshape(x_train.shape[0], 128, 128, 1)
#x_train = x_train.astype('float32')

print(x_filename)

for i in range(len(files)):
    cur_txt = open(os.path.join(ptxt, files[i]), 'r').readlines()

    for j in range(len(cur_txt)):
        coord = cur_txt[j].split(' ')
        #print(coord)
        originalImage = x_train[i]
        Image_namge = x_filename[i]

        x1 = int(float(coord[0]))
        y1 = int(float(coord[1]))
        x2 = int(float(coord[2]))
        y2 = int(float(coord[3]))
        Bubble = originalImage[y1:y2, x1:x2]
        cv2.imwrite('{}_Bubble_{}.jpg'.format(Image_namge, j), Bubble)



