#!/bin/bash
#FLUX: --job-name=Mistral
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load cpuarch/amd
module load anaconda-py3/2023.03
conda activate claire
set -x
MODEL=mistralai/Mistral-7B-v0.1
OUTDIR=$WORK/../commun/Claire/pretrain/Claire-Mistral-7B-0.1
mkdir -p $OUTDIR
srun --output=$OUTDIR/training_log.out --error=$OUTDIR/training_log.out \
python pretrain.py \
--devices 8 \
--num_nodes 1 \
--data_dir $SCRATCH/../commun/preprocessed_data/Claire/lit-gpt/padded_8_grouped/$MODEL \
--checkpoint_dir $WORK/../commun/Claire/checkpoints/$MODEL \
--language fr \
--out_dir $OUTDIR \
--precision bf16-true \
--num_epochs 1000 \
--max_checkpoints 39 \
--enable_validation true \
--early_stopping 4 \
--lora_r 16 \
--lora_alpha 32 \
--batch_size 16 \
--micro_batch_size 8 \
--save_interval 1800 \
--eval_interval 1800
