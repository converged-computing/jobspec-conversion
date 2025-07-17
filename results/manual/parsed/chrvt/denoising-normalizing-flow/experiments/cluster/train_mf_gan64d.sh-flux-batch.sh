#!/bin/bash
#FLUX: --job-name=mf_gand64d
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

cd /storage/homefs/ch19g182/Python/Denoising-Normalizing-Flow-master/experiments
nvcc --version
nvidia-smi
python train.py -c configs/train_mf_gan64d.config -i ${SLURM_ARRAY_TASK_ID}
