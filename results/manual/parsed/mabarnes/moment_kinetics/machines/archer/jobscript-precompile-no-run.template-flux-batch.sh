#!/bin/bash
#FLUX: --job-name=hanky-peas-6589
#FLUX: -n=16
#FLUX: --queue=serial
#FLUX: -t=3600
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

set -e
cd $SLURM_SUBMIT_DIR
source julia.env
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
echo "precompiling $(date)"
bin/julia --project -O3 --check-bounds=no precompile-no-run.jl
echo "finished! $(date)"
