#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=00:10:00

. ~/.profile
module load gcc/6.1.0
module load openmpi/1.10.2
module load cuDNN/v4.0
module load cuda/7.5.18
unsetenv PYTHONHOME
. ~/.python/python/bin/activate
mpirun cifar10/LBFGS.py
