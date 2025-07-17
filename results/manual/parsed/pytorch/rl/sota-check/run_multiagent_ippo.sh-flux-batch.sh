#!/bin/bash
#FLUX: --job-name=marl_ippo
#FLUX: -n=32
#FLUX: --urgency=16

export PYTHONPATH='$(dirname $(dirname $PWD))'

current_commit=$(git rev-parse --short HEAD)
project_name="torchrl-example-check-$current_commit"
group_name="mappo_ippo"
export PYTHONPATH=$(dirname $(dirname $PWD))
python $PYTHONPATH/sota-implementations/multiagent/mappo_ippo.py \
  logger.backend=wandb \
  logger.project_name="$project_name" \
  logger.group_name="$group_name"
exit_status=$?
if [ $exit_status -eq 0 ]; then
  echo "${group_name}_${SLURM_JOB_ID}=success" >> report.log
else
  echo "${group_name}_${SLURM_JOB_ID}=error" >> report.log
fi
