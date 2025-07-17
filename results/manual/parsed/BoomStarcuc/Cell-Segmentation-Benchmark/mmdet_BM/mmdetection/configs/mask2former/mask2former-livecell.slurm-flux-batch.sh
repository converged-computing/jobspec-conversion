#!/bin/bash
#FLUX: --job-name=mask2former-livecell-1C
#FLUX: --queue=tier3
#FLUX: -t=259200
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/mask2former/mask2former_r50_lsj_8x2_50e_coco_livecell.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/livecell/mask2former_r50_lsj_8x2_50e_coco_livecell
