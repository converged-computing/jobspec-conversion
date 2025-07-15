#!/bin/bash
#FLUX: --job-name=vsml
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=14400
#FLUX: --priority=16

if [ -n "$WANDB_DEPENDENCY" ]
then
    export WANDB_RESUME='must'
    if [ -n "$SLURM_ARRAY_JOB_ID" ]
    then
        export WANDB_RUN_ID=`cat wandb-run-"$WANDB_DEPENDENCY"_"$SLURM_ARRAY_TASK_ID"`
    else
        export WANDB_RUN_ID=`cat wandb-run-"$WANDB_DEPENDENCY"`
    fi
fi
echo "Activate venv"
source ~/path/to/venv/bin/activate
echo "Activate wandb"
sed -i '/^disabled = true/d' wandb/settings
sed -i '/^mode = offline/d' wandb/settings
echo "Run job"
if [[ "$@" == *"wandb agent"* ]]
then
  eval "$@"
else
  srun -X --wait=30 "$@"
fi
