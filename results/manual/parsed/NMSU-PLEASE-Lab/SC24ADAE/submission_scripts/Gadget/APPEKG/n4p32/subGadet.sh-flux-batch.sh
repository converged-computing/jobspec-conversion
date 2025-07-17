#!/bin/bash
#FLUX: --job-name=Gadget-CLEAN
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=wholenode
#FLUX: -t=1800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/apps/spack/anvil/apps/fftw/2.1.5-gcc-8.4.1-cac36sv/lib'

module load gsl/2.4
module load gcc/11.2.0
module load openmpi/4.0.6
mkdir -p galaxy
mkdir -p parameterfiles
mkdir -p ICs
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/apps/spack/anvil/apps/fftw/2.1.5-gcc-8.4.1-cac36sv/lib
cp /anvil/projects/x-cis230165/apps/Gadget-2.0.7/Gadget2/parameterfiles/galaxy.param .
cp /anvil/projects/x-cis230165/apps/Gadget-2.0.7/Gadget2/parameterfiles/outputs_lcdm_gas.txt parameterfiles
cp /anvil/projects/x-cis230165/testRuns/Gadget/ics-sizes/ic-s12.0 ICs
EXEC=../../Gadget2
time srun --ntasks-per-node=32 ${EXEC} galaxy.param
