#!/bin/bash
#FLUX: --job-name=gfn
#FLUX: -n=420
#FLUX: -t=1800
#FLUX: --urgency=16

cd $SCRATCH/jobs
julia="$PROJECT/julia-1.6.1/bin/julia"
module purge
module load openmpi
$julia << EOF
using ClusterManagers, Distributed
addprocs_slurm(parse(Int, ENV["SLURM_NTASKS"]));
@everywhere pushfirst!(Base.DEPOT_PATH, "/tmp/julia.cache")
@everywhere begin
   using Pkg
   const HOME = ENV["HOME"]
   Pkg.activate("$HOME/HelioseismicKernels")
end
@time using HelioseismicKernels
const num_ν = 4000
const ℓ_arr = 1:100
const r_obs = HelioseismicKernels.r_obs_default
const r_src = HelioseismicKernels.r_src_default
@time HelioseismicKernels.greenfn_components(r_src, num_ν = num_ν, ℓ_arr = ℓ_arr);
@time HelioseismicKernels.greenfn_components(r_src, num_ν = num_ν, ℓ_arr = ℓ_arr, c_scale = 1 + 1e-5);
@time HelioseismicKernels.greenfn_components(r_obs, num_ν = num_ν, ℓ_arr = ℓ_arr);
EOF
