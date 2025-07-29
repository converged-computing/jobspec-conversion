#!/bin/bash
#SBATCH --job-name=ex1_jobarray
#SBATCH --account=ebf11-fa23
#SBATCH --output=ex1_jobarray_%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=00:05:00
#SBATCH --partition=sla-prio
#SBATCH --array=1-10%5

echo "Starting job $SLURM_JOB_NAME"
echo "Job id: $SLURM_JOB_ID"
date
echo "Activing environment with that provides Julia 1.9.2"
source /storage/group/RISE/classroom/astro_528/scripts/env_setup
echo "About to change into $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR            # Change into directory where job was submitted from
date
echo "About to start Julia"
julia --project=. ex1_job_array.jl $SLURM_ARRAY_TASK_ID 
echo "Julia exited"
date
