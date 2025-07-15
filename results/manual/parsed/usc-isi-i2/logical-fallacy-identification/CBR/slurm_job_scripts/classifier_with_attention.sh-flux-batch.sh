#!/bin/bash
#FLUX: --job-name=logical_fallacy_classifier
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --priority=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
dataset="data/new_finegrained"
echo "Dataset: $dataset"
python -m cbr_analyser.reasoner.classifier_with_attention \
    --data_dir ${dataset}
conda deactivate
