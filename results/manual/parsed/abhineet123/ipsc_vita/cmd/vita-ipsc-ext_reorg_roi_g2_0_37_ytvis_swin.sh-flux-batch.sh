#!/bin/bash
#FLUX: --job-name=vita-ipsc-ext_reorg_roi_g2_0_37-swin
#FLUX: -c=4
#FLUX: -t=1440
#FLUX: --urgency=16

module load cuda cudnn gcc python/3.8
source ~/venv/vita/bin/activate
nvidia-smi
python train_net_vita.py --resume --num-gpus 2 --config-file configs/youtubevis_2019/vita-ipsc-ext_reorg_roi_g2_0_37-vita_SWIN_bs8.yaml MODEL.WEIGHTS pretrained/vita_swin_coco.pth SOLVER.IMS_PER_BATCH 2
