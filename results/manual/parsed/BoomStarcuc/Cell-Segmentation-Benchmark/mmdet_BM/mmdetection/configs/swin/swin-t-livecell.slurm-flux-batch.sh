#!/bin/bash
#FLUX: --job-name=gassy-kitty-2688
#FLUX: -t=259200
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/swin/mask_rcnn_swin-t-p4-w7_fpn_ms-crop-50e_coco_livecell.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/livecell/swin-t-p4-w7_fpn_ms-crop-50e_coco_livecell
