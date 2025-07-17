#!/bin/bash
#FLUX: --job-name=g_3e-2
#FLUX: -c=16
#FLUX: -t=18000
#FLUX: --urgency=16

    pwd
    module swap julia julia/1.8.0
    module list
    echo $SLURM_NPROCS
    echo $SLURM_CPUS_PER_TASK
    echo
    srun julia --threads=$SLURM_CPUS_PER_TASK stationary_distribution_generation.jl
    exit
=#
using Pkg
Pkg.activate(@__DIR__)
include("src/StrainSurveys.jl")
include("src/jobname_parser.jl")
using Random
Random.seed!(42)
ndis_vals = 2 .^ UnitRange(1, parse(Int, ENV["SLURM_ARRAY_TASK_COUNT"]))
@show jobname = ENV["SLURM_JOB_NAME"]
@show jobid = ENV["SLURM_ARRAY_TASK_ID"]
nsamples = 2^13
@show myγ = jobname_parser( jobname, "g", Float64; connector = "_" )
@show mynumber = parse(Int, jobid)
@show alpha = 1.8
@show myLx = 48 + 8 * (mynumber - 1)
@show myNd = round(Int, myγ * Float64(myLx)^alpha )  
params = DistributionParameters(; Lx = myLx, ndislocations = myNd, rtol = 0.001, nsamples = nsamples |> Int)
@time main( params; save_output = true )
