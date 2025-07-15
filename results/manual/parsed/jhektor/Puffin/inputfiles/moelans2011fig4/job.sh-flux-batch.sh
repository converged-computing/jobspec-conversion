#!/bin/bash
#FLUX: --job-name=misunderstood-peas-1981
#FLUX: --exclusive
#FLUX: --priority=16

cat $0
ml load GCC/6.3.0-2.27
ml load OpenMPI/2.0.2
ml load Moose_framework
mpirun -bind-to-core ../../puffin-opt -i imcsphere2d.i
