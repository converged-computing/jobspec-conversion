#!/bin/bash
#SBATCH --job-name=vsml
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1,gpu

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
