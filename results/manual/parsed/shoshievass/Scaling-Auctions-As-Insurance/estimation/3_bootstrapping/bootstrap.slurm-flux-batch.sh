#!/bin/bash
#FLUX: --job-name=bootstrap
#FLUX: -c=2
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

module load julia/1.7.3
module load knitro/12.1.1
echo $(which julia);
echo $(which knitro);
mkdir -p logs
srun julia --project CARA_bootstrap_cluster.jl $SLURM_ARRAY_TASK_ID > logs/$SLURM_ARRAY_TASK_ID.txt
