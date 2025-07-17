#!/bin/bash
#FLUX: --job-name=Inat
#FLUX: -c=40
#FLUX: --queue=batch_72h
#FLUX: --urgency=16

PORT=$[$RANDOM + 10000]
python paco_lt.py \
  --dataset inat \
  --arch resnet50 \
  --data /mnt/proj75/jqcui/Data/iNaturalist2018 \
  --alpha 0.05 \
  --beta 1.0 \
  --gamma 1.0 \
  --wd 1e-4 \
  --mark R50_mocot0.2_augrandcls_sim_400epochs_lr0.02_t1 \
  --lr 0.02 \
  --moco-t 0.2 \
  --aug randcls_sim \
  --randaug_m 10 \
  --randaug_n 2 \
  --dist-url "tcp://localhost:$PORT" \
  --num_classes 8142 \
  --epochs 400 
