#!/bin/bash
#FLUX: --job-name=carnivorous-lettuce-3154
#FLUX: -t=600
#FLUX: --priority=16

module load Intel IntelMPI Python numpy
python vectorization.py
