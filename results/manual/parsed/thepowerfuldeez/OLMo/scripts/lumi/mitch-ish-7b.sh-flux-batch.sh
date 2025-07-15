#!/bin/bash
#FLUX: --job-name=v1.5-mix-medium-mitch-ish
#FLUX: -N=128
#FLUX: -c=6
#FLUX: --queue=standard-g
#FLUX: -t=172800
#FLUX: --urgency=16

export OLMO_CONTAINER='llm-lumi-torch21_latest.sif'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MPICH_GPU_SUPPORT_ENABLED='1'
export NCCL_SOCKET_IFNAME='hsn'
export NCCL_NET_GDR_LEVEL='3'
export MIOPEN_USER_DB_PATH='/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'
export CXI_FORK_SAFE='1'
export CXI_FORK_SAFE_HP='1'
export FI_CXI_DISABLE_CQ_HUGETLB='1'
export GPU_MAX_HW_QUEUES='8'
export FI_CXI_DEFAULT_CQ_SIZE='131072'
export PYTHONPATH='.:${PYTHONPATH}'
export ROCM_PATH='/opt/rocm'
export SINGULARITYENV_LD_LIBRARY_PATH='/usr/local/lib:/opt/cray/libfabric/1.15.2.0/lib64'
export HF_DATASETS_OFFLINE='1'
export DATA_PATH='$FLASH_DIR/preprocessed/olmo-mix'
export CHECKPOINTS_PATH='$FLASH_DIR/checkpoints'
export EVAL_DATA_PATH='$SCRATCH_DIR/eval-data'

module load LUMI/22.08 partition/G
export OLMO_CONTAINER=llm-lumi-torch21_latest.sif
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPICH_GPU_SUPPORT_ENABLED=1
export NCCL_SOCKET_IFNAME=hsn
export NCCL_NET_GDR_LEVEL=3
export MIOPEN_USER_DB_PATH=/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export CXI_FORK_SAFE=1
export CXI_FORK_SAFE_HP=1
export FI_CXI_DISABLE_CQ_HUGETLB=1
export GPU_MAX_HW_QUEUES=8
export FI_CXI_DEFAULT_CQ_SIZE=131072
export PYTHONPATH=.:${PYTHONPATH}
export ROCM_PATH=/opt/rocm
export SINGULARITYENV_LD_LIBRARY_PATH=/usr/local/lib:/opt/cray/libfabric/1.15.2.0/lib64
export HF_DATASETS_OFFLINE=1
export DATA_PATH=$FLASH_DIR/preprocessed/olmo-mix
export CHECKPOINTS_PATH=$FLASH_DIR/checkpoints
export EVAL_DATA_PATH=$SCRATCH_DIR/eval-data
srun \
  --cpus-per-task=$SLURM_CPUS_PER_TASK \
  --distribution=block:block \
  --kill-on-bad-exit \
  scripts/run_with_environment.sh \
    singularity exec \
    -B"$PROJECT_DIR:$PROJECT_DIR" \
    -B"$FLASH_DIR:$FLASH_DIR" \
    -B"$SCRATCH_DIR:$SCRATCH_DIR" \
    -B /opt/cray:/opt/cray \
    -B /usr/lib64/libcxi.so.1:/usr/lib64/libcxi.so.1 \
    -B /usr/lib64/libjson-c.so.3:/usr/lib64/libjson-c.so.3 \
    $PROJECT_DIR/containers/$OLMO_CONTAINER \
    python scripts/train.py configs/v1_5-mix-medium-mitch-ish.yaml ${@} \
      --run_name=${SLURM_JOB_ID} \
      --activation_checkpointing=fine_grained \
      --fsdp.wrapping_strategy=one_in_four \
      --fsdp.sharding_strategy=FULL_SHARD \
      --sharded_checkpointer=local \
      --wandb.name=v1_5-mix-mitch-ish-lumi \
      --save_interval=10000 \
      --save_interval_ephemeral=1000 \
      --remote_save_folder=s3://ai2-llm/checkpoints/7b/mitchish-lumi \
      --save_folder=${FLASH_DIR}/checkpoints/mitchish-lumi
