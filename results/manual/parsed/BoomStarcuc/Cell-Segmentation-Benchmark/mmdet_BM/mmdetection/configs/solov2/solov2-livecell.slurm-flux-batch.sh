#!/bin/bash
#FLUX: --job-name=fuzzy-lentil-7314
#FLUX: -t=432000
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/solov2/solov2_r50_fpn_60e_coco_livecell.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/livecell/solov2_r50_fpn_60e_coco_livecell
