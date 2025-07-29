#!/bin/bash
#FLUX: --job-name=cuda-mpi
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=gpu-h100
#FLUX: -t=600
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'

cat  << STUFF > mymake
CUCOMP  = CC 
CULINK  = cc
CUFLAGS = -gpu=cc90  -cuda -target-accel=nvidia90
LIBRARIES =  -lcudart -lcuda
pp_cuda_aware: ping_pong_cuda_aware.o
	 \$(CULINK) \$(CUFLAGS) \$(LIBRARIES) ping_pong_cuda_aware.o -o pp_cuda_aware
ping_pong_cuda_aware.o: ping_pong_cuda_aware.cu
	 \$(CUCOMP) \$(CUFLAGS) \$(INCLUDES) -c ping_pong_cuda_aware.cu
.PHONY: clean
clean:
	rm -f pp_cuda_aware *.o
ping_pong_cuda_aware.cu:
	wget https://raw.githubusercontent.com/timkphd/examples/master/mpi/cuda/cuda_aware/ping_pong_cuda_aware.cu
STUFF
source /nopt/nrel/apps/gpu_stack/env_cpe23.sh
ml gcc
ml PrgEnv-nvhpc
ml cray-libsci/23.05.1.4  
make -f mymake clean
make -f mymake
export MPICH_GPU_SUPPORT_ENABLED=1
srun -N 2 --tasks-per-node=1 ./pp_cuda_aware 
