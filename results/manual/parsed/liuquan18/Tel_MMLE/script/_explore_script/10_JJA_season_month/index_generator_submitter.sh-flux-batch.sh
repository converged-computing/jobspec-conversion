#!/bin/bash
#FLUX: --job-name=ind_gen
#FLUX: --queue=compute
#FLUX: -t=14400
#FLUX: --urgency=16

mpirun -np 1 python -u index_generator.py $1 $2 $3
