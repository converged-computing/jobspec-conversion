#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ac-rodriguez/zsl_billow/Baselines/LsrGAN/Attribute_based_dataset/train_lsrgan_cub.sh
