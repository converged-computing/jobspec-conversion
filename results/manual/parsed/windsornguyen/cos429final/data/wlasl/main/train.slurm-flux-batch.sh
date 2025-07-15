#!/bin/bash
#FLUX: --job-name=a2a
#FLUX: -c=12
#FLUX: --queue=pli
#FLUX: -t=10800
#FLUX: --urgency=16

export WANDB_ENTITY='windsornguyen'
export WANDB_API_KEY='17dce35b188763800b6e9a443a761a1e713d87ab'
export WANDB_PROJECT='compass-finetune'
export WANDB_LOG_MODEL='checkpoint'

if [[ -z $SLURM_NNODES ]] || [[ -z $SLURM_NTASKS_PER_NODE ]]; then
    echo "SLURM environment variables not set. Assuming standalone setup."
    WORLD_SIZE=1
else
    # Calculate WORLD_SIZE safely
    WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
    echo "WORLD_SIZE=$WORLD_SIZE"
fi
if [[ -z $SLURM_JOB_NODELIST ]]; then
    echo "SLURM_JOB_NODELIST not set. Using localhost as MASTER_ADDR."
    MASTER_ADDR="localhost"
else
    master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
    if [[ -z $master_addr ]]; then
        echo "Failed to determine MASTER_ADDR. Exiting."
        exit 1
    fi
    MASTER_ADDR=$master_addr
    echo "MASTER_ADDR=$MASTER_ADDR"
fi
if [[ -z $SLURM_JOBID ]]; then
    export MASTER_PORT=$(shuf -i 2000-65000 -n 1)
else
    export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
fi
echo "MASTER_PORT=$MASTER_PORT"
export WANDB_ENTITY=windsornguyen
export WANDB_API_KEY=17dce35b188763800b6e9a443a761a1e713d87ab
export WANDB_PROJECT=compass-finetune
export WANDB_LOG_MODEL=checkpoint
echo "WandB and Slurm Environment Variables:"
printenv | grep -E 'WANDB|SLURM' | sort
if [ -z "$WANDB_API_KEY" ]; then
  echo "WANDB_API_KEY: Not found"
else
  echo "WANDB_API_KEY: Found"
fi
echo "Running on host $(hostname)"
if command -v nvidia-smi &>/dev/null; then
    echo "GPU Information:"
    nvidia-smi --query-gpu=gpu_name --format=csv,noheader
else
    echo "CUDA not installed or GPUs not available."
fi
module purge
module load anaconda3/2024.2
module load gcc-toolset/10
module load cudatoolkit/12.2
conda activate cos429
if [[ "$WORLD_SIZE" -eq "1" ]]; then
    # Standalone mode
    cmd="torchrun --standalone --master_port=$MASTER_PORT"
else
    # Distributed mode with nproc_per_node set from SLURM
    if [ -z "$SLURM_NTASKS_PER_NODE" ]; then
        echo "SLURM_NTASKS_PER_NODE is not set. Exiting."
        exit 1
    fi
    cmd="torchrun --nproc_per_node=$SLURM_NTASKS_PER_NODE --master_port=$MASTER_PORT"
fi
python train.py
