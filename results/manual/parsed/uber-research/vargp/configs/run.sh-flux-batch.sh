#!/bin/bash
#FLUX: --job-name=VAR-GP
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --priority=16

export WANDB_MODE='run'
export WANDB_DIR='${LOGDIR}'
export WANDB_NAME='${SLURM_JOB_NAME}--${SLURM_JOB_ID}'
export PYTHONPATH='$(pwd):${PYTHONPATH}'

if [[ -z "${WANDB_SWEEP_ID}" ]]; then
  echo "Missing WANDB_SWEEP_ID"
  exit 1
fi
source "${HOME}/.bash_profile"
export WANDB_MODE=run
export WANDB_DIR="${LOGDIR}"
export WANDB_NAME="${SLURM_JOB_NAME}--${SLURM_JOB_ID}"
cd "${WORKDIR}/var-gp"
export PYTHONPATH="$(pwd):${PYTHONPATH}"
conda deactivate
conda activate var-gp
wandb agent --count=1 ${WANDB_SWEEP_ID}
