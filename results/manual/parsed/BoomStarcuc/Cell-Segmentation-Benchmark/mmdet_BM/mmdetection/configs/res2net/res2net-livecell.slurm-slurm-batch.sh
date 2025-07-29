#!/bin/bash
#FLUX: --job-name=res2net-livecell-1C
#FLUX: --queue=tier3
#FLUX: -t=432000
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/res2net/cascade_mask_rcnn_r2_101_fpn_20e_coco_livecell.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/livecell/cascade_mask_rcnn_r2_101_fpn_20e_coco_livecell
