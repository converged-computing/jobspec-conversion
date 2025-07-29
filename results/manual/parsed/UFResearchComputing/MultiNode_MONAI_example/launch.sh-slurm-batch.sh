#!/bin/bash
#SBATCH --job-name=multinode_pytorch
#SBATCH --output=train.%j.out
#SBATCH --mail-user=<your
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=96gb
#SBATCH --time=2-00:00:00
#SBATCH --partition=hpg-ai
#SBATCH --constraint=ntasks-per-node=8

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
