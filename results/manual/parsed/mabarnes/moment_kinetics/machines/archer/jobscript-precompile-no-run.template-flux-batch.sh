#!/bin/bash
#FLUX: --job-name=delicious-sundae-3204
#FLUX: -n=16
#FLUX: --queue=serial
#FLUX: -t=3600
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

set -e
cd $SLURM_SUBMIT_DIR
source julia.env
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
echo "precompiling $(date)"
bin/julia --project -O3 --check-bounds=no precompile-no-run.jl
echo "finished! $(date)"
