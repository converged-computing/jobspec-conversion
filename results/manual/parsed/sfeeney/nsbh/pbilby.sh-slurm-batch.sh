#!/bin/bash
#SBATCH --job-name=NSBH
#SBATCH --output=nsbh.txt
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=4-04:00:00
#SBATCH --constraint=ntasks-per-node=14

export MKL_NUM_THREADS='1'
export MKL_DYNAMIC='FALSE'
export OMP_NUM_THREADS='1'
export MPI_PER_NODE='14'

export MKL_NUM_THREADS="1"
export MKL_DYNAMIC="FALSE"
export OMP_NUM_THREADS=1
export MPI_PER_NODE=14
mpirun python sim_nsbh_analysis_4NS.py
