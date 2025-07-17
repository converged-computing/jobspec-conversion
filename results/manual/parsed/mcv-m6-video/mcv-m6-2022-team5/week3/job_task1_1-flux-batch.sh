#!/bin/bash
#FLUX: --job-name=gloopy-arm-6714
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python task1_1.py -m "COCO-Detection/faster_rcnn_R_50_FPN_3x.yaml" -d "fasterRCNN_50FPN_detections" -v "/home/group05/m6_dataset/vdo.avi"
python task1_1.py -m "COCO-Detection/faster_rcnn_X_101_32x8d_FPN_3x.yaml" -d "fasterRCNN_X_101_detections" -v "/home/group05/m6_dataset/vdo.avi"
python task1_1.py -m "COCO-Detection/retinanet_R_101_FPN_3x.yaml" -d "retinanet_101_detections" -v "/home/group05/m6_dataset/vdo.avi"
python task1_1.py -m "COCO-InstanceSegmentation/mask_rcnn_X_101_32x8d_FPN_3x.yaml" -d "maskRCNN_101_detections" -v "/home/group05/m6_dataset/vdo.avi"
python task1_1.py -m "COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml" -d "maskRCNN_50FPN_detections" -v "/home/group05/m6_dataset/vdo.avi"
