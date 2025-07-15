#!/bin/bash
#FLUX: --job-name=faux-mango-6371
#FLUX: -t=259200
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/hrnet/cascade_mask_rcnn_hrnetv2p_w32_200e_coco_tissuenet_w.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/wholecell_oc/cascade_mask_rcnn_hrnetv2p_w32_200e_coco_tissuenet_w
