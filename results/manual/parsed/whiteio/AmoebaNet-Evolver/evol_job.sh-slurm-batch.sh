#!/bin/bash
#SBATCH --job-name=AmoebaNetEvolver
#SBATCH --output=job-%j.out
#SBATCH --mail-user=name@email.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=20-20:00:00
#SBATCH --partition=gpu

export PYTHONPATH='$PYTHONPATH:/users/40175159/gridware/share/python/3.6.4/lib/python3.6/site-packages'

module add nvidia-cuda
module add apps/python3
nvidia-smi
export PYTHONPATH=$PYTHONPATH:/users/40175159/gridware/share/python/3.6.4/lib/python3.6/site-packages
python3 main.py --device cuda --population_size 4
