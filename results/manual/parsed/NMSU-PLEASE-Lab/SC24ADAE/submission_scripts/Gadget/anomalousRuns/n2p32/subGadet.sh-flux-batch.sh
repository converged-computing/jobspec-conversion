#!/bin/bash
#FLUX: --job-name=Gadget-CLEAN
#FLUX: -N=2
#FLUX: --exclusive
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
cp /anvil/projects/x-cis230165/testRuns/Gadget/ics-sizes/ic-s8.0 ICs
EXEC=../../Gadget2
EXECHPAS=/anvil/projects/x-cis230165/tools/HPAS/install/bin/hpas
srun --overlap --ntasks-per-node=32 --cpu-bind=map_cpu:0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60,64,68,72,76,80,84,88,92,96,100,104,108,112,116,120,124 ${EXECHPAS}  cpuoccupy -u 80 &
time srun --overlap --ntasks-per-node=32 --cpu-bind=map_cpu:0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60,64,68,72,76,80,84,88,92,96,100,104,108,112,116,120,124 ${EXEC} galaxy.param
