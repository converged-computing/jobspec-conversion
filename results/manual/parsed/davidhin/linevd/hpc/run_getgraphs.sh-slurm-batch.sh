#!/bin/bash
#SBATCH --job-name=prepros
#SBATCH --output=hpc/logs/prepros_%a.out
#SBATCH --error=hpc/logs/prepros_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=48GB
#SBATCH --time=2-00:00:00
#SBATCH --array=1-100

module load Singularity
singularity exec -H /g/acvt/a1720858/sastvd main.sif python -u sastvd/scripts/getgraphs.py $SLURM_ARRAY_TASK_ID
