#!/bin/bash
#SBATCH --job-name=mugi_pipeline
#SBATCH --output=/home/mila/l/le.zhang/scratch/slurm_logs/muginfc-%j.txt
#SBATCH --error=/home/mila/l/le.zhang/scratch/slurm_logs/muginfc-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100l.3
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

module load miniconda/3
conda init
conda activate openflamingo
for irmode in mugisparse
do
    python mugi.py --llm gpt --irmode $irmode
done
