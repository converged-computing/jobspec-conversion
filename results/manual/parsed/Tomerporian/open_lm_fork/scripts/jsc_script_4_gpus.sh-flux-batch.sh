#!/bin/bash
#FLUX: --job-name=openlm
#FLUX: -c=12
#FLUX: --queue=booster
#FLUX: -t=21600
#FLUX: --priority=16

export NCCL_IB_TIMEOUT='50'
export UCX_RC_TIMEOUT='4s'
export NCCL_IB_RETRY_CNT='10'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export NCCL_ASYNC_ERROR_HANDLING='1'
export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export MASTER_PORT='12802'
export MASTER_ADDR='$master_addr"i'
export PYTHONPATH='$PYTHONPATH:${OPEN_CLIP_HOME}'

ml purge
CONDA_ENV="py9"
source /p/project/ccstdl/porian1/miniconda3/bin/activate ${CONDA_ENV}
export NCCL_IB_TIMEOUT=50
export UCX_RC_TIMEOUT=4s
export NCCL_IB_RETRY_CNT=10
export CUDA_VISIBLE_DEVICES=0,1,2,3
export NCCL_ASYNC_ERROR_HANDLING=1
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export MASTER_PORT=12802
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr"i"
echo "MASTER_ADDR="$MASTER_ADDR
OPEN_CLIP_HOME="/p/project/ccstdl/$USER/open_lm_fork"
export PYTHONPATH="$PYTHONPATH:${OPEN_CLIP_HOME}"
cd ${OPEN_CLIP_HOME}
LOGS="/p/scratch/ccstdl/porian1/$3"
WANDB_MODE=offline
srun --cpu_bind=v --accel-bind=gn --threads-per-core=1 python -u -m open_lm.main --name "$2" --logs $LOGS  --config $1 
