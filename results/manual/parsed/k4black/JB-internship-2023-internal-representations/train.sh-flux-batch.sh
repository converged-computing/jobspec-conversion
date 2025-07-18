#!/bin/bash
#FLUX: --job-name=jb
#FLUX: --queue=gpushort
#FLUX: -t=7200
#FLUX: --urgency=16

export NEPTUNE_PROJECT='k4black/jb-internal-representations'
export TOKENIZERS_PARALLELISM='false'

module purge
module load CUDA/11.4.1
module load cuDNN/8.2.2.26-CUDA-11.4.1
module load NCCL/2.10.3-GCCcore-11.2.0-CUDA-11.4.1
module load GCC/11.2.0
module load libgit2/1.1.1-GCCcore-11.2.0
module load Python/3.9.6-GCCcore-11.2.0
module load git/2.33.1-GCCcore-11.2.0-nodocs
module load git-lfs/2.7.1
source /data/$USER/.envs/jb-internship/bin/activate
export $(cat .env | xargs)
export NEPTUNE_PROJECT="k4black/jb-internal-representations"
export TOKENIZERS_PARALLELISM=false
python train.py $*
deactivate
