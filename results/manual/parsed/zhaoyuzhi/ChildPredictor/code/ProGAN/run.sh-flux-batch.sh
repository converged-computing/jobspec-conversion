#!/bin/bash
#FLUX: --job-name=mixture1
#FLUX: --queue=Pixel
#FLUX: --urgency=16

srun --mpi=pmi2 python -u train.py
