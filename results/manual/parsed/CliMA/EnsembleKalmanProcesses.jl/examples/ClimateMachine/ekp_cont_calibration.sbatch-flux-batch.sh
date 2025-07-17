#!/bin/bash
#FLUX: --job-name=ces_cont
#FLUX: -t=3600
#FLUX: --urgency=16

module load julia/1.5.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
iteration_=${1?Error: no iteration given}
julia --project sstep_calibration.jl --iteration $iteration_
echo "Ensemble ${iteration_} recovery finished."
mv clima_param_defs*.jl ../../../ClimateMachine.jl/test/Atmos/EDMF/
