#!/bin/bash
#SBATCH --account=ichec004
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=DevQ

cd $SLURM_SUBMIT_DIR
module load intel/2020u4
module load conda
echo "Starting Dask Cluster"
mpirun --np 21 dask-mpi --scheduler-file scheduler.json --interface ib0
echo "Dask Cluster stopped"
