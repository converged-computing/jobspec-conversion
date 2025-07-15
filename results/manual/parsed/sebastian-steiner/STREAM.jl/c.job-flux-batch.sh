#!/bin/bash
#FLUX: --job-name=fuzzy-cupcake-7947
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'

export OMP_NUM_THREADS=32
srun gcc -mcmodel=medium -fopenmp -O3 -DSTREAM_ARRAY_SIZE=1000000000 -DNTIMES=100 -o stream stream.c
srun likwid-pin -c N:0-31 ./stream
