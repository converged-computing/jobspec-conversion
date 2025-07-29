#!/bin/bash
#SBATCH --job-name=dask-workers
#SBATCH --output=dask-workers.%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=24

export MODULEPATH='/share/apps/compute/modulefiles/applications:$MODULEPATH'

export MODULEPATH=/share/apps/compute/modulefiles/applications:$MODULEPATH
module load anaconda
ibrun --npernode=1 dask-worker --scheduler-file ~/.dask_scheduler.json
