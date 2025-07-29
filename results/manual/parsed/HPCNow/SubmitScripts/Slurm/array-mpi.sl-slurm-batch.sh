#!/bin/bash
#SBATCH --job-name=JobArray
#SBATCH --account=hpcnow
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=8G
#SBATCH --time=01:00:00
#SBATCH --array=20-180

srun sleep $SLURM_ARRAY_TASK_ID
srun echo running on $(hostname)
module load intel/2015a
srun /sNow/utils/bin/pi_mpi
