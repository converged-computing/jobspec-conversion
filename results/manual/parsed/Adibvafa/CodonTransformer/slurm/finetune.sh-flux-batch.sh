#!/bin/bash
#FLUX: --job-name=finetune
#FLUX: -c=6
#FLUX: --queue=compute_full_node
#FLUX: -t=54000
#FLUX: --priority=16

export CUBLAS_WORKSPACE_CONFIG=':4096:2'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module --ignore_cache load cuda/11.4.4
module --ignore_cache load anaconda3
source activate light
cd /scratch/g/gfilion/adibvafa/Codon
export CUBLAS_WORKSPACE_CONFIG=:4096:2
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
stdbuf -oL -eL srun python finetune.py
