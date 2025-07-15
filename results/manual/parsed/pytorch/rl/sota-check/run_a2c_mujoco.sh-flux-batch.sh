#!/bin/bash
#FLUX: --job-name=a2c_mujoco
#FLUX: -n=32
#FLUX: --priority=16

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
