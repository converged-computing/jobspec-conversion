#!/bin/bash
#FLUX: --job-name=jupyter
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --priority=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate prototex
echo "*** Starting jupyter on:"$(hostname)
jupyter notebook --no-browser --port=9876
conda deactivate
