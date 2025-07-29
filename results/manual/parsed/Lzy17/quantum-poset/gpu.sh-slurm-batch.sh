#!/bin/bash
#SBATCH --job-name=posets
#SBATCH --account=use320
#SBATCH --output=poset.o%j.%N
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=6

module purge
module list
printenv
python3 spectrum.py
