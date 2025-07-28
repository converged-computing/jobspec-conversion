#!/bin/bash
#FLUX: --job-name=multinode_pytorch
#FLUX: -N=2
#FLUX: -n=16
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=hpg-ai
#FLUX: -t=172800
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'

export NCCL_DEBUG=INFO
TRAINING_CMD="unet_training_workflows_slurm.py"
PYTHON_PATH="singularity exec --nv pyt21.07 python3"       
PT_LAUNCH_UTILS_PATH="./"
source "${PT_LAUNCH_UTILS_PATH}/pt_multinode_helper_funcs.sh"
init_node_info
pwd; hostname; date
echo "Primary node: $PRIMARY"
echo "Primary TCP port: $PRIMARY_PORT"
echo "Secondary nodes: $SECONDARIES"
PT_LAUNCH_SCRIPT="run_on_node.sh"
echo "Running \"$TRAINING_CMD\" on each node..."
srun --unbuffered "$PT_LAUNCH_SCRIPT" "${PT_LAUNCH_UTILS_PATH}" "$TRAINING_CMD" "$PYTHON_PATH"
