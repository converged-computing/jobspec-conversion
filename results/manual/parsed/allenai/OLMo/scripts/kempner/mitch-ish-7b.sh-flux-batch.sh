#!/bin/bash
#FLUX: --job-name=v1.5-mix-medium-mitch-ish
#FLUX: -N=8
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
LOAD_PATH=s3://ai2-llm/checkpoints/7b/v1_5-mix-mitch-ish/step556000-unsharded
srun \
  "--cpus-per-task=$SLURM_CPUS_PER_TASK" \
  --distribution=block:block \
  --kill-on-bad-exit \
  scripts/run_with_environment.sh \
    $HOME/miniconda3/envs/LLM/bin/python -u scripts/train.py configs/v1_5-mix-medium-mitch-ish-s3.yaml \
      "--run_name=kempner_${SLURM_JOB_ID}" \
      --wandb.name=v1_5-mix-mitch-ish-final-tulu \
      '--data.paths=[s3://ai2-llm/preprocessed/tulu-v2-sft-mixture/gpt-neox-20b-pii-special/data.npy,s3://ai2-llm/preprocessed/olmo-mix/v1_5-sample-9B/gpt-neox-20b-pii-special/data.npy]' \
      --eval_interval=100 \
      --save_interval=500 \
      "--load_path=${LOAD_PATH}" \
      --restore_dataloader=false \
      --optimizer.learning_rate=0.000023 \
      --scheduler.t_warmup=556000 \
      --scheduler.alpha_f=0.001 \
      --scheduler.t_max=558223 \
      --stop_at=558223 \
      --time_limit=$((167 * 60 * 60)) \
      --model.flash_attention=true \
      "--save_folder=/n/holyscratch01/kempner_lab/Lab/checkpoints/${SLURM_JOB_ID}/"
