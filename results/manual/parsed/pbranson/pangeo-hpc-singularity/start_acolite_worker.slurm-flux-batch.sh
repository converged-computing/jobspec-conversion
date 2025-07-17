#!/bin/bash
#FLUX: --job-name=acolite-worker
#FLUX: -n=10
#FLUX: -t=3600
#FLUX: --urgency=16

export SINGULARITY_BINDPATH='/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME'
export SINGULARITYENV_PREPEND_PATH='/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin'
export SINGULARITYENV_XDG_RUNTIME_DIR=''
export SINGULARITYENV_DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE='False'
export SINGULARITYENV_DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE='False'

module load singularity
container=$MYSCRATCH/../pangeo-latest.sif
scheduler_file=$MYSCRATCH/scheduler.json
export SINGULARITY_BINDPATH=/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME
export SINGULARITYENV_PREPEND_PATH=/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin
export SINGULARITYENV_XDG_RUNTIME_DIR=""
export SINGULARITYENV_DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE=False
export SINGULARITYENV_DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE=False
mempcpu=$SLURM_MEM_PER_CPU
memlim=$(echo $SLURM_CPUS_PER_TASK*$mempcpu*1.2 | bc)
echo Memory limit is $memlim
echo starting $SLURM_NTASKS workers with $SLURM_CPUS_PER_TASK CPUs each
srun --export=ALL -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK \
singularity exec $container \
dask-worker --scheduler-file $scheduler_file --nthreads $SLURM_CPUS_PER_TASK --memory-limit auto  
