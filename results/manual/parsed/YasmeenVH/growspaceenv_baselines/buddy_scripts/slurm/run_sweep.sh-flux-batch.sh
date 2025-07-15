#!/bin/bash
#FLUX: --job-name=spython
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --priority=16

export XLA_FLAGS='--xla_gpu_cuda_data_dir=/cvmfs/ai.mila.quebec/apps/x86_64/common/cuda/10.1/'

function log() {
  echo -e "\e[32m"[DEPLOY LOG] $1"\e[0m"
}
source /etc/profile
log "Refreshing modules..."
module purge
module load python/3.7
module load pytorch/1.7
module load mujoco
module load mujoco-py
module load tensorflow
FOLDER=$SLURM_TMPDIR/src/
log "downloading source code from $1 to $FOLDER"
git clone $1 $FOLDER/
cd $FOLDER || exit
git checkout $3
log "pwd is now $(pwd)"
log "Setting up venv @ $SLURM_TMPDIR/venv..."
python3 -m virtualenv --system-site-packages "$SLURM_TMPDIR/venv"
source "$SLURM_TMPDIR/venv/bin/activate"
python3 -m pip install --upgrade pip
log "Downloading modules"
python3 -m pip install -r "requirements.txt" --exists-action w -f https://download.pytorch.org/whl/torch_stable.html
export XLA_FLAGS=--xla_gpu_cuda_data_dir=/cvmfs/ai.mila.quebec/apps/x86_64/common/cuda/10.1/
wandb agent "$2"
