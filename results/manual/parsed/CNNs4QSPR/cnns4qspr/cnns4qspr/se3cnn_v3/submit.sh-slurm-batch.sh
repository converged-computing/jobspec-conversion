#!/bin/bash
#SBATCH --job-name=1.0CPUscale
#SBATCH --account=stf
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:P100:1
#SBATCH --mem=120G
#SBATCH --time=3-18:00:00

source ~/.login
module load icc_17-impi_2017
module load cuda/10.1.105_418.39
mpiexec -np 2 python model_analysis.py --model SE3ResNet34Small --data-filename cath_3class_ca.npz --training-epochs 100 --batch-size 8 --restore-checkpoint-filename trial_8_latest.ckpt
