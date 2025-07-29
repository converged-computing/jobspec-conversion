#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --constraint=V100

export LR='0.0005 # CNN'

source ~/.bashrc
conda activate ncar
module load gcc openmpi/gcc cudatoolkit
export LR=0.0005 # CNN
srun --cpus-per-task 6 --ntasks-per-node 8 -N 1 -u python pytorch_eke.py --lr $LR \
     --log-interval 1000 --model 'resnet' --batch-size 512 --epochs 100 \
     --weighted-sampling
