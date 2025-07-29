#!/bin/bash
#FLUX --job-name=confused-omelette-5984
#FLUX -t=600
#FLUX --urgency=16

module load Intel IntelMPI Python numpy
python vectorization.py
