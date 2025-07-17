#!/bin/bash
#FLUX: --job-name=drycblles
#FLUX: -n=128
#FLUX: --queue=thin
#FLUX: -t=28800
#FLUX: --urgency=16

toolkit="gcc"     # gcc/intel
module purge
module load 2021
if [ "$toolkit" = "gcc" ]; then
    module load CMake/3.20.1-GCCcore-10.3.0
    module load foss/2021a
    module load netCDF/4.8.0-gompi-2021a
elif [ "$toolkit" = "intel" ]; then
    module load intel/2021a
    module load netCDF/4.8.0-iimpi-2021a
    module load FFTW/3.3.9-intel-2021a
fi
srun ./microhh init drycblles
srun ./microhh run drycblles
