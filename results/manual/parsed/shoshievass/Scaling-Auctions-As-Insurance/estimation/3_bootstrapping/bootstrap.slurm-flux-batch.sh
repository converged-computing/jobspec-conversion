#!/bin/bash
#FLUX: --job-name=conspicuous-arm-4810
#FLUX: --priority=16

module load julia/1.7.3
module load knitro/12.1.1
echo $(which julia);
echo $(which knitro);
mkdir -p logs
srun julia --project CARA_bootstrap_cluster.jl $SLURM_ARRAY_TASK_ID > logs/$SLURM_ARRAY_TASK_ID.txt
