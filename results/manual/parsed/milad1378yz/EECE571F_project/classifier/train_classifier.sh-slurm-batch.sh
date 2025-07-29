#!/bin/bash
#SBATCH --job-name=train_classifier
#SBATCH --account=st-sdena-1-gpu
#SBATCH --output=out-train_classifier.txt
#SBATCH --error=err-train_classifier.txt
#SBATCH --mail-user=miladyz@student.ubc.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=32G
#SBATCH --time=2-22:00:00
#SBATCH --constraint=gpu_mem_32

export HOME='/scratch/st-sdena-1/miladyz'

module load gcc/9.4.0 python/3.8.10 py-virtualenv/16.7.6
source /scratch/st-sdena-1/miladyz/env_py3.8.10/bin/activate  
cd $SLURM_SUBMIT_DIR
nvidia-smi
pwd
export HOME="/scratch/st-sdena-1/miladyz"
python train_classifier.py
