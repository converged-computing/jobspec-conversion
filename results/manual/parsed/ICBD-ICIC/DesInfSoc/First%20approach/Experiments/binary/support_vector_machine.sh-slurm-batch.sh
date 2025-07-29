#!/bin/bash
#SBATCH --job-name=itrust-support_vector_machine
#SBATCH --output=outputs/support_vector_machine-%A-%a.out
#SBATCH --error=errors/support_vector_machine-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=7-00:00:00
#SBATCH --array=28,30,31,32,34,36

source ../.experiments_env/bin/activate
srun python support_vector_machine.py ${SLURM_ARRAY_TASK_ID} context_ONLY-ACTION_K3_H4_P12-BINARY
