#!/bin/bash
#SBATCH --job-name=resnet50_fc_in
#SBATCH --output=./logs/resnet50_fc_in.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --partition=Pixel
#SBATCH --nodelist=SH-IDC1-10-5-34-166

srun --mpi=pmi2 sh ./run.sh
