#!/bin/bash
#SBATCH --job-name=dask_host
#SBATCH --account=geo
#SBATCH --mail-user=jbusecke@princeton.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=16

export XDG_RUNTIME_DIR=''

DASKDIR=~/.dask_tmp
rm -r $DASKDIR/worker*
source activate standard
export XDG_RUNTIME_DIR=""
rm -f scheduler.json
mpirun --np 4 dask-mpi --nthreads 4 --memory-limit 'auto' --bokeh-port 7771 --interface ib0 --local-directory $DASKDIR
