#!/bin/bash
#SBATCH --job-name=joaquin-train
#SBATCH --output=logs/train.o%j
#SBATCH --error=logs/train.e%j
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=64,rome

source ~/.bash_profile
init_conda
cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-distances
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/joaquin train -c config.yml -v --mpi
date
