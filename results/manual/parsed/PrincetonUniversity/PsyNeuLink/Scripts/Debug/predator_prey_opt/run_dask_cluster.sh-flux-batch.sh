#!/bin/bash
#FLUX: --job-name=pred_prey_search
#FLUX: -n=2
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

module load anaconda intel-mpi/gcc
conda activate psyneulink2
WORKDIR=/scratch/gpfs/dmturner/${SLURM_JOB_ID}
mkdir $WORKDIR
rm scheduler.json
srun dask-mpi --no-nanny --scheduler-file scheduler.json --local-directory $WORKDIR --nthreads 1
rm -rf $WORKDIR
rm scheduler.json
