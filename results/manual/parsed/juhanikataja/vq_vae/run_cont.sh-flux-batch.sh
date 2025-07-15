#!/bin/bash
#FLUX: --job-name=vqvae
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --queue=dev-g
#FLUX: -t=900
#FLUX: --priority=16

export EBU_USER_PREFIX='/project/project_462000559/EasyBuild'
export PYTHONPATH='$PYTHONPATH:/scratch/project_462000559/kostis/libs/analysator'

export EBU_USER_PREFIX=/project/project_462000559/EasyBuild
ml LUMI/23.09
module load PyTorch/2.2.0-rocm-5.6.1-python-3.10-asterix-singularity-20240315
export PYTHONPATH=$PYTHONPATH:/scratch/project_462000559/kostis/libs/analysator
rocminfo
srun singularity exec --bind $(pwd) $SIF python3 vq_vae2.py restart.0000100.2024-05-31_12-50-15.vlsv
