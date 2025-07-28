#!/bin/bash
#FLUX: --job-name=trainingCycleGAN
#FLUX: --queue=cuda
#FLUX: -t=828000
#FLUX: --urgency=16

module load nvidia/cudasdk/10.0
python train.py
