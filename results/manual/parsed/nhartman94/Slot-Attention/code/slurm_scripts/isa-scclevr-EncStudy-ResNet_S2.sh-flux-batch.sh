#!/bin/bash
#FLUX: --job-name=isa-scclevr-EncStudy-ResNet_S2
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load anaconda/3/2021.11 # <-> python 3.9.
module load cuda/11.6
module load cudnn/8.8
module load pytorch/gpu-cuda-11.6/2.0.0
conda activate gpu_env
pwd
python train-scclevr-encoder-study.py --config configs/isa-scclevr-EncStudy-ResNet_S2.yaml --warm_start --warm_start_config configs/isa-cosine-decay.yaml --device cuda:0 
