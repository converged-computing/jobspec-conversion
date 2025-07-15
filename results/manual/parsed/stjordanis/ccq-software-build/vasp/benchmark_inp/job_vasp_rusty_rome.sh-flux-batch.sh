#!/bin/bash
#FLUX: --job-name=vasp-test-rome
#FLUX: --queue=ccq
#FLUX: -t=28800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module load vasp/6.1.2_gnu_ompi/module 
mpirun vasp_std
