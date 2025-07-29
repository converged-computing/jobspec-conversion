#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --partition=gpu

ml load py-tensorflow/2.1.0_py36
ml load py-keras/2.3.1_py36
srun python cifar10_resnet.py
