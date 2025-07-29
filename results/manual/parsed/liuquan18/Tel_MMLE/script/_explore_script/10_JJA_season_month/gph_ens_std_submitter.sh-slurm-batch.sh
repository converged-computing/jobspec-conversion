#!/bin/bash
#FLUX: --job-name=slope_forced
#FLUX: --queue=compute
#FLUX: -t=28800
#FLUX: --urgency=16

mpirun -np 1 python -u gph_ens_std.py $1 $2 $3
