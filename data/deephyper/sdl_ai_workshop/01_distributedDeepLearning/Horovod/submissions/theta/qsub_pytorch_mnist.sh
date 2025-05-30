#!/bin/bash
#COBALT -n 4
#COBALT -t 1:00:00
#COBALT -q theta-knl --attrs mcdram=cache:numa=quad
#COBALT -A SDL_Workshop -O results/theta/pytorch_mnist

#submisstion script for running tensorflow_mnist with horovod

echo "Running Cobalt Job $COBALT_JOBID."

#Loading modules

module load datascience/pytorch-1.7

PROC_PER_NODE=4

aprun -n $(($COBALT_JOBSIZE*$PROC_PER_NODE)) -N $PROC_PER_NODE \
    -j 2 -d 32 -cc depth \
    -e OMP_NUM_THREADS=32 \
    -e KMP_BLOCKTIME=0 \
    python pytorch_mnist.py --num_threads=32 --device cpu --epochs 32 >& results/theta/pytorch_mnist.out

