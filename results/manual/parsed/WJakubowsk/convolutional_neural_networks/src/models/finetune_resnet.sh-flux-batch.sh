#!/bin/bash
#FLUX: --job-name=finetune_resnet
#FLUX: -c=6
#FLUX: --gpus-per-task=1
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --priority=16

. /home2/faculty/wjakubowski/miniconda3/etc/profile.d/conda.sh
conda activate cnn
python /mnt/evafs/groups/ganzha_23/wjakubowski/ConvolutionalNeuralNetworks/src/models/resnet.py \
    --data "/mnt/evafs/groups/ganzha_23/wjakubowski/ConvolutionalNeuralNetworks/data/" \
    --outputdir "/mnt/evafs/groups/ganzha_23/wjakubowski/ConvolutionalNeuralNetworks/src/models"
