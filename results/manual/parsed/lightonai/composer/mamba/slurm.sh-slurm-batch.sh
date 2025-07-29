#!/bin/bash
#FLUX: --job-name=mamba
#FLUX: -n=4
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

export WANDB_API_KEY='your-api-key'

export WANDB_API_KEY="your-api-key"
module purge
module load env/release/2023.1
module load CUDA/12.2.0
source ~/.bashrc
conda activate your-env
NODES=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
NNODES=${#NODES[@]}
NODES_ARRAY=($NODES)
HEAD_NODE=${NODES_ARRAY[0]}
MASTER_ADDR=$(srun --nodes=1 --ntasks=1 -w "$HEAD_NODE" hostname --ip-address)
MASTER_PORT=$RANDOM
NPROC=$(nvidia-smi -L | wc -l)
WORLD_SIZE=$((NNODES * NPROC))
echo "Total number of nodes: $NNODES"
echo "Node names: ${NODES[@]}"
echo "Head node: $HEAD_NODE"
function run_composer() {
    srun --nodelist=${NODE} --ntasks=1 composer \
        --world_size ${WORLD_SIZE} \
        --nproc ${NPROC} \
        --node_rank ${NODE_RANK} \
        --master_addr ${MASTER_ADDR} \
        --master_port ${MASTER_PORT} \
        --verbose \
        mamba/train.py
}
NODE_RANK=1
for (( NODE_RANK=1; NODE_RANK<${NNODES}; NODE_RANK++ ))
do
    NODE=${NODES[$NODE_RANK]}
    echo "Run compute node ${NODE} for rank: ${NODE_RANK}"
    run_composer &
done
NODE_RANK=0
NODE=${HEAD_NODE}
echo "Run master node ${NODE} for rank: ${NODE_RANK}"
run_composer
wait
