#!/bin/bash
#FLUX: --job-name=delicious-onion-8967
#FLUX: --queue=serial
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

set -e
cd $SLURM_SUBMIT_DIR
source julia.env
echo "post-processing RUNDIR $(date)"
bin/julia -Jmakie_postproc.so --project=makie_post_processing/ run_makie_post_processing.jl RUNDIR
echo "finished post-processing RUNDIR $(date)"
