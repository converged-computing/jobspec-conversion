#!/bin/bash
#FLUX: --job-name=PipeFlow_%a
#FLUX: -n=32
#FLUX: -t=10
#FLUX: --urgency=16

filename="${SLURM_ARRAY_TASK_ID}"
cd $HOME/laminar/medMesh
chmod u=rwx,g=r,o=r Allrun
module load compiler/intel/2018/4\ mpi/intel/2018/4\ boost/1.69.0\ cmake/3.14.3\ fftw/3.3.8
source /apps/local/materials/OpenFOAM/v2106/el7/AVX512/intel-2018/intel-2018/OpenFOAM-v2106/etc/bashrc
./Preproc
mpirun -np 32 chtMultiRegionSimpleFoam -parallel
./Postproc
