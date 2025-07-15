#!/bin/bash
#FLUX: --job-name=PipeFlow_%a
#FLUX: -n=32
#FLUX: -t=1
#FLUX: --priority=16

cd /lustrehome/home/s.2115589/caseDatabase/
module load compiler/intel/2018/4\ mpi/intel/2018/4\ boost/1.69.0\ cmake/3.14.3\ fftw/3.3.8
source /apps/local/materials/OpenFOAM/v2106/el7/AVX512/intel-2018/intel-2018/OpenFOAM-v2106/etc/bashrc
./Preproc
