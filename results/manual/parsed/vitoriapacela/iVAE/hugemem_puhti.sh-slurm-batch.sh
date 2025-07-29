#!/bin/bash
#SBATCH --job-name=iVAE
#SBATCH --account=Project_2002842
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00
#SBATCH --partition=hugemem

module purge
module load pytorch/1.4
srun python3 main.py --config test-full-ivae-u.yaml --n-sims 1 --m 0.5 --s 0
