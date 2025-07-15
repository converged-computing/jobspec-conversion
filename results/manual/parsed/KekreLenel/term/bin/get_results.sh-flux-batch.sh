#!/bin/bash
#FLUX: --job-name=term
#FLUX: -t=14340
#FLUX: --priority=16

module load julia/1.9.1
srun --export=ALL julia -t $NUM_THREADS run.jl $SLURM_ARRAY_TASK_ID "della"
