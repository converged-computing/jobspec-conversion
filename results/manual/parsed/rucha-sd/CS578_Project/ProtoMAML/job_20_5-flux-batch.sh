#!/bin/bash
#FLUX: --job-name=fat-peas-6463
#FLUX: --queue=cuda-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

nvidia-smi
echo "Running PROTOMAML on Omniglot"
echo "--------------------------------------------------------------------------"
echo "20-way, 5-shot"
echo "--------------------------------------------------------------------------"
python3 protomaml.py --K_shot 5 --N_way 20 --image_background "images_background" --image_evaluation "images_evaluation" --epochs 400
