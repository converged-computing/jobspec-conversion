#!/bin/bash
#FLUX: --job-name=matinv
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load anaconda3/2023.9
kernprof -l matrix_inverse.py
