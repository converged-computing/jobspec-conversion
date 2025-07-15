#!/bin/bash
#FLUX: --job-name=Train_PEX
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --priority=16

module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
source activate pex
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/logs
mkdir "$TMPDIR"/checkpoints
srun python -u run/main.py \
        --device cuda  \
	--datadir "$TMPDIR"/data/ \
	--kg-datadir "$TMPDIR"/data/kg_data/ \
        --checkpoint_dir "$TMPDIR"/checkpoints/ \
	--task dialog  \
        --model kg_gen  \
        --kg kg.graph-sm  \
        --batch_size 16  \
        --learning_rate 0.0001 \
        --fixed_lm \
        --traindata msc/msc_dialogue/session_2/train.txt  \
        --validdata msc/msc_dialogue/session_2/valid.txt  \
        --testdata msc/msc_dialogue/session_2/test.txt \
        --train_samples 100  \
        --valid_samples 10 \
        --test_samples 10  \
        --decoder_max 25  \
        --epochs 1  \
        --save test  \
        --loglevel DEBUG  \
        --logdir "$TMPDIR"/logs/  \
cp "$TMPDIR"/logs/* ./logs
cp "$TMPDIR"/checkpoints/* ./checkpoints
