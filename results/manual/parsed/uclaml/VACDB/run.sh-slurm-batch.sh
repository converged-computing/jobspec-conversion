#!/bin/bash
#SBATCH --job-name=v3
#SBATCH --output=my_job.output
#SBATCH --error=my_job.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=main
#SBATCH --constraint=ntasks-per-node=1

source /etc/profile.d/modules.sh
source ~/.bashrc
mamba activate nrm
srun python3 main.py $SLURM_ARRAY_TASK_ID
