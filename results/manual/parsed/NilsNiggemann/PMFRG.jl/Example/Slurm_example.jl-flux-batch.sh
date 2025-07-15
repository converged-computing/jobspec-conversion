#!/bin/bash
#FLUX: --job-name=SquareLattice
#FLUX: -c=32
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --priority=16

module load lang/Julia/1.8.2-linux-x86_64; julia -O3 -t $SLURM_CPUS_PER_TASK <path/to/this/file/>.Slurm_example.jl $SLURM_ARRAY_TASK_ID
exit
=#
using Pkg
Pkg.activate(@__DIR__)
cd(@__DIR__)
using PMFRG, SquareLattice
using PMFRG: h5write
strd(x) = string(round(x, digits = 3))
i_arg = parse(Int, ARGS[1])
NLen = 12
Trange = 0.2:0.1:2.0
J2range = 0.025:0.025:0.175
jobsarray = [(t, j) for t in Trange, j in J2range]
T, J2 = jobsarray[i_arg]
@info "(NLen,J2,T) = $NLen, $J2, $T"
@info "Job $i_arg / $(jobsarray |> length)"
@time System = getSquareLattice(NLen, [1.0, J2])
Par = Params(
    System,
    OneLoop(),
    T = T,
    MinimalOutput = false,
    N = 64,
    Ngamma = 64,
    accuracy = 1E-8,
    Lam_max = exp(10.0),
    Lam_min = exp(-10.0),
)
mainFile =
    "../Data/J1J2Tsweep/" * PMFRG.generateFileName(Par, "_T=_$(strd(T))_J2=_$(strd(J2))")
flowpath = "/scratch/<path_to_scratch>/$i_arg/"
flush(stdout)
Group = "J2:" * strd(J2) * "/T:" * strd(T)
Solution, saved_values = SolveFRG(
    Par,
    MainFile = mainFile,
    CheckpointDirectory = flowpath,
    method = DP5(),
    VertexCheckpoints = [],
    CheckPointSteps = 10;
    Group,
)
h5write(mainFile, Group * "/J2", J2) #save additional metadata
