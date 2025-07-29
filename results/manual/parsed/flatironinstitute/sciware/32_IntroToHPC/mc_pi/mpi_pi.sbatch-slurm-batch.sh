#!/bin/bash
#SBATCH --output=mpi_pi.log
#SBATCH --error=mpi_pi.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=scc
#SBATCH --constraint=ntasks-per-node=64,ib-icelake

echo $SLURM_JOBID
source load_env.sh
srun python mpi_pi.py 1000000
