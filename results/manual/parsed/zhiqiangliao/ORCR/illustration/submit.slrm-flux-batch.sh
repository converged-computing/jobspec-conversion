#!/bin/bash
#FLUX: --job-name=chunky-citrus-8477
#FLUX: -c=10
#FLUX: --queue=batch
#FLUX: -t=432000
#FLUX: --urgency=16

echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
cd /scratch/work/liaoz1/papers/WRCNLS/simu/ill2/
module load julia
srun julia -t $SLURM_CPUS_PER_TASK ill.jl
