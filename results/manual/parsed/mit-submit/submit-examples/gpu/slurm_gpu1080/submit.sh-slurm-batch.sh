#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=res_%j-%a.txt
#SBATCH --error=err_%j-%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2GB
#SBATCH --time=06:50:00
#SBATCH --partition=submit-gpu1080
#SBATCH --array=1-32

source /home/submit/freerc/.bashrc
conda activate dask
hostname
nvidia-smi
python cuda_test.py $1 -v $SLURM_ARRAY_TASK_ID
nvidia-smi
