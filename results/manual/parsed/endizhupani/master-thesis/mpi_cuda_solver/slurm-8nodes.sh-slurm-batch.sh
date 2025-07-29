#!/bin/bash
#FLUX: --job-name=custom-solver-8nodes
#FLUX: -N=8
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=gpu2080
#FLUX: -t=54000
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'
export I_MPI_DEBUG='3'
export I_MPI_FABRICS='shm:tcp'

module load intelcuda/2019a
module load CMake/3.15.3
cd /home/e/e_zhup01/mpi_cuda_solver
./build-release.sh
export OMP_NUM_THREADS=24
export I_MPI_DEBUG=3
export I_MPI_FABRICS=shm:tcp
for cpu_p in `seq 0.1 0.1 0.3`; do
    for m_size in 512 1000 5000 10000; do
        for gpu_n in 1 4; do
        mpirun /home/e/e_zhup01/mpi_cuda_solver/build/mpi_cuda_solver.exe $m_size $gpu_n $cpu_p 5 "/scratch/tmp/e_zhup01/custom-impl-measurements/stats_n8_try3.csv"
        done
    done    
done
