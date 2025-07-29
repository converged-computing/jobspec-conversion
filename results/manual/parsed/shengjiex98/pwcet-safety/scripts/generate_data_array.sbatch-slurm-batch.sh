#!/bin/bash
#FLUX: --job-name=pwcet-safety-array
#FLUX: -c=16
#FLUX: --queue=general
#FLUX: -t=3600
#FLUX: --urgency=16

echo "SLURM_ARRAY_JOB_ID: $SLURM_ARRAY_JOB_ID."
echo "SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID"
echo "Executing on the machine:" $(hostname)
module purge
module use $HOME/modulefiles
module add julia/1.10.0
echo "Start running Julia: " $(date)
SECONDS=0
(set -x; julia --project --threads=16 generate_data_ewb.jl)
echo "End running Julia: " $(date)
echo "Elapsed time: $SECONDS"
