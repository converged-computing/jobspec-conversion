#!/bin/bash
#SBATCH --job-name=1D-CPU
#SBATCH --account=nstaff
#SBATCH --output=1d-cpu.o%j
#SBATCH --error=1d-cpu.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=1-00:00:00
#SBATCH --qos=regular
#SBATCH --exclusive
#SBATCH --constraint=cpu,ntasks-per-node=1

set +x
BUILD_HOME=${HOME}/repos/nvstdpar/build-1d-cpu
mkdir -p ${BUILD_HOME}
cd ${BUILD_HOME}
rm -rf ./*
ml unload cudatoolkit
ml use /global/cfs/cdirs/m1759/wwei/nvhpc_23_7/modulefiles
ml nvhpc/23.7
ml gcc/12.2.0
ml cmake/3.24
oneDimension_size=1000000000
oneDimension_iterations=4000
cmake .. -DSTDPAR=multicore -DOMP=multicore -DCMAKE_CXX_COMPILER=$(which nvc++)
make -j
cd ${BUILD_HOME}/apps/1d_stencil
T=(256 128 64 32 16 8 4 2 1)
unset OMP_NUM_THREADS
for i in "${T[@]}"; do
    echo "1d:omp, threads=${i}"
    srun -n 1 --cpu-bind=none ./stencil_omp --size $oneDimension_size --nt $oneDimension_iterations --nthreads=$i
    echo "1d:stdexec, threads=${i}"
    srun -n 1 --cpu-bind=none ./stencil_stdexec --sch cpu --size $oneDimension_size --nt $oneDimension_iterations --nthreads=$i
done
for i in "${T[@]}"; do
    echo "1d:stdpar, threads=${i}"
    export OMP_NUM_THREADS=${i}
    srun -n 1 --cpu-bind=none ./stencil_stdpar --size $oneDimension_size --nt $oneDimension_iterations
done
unset OMP_NUM_THREADS
echo "1d:serial"
srun -n 1 --cpu-bind=none ./stencil_serial --size $oneDimension_size --nt $oneDimension_iterations
