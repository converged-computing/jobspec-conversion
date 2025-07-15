#!/bin/bash
#FLUX: --job-name=tart-caramel-4479
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --priority=16

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
array=($(ls run-exp3-a-*.json))
mpirun -np  48 ./benchmark_01 json "${array[@]}" | tee exp3a_annulus.txt
array=($(ls run-exp3-b-*.json))
mpirun -np  48 ./benchmark_01 json "${array[@]}" | tee exp3a_quadrant.txt
