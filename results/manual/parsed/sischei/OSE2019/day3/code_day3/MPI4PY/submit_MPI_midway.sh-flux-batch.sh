#!/bin/bash
#FLUX: --job-name=tart-carrot-7502
#FLUX: -N=2
#FLUX: --urgency=16

module load Anaconda2
mpirun python bcast.py
