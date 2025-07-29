#!/bin/bash
#SBATCH --job-name=test_mistral
#SBATCH --output=logs/slurm.%j.out
#SBATCH --error=logs/slurm.%j.err
#SBATCH --mail-user=f20210329@hyderabad.bits-pilani.ac.in
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:30

spack load anaconda3@2022.05
conda init bash
eval "$(conda shell.bash hook)"
conda activate /home/prajna/.conda/envs/mistral
cd /home/prajna/mistral_finetune
python finetune_02.py
