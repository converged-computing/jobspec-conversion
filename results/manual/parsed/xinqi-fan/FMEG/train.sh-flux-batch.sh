#!/bin/bash
#FLUX: --job-name=astute-lemur-3251
#FLUX: -c=4
#FLUX: --queue=gpu_7d1g
#FLUX: --urgency=16

module load gcc openmpi/4.0.5/gcc/8.3.0
module load cuda/11.0.2 cuda/blas/11.0.2 cuda/fft/11.0.2
source activate pytorch160
nvidia-smi
cd /home/xinqifan2/Project/first-order-model
python run.py --config config/samm-256.yaml --checkpoint checkpoints_samm/vox-cpk.pth.tar
