#!/bin/bash
#SBATCH --job-name=a2c_mujoco
#SBATCH --output=slurm_logs/a2c_mujoco_%j.txt
#SBATCH --error=slurm_errors/a2c_mujoco_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

export PYTHONPATH='$(dirname $(dirname $PWD))'

current_commit=$(git rev-parse --short HEAD)
project_name="torchrl-example-check-$current_commit"
group_name="a2c_mujoco"
export PYTHONPATH=$(dirname $(dirname $PWD))
python $PYTHONPATH/sota-implementations/a2c/a2c_mujoco.py \
  logger.backend=wandb \
  logger.project_name="$project_name" \
  logger.group_name="$group_name"
exit_status=$?
if [ $exit_status -eq 0 ]; then
  echo "${group_name}_${SLURM_JOB_ID}=success" >>> report.log
else
  echo "${group_name}_${SLURM_JOB_ID}=error" >>> report.log
fi
