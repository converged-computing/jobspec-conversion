#!/bin/bash
#FLUX: --job-name=multinode
#FLUX: -N=4
#FLUX: -c=160
#FLUX: -t=7140
#FLUX: --urgency=16

export GPUS_PER_NODE='4'
export LAUNCHER='accelerate launch \'
export SCRIPT='/accelerate/examples/complete_nlp_example.py'
export SCRIPT_ARGS=' \'
export CMD='$LAUNCHER $PYTHON_FILE $ARGS" '

source activateEnviroment.sh
export GPUS_PER_NODE=4
head_node_ip=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export LAUNCHER="accelerate launch \
    --num_processes $((SLURM_NNODES * GPUS_PER_NODE)) \
    --num_machines $SLURM_NNODES \
    --rdzv_backend c10d \
    --main_process_ip $head_node_ip \
    --main_process_port 29500 \
    "
export SCRIPT="/accelerate/examples/complete_nlp_example.py"
export SCRIPT_ARGS=" \
    --mixed_precision fp16 \
    --output_dir /accelerate/examples/output \
    "
export CMD="$LAUNCHER $PYTHON_FILE $ARGS" 
srun $CMD
