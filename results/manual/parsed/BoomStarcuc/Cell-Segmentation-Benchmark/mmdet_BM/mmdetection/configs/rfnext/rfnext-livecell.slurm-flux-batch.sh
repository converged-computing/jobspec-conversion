#!/bin/bash
#FLUX: --job-name=dirty-latke-5007
#FLUX: -t=172800
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/rfnext/rfnext_fixed_multi_branch_cascade_mask_rcnn_r2_101_fpn_200e_coco_livecell.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/livecell/rfnext_fixed_multi_branch_cascade_mask_rcnn_r2_101_fpn_200e_coco_livecell
