#!/bin/bash
#SBATCH --job-name=sigmasep
#SBATCH --output=/dev/shm/jmooij1/sigmasep/log/sigmasep-%a.stdout
#SBATCH --error=/dev/shm/jmooij1/sigmasep/log/sigmasep-%a.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --array=1-300

python experiment.py $SLURM_ARRAY_TASK_ID
