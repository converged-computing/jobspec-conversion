#!/bin/bash
#FLUX: --job-name=nest
#FLUX: -c=28
#FLUX: --queue=LADON
#FLUX: -t=362340
#FLUX: --urgency=16

module load Anaconda3
source activate cnn
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch-lts -y
python -u train_alexnet_flexabile.py
