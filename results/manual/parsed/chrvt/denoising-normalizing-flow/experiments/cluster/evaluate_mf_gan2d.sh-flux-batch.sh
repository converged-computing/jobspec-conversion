#!/bin/bash
#FLUX: --job-name=mf_gan2d_eval
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

cd /storage/homefs/ch19g182/Python/Denoising-Normalizing-Flow-master/experiments
nvcc --version
nvidia-smi
python evaluate.py -c configs/evaluate_mf_gan2d.config -i ${SLURM_ARRAY_TASK_ID}
