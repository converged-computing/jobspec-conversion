#!/bin/bash
#FLUX: --job-name=expressive-frito-7085
#FLUX: -t=144000
#FLUX: --priority=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/strong_baselines/mask_rcnn_r50_caffe_fpn_syncbn-all_rpn-2conv_lsj_100e_coco_tissuenet_w.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/wholecell_oc/mask_rcnn_r50_caffe_fpn_syncbn-all_rpn-2conv_lsj_100e_coco_tissuenet_w
