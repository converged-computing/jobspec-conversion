#!/bin/bash
#FLUX: --job-name=fort_Ne_sweeo
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/shared/hpc/matlab/$MATLAB_VER/bin/glnxa64:/shared/hpc/matlab/$MATLAB_VER/sys/os/glnxa64'
export PATH='$PATH:/shared/hpc/matlab/$MATLAB_VER/extern/include'

MATLAB_VER=R2022a
cd /home/lynch/boltzmann_solvers/mtmhbe_solver/solvers_fortran/time-dependent-pulse-Neps
module load intel
module load intel-mkl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/shared/hpc/matlab/$MATLAB_VER/bin/glnxa64:/shared/hpc/matlab/$MATLAB_VER/sys/os/glnxa64
export PATH=$PATH:/shared/hpc/matlab/$MATLAB_VER/extern/include
./loki_b_pulse_exe > fort_Ne_sweep.txt
