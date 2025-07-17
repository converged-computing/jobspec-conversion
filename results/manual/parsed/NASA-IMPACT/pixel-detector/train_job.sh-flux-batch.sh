#!/bin/bash
#FLUX: --job-name=TESTTENSORFLOW
#FLUX: -N=4
#FLUX: --queue=dc-gpu
#FLUX: -t=7200
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

ml Stages/2022
ml CUDA/11.5
ml cuDNN/8.3.1.22-CUDA-11.5
export CUDA_VISIBLE_DEVICES="0,1,2,3"
echo "Starting training"
source /p/project/training2206/<username>/pixel-detector/.venv/bin/activate
srun python code/train.py
echo "DONE"
