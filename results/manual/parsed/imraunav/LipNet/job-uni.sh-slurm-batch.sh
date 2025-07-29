#!/bin/bash
#SBATCH --job-name=LipNet-uni
#SBATCH --output=output.uni
#SBATCH --mail-user=t22104@students.iitmandi.ac.in
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=16

module load DL-Conda_3.7
source /home/apps/DL/DL-CondaPy3.7/bin/activate torch
cd $SLURM_SUBMIT_DIR
CUDA_VISIBLE_DEVICES=0,1 python train-uni.py
