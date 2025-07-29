#!/bin/bash
#SBATCH --job-name=ImageNet_SGV
#SBATCH --account=conf-gpu-2020.11.23
#SBATCH --output=logs/ImageNet_SGV.%J.out
#SBATCH --error=logs/ImageNet_SGV.%J.err
#SBATCH --mail-user=alfarrm@kaust.edu.sa
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=04:00:00
#SBATCH --partition=batch
#SBATCH --constraint=ref_32T
#SBATCH --array=[1-500]

source activate upd_pt
nvidia-smi
python main.py \
--checkpoint runs/baseline \
--num-chunk ${SLURM_ARRAY_TASK_ID} \
--chunks 500 --eps 0.00784 --experiment imagenet_nominal_training
