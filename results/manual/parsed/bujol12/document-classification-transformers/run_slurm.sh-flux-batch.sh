#!/bin/bash
#FLUX: --job-name=chunky-cherry-2992
#FLUX: --queue=gpgpuC
#FLUX: --urgency=16

configName=$1
trainData=$2
evalData=$3
echo "Config " $configName
echo "Train Data " $trainData
echo "Eval Data " $evalData
source /homes/${USER}/.bashrc
conda activate dissertation
source /vol/cuda/11.0.3-cudnn8.0.5.39/setup.sh
/usr/bin/nvidia-smi
cd /vol/bitbucket/${USER}/document-classification-transformers
python main.py --config $configName --eval $evalData --train $trainData
