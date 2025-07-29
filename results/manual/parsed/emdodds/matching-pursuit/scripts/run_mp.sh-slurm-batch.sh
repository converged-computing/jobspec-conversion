#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=cortex_k40

export MODULEPATH='/global/software/sl-6.x64_64/modfiles/apps:$MODULEPATH'

cd /global/home/users/edodds/matching-pursuit
export MODULEPATH=/global/software/sl-6.x64_64/modfiles/apps:$MODULEPATH
module load ml/tensorflow/0.12.1
python scripts/fit_mp.py
