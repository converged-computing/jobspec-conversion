#!/bin/bash
#FLUX: --job-name=red-cherry-0448
#FLUX: -c=4
#FLUX: --gpus-per-task=2
#FLUX: --exclusive
#FLUX: --queue=hpg-ai
#FLUX: -t=14400
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export TORCH_DISTRIBUTED_DEBUG='DETAIL'
export NCCL_ASYNC_ERROR_HANDLING='1'

export NCCL_DEBUG=INFO
export TORCH_DISTRIBUTED_DEBUG=DETAIL
export NCCL_ASYNC_ERROR_HANDLING=1
TRAINING_SCRIPT="$(realpath "$HOME/run_monaicore/dynunet/dynunet_pipeline/train.py")"
TRAINING_CMD="$TRAINING_SCRIPT \
-root_dir /mnt \
-datalist_path /mnt/dynunet/config/ \
-fold 0 \
-train_num_workers 4 \
-interval 1 \
-num_samples 1 \
-learning_rate 1e-1 \
-max_epochs 5 \
-task_id 04 \
-pos_sample_num 2 \
-expr_name baseline \
-tta_val True \
-multi_gpu True"
PYTHON_PATH="singularity exec --nv \
--bind /blue/vendor-nvidia/hju/data/MSD:/mnt \
/blue/vendor-nvidia/hju/monaicore1.0.1 python3" 
PT_LAUNCH_UTILS_PATH=$HOME/run_monaicore/multigpu/util_multigpu
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
