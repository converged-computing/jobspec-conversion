#!/bin/bash
#FLUX: --job-name="qe-test-rome"
#FLUX: --queue=ccq
#FLUX: -t=28800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm quantum_espresso/7.0_gnu_ompi
mpirun pw.x < si.scf.in > si.scf.out
