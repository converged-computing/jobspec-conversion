#!/bin/bash
#FLUX: --job-name=bs_16_exp
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

export HF_HOME='/scratch/ml9027/.cache'
export HF_DATASETS_CACHE='/scratch/ml9027/.cache'
export TRANSFORMERS_CACHE='/scratch/ml9027/.cache'

export HF_HOME="/scratch/ml9027/.cache"
export HF_DATASETS_CACHE="/scratch/ml9027/.cache"
export TRANSFORMERS_CACHE="/scratch/ml9027/.cache"
module purge
singularity exec \
  --nv --overlay /scratch/ml9027/my_env/overlay-15GB-500K.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif  \
    /bin/bash -c "source /ext3/env.sh; conda activate /scratch/ml9027/lamp-main/penv; \
  nvidia-smi; export PYTHONNOUSERSITE=True; \
  cd /scratch/ml9027/ming/lamp-main; \
  ./bs_exp.sh huawei-noah/TinyBERT_General_6L_768D cola 16"
