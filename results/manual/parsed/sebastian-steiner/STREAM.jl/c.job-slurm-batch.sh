#!/bin/bash
#SBATCH --output=c.out
#SBATCH --error=c.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:15:00

export OMP_NUM_THREADS='32'

export OMP_NUM_THREADS=32
srun gcc -mcmodel=medium -fopenmp -O3 -DSTREAM_ARRAY_SIZE=1000000000 -DNTIMES=100 -o stream stream.c
srun likwid-pin -c N:0-31 ./stream
