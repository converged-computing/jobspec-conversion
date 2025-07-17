#!/bin/bash
#FLUX: --job-name=7b_32k
#FLUX: -c=48
#FLUX: --queue=hopper-prod
#FLUX: --urgency=50

export AWS_DEFAULT_REGION='us-east-1'
export USE_FAST='1'
export CUDA_DEVICE_MAX_CONNECTIONS='1'
export FI_PROVIDER='efa'
export FI_EFA_FORK_SAFE='1'
export LAUNCHER='python -u -m torch.distributed.run \'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_DEBUG='WARN  # VERSION, WARN, INFO'
export NCCL_DEBUG_SUBSYS='COLL'

set -x -e
source ~/.bashrc
export AWS_DEFAULT_REGION=us-east-1
source /admin/home/loubna/miniconda3/etc/profile.d/conda.sh
conda activate /fsx/nouamane/miniconda/envs/2-1-cu121
module load cuda/12.1
echo "START TIME: $(date)"
echo "Git commit: $(git rev-parse HEAD)"
echo "printenv:"
printenv
echo "nvidia-smi:"
nvidia-smi
echo "torch version:"
python -m torch.utils.collect_env
BRRR_REPO=/fsx/loubna/projects/brrr
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
if [ -z ${CONFIG_FILE+x} ]; then
    echo "CONFIG_FILE is unset, using default"
else
    echo "CONFIG_FILE is set to '$CONFIG_FILE'"
    # remove yaml extension
    CONFIG_FILE_NAME=${CONFIG_FILE##*/}
    CONFIG_FILE_NAME=${CONFIG_FILE_NAME%.yaml}
    # copy config file to tmp folder
    TMP_CONFIG_FILE=/fsx/loubna/logs/starcoder2/configs/${CONFIG_FILE_NAME}_${SLURM_JOB_ID}.yaml
    echo "Renaming config file to $TMP_CONFIG_FILE"
    # create TMP_CONFIG_FILE folder if it doesn't exist
    mkdir -p $(dirname $TMP_CONFIG_FILE)
    cp $CONFIG_FILE $TMP_CONFIG_FILE
    CONFIG_FILE=$TMP_CONFIG_FILE
fi
export USE_FAST=1
export CUDA_DEVICE_MAX_CONNECTIONS=1
export FI_PROVIDER=efa
export FI_EFA_FORK_SAFE=1
unset FI_EFA_ENABLE_SHM_TRANSFER
unset NCCL_PROTO
CMD=" \
    examples/use_trainer.py \
    --config-file $CONFIG_FILE
    "
export LAUNCHER="python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv-id ${SLURM_JOB_ID} \
    --rdzv-backend etcd-v2 \
    --rdzv-endpoint etcd.hpc-cluster-hopper.hpc.internal.huggingface.tech:2379 \
    --tee 3 \
    "
echo $CMD
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_DEBUG=WARN  # VERSION, WARN, INFO
export NCCL_DEBUG_SUBSYS=COLL
srun $SRUN_ARGS -u bash -c "$LAUNCHER --node_rank \$SLURM_PROCID --role \$SLURMD_NODENAME: $CMD"
echo "END TIME: $(date)"
