#!/bin/bash
#FLUX: --job-name=parallel_onenode_v2
#FLUX: -n=4
#FLUX: --queue=sla-prio
#FLUX: -t=14400
#FLUX: --urgency=16

echo "Starting job $SLURM_JOB_NAME"
echo "Job id: $SLURM_JOB_ID"
date
echo "This job was assigned the following nodes"
echo $SLURM_NODELIST
echo "Activing environment with that provides Julia 1.9.2"
source /storage/group/RISE/classroom/astro_528/scripts/env_setup
echo "About to change into $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR            # Change into directory where job was submitted from
date
echo "About to start Julia, using $SLURM_TASKS_PER_NODE worker processes on assigned node"
julia --project=. -p $SLURM_TASKS_PER_NODE parallel_v2.jl
echo "Julia exited"
date
