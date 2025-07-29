#!/bin/bash
#SBATCH --account=GutIntelligenceLab
#SBATCH --output=/scratch/ys5hd/EoE/CRC/finetune/model_log_tcia_tnbc.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

module load anaconda3
source activate pytorch_yash
python -u /scratch/ys5hd/EoE/CRC/finetune/orchestrator.py 0. 1. 'tcia' 'tnbc'
