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

# MODEL for V10
MODEL = {"ANCHORS": [[(6.6414, 6.8018), (9.8782, 6.1234), (6.5990, 13.4083)],  # Anchors for small obj
                     [(13.3982, 6.5994), (6.7748, 12.1692), (10.3516, 8.8825)],  # Anchors for medium obj
                     [(9.8590, 12.6997), (13.4188, 10.1027), (13.2853, 13.2730)]],  # Anchors for big obj
         "STRIDES": [8, 16, 32],
         "ANCHORS_PER_SCLAE": 3
         }

# train
TRAIN = {
    "TRAIN_IMG_SIZE": 128,
    "AUGMENT": True,
    "BATCH_SIZE": 2,
    "MULTI_SCALE_TRAIN": True,
    "IOU_THRESHOLD_LOSS": 0.5,
    "EPOCHS": 100,
    "NUMBER_WORKERS": 1,
    "MOMENTUM": 0.9,
    "WEIGHT_DECAY": 0.0005,
    "LR_INIT": 1e-4,
    "LR_END": 1e-6,
    "WARMUP_EPOCHS": 2  # or None
}

# test
TEST = {
    "TEST_IMG_SIZE": 128,
    "BATCH_SIZE": 2,
    "NUMBER_WORKERS": 0,
    "CONF_THRESH": 0.01,
    "NMS_THRESH": 0.5,
    "MULTI_SCALE_TEST": False,
    "FLIP_TEST": False
}
