#!/bin/bash
#FLUX: --job-name=hrnet-tissuenet-n-1C
#FLUX: --queue=tier3
#FLUX: -t=259200
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/hrnet/cascade_mask_rcnn_hrnetv2p_w32_200e_coco_tissuenet_n.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/nuclear_oc/hrnet_v2p_w32_200e_coco_tissuenet_n
