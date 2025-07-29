#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=1-12:00:00
#SBATCH --partition=dpart
#SBATCH --qos=high

export WORK_DIR='/scratch0/slurm_${SLURM_JOBID}'
export PYTHONPATH='.:$PYTHONPATH'

set -x
module add cuda gcc/6.3.0
export WORK_DIR="/scratch0/slurm_${SLURM_JOBID}"
export PYTHONPATH=".:$PYTHONPATH"
srun bash -c "mkdir ${WORK_DIR}"
srun rsync -a --exclude="*.out" $WORK_DIR
srun bash -c "cd ${WORK_DIR}"
srun python -u "$@"
srun bash -c "rm -rf ${WORK_DIR}"
