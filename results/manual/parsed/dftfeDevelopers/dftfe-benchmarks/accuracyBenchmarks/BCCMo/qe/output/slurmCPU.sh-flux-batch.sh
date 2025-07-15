#!/bin/bash
#FLUX: --job-name=qe
#FLUX: -N=3
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'

export OMP_NUM_THREADS=2
mpirun -n 54 pw.x -input mo4x.scf.in > mo4xEcut50.scf.out
