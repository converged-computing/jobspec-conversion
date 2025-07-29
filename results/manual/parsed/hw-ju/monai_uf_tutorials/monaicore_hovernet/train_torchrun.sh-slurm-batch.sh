#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=8
#SBATCH --mem=64gb
#SBATCH --time=01:00:00
#SBATCH --partition=hpg-ai
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

export NCCL_DEBUG='INFO'
export TORCH_DISTRIBUTED_DEBUG='DETAIL'
export NCCL_ASYNC_ERROR_HANDLING='1'

module load singularity
export NCCL_DEBUG=INFO
export TORCH_DISTRIBUTED_DEBUG=DETAIL
export NCCL_ASYNC_ERROR_HANDLING=1
TRAINING_SCRIPT="$(realpath "$HOME/monai_uf_tutorials/monaicore_hovernet/training.py")"
TRAINING_CMD="$TRAINING_SCRIPT \
--stage=0 \
--ep=3 \
--bs=16 \
--log-dir=./logs \
--root=/mnt/Prepared"
PYTHON_PATH="singularity exec --nv \
--bind /blue/vendor-nvidia/hju/data/hovernet_data/CoNSeP:/mnt \
/blue/vendor-nvidia/hju/monaicore1.1.0"
PT_LAUNCH_UTILS_PATH=$HOME/monai_uf_tutorials/monaicore_hovernet/util_multigpu
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
