#!/bin/bash
#FLUX --job-name=astute-cattywampus-2193
#FLUX -N=2
#FLUX --urgency=16

module load Anaconda2
mpirun python bcast.py
