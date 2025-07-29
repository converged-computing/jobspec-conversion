#!/bin/bash
#SBATCH --output=slurm_log/%j_out.txt
#SBATCH --error=slurm_log/%j_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu

CUDA_VISIBLE_DEVICES=1 python evaluate.py --save_path result_imgs_pas100
