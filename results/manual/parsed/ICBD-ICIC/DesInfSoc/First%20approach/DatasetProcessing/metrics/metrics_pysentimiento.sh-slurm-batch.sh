#!/bin/bash
#SBATCH --job-name=itrust-sentiments
#SBATCH --output=outputs2/sentiments-%A-%a.out
#SBATCH --error=errors2/sentiments-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00
#SBATCH --array=0-58

source .sentiments_env/bin/activate
srun python metrics_pysentimiento.py ${SLURM_ARRAY_TASK_ID}
