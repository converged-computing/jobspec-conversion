#!/bin/bash
#FLUX: --job-name=dask-worker
#FLUX: -N=2
#FLUX: -n=6
#FLUX: --queue=debugq
#FLUX: -t=3600
#FLUX: --urgency=16

export SINGULARITY_BINDPATH='/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME'
export SINGULARITYENV_PREPEND_PATH='/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin'
export SINGULARITYENV_XDG_RUNTIME_DIR=''

module load singularity
container=$MYSCRATCH/../pangeo-latest.sif
scheduler_file=$MYSCRATCH/scheduler.json
memlim=20000
numworkers=$SLURM_NTASKS
export SINGULARITY_BINDPATH=/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME
export SINGULARITYENV_PREPEND_PATH=/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin
export SINGULARITYENV_XDG_RUNTIME_DIR=""
echo Memory limit is $memlim
echo starting $SLURM_NTASKS workers with $SLURM_CPUS_PER_TASK CPUs each
srun --export=ALL -N $SLURM_JOB_NUM_NODES -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK \
    singularity exec $container \
    dask-worker --scheduler-file $scheduler_file --nthreads $SLURM_CPUS_PER_TASK --memory-limit ${memlim}M
