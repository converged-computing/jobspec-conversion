#!/bin/bash

# this is a multi-node SLURM script using `accelerate` launcher

#SBATCH --job-name=eval-harness
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1          # crucial - only 1 task per node
#SBATCH --gres=gpu:8                 # EDIT this if it's not 8-gpus per node
#SBATCH --exclusive
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

echo "START TIME: $(date)"

source ~/.bashrc
source activate harness

# auto-fail on any errors in this script
set -eo pipefail

# logging script's variables/commands for future debug needs
set -x

# EDIT the conda evn and any startup scripts
# source /path/to/start-xxx-user # if you have something to preload before the job
# conda activate stas-xxx        # if you have conda env to activate

LOG_PATH="harness_eval_main_log.txt"

# EDIT if it's not 8-gpus per node
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
NUM_PROCESSES=$(expr $NNODES \* $GPUS_PER_NODE)

# define the node 0 hostname:port
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000

# note `\$SLURM_PROCID` we don't want it interpolated till `srun` since otherwise all nodes will get
# 0 and the launcher will hang
#
# same goes for `\$(hostname -s|tr -dc '0-9')` - we want it to interpolate at `srun` time
LAUNCHER=""

model=$1
tasks=$2

echo "MODEL: $model"
echo "TASKS: $tasks"

# EDIT the path+name of the python script and whatever args it needs
export PROGRAM="\
lm_eval \
--model hf \
--model_args pretrained=$model,parallelize=True,trust_remote_code=True \
--tasks $tasks \
--num_fewshot 0 \
--batch_size 8 \
--output_path evals \
--write_out \
--log_samples \
--verbosity DEBUG \
--wandb_args project=lm-eval-harness-integration,job_type=eval,name=$model \
--hf_hub_log_args hub_results_org=yentinglin,hub_repo_name=lm-eval-results,push_results_to_hub=True,push_samples_to_hub=True,public_repo=False \
--seed 42 \
--trust_remote_code \
"

export CMD="$LAUNCHER $PROGRAM"

echo $CMD

# EDIT if you want to redirect /tmp to /scratch (some local SSD path) since /tmp is tiny on compute nodes
# export TMPDIR=/scratch

# EDIT: useful for debug if needed
#
# to debug NCCL issues
# export NCCL_DEBUG=INFO
#
# to unravel async errors w/o the correct traceback - potentially makes everything very slower
# export CUDA_LAUNCH_BLOCKING=1
#
# to force crashing on nccl issues like hanging broadcast
# export NCCL_ASYNC_ERROR_HANDLING=1

# srun error handling:
# --wait=60: wait 60 sec after the first task terminates before terminating all remaining tasks
# --kill-on-bad-exit=1: terminate a step if any task exits with a non-zero exit code
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    --jobid $SLURM_JOB_ID \
    "

# bash -c is needed for the delayed interpolation of env vars to work
srun $SRUN_ARGS bash -c "$CMD" 2>&1 | tee -a $LOG_PATH

echo "END TIME: $(date)"
