#!/bin/bash
#FLUX --job-name=hello-parsnip-5553
#FLUX -t=600
#FLUX --urgency=16

module load Intel IntelMPI Python numpy
python vectorization.py
