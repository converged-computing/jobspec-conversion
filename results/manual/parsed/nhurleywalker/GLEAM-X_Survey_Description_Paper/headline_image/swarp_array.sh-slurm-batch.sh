#!/bin/bash
#SBATCH --account=pawsey0272
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=workq
#SBATCH --array=1-4

file=`ls IDR1_XG*fits | head -${SLURM_ARRAY_TASK_ID} | tail -1`
singularity exec $GXCONTAINER swarp -c CAR.swarp.template $file
