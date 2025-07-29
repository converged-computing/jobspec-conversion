#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

export SINGULARITY_TMPDIR='/ibex/user/$USER/TMPDIR'
export SINGULARITY_CACHEDIR='/ibex/user/$USER/singularity_cache'

module load singularity
mkdir -p /ibex/user/$USER/singularity_cache /ibex/user/$USER/TMPDIR
export SINGULARITY_TMPDIR=/ibex/user/$USER/TMPDIR
export SINGULARITY_CACHEDIR=/ibex/user/$USER/singularity_cache
singularity build -f --force $PWD/horovod_krccl.sif $PWD/horovod_krccl.def
