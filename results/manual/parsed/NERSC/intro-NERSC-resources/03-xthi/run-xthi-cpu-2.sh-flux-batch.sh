#!/bin/bash
#FLUX: --job-name=run-xthi
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'
export OMP_PROC_BIND='close'
export OMP_PLACES='threads'

echo "use the default GNU compiler"
module load cpu
cc -fopenmp -o xthi xthi.c
export OMP_NUM_THREADS=8
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
srun -n 8 -c 32 --cpu-bind=cores ./xthi |sort -k4,6n
echo "try a different compiler, and different number of MPI tasks and threads"
module load PrgEnv-nvidia
cc -mp -o xthi xthi.c
export OMP_NUM_THREADS=4
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
srun -n 16 -c 16 --cpu-bind=cores ./xthi |sort -k4,6n
echo "try different OMP_PROC_BIND"
export OMP_PROC_BIND=close
srun -n 16 -c 16 --cpu-bind=cores ./xthi |sort -k4,6n
