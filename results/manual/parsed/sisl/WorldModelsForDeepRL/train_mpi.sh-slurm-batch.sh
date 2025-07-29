#!/bin/bash
#SBATCH --output=mpi/mpi_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=17
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:1
#SBATCH --time=10-00:00:00
#SBATCH --partition=gpu

export DISPLAY=':99.0'

source /etc/profile
module load mpi/openmpi-4.0
module load anaconda/2020a
export DISPLAY=':99.0'
Xvfb :99 -screen 0 1400x900x24 > /dev/null 2>&1 &
mpirun python -B train_a3c.py --env_name CarRacing-v0 --model sac --iter 1 --steps 500000
