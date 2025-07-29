#!/bin/bash
#FLUX: --job-name=p4p1
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR   
mpic++ -fopenmp matmulti_omp_mpi.cpp -o matmulti_omp_mpi
N=2000
for(( size = 1; size <=4; size *= 2))
do
    for(( threads = 1; threads <= 128; threads *= 2 ))
    do
        echo "-----------------------------------------------"
        echo "Running for number of threads:$threads and nodes:$size"
        echo "-----------------------------------------------"
        mpiexec -n $size ./matmulti_omp_mpi $threads $N
    done
done
scontrol show job $SLURM_JOB_ID     ### write job information to output file
