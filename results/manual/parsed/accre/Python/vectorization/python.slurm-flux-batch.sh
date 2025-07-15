#!/bin/bash
#FLUX: --job-name=salted-parsnip-2569
#FLUX: -t=600
#FLUX: --urgency=16

module load Intel IntelMPI Python numpy
python vectorization.py
