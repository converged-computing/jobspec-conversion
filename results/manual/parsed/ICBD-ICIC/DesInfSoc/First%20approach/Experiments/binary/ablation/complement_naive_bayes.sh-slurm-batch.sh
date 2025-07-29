#!/bin/bash
#SBATCH --job-name=itrust-complement_naive_bayes
#SBATCH --output=outputs/complement_naive_bayes-%A-%a.out
#SBATCH --error=errors/complement_naive_bayes-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=7-00:00:00
#SBATCH --array=28,30,32,31,34,36

source ../../.experiments_env/bin/activate
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY no-personality
