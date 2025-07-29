#!/bin/bash
#FLUX: --job-name=mo4x
#FLUX: -N=2
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
mpirun -n 72 /scratch/vikramg_root/vikramg/dsambit/buildnew/release/real/dftfe parameterFileCPU.prm > outputFEOrder7Meshsize2p0
