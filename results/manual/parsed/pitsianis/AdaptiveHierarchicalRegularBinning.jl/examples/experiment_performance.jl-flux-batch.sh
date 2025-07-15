#!/bin/bash
#FLUX: --job-name=phat-pastry-4491
#FLUX: --priority=16

echo julia --project=. -t$SLURM_CPUS_PER_TASK --compiled-modules=no $(scontrol show job=$SLURM_JOBID | awk -F= '/Command=/{print $2}')
julia --project=. -t$SLURM_CPUS_PER_TASK --compiled-modules=no $(scontrol show job=$SLURM_JOBID | awk -F= '/Command=/{print $2}')
exit
using DrWatson
@quickactivate "AHRB"
using AdaptiveHierarchicalRegularBinning, BenchmarkTools, Random
include( "benchmarkutils.jl" )
force = true
path = datadir("experiments")
savecmd = exp -> savename("version-aug7-block-ecp-2023-dimitris", exp; ignores = ["cpu"], allowedtypes = (Real, String, Symbol, DataType))
general_args = Dict(
  :n => [(1:10) .* 1_000_000;], 
  :d => [2:4:42;],
  :seed => 0,
  :enctype => [UInt128],
  :l => 3,
  :lstep => 3,
  :p => 2^7,
  :np => Threads.nthreads(),
  :hostname => gethostname(),
  :cpu => Sys.cpu_info()[1].model,
  :distribution => ["uniform"]
)
list_experiments = dict_list(general_args)
map( list_experiments ) do experiment
  data, _ = @produce_or_load(run_experiment, experiment, path; filename = savecmd, 
    tag = true, storepatch=true, force = force, 
    wsave_kwargs = Dict(:compress => true) )
end
