#!/bin/bash
#SBATCH --job-name=item2vectrans
#SBATCH --output=1my-output.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --gres=1
#SBATCH --mem=20G
#SBATCH --time=16-00:00:00
#SBATCH --partition=gpu
#SBATCH --nodelist=hpc03

module list
python  src/recsys23/main.py 
