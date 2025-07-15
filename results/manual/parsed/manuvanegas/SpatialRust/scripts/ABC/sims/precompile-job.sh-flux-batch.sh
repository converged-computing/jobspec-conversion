#!/bin/bash
#FLUX: --job-name=spicy-taco-2236
#FLUX: -n=5
#FLUX: --priority=16

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
julia -e '
	using Pkg;
	Pkg.activate(".");
comptime = @elapsed using SpatialRust;
println("Time to compile: $comptime")'
julia --machine-file $SLURM_NODEFILE -e '@everywhere begin;
	using Pkg;
	Pkg.activate(".");
end;
usingtime = @elapsed @everywhere using SpatialRust;
println("Time to load again: $usingtime");
flush(stdout);
using Arrow, DataFrames;
using Tables: namedtupleiterator;
run_time = @elapsed begin;
    parameters = DataFrame(Arrow.Table(string("data/ABC/parameters_8.arrow")))[1:20,:];
    wp = CachingPool(workers());
    outputs = abc_pmap(Tables.namedtupleiterator(parameters), wp);
end;
println("Time to run: $run_time")
'
