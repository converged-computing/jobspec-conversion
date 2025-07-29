#!/bin/bash
#SBATCH --job-name=itrust-random_forest
#SBATCH --output=outputs/random_forest-%A-%a.out
#SBATCH --error=errors/random_forest-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:10:00
#SBATCH --array=28,30,31,32,34,36

features="$1"
source ../../.experiments_env/bin/activate
srun python random_forest.py ${SLURM_ARRAY_TASK_ID} context_SPREAD20_K3_H4_P12-BINARY "$features"
