#!/bin/bash
#FLUX: --job-name=for_gst_2log
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/shared/hpc/matlab/$MATLAB_VER/bin/glnxa64:/shared/hpc/matlab/$MATLAB_VER/sys/os/glnxa64'
export PATH='$PATH:/shared/hpc/matlab/$MATLAB_VER/extern/include'

MATLAB_VER=R2021a
cd /home/lynch/boltzmann_solvers/mtmhbe_solver/solvers_fortran/laporta_grid_study
module load intel
module load intel-mkl
export OMP_NUM_THREADS=8
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/shared/hpc/matlab/$MATLAB_VER/bin/glnxa64:/shared/hpc/matlab/$MATLAB_VER/sys/os/glnxa64
export PATH=$PATH:/shared/hpc/matlab/$MATLAB_VER/extern/include
./grid_study_laporta_exe > /home/lynch/boltzmann_solvers/mtmhbe_solver/performance/laporta/grid_study/grid_sweep_data/laporta_mtmhbe_ET2_log_fortran.txt
