#!/bin/bash
#SBATCH --job-name=params
#SBATCH --output=params.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00

module load Python/3.7.4-GCCcore-8.3.0
pip3 install --user datasets transformers carbontracker deepspeed
pip3 install --user torch torchvision pymongo
python3 opt_csv.py $SLURM_JOB_ID $1
