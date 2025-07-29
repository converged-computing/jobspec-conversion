#!/bin/bash
#SBATCH --job-name=KFInSAR
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=0
#SBATCH --time=5-08:00:00
#SBATCH --constraint=ntasks-per-node=15

export OMP_NUM_THREADS='8'

source ~/.bashrc
export OMP_NUM_THREADS=8
mpirun -n 30 python -u kfts.py -c configs/refconfigfile.ini
echo Time is `date`
