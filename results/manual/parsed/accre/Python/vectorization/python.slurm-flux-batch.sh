#!/bin/bash
#FLUX: --job-name=crunchy-kitty-6560
#FLUX: -t=600
#FLUX: --urgency=16

module load Intel IntelMPI Python numpy
python vectorization.py
