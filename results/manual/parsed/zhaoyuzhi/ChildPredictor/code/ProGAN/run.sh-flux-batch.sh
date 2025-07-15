#!/bin/bash
#FLUX: --job-name=mixture1
#FLUX: --urgency=16

srun --mpi=pmi2 python -u train.py
