#!/bin/bash
#FLUX: --job-name=gpaco_placeslt_r152
#FLUX: -c=40
#FLUX: --queue=batch_72h
#FLUX: --urgency=16

PORT=$[$RANDOM + 10000]
source activate py3.8_pt1.8.1 
python paco_fp16_places.py \
  --dataset places \
  --arch resnet152 \
  --data /research/d4/gds/zszhong21/jqcui/Data/Places \
  --alpha 0.02 \
  --beta 1.0 \
  --gamma 1.0 \
  --wd 5e-4 \
  --mark gpaco_placeslt_r152 \
  --lr 0.02 \
  --moco-t 0.2 \
  --aug sim_sim \
  --randaug_m 10 \
  --randaug_n 2 \
  --dist-url "tcp://localhost:$PORT" \
  --epochs 30 \
  --fp16 \
  --reload_torch pretrain/resnet152-394f9c45.pth \
  --evaluate \
  --resume ../../../pretrain_models/gpaco_r152_placeslt.pth.tar 
