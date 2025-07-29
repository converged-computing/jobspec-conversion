#!/bin/bash
#SBATCH --mail-user=ja6750kr-s@student.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=16:00:00

nvidia-smi
ml Anaconda/2021.05-nsc1
conda activate /proj/berzelius-2021-21/users/jacob/conda_envs/nilsre
python main.py > jacob_edits/2023_05_05_bert_finetune_merged.txt
