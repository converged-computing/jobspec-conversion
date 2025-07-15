#!/bin/bash
#FLUX: --job-name=R2D2
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=gpu_partition
#FLUX: -t=86400
#FLUX: --priority=16

echo "This is a minimal example. See --help or args.py for more," \
     "e.g. on augmentation, cropping, padding, and data division."
echo "Training on 2 nodes with 8 GPUs."
echo "input data: {train,val,test}/R{0,1}-*.npy"
echo "target data: {train,val,test}/D{0,1}-*.npy"
echo "normalization functions: {R,D}{0,1} in ./RnD.py," \
     "see map2map/data/norms/*.py for examples"
echo "model: Net in ./model.py, see map2map/models/*.py for examples"
echo "Training with placeholder learning rate 1e-4 and batch size 1."
hostname; pwd; date
srun m2m.py train \
    --train-in-patterns "train/R0-*.npy,train/R1-*.npy" \
    --train-tgt-patterns "train/D0-*.npy,train/D1-*.npy" \
    --val-in-patterns "val/R0-*.npy,val/R1-*.npy" \
    --val-tgt-patterns "val/D0-*.npy,val/D1-*.npy" \
    --in-norms RnD.R0,RnD.R1 --tgt-norms RnD.D0,RnD.D1 \
    --model model.Net --callback-at . \
    --lr 1e-4 --batch-size 1 \
    --epochs 1024 --seed $RANDOM
date
