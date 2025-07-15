#!/bin/bash
#FLUX: --job-name=wobbly-ricecake-1048
#FLUX: -t=259200
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/mask2former/mask2former_r50_lsj_8x2_50e_coco_tissuenet_n.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/nuclear_oc/mask2former_r50_lsj_8x2_50e_coco_tissuenet_n
