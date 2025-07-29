#!/bin/bash
#FLUX: --job-name=chocolate-fork-5920
#FLUX: -t=600
#FLUX: --urgency=16

module load Intel IntelMPI Python numpy
python vectorization.py
