#!/bin/bash
#FLUX: --job-name=dqn_atari
#FLUX: -n=32
#FLUX: --priority=16

export PYTHONPATH='$(dirname $(dirname $PWD))'

current_commit=$(git rev-parse --short HEAD)
project_name="torchrl-example-check-$current_commit"
group_name="dqn_atari"
export PYTHONPATH=$(dirname $(dirname $PWD))
python $PYTHONPATH/sota-implementations/dqn/dqn_atari.py \
  logger.backend=wandb \
  logger.project_name="$project_name" \
  logger.group_name="$group_name"
exit_status=$?
if [ $exit_status -eq 0 ]; then
  echo "${group_name}_${SLURM_JOB_ID}=success" >> report.log
else
  echo "${group_name}_${SLURM_JOB_ID}=error" >> report.log
fi
