#!/bin/bash
#FLUX: --job-name=gassy-pancake-4153
#FLUX: -t=172800
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/rfnext/rfnext_fixed_multi_branch_cascade_mask_rcnn_r2_101_fpn_200e_coco_tissuenet_n.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/nuclear_oc/rfnext_fixed_multi_branch_cascade_mask_rcnn_r2_101_fpn_200e_coco_tissuenet_n
