#!/bin/bash
#FLUX: --job-name=select
#FLUX: --queue=Pixel
#FLUX: --urgency=16

srun --mpi=pmi2 python -u main.py
