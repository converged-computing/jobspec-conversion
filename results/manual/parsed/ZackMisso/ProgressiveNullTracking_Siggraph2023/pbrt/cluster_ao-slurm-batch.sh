#!/bin/bash
#SBATCH --job-name={job_id}
#SBATCH --account=jarosz-lab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-10

./pbrt --experiment ao_prog ${SLURM_ARRAY_TASK_ID}
