#!/bin/bash
#FLUX: --job-name=HEAT-CPU
#FLUX: --exclusive
#FLUX: --queue=cg4-cpu4x120gb-gpu4x80gb
#FLUX: --urgency=16

export PATH='/home/wwei/install/cmake_3_27_3/bin/:$PATH'

set +x
BUILD_HOME=${HOME}/repos/nvstdpar/build-heat-cpu
mkdir -p ${BUILD_HOME}
cd ${BUILD_HOME}
rm -rf ./*
module unload gcc; module load gcc/12.3.0; module load nvhpc/23.5; module load slurm
export PATH=/home/wwei/install/cmake_3_27_3/bin/:$PATH
cmake .. -DCMAKE_BUILD_TYPE=Release -DSTDPAR=multicore -DOMP=multicore -DCMAKE_CXX_COMPILER=$(which nvc++)
make -j heat-equation-omp heat-equation-serial heat-equation-stdexec heat-equation-stdpar
cd ${BUILD_HOME}/apps/heat-equation
T=(256 128 64 32 16 8 4 2 1)
unset OMP_NUM_THREADS
for i in "${T[@]}"; do
    echo "heat:omp, threads=${i}"
    srun -n 1 --cpu-bind=none ./heat-equation-omp -s=1000 -n=46000 --time --nthreads=${i}
    echo "heat:stdexec, threads=${i}"
    srun -n 1 --cpu-bind=none ./heat-equation-stdexec -s=1000 -n=46000 --time --nthreads=${i}
done
for i in "${T[@]}"; do
    echo "heat:stdpar, threads=${i}"
    export OMP_NUM_THREADS=${i}
    srun -n 1 --cpu-bind=none ./heat-equation-stdpar -s=1000 -n=46000 --time
done
unset OMP_NUM_THREADS
echo "heat:serial"
srun -n 1 --cpu-bind=none ./heat-equation-serial -s=1000 -n=46000 --time
