#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='64 OMP_PROC_BIND=spread OMP_PLACES=cores'

export OMP_NUM_THREADS=64 OMP_PROC_BIND=spread OMP_PLACES=cores
[ "$COMPILER" = pgi-18 ] && OMP_PROC_BIND=true # PGI compiler doesn't support OMP_PROC_BIND=spread
"./$BENCHMARK_EXE" > $BENCHMARK_EXE.out
