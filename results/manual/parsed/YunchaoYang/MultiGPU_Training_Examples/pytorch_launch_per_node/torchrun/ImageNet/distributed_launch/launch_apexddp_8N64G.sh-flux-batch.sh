#!/bin/bash
#FLUX: --job-name=tart-hippo-5830
#FLUX: -N=8
#FLUX: -n=8
#FLUX: -c=12
#FLUX: --gpus-per-task=8
#FLUX: --queue=hpg-ai
#FLUX: -t=172800
#FLUX: --urgency=16

export NCCL_DEBUG='WARN #change to INFO if debugging DDP'

module load ngc-pytorch/1.11.0
PYTHON_PATH=python3
TRAINING_SCRIPT=main_amp.py
TRAINING_CMD="$TRAINING_SCRIPT -a resnet50 --b 224 --workers 4 --opt-level O2 ./" 
PT_LAUNCH_UTILS_PATH=$PWD/utils
export NCCL_DEBUG=WARN #change to INFO if debugging DDP
source "${PT_LAUNCH_UTILS_PATH}/pt_multinode_helper_funcs.sh"
init_node_info
echo "Primary node: $PRIMARY"
echo "Primary TCP port: $PRIMARY_PORT"
echo "Secondary nodes: $SECONDARIES"
PT_LAUNCH_SCRIPT="./utils/run_on_node.sh"
echo "Running \"$TRAINING_CMD\" on each node..."
pwd; hostname; date
srun --unbuffered --export=ALL "$PT_LAUNCH_SCRIPT" "${PT_LAUNCH_UTILS_PATH}" "$TRAINING_CMD" "$PYTHON_PATH"
