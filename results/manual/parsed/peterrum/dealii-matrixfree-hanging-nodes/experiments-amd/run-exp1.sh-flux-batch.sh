#!/bin/bash
#FLUX: --job-name=hello-earthworm-9168
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --urgency=16

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
array=($(ls run-exp1-a-*.json))
mpirun -np  48 ./benchmark_01 json "${array[@]}" | tee exp1_annulus.txt
array=($(ls run-exp1-c-*.json))
mpirun -np  48 ./benchmark_01 json "${array[@]}" | tee exp1_quadrant.txt
