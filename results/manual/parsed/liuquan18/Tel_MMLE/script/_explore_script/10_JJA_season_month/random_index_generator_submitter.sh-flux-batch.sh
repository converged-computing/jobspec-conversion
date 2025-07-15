#!/bin/bash
#FLUX: --job-name=rand_one
#FLUX: --queue=compute
#FLUX: -t=14400
#FLUX: --urgency=16

mpirun -np 1 python -u random_index_generator.py $1 $2 $3
