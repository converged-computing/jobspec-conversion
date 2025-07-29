#!/bin/bash
#SBATCH --job-name=PkgCompiler
#SBATCH --output=logs/ABC/pkgcomp/o.%x-%A.o
#SBATCH --error=logs/ABC/pkgcomp/o.%x-%A.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=00:35:00
#SBATCH --partition=public

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
