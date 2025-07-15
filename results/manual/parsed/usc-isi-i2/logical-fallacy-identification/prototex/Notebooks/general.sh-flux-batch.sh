#!/bin/bash
#FLUX: --job-name=general
#FLUX: -c=16
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --priority=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate prototex
python inference_and_explanations.py
conda deactivate
