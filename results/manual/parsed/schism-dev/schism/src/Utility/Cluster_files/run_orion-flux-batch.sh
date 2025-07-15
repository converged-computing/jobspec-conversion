#!/bin/bash
#FLUX: --job-name=delicious-buttface-1067
#FLUX: --exclusive
#FLUX: --urgency=16

set -e
ulimit -s unlimited 
module load intel/2020 impi/2020 netcdf/4.7.2-parallel
srun ./pschism_ORION_TVD-VL 8
