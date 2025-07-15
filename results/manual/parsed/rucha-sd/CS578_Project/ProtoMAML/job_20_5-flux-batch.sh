#!/bin/bash
#FLUX: --job-name=lovable-parsnip-0957
#FLUX: --queue=cuda-gpu
#FLUX: -t=86400
#FLUX: --priority=16

nvidia-smi
echo "Running PROTOMAML on Omniglot"
echo "--------------------------------------------------------------------------"
echo "20-way, 5-shot"
echo "--------------------------------------------------------------------------"
python3 protomaml.py --K_shot 5 --N_way 20 --image_background "images_background" --image_evaluation "images_evaluation" --epochs 400
