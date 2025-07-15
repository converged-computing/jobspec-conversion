#!/bin/bash
#FLUX: --job-name=conspicuous-lamp-3667
#FLUX: -n=4
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --priority=16

export SINGULARITY_BINDPATH='/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME'
export SINGULARITYENV_PREPEND_PATH='/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin'
export SINGULARITYENV_XDG_RUNTIME_DIR=''

module load singularity
container=$1
scheduler_file=$2
export SINGULARITY_BINDPATH=/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME
export SINGULARITYENV_PREPEND_PATH=/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin
export SINGULARITYENV_XDG_RUNTIME_DIR=""
mempcpu=$SLURM_MEM_PER_CPU
memlim=$(echo $SLURM_CPUS_PER_TASK*$mempcpu*0.98 | bc)
echo Memory limit is $memlim
echo starting $SLURM_NTASKS workers with $SLURM_CPUS_PER_TASK CPUs each
srun --export=ALL -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK \
singularity exec $container \
dask-worker --scheduler-file $scheduler_file --nthreads $SLURM_CPUS_PER_TASK --memory-limit ${memlim}M 
