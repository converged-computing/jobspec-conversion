#!/bin/bash
#FLUX: --job-name=codemix
#FLUX: -c=4
#FLUX: --urgency=16

spack unload 
spack load gcc@11.2.0
spack load cuda@11.7.1%gcc@11.2.0 arch=linux-rocky8-zen2
spack load python@3.9.13%gcc@11.2.0 arch=linux-rocky8-zen2
source ~/omkar/envs/codemix/bin/activate
cd /home/aruna/omkar/multitask
srun ~/omkar/envs/codemix/bin/python main.py \
--run_name "xlm-base-cf-2-v1" \
--base_model xlm-roberta-base \
--epochs 100 \
--ner_lr 3e-4 \
--lid_lr 3e-5 \
--batch_size 32 \
--logger wandb \
--exp_path "/scratch/aruna/codemix-runs" \
--dataset_dir "/scratch/aruna/codemix-data/ner" \
--k 8
