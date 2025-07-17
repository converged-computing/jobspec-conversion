#!/bin/bash
#FLUX: --job-name=WS2Spin
#FLUX: -N=4
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
mpirun -n 144 /scratch/vikramg_root/vikramg/dsambit/buildTest/release/real/dftfe parameterFile.prm > outputMesh2
