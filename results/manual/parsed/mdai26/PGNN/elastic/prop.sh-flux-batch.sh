#!/bin/bash
#FLUX: --job-name=pusheena-pancake-7889
#FLUX: --priority=16

module load intel/compiler
module load intel/mkl
module load fftw/impi/3.3.10
foldername="data_$SLURM_ARRAY_TASK_ID"
cd "$foldername"
mpirun -n 16 ./EffPropertyPoly.exe
cd ..
