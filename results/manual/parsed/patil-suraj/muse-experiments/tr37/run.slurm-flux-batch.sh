#!/bin/bash
#FLUX: --job-name=oai-clip-lbl-smooth-laiona5-resumed-2
#FLUX: -N=4
#FLUX: -c=96
#FLUX: --exclusive
#FLUX: --queue=production-cluster
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='${SLURM_STEP_GPUS:-$SLURM_JOB_GPUS}'
export LAUNCHER='python -u -m torch.distributed.run \'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_PROTO='simple'
export RDMAV_FORK_SAFE='1'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_PROVIDER='efa'
export FI_LOG_LEVEL='1'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='ens'

set -x -e
source /admin/home/suraj/.bashrc
source /fsx/suraj/miniconda3/etc/profile.d/conda.sh
conda activate muse
echo "START TIME: $(date)"
MUSE_REPO=/admin/home/suraj/code/muse
OUTPUT_DIR=/fsx/suraj/oai-clip-lbl-smooth-laiona5-resumed-2
LOG_PATH=$OUTPUT_DIR/main_log.txt
CONFIG_PATH=/admin/home/suraj/code/muse-experiments/tr37/config.yaml
mkdir -p $OUTPUT_DIR
touch $LOG_PATH
pushd $MUSE_REPO
CMD=" \
    $MUSE_REPO/training/train_muse.py config=$CONFIG_PATH \
    experiment.name=$(basename $OUTPUT_DIR) \
    experiment.output_dir=$OUTPUT_DIR \
    "
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
export CUDA_VISIBLE_DEVICES=${SLURM_STEP_GPUS:-$SLURM_JOB_GPUS}
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
export LAUNCHER="python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv_backend c10d \
    --max_restarts 0 \
    --tee 3 \
    "
echo $CMD
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_PROTO=simple
export RDMAV_FORK_SAFE=1
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1
export FI_PROVIDER=efa
export FI_LOG_LEVEL=1
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=ens
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER --node_rank \$SLURM_PROCID --role \$SLURMD_NODENAME: $CMD" 2>&1 | tee $LOG_PATH
