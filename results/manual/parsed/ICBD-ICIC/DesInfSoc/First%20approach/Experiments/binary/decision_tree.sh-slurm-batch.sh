#!/bin/bash
#SBATCH --job-name=itrust-decision_tree
#SBATCH --output=outputs/decision_tree-%A-%a.out
#SBATCH --error=errors/decision_tree-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=7-00:00:00
#SBATCH --array=28,30,31,32,34,36

source ../.experiments_env/bin/activate
srun python decision_tree.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY
