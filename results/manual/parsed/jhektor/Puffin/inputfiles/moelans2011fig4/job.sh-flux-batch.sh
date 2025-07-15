#!/bin/bash
#FLUX: --job-name=nerdy-lentil-4340
#FLUX: --exclusive
#FLUX: --urgency=16

cat $0
ml load GCC/6.3.0-2.27
ml load OpenMPI/2.0.2
ml load Moose_framework
mpirun -bind-to-core ../../puffin-opt -i imcsphere2d.i
