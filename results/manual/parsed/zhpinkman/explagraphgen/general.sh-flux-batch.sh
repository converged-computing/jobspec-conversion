#!/bin/bash
#FLUX: --job-name=general
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --urgency=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate explagraphgen
bash scripts/train_graph_contrastive.sh
conda deactivate
