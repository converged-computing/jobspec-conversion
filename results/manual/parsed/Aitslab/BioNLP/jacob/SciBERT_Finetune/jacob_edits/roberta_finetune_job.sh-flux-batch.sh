#!/bin/bash
#FLUX: --job-name=wobbly-ricecake-7685
#FLUX: -t=10800
#FLUX: --urgency=16

nvidia-smi
ml Anaconda3
conda init bash
conda activate /mimer/NOBACKUP/groups/snic2022-22-707/jacob/conda_envs/roberta
python main.py > jacob_edits/2023_05_10_roberta_finetune_merged.txt
