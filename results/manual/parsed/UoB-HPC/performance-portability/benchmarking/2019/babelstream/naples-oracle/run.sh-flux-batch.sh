#!/bin/bash
#FLUX: --job-name=arid-despacito-6559
#FLUX: --priority=16

export OMP_NUM_THREADS='64 OMP_PROC_BIND=spread OMP_PLACES=cores'

export OMP_NUM_THREADS=64 OMP_PROC_BIND=spread OMP_PLACES=cores
[ "$COMPILER" = pgi-18 ] && OMP_PROC_BIND=true # PGI compiler doesn't support OMP_PROC_BIND=spread
"./$BENCHMARK_EXE" > $BENCHMARK_EXE.out
