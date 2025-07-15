#!/bin/bash
#FLUX: --job-name=crusty-hobbit-0577
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=mics
#FLUX: -t=72000
#FLUX: --priority=16

source ~/.bashrc
conda activate ai2
. /scratch/spack/share/spack/setup-env.sh
spack load cuda@9.0.176
spack load cudnn@7.6.5.32-9.0-linux-x64
python train.py
