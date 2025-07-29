#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --qos=shared
#SBATCH --constraint=haswell
#SBATCH --array=0-99

singularity
exec
docker:ddixit/fun4all:eicresearch
shifter ./shifter.sh $SLURM_ARRAY_TASK_ID 100000 0 0 1 0.3 20
