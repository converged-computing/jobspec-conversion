#!/bin/bash
#FLUX: --job-name=llama7
#FLUX: -N=16
#FLUX: -c=16
#FLUX: --queue=kempner_project
#FLUX: -t=601200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MPICH_GPU_SUPPORT_ENABLED='1'
export MIOPEN_USER_DB_PATH='/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'
export PYTHONPATH='.:${PYTHONPATH}'
export DATA_PATH='/n/home06/dgroeneveld/data/preprocessed/olmo-mix'
export EVAL_DATA_PATH='/n/home06/dgroeneveld/data/eval-data'
export CHECKPOINTS_PATH='/n/home06/dgroeneveld/checkpoints'
export PYTORCH_KERNEL_CACHE_PATH='/tmp/pytorch_kernel_cache/'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPICH_GPU_SUPPORT_ENABLED=1
export MIOPEN_USER_DB_PATH=/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export PYTHONPATH=.:${PYTHONPATH}
export DATA_PATH=/n/home06/dgroeneveld/data/preprocessed/olmo-mix
export EVAL_DATA_PATH=/n/home06/dgroeneveld/data/eval-data
export CHECKPOINTS_PATH=/n/home06/dgroeneveld/checkpoints
export PYTORCH_KERNEL_CACHE_PATH=/tmp/pytorch_kernel_cache/
mkdir -p $PYTORCH_KERNEL_CACHE_PATH
srun \
  --cpus-per-task=$SLURM_CPUS_PER_TASK \
  --distribution=block:block \
  --kill-on-bad-exit \
  scripts/run_with_environment.sh \
    $HOME/miniconda3/envs/LLM/bin/python -u scripts/train.py configs/llama7.yaml \
      --run_name=kempner_llama7_${SLURM_JOB_ID} \
      --save_folder=/n/holyscratch01/kempner_lab/Lab/checkpoints/${SLURM_JOB_ID}/ \
      --data.num_workers=4 \
      --device_train_microbatch_size=6 \
      --time_limit=$((167 * 60 * 60)) \
      ${@}
