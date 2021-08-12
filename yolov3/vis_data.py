# --------------------------------------------------------
# Check the VOC data used by detect project
# Written by Guo Pei in 20191106
# --------------------------------------------------------

from __future__ import print_function
import os
import sys
import cv2
import random
import shutil
from tqdm import tqdm
import numpy as np
import argparse
import xml.etree.ElementTree as ET


def xml_reader(filename):
    """ Parse a PASCAL VOC xml file """
    tree = ET.parse(filename)
    objects = []
    for obj in tree.findall('object'):
        obj_struct = {}
        obj_struct['name'] = obj.find('name').text
        bbox = obj.find('bndbox')
        obj_struct['bbox'] = [int(bbox.find('xmin').text),
                              int(bbox.find('ymin').text),
                              int(bbox.find('xmax').text),
                              int(bbox.find('ymax').text)]
        objects.append(obj_struct)

    return objects


def get_image_list(image_dir, suffix=['jpg', 'png']):
    '''get all image path ends with suffix'''
    if not os.path.exists(image_dir):
        print("PATH:%s not exists" % image_dir)
        return []
    imglist = []
    for root, sdirs, files in os.walk(image_dir):
        if not files:
            continue
        for filename in files:
            filepath = os.path.join(root, filename)
            if filename.split('.')[-1] in suffix:
                imglist.append(filepath)
    return imglist


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='check data')
    parser.add_argument('--input', default='../VOC2007/JPEGImages', help='The input dir of images', type=str)
    parser.add_argument('--output', dest='output', default='temp', help='The output dir of images', type=str)
    parser.add_argument('--num', dest='num', default=50, help='The number of images you want to check', type=int)
    args = parser.parse_args()

    if not os.path.exists(args.output):
        os.makedirs(args.output)

    img_list = get_image_list(args.input)
    # img_list = random.sample(img_list, args.num)

    for img_path in tqdm(img_list):
        img = cv2.imread(img_path)
        if img is None or not img.any():
            continue
        xml_path = img_path.replace("JPEGImages", "Annotations").replace(".jpg", ".xml").replace(".png", ".xml")
        # if os.path.exists(xml_path) is False:
        #     shutil.move(img_path, img_path.replace('JPEGImages', 'error_img'))
            # continue
        objects = xml_reader(xml_path)
        if len(objects) == 0:
            continue

        # draw box and name
        for obj in objects:
            name = obj['name']
            box = obj['bbox']
            p1 = (box[0], box[1])
            p2 = (box[2], box[3])
            p3 = (max(box[0], 15), max(box[1], 15))
            cv2.rectangle(img, p1, p2, (0, 0, 255), 2)
            cv2.putText(img, name, p3, cv2.FONT_ITALIC, 1, (0, 255, 0), 2)

        img_name = os.path.basename(img_path)
        cv2.imwrite(os.path.join(args.output, img_name), img)