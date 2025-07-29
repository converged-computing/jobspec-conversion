#!/bin/bash
#SBATCH --job-name=train_echomorph
#SBATCH --output=logs/slurm-%x.%j.out
#SBATCH --mail-user=semjon.00@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=16G
#SBATCH --time=2-02:10:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=falcon2

export PYTHONUNBUFFERED='TRUE'

module load any/python/3.8.3-conda
git log -n 1 --pretty=format:"Commit: %H %s%n"
conda activate hypatia
export PYTHONUNBUFFERED=TRUE
python training.py --total_epochs=2 --batch_size=32 --learning_rate=0.0001 --save_time=3600 --no_random_degradation
