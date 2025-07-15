#!/bin/bash
#FLUX: --job-name=inkid
#FLUX: --priority=16

module load ccs/singularity
if [ -z "$SLURM_ARRAY_TASK_ID" ]; then
    time singularity run --nv --overlay inkid.overlay inkid.sif inkid-train-and-predict "$@"
else
    time singularity run --nv --overlay inkid.overlay inkid.sif inkid-train-and-predict "$@" --cross-validate-on $SLURM_ARRAY_TASK_ID
fi
