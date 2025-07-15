#!/bin/bash
#FLUX: --job-name=strawberry-bike-1455
#FLUX: -t=432000
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/solov2/solov2_r50_fpn_60e_coco_livecell.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/livecell/solov2_r50_fpn_60e_coco_livecell
