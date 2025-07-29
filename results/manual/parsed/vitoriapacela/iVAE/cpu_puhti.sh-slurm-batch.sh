#!/bin/bash
#SBATCH --job-name=iVAE
#SBATCH --account=Project_2002842
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=8000
#SBATCH --time=3-00:00:00

module purge
module load pytorch/1.4
srun python3 main.py --config binary-6-2-fast_ica.yaml --n-sims 3 --m 2.0 --s 0
