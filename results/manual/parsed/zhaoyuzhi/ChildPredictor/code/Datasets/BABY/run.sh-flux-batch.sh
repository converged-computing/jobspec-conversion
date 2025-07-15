#!/bin/bash
#FLUX: --job-name=select
#FLUX: --priority=16

srun --mpi=pmi2 python -u main.py
