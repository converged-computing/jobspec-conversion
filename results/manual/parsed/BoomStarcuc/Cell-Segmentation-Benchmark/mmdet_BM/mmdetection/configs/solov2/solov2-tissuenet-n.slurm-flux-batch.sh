#!/bin/bash
#FLUX: --job-name=sticky-truffle-3000
#FLUX: -t=432000
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/solov2/solov2_r50_fpn_60e_coco_tissuenet_n.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/nuclear_oc/solov2_r50_fpn_60e_coco_tissuenet_n
