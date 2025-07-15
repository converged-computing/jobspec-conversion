#!/bin/bash
#FLUX: --job-name=arid-cat-3699
#FLUX: -N=2
#FLUX: --urgency=16

module load Anaconda2
mpirun python bcast.py
