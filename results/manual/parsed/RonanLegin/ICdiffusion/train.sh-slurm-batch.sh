#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=128G
#SBATCH --time=23:30:00
#SBATCH --partition=gpu
#SBATCH --constraint=h100

export MODULEPATH='/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH'

module purge
export MODULEPATH=/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH
module load modules/2.1 cuda/12.0 cudnn/cuda12-8.8.0
source ~/envs/score_pytorch_h100/bin/activate
python train.py
