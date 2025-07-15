#!/bin/bash
#FLUX: --job-name=training-run-continue
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

STYLEGAN_PATH=/your/path/to/stylegan
module load TensorFlow/1.10.1-fosscuda-2018a-Python-3.6.4
cd $STYLEGAN_PATH
source venv/bin/activate
srun python train.py
