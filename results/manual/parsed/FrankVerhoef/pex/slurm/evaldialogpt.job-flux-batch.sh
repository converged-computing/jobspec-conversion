#!/bin/bash
#FLUX: --job-name=Eval_GPT
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --priority=16

source ./slurm/.secrets
module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
source activate pex
HPARAMS_FILE=$HOME/pex/slurm/eval_gpt_params.txt
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/logs
mkdir "$TMPDIR"/output
echo START
date
srun python -u run/main.py eval dialogpt dialog \
        --basedir msc/msc_dialogue/  \
        --speaker_prefixes \<other\> \<self\> \
        --sessionbreak_token \<session\> \
	--include_persona \
        --augmented \
	--lm gpt2 \
        --speechact_classifier trained_speechact_bert \
	--decoder_max 50 \
        --batch_size 8  \
        --log_interval 5 \
        --device cuda  \
        --loglevel VERBOSE  \
        --logdir "$TMPDIR"/logs/  \
	--datadir "$TMPDIR"/data/ \
        --checkpoint_dir ./checkpoints/ \
	--output_dir "$TMPDIR"/output/ \
 	$(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1)       
cp "$TMPDIR"/logs/* ./logs
cp "$TMPDIR"/data/msc/msc_dialogue/preprocessed* ./data/msc/msc_dialogue
cp "$TMPDIR"/output/* output
echo FINISH
date
