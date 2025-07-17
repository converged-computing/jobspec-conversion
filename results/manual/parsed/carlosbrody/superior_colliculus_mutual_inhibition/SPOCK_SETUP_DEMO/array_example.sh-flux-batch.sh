#!/bin/bash
#FLUX: --job-name=array-example
#FLUX: --queue=Brody
#FLUX: -t=600
#FLUX: --urgency=16

module load julia/1.2.0
echo "Slurm Job ID, unique: $SLURM_JOB_ID"
echo "Slurm Array Task ID, relative: $SLURM_ARRAY_TASK_ID"
julia array_example.jl $1 $SLURM_JOB_ID $SLURM_ARRAY_TASK_ID
mv log-array-example-${SLURM_JOB_ID}.out $1/log-array-example-${SLURM_JOB_ID}.out
