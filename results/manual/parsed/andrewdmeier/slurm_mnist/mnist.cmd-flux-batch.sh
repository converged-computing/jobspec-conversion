#!/bin/bash
#FLUX: --job-name=tensorflow_tutorial
#FLUX: -t=300
#FLUX: --urgency=16

module load anaconda3
source activate tf-gpu
srun python mnist_classify.py
