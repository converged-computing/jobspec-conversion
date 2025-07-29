#!/bin/bash
#SBATCH --job-name=<JOBNAME>
#SBATCH --account=hpc-prf-intexml
#SBATCH --mail-user=<MAIL>
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=00:05:00
#SBATCH --array=0-1

module reset
module load system singularity
singularity exec singularity_container.sif bash -c "./run_in_container.sh $SLURM_ARRAY_TASK_ID"
