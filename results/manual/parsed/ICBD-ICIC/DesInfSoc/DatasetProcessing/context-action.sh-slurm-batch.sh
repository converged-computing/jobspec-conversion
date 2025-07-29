#!/bin/bash
#SBATCH --job-name=itrust-context
#SBATCH --output=outputs/context-%A-%a.out
#SBATCH --error=errors/context-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00
#SBATCH --array=0-21

source .context_env/bin/activate
srun python context-action.py ${SLURM_ARRAY_TASK_ID}
