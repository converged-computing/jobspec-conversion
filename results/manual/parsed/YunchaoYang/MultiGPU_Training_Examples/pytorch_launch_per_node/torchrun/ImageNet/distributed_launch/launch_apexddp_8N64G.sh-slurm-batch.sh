#!/bin/bash
#SBATCH --account=bala-gatorflow
#SBATCH --output=%x.%j.out
#SBATCH --nodes=8
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=12
#SBATCH --gpus-per-task=8
#SBATCH --mem-per-cpu=1024gb
#SBATCH --time=2-00:00:00
#SBATCH --partition=hpg-ai
#SBATCH --qos=bala-gatorflow
#SBATCH --constraint=ntasks-per-node=1

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
