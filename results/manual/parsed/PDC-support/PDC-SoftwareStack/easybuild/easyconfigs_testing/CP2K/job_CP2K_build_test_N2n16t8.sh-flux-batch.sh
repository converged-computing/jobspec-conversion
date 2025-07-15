#!/bin/bash
#FLUX: --job-name=joyous-avocado-1110
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'
export OMP_PLACES='cores'

export OMP_NUM_THREADS=8
export OMP_PLACES=cores
ml PDC/21.11
ml EasyBuild-user/4.5.0
ml CP2K/2022.2-cpeGNU-21.11
tools/regtesting/do_regtest_dardel.sh -arch CP2K-2022.2-cpeGNU -version psmp -nobuild -mpiranks 32 -maxtasks 256 -ompthreads 8
