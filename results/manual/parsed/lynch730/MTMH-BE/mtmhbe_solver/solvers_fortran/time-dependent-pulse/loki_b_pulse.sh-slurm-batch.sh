#!/bin/bash
#FLUX: --job-name=NLK_sweep
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/shared/hpc/matlab/$MATLAB_VER/bin/glnxa64:/shared/hpc/matlab/$MATLAB_VER/sys/os/glnxa64'
export PATH='$PATH:/shared/hpc/matlab/$MATLAB_VER/extern/include'

MATLAB_VER=R2021a
cd /home/lynch/boltzmann_solvers/mtmhbe_solver/solvers_fortran/time-dependent-pulse
module load intel
module load intel-mkl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/shared/hpc/matlab/$MATLAB_VER/bin/glnxa64:/shared/hpc/matlab/$MATLAB_VER/sys/os/glnxa64
export PATH=$PATH:/shared/hpc/matlab/$MATLAB_VER/extern/include
./loki_b_pulse_exe > loki_b_out.txt
