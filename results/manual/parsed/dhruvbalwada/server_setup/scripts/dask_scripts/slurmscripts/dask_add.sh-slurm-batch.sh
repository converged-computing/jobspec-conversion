#!/bin/bash
#SBATCH --job-name=dask_worker
#SBATCH --account=geo
#SBATCH --mail-user=jbusecke@princeton.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=16

export XDG_RUNTIME_DIR=''

DASKDIR=~/.dask_tmp
source activate standard
export XDG_RUNTIME_DIR=""
mpirun --n 12 dask-mpi --nthreads 4 --memory-limit 'auto' --interface em1 --no-scheduler --local-directory $DASKDIR
