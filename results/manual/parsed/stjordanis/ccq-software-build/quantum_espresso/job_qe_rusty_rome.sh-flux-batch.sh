#!/bin/bash
#FLUX: --job-name="qe-test-rome"
#FLUX: --queue=ccq
#FLUX: -t=28800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load quantum_espresso/6.6_gnu_ompi/module
mpirun pw.x < si.scf.in > si.scf.out
