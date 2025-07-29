#!/bin/bash
#SBATCH --job-name=Data Generalization
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:rtx3090:1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00
#SBATCH --qos=job_gpu
#SBATCH --constraint=ntasks-per-node=1

module load Anaconda3
eval "$(conda shell.bash hook)"
conda activate data_aug
python -m data_generalization.date_normalizer
