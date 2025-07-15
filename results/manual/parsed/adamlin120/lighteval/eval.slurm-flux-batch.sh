#!/bin/bash
#FLUX: --job-name=eval_llm
#FLUX: --exclusive
#FLUX: --queue=defq
#FLUX: --priority=16

export PROGRAM='\'
export CMD='$LAUNCHER $PROGRAM'

echo "START TIME: $(date)"
source ~/.bashrc
source activate lighteval
set -eo pipefail
set -x
LOG_PATH="main_log.txt"
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
NUM_PROCESSES=$(expr $NNODES \* $GPUS_PER_NODE)
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
LAUNCHER="python -u -m accelerate.commands.launch \
    --rdzv_conf "rdzv_backend=c10d,rdzv_endpoint=$MASTER_ADDR:$MASTER_PORT" \
    --main_process_ip $MASTER_ADDR \
    --main_process_port $MASTER_PORT \
    --machine_rank \$SLURM_PROCID \
    --num_machines $NNODES \
    --num_processes 1 \
    --role \$(hostname -s|tr -dc '0-9'): --tee 3 \
"
export PROGRAM="\
    run_evals_accelerate.py \
    --model_args "pretrained=${1},trust_remote_code=True" \
    --override_batch_size 1 \
    --output_dir="./evals/" \
    --tasks tasks_examples/open_llm_leaderboard_tasks.txt \
    --model_parallel \
    --use_chat_template \
"
    #--tasks tasks_examples/twllm_eval.txt \
    #--custom_tasks "community_tasks/twllm_eval.py" \
export CMD="$LAUNCHER $PROGRAM"
echo $CMD
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    --jobid $SLURM_JOB_ID \
    "
srun $SRUN_ARGS bash -c "$CMD" 2>&1 | tee -a $LOG_PATH
echo "END TIME: $(date)"
