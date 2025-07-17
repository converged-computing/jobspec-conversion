#!/bin/bash
#FLUX: --job-name=transformer
#FLUX: -n=6
#FLUX: --queue=a100
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:`pwd`/scripts'

CUDA_VISIBLE_DEVICES=$(ncvd)
module load python/anaconda-python-3.7
module load software/TensorFlow-A100-GPU
start=$(date +%s)
echo "Starting script..."
export PYTHONPATH=$PYTHONPATH:`pwd`/scripts
python3 scripts/finetune_example.py
end=$(date +%s)
echo "Elapsed Time: $(($end-$start)) seconds"
