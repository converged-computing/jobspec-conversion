#!/bin/bash
#FLUX: --job-name=muffled-leopard-3855
#FLUX: -t=60
#FLUX: --priority=16

echo This job shares a SLURM array job ID with the parent job: $SLURM_ARRAY_JOB_ID
echo This job has a SLURM job ID: $SLURM_JOBID
echo This job has a unique SLURM array index: $SLURM_ARRAY_TASK_ID
time srun -n 24 --export=all ./darts-mpi $SLURM_ARRAY_TASK_ID
