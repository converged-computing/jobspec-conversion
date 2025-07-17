#!/bin/bash
#FLUX: --job-name=hanky-poodle-0400
#FLUX: -t=28800
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source /path/to/environment/pyenv_affinity/bin/activate
module purge
module load baskerville
module load bask-apps/live
module load NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
module load PyTorch/2.0.1-foss-2022a-CUDA-11.7.0
module load torchvision/0.15.2-foss-2022a-CUDA-11.7.0
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python /path/to/affinity-vae/run.py --config_file path/to/avae-config_file --new_out
