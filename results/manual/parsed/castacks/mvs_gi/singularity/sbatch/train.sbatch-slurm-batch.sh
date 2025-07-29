#!/bin/bash
#SBATCH --job-name=t-lightning
#SBATCH --output=job-%A-%a.out
#SBATCH --error=job-%A-%a.err
#SBATCH --mail-user=cpulling@andrew.cmu.edu
#SBATCH --mail-type=ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=v100-32:8
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

srun 'bash' train.job ${SLURM_ARRAY_TASK_ID}
