#!/bin/bash
#FLUX: --job-name=crusty-pastry-9727
#FLUX: -t=3600
#FLUX: --urgency=16

module load julia/1.8.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
julia preprocess.jl
julia init_calibration.jl
echo 'Ensemble initialized for calibration.'
