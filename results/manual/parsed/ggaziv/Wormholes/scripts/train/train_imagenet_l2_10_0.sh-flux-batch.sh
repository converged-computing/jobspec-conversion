#!/bin/bash
#FLUX: --job-name=eps10
#FLUX: --priority=16

DATA_PATH=<DATA_PATH>
RESULTS_DIR=<RESULTS_DIR>
DATASET=imagenet
python -m wormholes.main --dataset $DATASET --data $DATA_PATH \
   --adv-train 1 --arch resnet50 \
   --out-dir $RESULTS_DIR --exp-name imagenet_l2_10_0 --eps 10.0 --attack-lr 1.5 \
   --attack-steps 10 --constraint 2 #\
   # --resume-optimizer 1 --resume ${RESULTS_DIR}/imagenet_l2_10_0/checkpoint.pt.latest
