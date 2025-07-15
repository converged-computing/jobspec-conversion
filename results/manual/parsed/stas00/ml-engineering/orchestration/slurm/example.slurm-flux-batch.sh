#!/bin/bash
#FLUX: --job-name=example-job
#FLUX: -N=2
#FLUX: -c=96
#FLUX: --exclusive
#FLUX: --queue=xyz-cluster
#FLUX: -t=600
#FLUX: --urgency=16

export LAUNCHER='python -u -m torch.distributed.run \'
export NCCL_ASYNC_ERROR_HANDLING='1'

set -x -e
source /path/to/start-xxx-user # if you have something to preload before the job
conda activate stas-xxx        # if you have conda env to activate
echo "START TIME: $(date)"
LOG_PATH="main_log.txt"
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
export LAUNCHER="python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv_backend c10d \
    --max_restarts 0 \
    --role `hostname -s`: \
    --tee 3 \
    "
CMD="\
torch-distributed-gpu-test.py \
"
echo $CMD
export NCCL_ASYNC_ERROR_HANDLING=1
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER --node_rank \$SLURM_PROCID --role \$SLURMD_NODENAME: $CMD" 2>&1 | tee -a $LOG_PATH
echo "END TIME: $(date)"
