#!/bin/bash
#SBATCH --job-name=olmo-small-ablation
#SBATCH --account=project_462000229
#SBATCH --output=/pfs/lustref1/flash/project_462000229/logs/%j.log
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=0
#SBATCH --time=2-00:00:00
#SBATCH --partition=standard-g
#SBATCH --constraint=ntasks-per-node=8

export OLMO_CONTAINER='llm-lumi_latest.sif'
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
export WANDB_PROJECT='c4-small'
export ROCM_PATH='/opt/rocm'
export SINGULARITYENV_LD_LIBRARY_PATH='/usr/local/lib:/opt/cray/libfabric/1.15.2.0/lib64'
export CONFIG_PATH='configs/olmo-small-ablation.yaml'
export RUN_NAME='$(cat $CONFIG_PATH | grep -ohP "^run_name\:\w*(.+)$" | sed 's/run_name:\s*//')'

module load LUMI/22.08 partition/G
if [ -z ${LOAD_PATH+x} ]; then
  LOAD_PATH_ARG=""
else
  LOAD_PATH_ARG="--load_path=${LOAD_PATH}"
fi
export OLMO_CONTAINER=llm-lumi_latest.sif
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
export WANDB_PROJECT=c4-small
export ROCM_PATH=/opt/rocm
export SINGULARITYENV_LD_LIBRARY_PATH=/usr/local/lib:/opt/cray/libfabric/1.15.2.0/lib64
export CONFIG_PATH=configs/olmo-small-ablation.yaml
export RUN_NAME=$(cat $CONFIG_PATH | grep -ohP "^run_name\:\w*(.+)$" | sed 's/run_name:\s*//')
srun \
  --cpus-per-task=$SLURM_CPUS_PER_TASK \
  --distribution=block:block \
  --kill-on-bad-exit \
  scripts/run_with_environment.sh \
    singularity exec \
    -B"$PROJECT_DIR:$PROJECT_DIR" \
    -B"$SCRATCH_DIR:$SCRATCH_DIR" \
    -B"$FLASH_DIR:$FLASH_DIR" \
    -B /opt/cray:/opt/cray \
    -B /usr/lib64/libcxi.so.1:/usr/lib64/libcxi.so.1 \
    -B /usr/lib64/libjson-c.so.3:/usr/lib64/libjson-c.so.3 \
    $PROJECT_DIR/containers/$OLMO_CONTAINER \
    python scripts/train.py $CONFIG_PATH \
      --run_name="${RUN_NAME}_${SLURM_JOB_ID}" \
      --wandb.project=$WANDB_PROJECT \
      $LOAD_PATH_ARG \
      ${@}
