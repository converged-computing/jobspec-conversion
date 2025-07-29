#!/bin/bash
#SBATCH --job-name=train
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=k80:1
#SBATCH --mem=12G
#SBATCH --time=1-00:00:00

module load GCC/8.3.0
module load CUDA/10.2.89
cd ~/CSE803FinalProject
conda activate CVProj
WANDB_MODE=online python train.py --gpus=1 --model=SRResNet --batch_size=64
scontrol show job $SLURM_JOB_ID
