#!/bin/bash
#SBATCH --job-name=ffs_256
#SBATCH --account=g92-1496
#SBATCH --output=/home/kpusteln/loads/tsm_base.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:volta:4
#SBATCH --time=2-00:00:00
#SBATCH --constraint=volta32G

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
