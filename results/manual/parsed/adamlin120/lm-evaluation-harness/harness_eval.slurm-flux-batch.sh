#!/bin/bash
#FLUX: --job-name=eval-harness
#FLUX: --exclusive
#FLUX: --queue=defq
#FLUX: --priority=16

export PROGRAM='\'
export CMD='$LAUNCHER $PROGRAM'

echo "START TIME: $(date)"
source ~/.bashrc
source activate harness
set -eo pipefail
set -x
LOG_PATH="harness_eval_main_log.txt"
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
NUM_PROCESSES=$(expr $NNODES \* $GPUS_PER_NODE)
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
LAUNCHER=""
model=$1
tasks=$2
echo "MODEL: $model"
echo "TASKS: $tasks"
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
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    --jobid $SLURM_JOB_ID \
    "
srun $SRUN_ARGS bash -c "$CMD" 2>&1 | tee -a $LOG_PATH
echo "END TIME: $(date)"
