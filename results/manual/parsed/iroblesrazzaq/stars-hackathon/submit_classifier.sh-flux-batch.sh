#!/bin/bash
#FLUX: --job-name=lovely-pastry-8553
#FLUX: --queue=schmidt-gpu
#FLUX: -t=7200
#FLUX: --urgency=16

echo "output of the visible GPU environment"
nvidia-smi
module load python/miniforge-24.1.2 # python 3.10
source /project/dfreedman/hackathon/hackathon-env/bin/activate
echo Tensorflow
python MergeNeuralNetwork.py
