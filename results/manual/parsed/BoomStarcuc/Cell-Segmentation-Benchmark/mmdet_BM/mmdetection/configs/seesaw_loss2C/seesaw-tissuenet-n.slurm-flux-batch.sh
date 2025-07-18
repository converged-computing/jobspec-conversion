#!/bin/bash
#FLUX: --job-name=seesaw-tissuenet-n-2C
#FLUX: --queue=tier3
#FLUX: -t=432000
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/seesaw_loss2C/cascade_mask_rcnn_r101_fpn_random_seesaw_loss_normed_mask_mstrain_2x_lvis_v1_tissuenet_n.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/nuclear/Cascade_Mask_RCNN_seesaw
