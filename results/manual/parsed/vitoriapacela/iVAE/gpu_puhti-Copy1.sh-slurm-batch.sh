#!/bin/bash
#SBATCH --job-name=iVAE
#SBATCH --account=Project_2002842
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=8000
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load pytorch/1.4
srun python3 main.py --config binary-5-adam-Copy7.yaml --n-sims 3 --m 2.0 --s 33 --fix_prior_mean
