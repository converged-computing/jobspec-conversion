#!/bin/bash
#FLUX: --job-name=ces_cont
#FLUX: -t=3600
#FLUX: --urgency=16

module load julia/1.8.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
iteration_=${1?Error: no iteration given}
julia sstep_calibration.jl --iteration $iteration_
echo "Ensemble ${iteration_} recovery finished."
