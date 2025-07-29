#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --mem=250000
#SBATCH --time=4-04:00:00
#SBATCH --partition=parallel
#SBATCH --constraint=ntasks-per-node=1

export SLURM_MPI_TYPE='pmi2'
export OMP_NUM_THREADS='28'
export MKL_NUM_THREADS='28'

export SLURM_MPI_TYPE=pmi2
export OMP_NUM_THREADS=28
export MKL_NUM_THREADS=28
module load gcc-5.4.0/boost-1.55.0-openmpi-1.10.3 
source /home/zhcui/.bashrc
srun hostname
ulimit -l unlimited
python ./hub2d.ti.py 4.0 . 0.9
