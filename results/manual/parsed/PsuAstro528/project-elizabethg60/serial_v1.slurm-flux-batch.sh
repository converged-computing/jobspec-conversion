#!/bin/bash
#FLUX: --job-name=serial_v1
#FLUX: --queue=sla-prio
#FLUX: -t=14400
#FLUX: --priority=16

echo "Starting job $SLURM_JOB_NAME"
echo "Job id: $SLURM_JOB_ID"
date
echo "Activing environment with that provides Julia 1.9.2"
source /storage/group/RISE/classroom/astro_528/scripts/env_setup
echo "About to change into $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR            # Change into directory where job was submitted from
date
echo "About to start Julia"
julia --project=. serial_v1.jl
echo "Julia exited"
date
