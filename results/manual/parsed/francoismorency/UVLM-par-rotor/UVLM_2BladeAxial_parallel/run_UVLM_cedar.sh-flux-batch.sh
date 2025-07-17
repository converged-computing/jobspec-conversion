#!/bin/bash
#FLUX: --job-name=6
#FLUX: -c=48
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$MATLABHOME/bin/glnxa64'
export OMP_NUM_THREADS='6'

module load matlab/2022a
MATLABHOME=/cvmfs/restricted.computecanada.ca/easybuild/software/2020/Core/matlab/2022a
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MATLABHOME/bin/glnxa64
make -f Makefile_cedar.mk clean
make -f Makefile_cedar.mk MATLABHOME=$MATLABHOME
export OMP_NUM_THREADS=6
./UVLM_2_Blade_Rotor_Axial 6
