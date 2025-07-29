#!/bin/bash
#FLUX --job-name=salted-noodle-6806
#FLUX -N=2
#FLUX --urgency=16

module load Anaconda2
mpirun python bcast.py
