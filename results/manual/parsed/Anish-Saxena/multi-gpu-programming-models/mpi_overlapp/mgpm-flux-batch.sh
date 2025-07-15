#!/bin/bash
#FLUX: --job-name=rainbow-latke-0888
#FLUX: -N=2
#FLUX: --priority=16

NPROCS=16
NPPERSOC=$(($NPROCS>>2))
source ~/init.sh
make clean && make
rm -r hpctoolkit*
mpirun -np $NPROCS -npersocket $NPPERSOC hpcrun -e CPUTIME -e IO -e gpu=nvidia -t ./jacobi
hpcstruct --gpucfg yes hpctoolkit*
hpcstruct --gpucfg yes jacobi
hpcprof -S jacobi.hpcstruct -I jacobi.cpp -I jacobi_kernels.cu -I ./+ hpctoolkit*
echo "===DONE==="
