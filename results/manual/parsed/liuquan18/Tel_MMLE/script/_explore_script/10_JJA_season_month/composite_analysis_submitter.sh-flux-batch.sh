#!/bin/bash
#FLUX: --job-name=com
#FLUX: --queue=compute
#FLUX: -t=28800
#FLUX: --urgency=16

mpirun -np 1 python -u composite_analysis.py $1 $2 $3
