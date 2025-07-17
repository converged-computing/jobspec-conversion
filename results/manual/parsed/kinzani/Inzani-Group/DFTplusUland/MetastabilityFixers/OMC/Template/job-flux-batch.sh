#!/bin/bash
#FLUX: --job-name=OMC_U_zzz
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export LD_LIBRARY_PATH='/sulis/easybuild/software/imkl/2019.5.281-gompi-2019b/mkl/lib/intel64:$LD_LIBRARY_PATH'

module purge
module load intel/2019b
export OMP_NUM_THREADS=1
export LD_LIBRARY_PATH=/sulis/easybuild/software/imkl/2019.5.281-gompi-2019b/mkl/lib/intel64:$LD_LIBRARY_PATH
./RunOMCparts1and2
