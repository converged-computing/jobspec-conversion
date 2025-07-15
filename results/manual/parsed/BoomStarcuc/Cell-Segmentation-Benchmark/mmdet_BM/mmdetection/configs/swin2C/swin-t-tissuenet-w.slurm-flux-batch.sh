#!/bin/bash
#FLUX: --job-name=quirky-puppy-2968
#FLUX: -t=432000
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/swin2C/mask_rcnn_swin-t-p4-w7_fpn_ms-crop-50e_coco_tissuenet_w.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/wholecell/Swin-T
