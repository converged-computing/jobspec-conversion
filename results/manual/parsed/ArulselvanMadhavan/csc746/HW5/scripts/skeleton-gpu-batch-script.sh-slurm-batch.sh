#!/bin/bash
#SBATCH --job-name=gpu-job
#SBATCH --output=gpu-job.o%j
#SBATCH --error=gpu-job.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=00:05:00
#SBATCH --constraint=gpu

export LIBOMPTARGET_INFO='4'

export LIBOMPTARGET_INFO=4
for N in 1 2 4 8 12 16
do
    echo "Running OMP_NUM_THREADS=$N"
    export OMP_NUM_THREADS=$N
    export OMP_PLACES=threads
    export OMP_PROC_BIND=spread
    ./sobel_cpu > ../logs/cpu/sobel_cpu_$N.txt 2>&1
done
