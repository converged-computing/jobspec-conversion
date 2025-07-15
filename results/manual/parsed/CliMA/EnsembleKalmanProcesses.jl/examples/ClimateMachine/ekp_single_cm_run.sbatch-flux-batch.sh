#!/bin/bash
#FLUX: --job-name=stanky-ricecake-5521
#FLUX: -t=3600
#FLUX: --urgency=16

module load julia/1.5.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
iteration_=${1?Error: no iteration given}
run_num=${SLURM_ARRAY_TASK_ID}
version=$(head -"$run_num" "versions_"$iteration_".txt" | tail -1)
julia --project=../../../ClimateMachine.jl ../../../ClimateMachine.jl/test/Atmos/EDMF/stable_bl_anelastic1d.jl --diagnostics 60ssecs --cparam-file $version
mv ../../../ClimateMachine.jl/test/Atmos/EDMF/$version $version'.output/'
echo "CM simulation for ${version} in iteration ${iteration_} finished"
