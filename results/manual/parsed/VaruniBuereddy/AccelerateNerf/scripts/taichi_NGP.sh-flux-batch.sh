#!/bin/bash
#FLUX: --job-name=taichiNerf_ngp
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load cuda/11.6.2
module load intel/19.1.2
module load python/intel/3.8.6
module load anaconda3/2020.07
cd /scratch/rgn5646/Project/taichi-nerfs/
python -m pip install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu116
pip install -U pip && pip install -i https://pypi.taichi.graphics/simple/ taichi-nightly
pip install -r requirements.txt
./scripts/train_nsvf_lego.sh
