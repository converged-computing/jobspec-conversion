#!/bin/bash
#SBATCH --output=/home/zguo30/ppg_ecg_proj/ecg_only_baseline/slurm_outputs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=220G
#SBATCH --time=10-00:00:00

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python main.py
