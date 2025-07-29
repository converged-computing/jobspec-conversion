#!/bin/bash
#SBATCH --output=/d/hpc/home/go7745/4/procesi/Database/%a.db
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=0-9

srun /d/hpc/home/go7745/4/procesi/grpc/grpc -s localhost -p 8100 -id $SLURM_ARRAY_TASK_ID -n $SLURM_ARRAY_TASK_COUNT
