#!/bin/bash
#FLUX: --job-name=sentence_segmentation
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --urgency=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
python sentence_segmentation.py
conda deactivate
