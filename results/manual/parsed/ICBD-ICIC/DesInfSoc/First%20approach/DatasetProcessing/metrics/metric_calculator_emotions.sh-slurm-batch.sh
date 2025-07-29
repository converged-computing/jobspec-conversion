#!/bin/bash
#SBATCH --job-name=itrust-emotions
#SBATCH --output=outputs/emotions-%A-%a.out
#SBATCH --error=errors/emotions-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00
#SBATCH --array=0-14

source .emotions_env/bin/activate
srun python metric_calculator_emotions.py ${SLURM_ARRAY_TASK_ID} 
