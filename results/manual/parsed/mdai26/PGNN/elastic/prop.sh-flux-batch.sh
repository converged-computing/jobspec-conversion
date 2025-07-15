#!/bin/bash
#FLUX: --job-name=crunchy-signal-0397
#FLUX: --urgency=16

module load intel/compiler
module load intel/mkl
module load fftw/impi/3.3.10
foldername="data_$SLURM_ARRAY_TASK_ID"
cd "$foldername"
mpirun -n 16 ./EffPropertyPoly.exe
cd ..
