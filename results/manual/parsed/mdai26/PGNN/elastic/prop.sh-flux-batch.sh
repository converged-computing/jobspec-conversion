#!/bin/bash
#FLUX: --job-name=creamy-fork-6362
#FLUX: --queue=research
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel/compiler
module load intel/mkl
module load fftw/impi/3.3.10
foldername="data_$SLURM_ARRAY_TASK_ID"
cd "$foldername"
mpirun -n 16 ./EffPropertyPoly.exe
cd ..
