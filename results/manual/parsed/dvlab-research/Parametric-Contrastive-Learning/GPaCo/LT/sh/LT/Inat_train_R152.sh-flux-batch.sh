#!/bin/bash
#FLUX: --job-name=gpaco_inat_r152
#FLUX: -c=56
#FLUX: --queue=dvlab
#FLUX: --urgency=16

source activate py3.8_pt1.8.1 
PORT=$[$RANDOM + 10000]
python paco_lt.py \
  --dataset inat \
  --arch resnet152 \
  --data /mnt/proj75/jqcui/Data/iNaturalist2018 \
  --alpha 0.05 \
  --beta 1.0 \
  --gamma 1.0 \
  --wd 1e-4 \
  --mark gpaco_inat_r152 \
  --lr 0.04 \
  --moco-t 0.2 \
  --aug randcls_sim \
  --randaug_m 10 \
  --randaug_n 2 \
  --dist-url "tcp://localhost:$PORT" \
  --num_classes 8142 \
  --epochs 400
