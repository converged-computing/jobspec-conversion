#!/bin/bash
#FLUX: --job-name=4mpi-alt
#FLUX: -N=4
#FLUX: -c=16
#FLUX: -t=1800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$HOME/build/NAMD/NAMD_3.0b6_Source/tcl/lib:$HOME/build/NAMD/NAMD_3.0b6_Source/fftw/lib:$LD_LIBRARY_PATH'
export PATH='$HOME/build/NAMD/NAMD_3.0b6_Source/charm-v7.0.0/bin:$PATH'

module purge
module load compilers/gcc/13 libraries/openmpi/5.0.3/gcc-13 tools/cmake
export LD_LIBRARY_PATH="$HOME/build/NAMD/NAMD_3.0b6_Source/tcl/lib:$HOME/build/NAMD/NAMD_3.0b6_Source/fftw/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/build/NAMD/NAMD_3.0b6_Source/charm-v7.0.0/bin:$PATH"
mpirun ~/build/NAMD/NAMD_3.0b6_Source/Linux-ARM64-g++/namd3 +ppn 15 +pemap 1-15 +commap 0 ~/build/apoa1/apoa1.namd
