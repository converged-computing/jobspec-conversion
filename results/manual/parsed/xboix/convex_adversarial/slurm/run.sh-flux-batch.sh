#!/bin/bash
#FLUX: --job-name=robustness
#FLUX: --queue=cbmm
#FLUX: --urgency=16

cd /om2/user/xboix/src/convex_adversarial/
hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
singularity exec -B /om:/om -B /om2:/om2 -B /scratch/user/xboix:/vast --nv /om/user/xboix/singularity/xboix-tensorflow2.8.0.simg \
python3 main.py \
--experiment_id=$((644 +${SLURM_ARRAY_TASK_ID})) \
--run=train \
--gpu_id=0
singularity exec -B /om:/om -B /om2:/om2 -B /scratch/user/xboix:/vast --nv /om/user/xboix/singularity/xboix-tensorflow2.8.0.simg \
python3 main.py \
--experiment_id=$((644 +${SLURM_ARRAY_TASK_ID})) \
--run=test \
--gpu_id=0
