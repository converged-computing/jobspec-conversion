#!/bin/bash
#FLUX: --job-name=ffs_256
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --priority=16

module purge 2>&1 >/dev/null
module load \
  gpu/cuda/11.7 \
  common/git/2.27.0 \
  common/anaconda/3.8 \
  common/compilers/nvidia/21.2 \
  common/compilers/gcc/9.3.1
cd /home/kpusteln/stylegan-v
conda activate ./env
CC=gcc CXX=g++ \
python3 src/infra/launch.py \
  hydra.run.dir=. \
  exp_suffix=tsm_base \
  env=local \
  dataset=ffs \
  dataset.name=ffs_processed \
  dataset.resolution=256 \
  +ignore_uncommited_changes=true \
  +overwrite=True \
  num_gpus=4 \
