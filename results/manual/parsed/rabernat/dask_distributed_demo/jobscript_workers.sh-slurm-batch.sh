#!/bin/bash
#SBATCH --job-name=worker
#SBATCH --account=ocp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --exclusive
#SBATCH --array=0-4

df /local
LDIR="/local/dask-worker-dir-$$"
source activate dask_distributed
dask-worker --memory-limit 100e9 --nthreads 4 --local-directory $LDIR \
       	--scheduler-file $HOME/.dask_schedule_file.json --interface ib0
