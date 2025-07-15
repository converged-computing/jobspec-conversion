#!/bin/bash
#FLUX: --job-name=dnf_gan2d
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

cd /storage/homefs/ch19g182/Python/Denoising-Normalizing-Flow-master/experiments
nvcc --version
nvidia-smi
python train.py -c configs/train_dnf_gan2d.config -i ${SLURM_ARRAY_TASK_ID}
