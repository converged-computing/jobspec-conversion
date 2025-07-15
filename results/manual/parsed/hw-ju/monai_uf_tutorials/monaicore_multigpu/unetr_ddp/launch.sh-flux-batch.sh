#!/bin/bash
#FLUX: --job-name=adorable-itch-4230
#FLUX: -c=4
#FLUX: --gpus-per-task=4
#FLUX: --exclusive
#FLUX: --queue=hpg-ai
#FLUX: -t=14400
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export TORCH_DISTRIBUTED_DEBUG='DETAIL'
export NCCL_ASYNC_ERROR_HANDLING='1'

module load singularity
export NCCL_DEBUG=INFO
export TORCH_DISTRIBUTED_DEBUG=DETAIL
export NCCL_ASYNC_ERROR_HANDLING=1
TRAINING_SCRIPT="$(realpath "$HOME/monai_uf_tutorials/monaicore_multigpu/unetr_ddp/unetr_btcv_ddp.py")"
TRAINING_CMD="$TRAINING_SCRIPT"
PYTHON_PATH="singularity exec --nv --bind /blue/vendor-nvidia/hju/data/unetr_data:/mnt \
         /blue/vendor-nvidia/hju/monaicore0.8.1 python3" 
PT_LAUNCH_UTILS_PATH=$HOME/monai_uf_tutorials/monaicore_multigpu/util_multigpu
source "${PT_LAUNCH_UTILS_PATH}/pt_multinode_helper_funcs.sh"
init_node_info
pwd; hostname; date
echo "Primary node: $PRIMARY"
echo "Primary TCP port: $PRIMARY_PORT"
echo "Secondary nodes: $SECONDARIES"
PT_LAUNCH_SCRIPT=$(realpath "${PT_LAUNCH_UTILS_PATH}/run_on_node.sh")
echo "Running \"$TRAINING_CMD\" on each node..."
srun --unbuffered "$PT_LAUNCH_SCRIPT" "$(realpath $PT_LAUNCH_UTILS_PATH)" \
    "$TRAINING_CMD" "$PYTHON_PATH"    
