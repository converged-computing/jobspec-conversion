#!/bin/bash
#FLUX: --job-name=ae_cnn
#FLUX: --queue=gpu-a100-80g
#FLUX: -t=86400
#FLUX: --urgency=16

module load cuda11.8/toolkit/11.8.0
srun python ae_training_cnn.py
