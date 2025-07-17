#!/bin/bash
#FLUX: --job-name=LIKWID
#FLUX: -N=16
#FLUX: --queue=micro
#FLUX: -t=7200
#FLUX: --urgency=16

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
mpirun -np 768 ./benchmark_02 quadrant 9 4 0 1 | tee exp4_b_0_1.txt
mpirun -np 768 ./benchmark_02 quadrant 9 4 1 0 | tee exp4_b_1_0.txt
mpirun -np 768 ./benchmark_02 quadrant 9 4 0 0 | tee exp4_b_0_0.txt
