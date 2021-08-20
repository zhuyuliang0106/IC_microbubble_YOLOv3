# coding=utf-8
# project
DATA_PATH = r"F:\0Fcode\code0711_yolo\VOC2007"
#PROJECT_PATH = r"F:\0Fcode\code0727_det\yolov3"
PROJECT_PATH = r"D:\IC\BioMedical\Individual Project\Code\Pytorch_yolov3\yolov3\yolov3"

# DATA = {"CLASSES":['aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus',
#            'car', 'cat', 'chair', 'cow', 'diningtable', 'dog', 'horse',
#            'motorbike', 'person', 'pottedplant', 'sheep', 'sofa',
#            'train', 'tvmonitor'],
#         "NUM":20}

DATA = {"CLASSES": ['point'],
        "NUM": 1}

# model
#MODEL = {"ANCHORS": [[(1.25, 1.625), (2.0, 3.75), (4.125, 2.875)],  # Anchors for small obj
#                     [(1.875, 3.8125), (3.875, 2.8125), (3.6875, 7.4375)],  # Anchors for medium obj
#                     [(3.625, 2.8125), (4.875, 6.1875), (11.65625, 10.1875)]],  # Anchors for big obj
#         "STRIDES": [8, 16, 32],
#         "ANCHORS_PER_SCLAE": 3
#         }

# MODEL for V11
#MODEL = {"ANCHORS": [[(3.6319, 3.2745), (3.6606, 4.7699), (3.9423, 6.5241)],  # Anchors for small obj
#                     [(5.5596, 4.0878), (5.5918, 6.3293), (7.3806, 4.3591)],  # Anchors for medium obj
#                     [(4.9880, 8.0489), (7.3333, 6.0576), (7.6158, 7.6705)]],  # Anchors for big obj
#         "STRIDES": [8, 16, 32],
#         "ANCHORS_PER_SCLAE": 3
#         }

#Model for Final
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
