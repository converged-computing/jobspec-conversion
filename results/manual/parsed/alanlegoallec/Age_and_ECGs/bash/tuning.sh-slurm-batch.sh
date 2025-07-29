#!/bin/bash
#SBATCH --mail-user=alanlegoallec@g.harvard.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --partition=gpu

module load gcc/6.2.0
module load python/3.6.0
module load cuda/10.0
source ~/python_3.6.0/bin/activate
python ../scripts/TS04_tuning.py $1 $2 $3 $4
