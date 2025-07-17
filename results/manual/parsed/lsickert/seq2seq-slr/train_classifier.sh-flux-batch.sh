#!/bin/bash
#FLUX: --job-name=train_classifier_model
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/scratch/$USER/.cache/huggingface/datasets'

module purge
module load Python/3.8.6-GCCcore-10.2.0
source /data/$USER/.envs/seq2slr/bin/activate
module load PyTorch/1.10.0-fosscuda-2020b
export HF_DATASETS_CACHE="/scratch/$USER/.cache/huggingface/datasets"
python -u main.py --action train_classifier --lang en --qual gold,silver --name mlClassifier --epochs 5
