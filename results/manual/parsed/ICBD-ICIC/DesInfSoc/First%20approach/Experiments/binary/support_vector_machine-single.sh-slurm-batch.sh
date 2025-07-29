#!/bin/bash
#SBATCH --job-name=itrust-support_vector_machine-single
#SBATCH --output=outputs/support_vector_machine-single-%A-%a.out
#SBATCH --error=errors/support_vector_machine-single-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=8G
#SBATCH --time=7-00:00:00
#SBATCH --array=28

source ../.experiments_env/bin/activate
srun python support_vector_machine-single.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY
