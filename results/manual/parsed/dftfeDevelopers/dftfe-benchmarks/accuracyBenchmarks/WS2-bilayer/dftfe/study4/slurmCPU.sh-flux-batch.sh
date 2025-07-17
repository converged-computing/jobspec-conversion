#!/bin/bash
#FLUX: --job-name=WS2
#FLUX: -N=8
#FLUX: -t=360000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
mpirun -n 288 /scratch/vikramg_root/vikramg/dsambit/buildChebyOpt/release/real/dftfe parameterFile.prm > outputFeorder7Mesh1p6Atomballradius6p0Relaxation
