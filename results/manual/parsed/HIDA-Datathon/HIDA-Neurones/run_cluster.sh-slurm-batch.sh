#!/bin/bash
#FLUX: --job-name=HIDA-20
#FLUX: -N=3
#FLUX: --exclusive
#FLUX: --queue=pGPU
#FLUX: -t=28800
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

module load compilers/cuda/10.1
export CUDA_VISIBLE_DEVICES="0"
nvidia-smi
srun /gpfs/home/machnitz/miniconda3/envs/pytorch/bin/python main.py \
      --max_epochs 20 --gpus 1 --num_workers 20 \
      --batch_size 6 --learning_rate 0.0001 \
      --data_dir "/gpfs/home/machnitz/HIDA/HIDA-ufz_image_challenge/photos_annotated" \
      --num_nodes 3 --distributed_backend "ddp"
