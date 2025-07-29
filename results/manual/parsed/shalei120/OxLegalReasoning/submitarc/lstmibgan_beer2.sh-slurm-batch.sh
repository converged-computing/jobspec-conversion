#!/bin/bash
#SBATCH --job-name=LegalReasoning
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load gpu/cuda/9.2.148
module load python/anaconda3/5.0.1
echo $PWD
python3 main_beer.py -m lstmibgan -a 2 > slurm-beermodel-$SLURM_JOB_ID.out
