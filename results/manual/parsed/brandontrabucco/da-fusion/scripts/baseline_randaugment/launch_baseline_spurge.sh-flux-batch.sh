#!/bin/bash
#FLUX: --job-name=spurge
#FLUX: --queue=russ_reserved
#FLUX: -t=259200
#FLUX: --urgency=16

source ~/anaconda3/etc/profile.d/conda.sh
conda activate semantic-aug
cd ~/spurge/semantic-aug
RANK=$SLURM_ARRAY_TASK_ID WORLD_SIZE=$SLURM_ARRAY_TASK_COUNT \
python train_classifier.py \
--logdir ./randaugment-spurge-baselines/baseline \
--dataset spurge --num-synthetic 0 \
--synthetic-probability 0.0 --num-trials 8 \
--examples-per-class 1 2 4 8 16 --use-randaugment
