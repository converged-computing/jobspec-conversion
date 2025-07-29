#!/bin/bash
#SBATCH --job-name=xsf_mpi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=25-00:00:00
#SBATCH --partition=wzhcnormal
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=40

export PATH='~/soft/miniconda/bin:$PATH'

export PATH="~/soft/miniconda/bin:$PATH"
source activate pytorch
python pre_train.py
mpiexec -n 40 python main.py
