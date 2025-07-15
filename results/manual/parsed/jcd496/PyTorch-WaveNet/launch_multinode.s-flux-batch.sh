#!/bin/bash
#FLUX: --job-name=WaveNet
#FLUX: -t=54000
#FLUX: --priority=16

module purge
module load openmpi/intel/2.0.3
module load cuda/10.1.105
module load anaconda3/5.3.0
. /share/apps/anaconda3/5.3.0/etc/profile.d/conda.sh
conda activate dis_pytorch_env
python train.py
