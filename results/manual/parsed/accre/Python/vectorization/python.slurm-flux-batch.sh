#!/bin/bash
#FLUX: --job-name=grated-parsnip-4380
#FLUX: -t=600
#FLUX: --urgency=16

module load Intel IntelMPI Python numpy
python vectorization.py
