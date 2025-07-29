#!/bin/bash
#SBATCH --job-name=parallelSlurm
#SBATCH --account=PAA0202
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=28

cd $SLURM_SUBMIT_DIR
module load gnu/9.1.0
module load openmpi/1.10.7
module load mkl/2019.0.5
module load R/4.0.2
mpirun -np 1 R --slave < Rmpi.R
hostname
