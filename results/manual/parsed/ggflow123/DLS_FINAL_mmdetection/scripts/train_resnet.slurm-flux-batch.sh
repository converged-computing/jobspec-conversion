#!/bin/bash
#FLUX: --job-name=res_train
#FLUX: -c=14
#FLUX: -t=86400
#FLUX: --priority=16

module purge
cd ../
bash ./tools/dist_train.sh ./configs/mask_rcnn/mask_rcnn_r50_fpn_1x_coco_datapath.py  4
