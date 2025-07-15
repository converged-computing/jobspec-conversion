#!/bin/bash
#FLUX: --job-name=confused-platanos-7698
#FLUX: --queue=mpi-cpus  --gres=gpu:0
#FLUX: --priority=16

python3 embed.py \
       -dim 2 \
       -lr 0.3 \
       -epochs 1000 \
       -negs 50 \
       -burnin 20 \
       -ndproc 4 \
       -manifold group_rie \
       -dset wordnet/grqc.csv \
       -batchsize 10 \
       -eval_each 100 \
       -sparse \
       -train_threads 2
