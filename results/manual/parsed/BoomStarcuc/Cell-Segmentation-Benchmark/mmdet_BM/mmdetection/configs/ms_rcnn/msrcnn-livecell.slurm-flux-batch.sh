#!/bin/bash
#FLUX: --job-name=msrcnn-livecell-1C
#FLUX: --queue=tier3
#FLUX: -t=432000
#FLUX: --urgency=16

spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
cd mmdetection
nvidia-smi
sh mmdetection/tools/dist_train.sh mmdetection/configs/ms_rcnn/ms_rcnn_r50_caffe_fpn_2x_coco_livecell.py 4 --work-dir /shared/rc/spl/mmdet_output/All_to_all/livecell/ms_rcnn_r50_caffe_fpn_1x_coco_livecell
