#!/bin/bash
#SBATCH --account=cs-552
#SBATCH --output=logs/slurm/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --qos=cs-552

module load gcc python 
source ~/venvs/sillystill/bin/activate
pip install -r requirements.txt
deactivate
