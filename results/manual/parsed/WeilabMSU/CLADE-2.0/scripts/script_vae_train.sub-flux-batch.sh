#!/bin/bash
#FLUX: --job-name=vaetrain
#FLUX: -t=86340
#FLUX: --urgency=16

source activate deep_sequence
dataset=GB1
THEANO_FLAGS='floatX=float32,device=cuda' python src/vae_train.py Input/"$dataset"/"$dataset".a2m "$dataset"_seed$[$SLURM_ARRAY_TASK_ID] $[$SLURM_ARRAY_TASK_ID]
