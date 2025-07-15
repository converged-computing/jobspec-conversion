#!/bin/bash
#FLUX: --job-name=qe
#FLUX: -N=3
#FLUX: -t=36000
#FLUX: --priority=16

export OMP_NUM_THREADS='2'

export OMP_NUM_THREADS=2
mpirun -n 108 pw.x -npool 1 -input WS2Ecut50.scf.in > WS2Ecut50.scf.out
