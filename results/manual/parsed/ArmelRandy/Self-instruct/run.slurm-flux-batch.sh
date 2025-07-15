#!/bin/bash
#FLUX: --job-name=self-instruct
#FLUX: -c=48
#FLUX: --exclusive
#FLUX: --queue=production-cluster
#FLUX: --priority=16

export WANDB_PROJECT='test'
export HF_DATASETS_CACHE='/fsx/armel/.cache'
export LAUNCHER='python3 -u -m torch.distributed.run \'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_PROTO='simple'
export RDMAV_FORK_SAFE='1'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_PROVIDER='efa'
export FI_LOG_LEVEL='1'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='ens'
export CUDA_HOME='/usr/local/cuda-11.6'
export LD_PRELOAD='$CUDA_HOME/lib/libnccl.so'
export LD_LIBRARY_PATH='$CUDA_HOME/efa/lib:$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH'

set -x -e
source /admin/home/armel/.bashrc
conda activate finetune
echo "START TIME: $(date)"
GPUS_PER_NODE=8
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
NNODES=$SLURM_NNODES
NODE_RANK=$SLURM_PROCID 
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
export WANDB_PROJECT=test
export HF_DATASETS_CACHE="/fsx/armel/.cache"
PATH_TO_LOG=/fsx/armel/Self-instruct/logs/
LOG_PATH=$PATH_TO_LOG/test_log.txt
CMD=" \
    main.py \
    --seed_tasks_path="data/code_tasks.jsonl" \
    --output_data_path data/bi/code_llama_34b/output.jsonl \
    --num_instructions_to_generate 20000 \
    --template_name better \
    --format 2 \
    --model_name_or_path="codellama/CodeLlama-34b-hf" \
    --num_prompt_instructions 8 \
    --request_batch_size 8 \
    --num_prompt_synthetic_instructions 2 \
    --max_new_tokens 4096 \
    --temperature 0.8 \
    --top_p 0.95 \
    --num_beams 1 \
    --repetition_penalty 1.2 \
    --threshold 0.7 \
    --seed 42 \
    --keep_programming \
"
export LAUNCHER="python3 -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv_backend c10d \
    --max_restarts 0 \
    --tee 3 \
    "
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_PROTO=simple
export RDMAV_FORK_SAFE=1
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1
export FI_PROVIDER=efa
export FI_LOG_LEVEL=1
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=ens
export CUDA_HOME=/usr/local/cuda-11.6
export LD_PRELOAD=$CUDA_HOME/lib/libnccl.so
export LD_LIBRARY_PATH=$CUDA_HOME/efa/lib:$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER $CMD"
echo "END TIME: $(date)"
