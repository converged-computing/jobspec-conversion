#!/bin/bash
#FLUX: --job-name=faux-blackbean-5415
#FLUX: -t=432000
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/hrnet2C/cascade_mask_rcnn_hrnetv2p_w32_200e_coco_tissuenet_w.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/wholecell/HRNet
