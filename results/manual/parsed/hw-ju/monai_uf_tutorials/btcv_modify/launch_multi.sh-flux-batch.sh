#!/bin/bash
#FLUX: --job-name=chocolate-animal-3898
#FLUX: -c=8
#FLUX: --gpus-per-task=8
#FLUX: --exclusive
#FLUX: --queue=hpg-ai
#FLUX: -t=7200
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export TORCH_DISTRIBUTED_DEBUG='DETAIL'
export NCCL_ASYNC_ERROR_HANDLING='1'

module load singularity
export NCCL_DEBUG=INFO
export TORCH_DISTRIBUTED_DEBUG=DETAIL
export NCCL_ASYNC_ERROR_HANDLING=1
TRAINING_SCRIPT="$(realpath "$HOME/monai_uf_tutorials/btcv_modify/main.py")"
TRAINING_CMD="$TRAINING_SCRIPT \
--distributed \
--logdir=/mnt \
--data_dir=/mnt --json_list=dataset_0.json \
--roi_x=96 --roi_y=96 --roi_z=96 --feature_size=48 \
--batch_size=1 \
--val_every=1 --max_epochs=3 \
--save_checkpoint \
--noamp"
PYTHON_PATH="singularity exec --nv --bind /blue/vendor-nvidia/hju/data/BTCV:/mnt \
         /blue/vendor-nvidia/hju/monaicore0.9.1 python3"
PT_LAUNCH_UTILS_PATH=$HOME/monai_uf_tutorials/monaicore_multigpu/util_multigpu
source "${PT_LAUNCH_UTILS_PATH}/pt_multinode_helper_funcs.sh"
init_node_info
pwd; hostname; date
echo "Primary node: $PRIMARY"
echo "Primary TCP port: $PRIMARY_PORT"
echo "Secondary nodes: $SECONDARIES"
PT_LAUNCH_SCRIPT=$(realpath "${PT_LAUNCH_UTILS_PATH}/run_on_multinode.sh")
echo "Running \"$TRAINING_CMD\" on each node..."
srun --unbuffered "$PT_LAUNCH_SCRIPT" "$(realpath $PT_LAUNCH_UTILS_PATH)" \
    "$TRAINING_CMD" "$PYTHON_PATH"    
