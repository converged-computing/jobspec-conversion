#!/bin/bash
#FLUX: --job-name=PipeFlow_%a
#FLUX: -n=40
#FLUX: -t=10
#FLUX: --urgency=16

module load compiler/gnu/12 mpi/openmpi/4.1.5 boost/1.82.0 fftw/3.3.10 cmake/3.14.3
source /apps/local/materials/OpenFOAM/v2212/el7/AVX512/gnu-12.1/openmpi-4.1/OpenFOAM-v2212/etc/bashrc
./Preproc
mpirun -np 40 chtMultiRegionSimpleFoam -parallel
./Postproc
