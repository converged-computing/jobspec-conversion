#!/bin/bash
#FLUX: --job-name=mitchish65
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
export FI_CXI_DEFAULT_CQ_SIZE='131072'
export PYTHONPATH='.:${PYTHONPATH}'
export ROCM_PATH='/opt/rocm'
export SINGULARITYENV_LD_LIBRARY_PATH='/usr/local/lib:/opt/cray/libfabric/1.15.2.0/lib64'
export DATA_PATH='$FLASH_DIR/preprocessed/olmo-mix'
export CHECKPOINTS_PATH='$FLASH_DIR/checkpoints'
export EVAL_DATA_PATH='$SCRATCH_DIR/eval-data'

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
export FI_CXI_DEFAULT_CQ_SIZE=131072
export PYTHONPATH=.:${PYTHONPATH}
export ROCM_PATH=/opt/rocm
export SINGULARITYENV_LD_LIBRARY_PATH=/usr/local/lib:/opt/cray/libfabric/1.15.2.0/lib64
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
    python scripts/train.py configs/mitchish65.yaml \
      --run_name=${SLURM_JOB_ID} \
      --time_limit=$((47 * 60 * 60)) \
      --canceled_check_interval=10 \
      --device_train_microbatch_size=2 \
      --save_interval=1000 \
      ${@}
