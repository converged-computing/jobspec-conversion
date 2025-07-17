#!/bin/bash
#FLUX: --job-name=arldm
#FLUX: --queue=research
#FLUX: -t=86400
#FLUX: --urgency=16

export HYDRA_FULL_ERROR='1'
export TORCH_CUDA_ARCH_LIST='7.0 7.5 8.0+PTX'
export NCCL_DEBUG='WARN'

export HYDRA_FULL_ERROR=1
export TORCH_CUDA_ARCH_LIST="7.0 7.5 8.0+PTX"
export NCCL_DEBUG=WARN
cd $SLURM_SUBMIT_DIR
module load anaconda/full
echo nvidia-smi
bootstrap_conda
conda activate arldm
python3 /srv/home/kumar256/ARLDM/main.py
