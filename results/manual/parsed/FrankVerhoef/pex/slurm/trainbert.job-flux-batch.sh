#!/bin/bash
#FLUX: --job-name=Train_Bert
#FLUX: --queue=gpu
#FLUX: -t=9000
#FLUX: --urgency=16

source ./slurm/.secrets
module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
source activate pex
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/logs
mkdir "$TMPDIR"/checkpoints
srun python -u run/main.py train bert classify \
        --basedir msc/msc_personasummary/  \
        --sessions 1 2 3 \
	--len_context 1 \
        --batch_size 64  \
        --learning_rate 0.0001 \
        --freeze 8 \
	--epochs 5  \
	--valid_samples 2000 \
	--test_samples 1000 \
	--valid_interval 25 \
        --patience 9 \
        --device cuda  \
        --loglevel DEBUG  \
        --logdir "$TMPDIR"/logs/  \
	--datadir "$TMPDIR"/data/ \
        --checkpoint_dir "$TMPDIR"/checkpoints/ \
        --save trained_len1  \
        --use_wandb
cp "$TMPDIR"/logs/* ./logs
cp "$TMPDIR"/checkpoints/* ./checkpoints
