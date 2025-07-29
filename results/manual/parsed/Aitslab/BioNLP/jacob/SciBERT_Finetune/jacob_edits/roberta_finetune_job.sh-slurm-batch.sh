#!/bin/bash
#SBATCH --account=SNIC2022-22-707
#SBATCH --mail-user=ja6750kr-s@student.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00

nvidia-smi
ml Anaconda3
conda init bash
conda activate /mimer/NOBACKUP/groups/snic2022-22-707/jacob/conda_envs/roberta
python main.py > jacob_edits/2023_05_10_roberta_finetune_merged.txt
