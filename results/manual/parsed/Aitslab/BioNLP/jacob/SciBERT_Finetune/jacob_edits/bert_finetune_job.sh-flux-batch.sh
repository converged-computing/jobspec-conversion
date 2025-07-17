#!/bin/bash
#FLUX: --job-name=ornery-hope-6691
#FLUX: -t=57600
#FLUX: --urgency=16

nvidia-smi
ml Anaconda/2021.05-nsc1
conda activate /proj/berzelius-2021-21/users/jacob/conda_envs/nilsre
python main.py > jacob_edits/2023_05_05_bert_finetune_merged.txt
