#!/bin/bash
#FLUX: --job-name=CORIE
#FLUX: -N=2
#FLUX: -n=80
#FLUX: --exclusive
#FLUX: --queue=orion
#FLUX: -t=7200
#FLUX: --urgency=16

set -e
ulimit -s unlimited 
module load intel/2020 impi/2020 netcdf/4.7.2-parallel
srun ./pschism_ORION_TVD-VL 8
