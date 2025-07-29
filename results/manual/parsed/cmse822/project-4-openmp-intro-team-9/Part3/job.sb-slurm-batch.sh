#!/bin/bash
#SBATCH --job-name=p4p1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=4,amd20

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
