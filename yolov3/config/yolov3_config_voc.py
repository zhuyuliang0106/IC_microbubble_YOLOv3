# coding=utf-8
# project
DATA_PATH = r"F:\0Fcode\code0711_yolo\VOC2007"
#PROJECT_PATH = r"F:\0Fcode\code0727_det\yolov3"
PROJECT_PATH = r"D:\IC\BioMedical\Individual Project\Code\Pytorch_yolov3\yolov3\yolov3"
# PROJECT_PATH is where your whole file of the network is.

# DATA = {"CLASSES":['aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus',
#            'car', 'cat', 'chair', 'cow', 'diningtable', 'dog', 'horse',
#            'motorbike', 'person', 'pottedplant', 'sheep', 'sofa',
#            'train', 'tvmonitor'],
#         "NUM":20}

#In this project, only one classify, that is microbubble, thus only one.
DATA = {"CLASSES": ['point'],
        "NUM": 1}


#This is the dimension of the anchor box, you need to know what is the anchor box in YOLOv3 first.
MODEL = {"ANCHORS": [[(4.4833, 4.6323), (5.1899, 6.9693), (6.6161, 5.2267)],  # Anchors for small obj
                     [(5.3304, 9.6980), (9.1278, 5.1023), (7.7567, 7.5340)],  # Anchors for medium obj
                     [((7.8473, 9.8834)), (10.4862, 6.7193), (10.3803, 9.8862)]],  # Anchors for big obj
         "STRIDES": [8, 16, 32],
         "ANCHORS_PER_SCLAE": 3
         }


# train
TRAIN = {
    "TRAIN_IMG_SIZE": 128,
    "AUGMENT": True,
    "BATCH_SIZE": 2,
    "MULTI_SCALE_TRAIN": False,
    "IOU_THRESHOLD_LOSS": 0.5,
    "EPOCHS": 50,
    "NUMBER_WORKERS": 1,
    "MOMENTUM": 0.9,
    "WEIGHT_DECAY": 0.0005,
    "LR_INIT": 1e-4,
    "LR_END": 1e-7,
    "WARMUP_EPOCHS": 2  # or None
}

# test
TEST = {
    "TEST_IMG_SIZE": 128,
    "BATCH_SIZE": 1,
    "NUMBER_WORKERS": 0,
    "CONF_THRESH": 0.01,
    "NMS_THRESH": 0.5,
    "MULTI_SCALE_TEST": False,
    "FLIP_TEST": False
}

# some tips
# your IMG_SIZE should be same as your input image.
# don't use 'multi_scale_trian'. If you change the code in the training, you can use this function.
# BATCH_SIZE should be fitted to your GPU and the training datasets.
