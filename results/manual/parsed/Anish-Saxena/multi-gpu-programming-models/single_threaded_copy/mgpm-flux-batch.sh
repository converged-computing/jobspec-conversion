#!/bin/bash
#FLUX: --job-name=salted-general-9005
#FLUX: -N=2
#FLUX: --priority=16

NPROCS=16
NPPERSOC=$(($NPROCS>>2))
source ~/init.sh
make clean && make
rm -rf hpctoolkit*
hpcrun -e CPUTIME -e IO -e gpu=nvidia -t ./jacobi
hpcstruct --gpucfg yes hpctoolkit*
hpcstruct jacobi
hpcprof -S jacobi.hpcstruct -I jacobi.cu -I $CUDA_HOME/+ hpctoolkit*
echo "===DONE==="
