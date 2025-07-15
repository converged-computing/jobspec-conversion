#!/bin/bash
#FLUX: --job-name=astute-sundae-1944
#FLUX: -t=432000
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/res2net2C/cascade_mask_rcnn_r2_101_fpn_20e_coco_tissuenet_n.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/nuclear/res2net
