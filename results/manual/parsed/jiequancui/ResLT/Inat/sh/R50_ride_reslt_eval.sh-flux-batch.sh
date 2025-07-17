#!/bin/bash
#FLUX: --job-name=Inat
#FLUX: -c=24
#FLUX: --queue=batch_72h
#FLUX: --urgency=16

source activate py3.6pt1.5
python iNaturalTrain_reslt_ride.py \
  --arch ResNet50Model \
  --mark ResNet50Model \
  -dataset iNaturalist2018 \
  --data_path /research/dept6/jqcui/Data/iNaturalist2018/ \
  -b 256 \
  --epochs 200 \
  --num_works 40 \
  --lr 0.1 \
  --weight-decay 1e-4 \
  --beta 0.85 \
  --gamma 0.3 \
  --after_1x1conv \
  --num_classes 8142  \
  --val_num_experts 2 \
  --resume data/iNaturalist2018/ResNet50Model/model_best.pth.tar \
  --evaluate \
