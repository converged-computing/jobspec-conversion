#!/bin/bash
#SBATCH --job-name=34131
#SBATCH --output=34131.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=40GB
#SBATCH --time=04:00:00

source ../venvs/hammer/bin/activate
module load python/intel/3.8.6
module load openmpi/intel/4.0.5
time python3 hammer-run.py  --envname cn --config configs/cn.yaml --nagents 3 --dru_toggle 0 --meslen 0 --randomseed 34131
