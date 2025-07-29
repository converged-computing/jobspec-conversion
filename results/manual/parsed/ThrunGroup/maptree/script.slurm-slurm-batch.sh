#!/bin/bash
#SBATCH --job-name=bdt-map
#SBATCH --account=thrun
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=1-00:00:00
#SBATCH --array=0-51

python -u run_experiment.py -j ${SLURM_ARRAY_TASK_ID}
