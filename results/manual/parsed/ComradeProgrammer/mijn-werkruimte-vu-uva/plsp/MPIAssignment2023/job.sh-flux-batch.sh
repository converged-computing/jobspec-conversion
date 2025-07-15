#!/bin/bash
#FLUX: --job-name=phat-parsnip-6767
#FLUX: -t=3600
#FLUX: --urgency=16

module load openmpi/gcc/64/4.0.2
module load julia/1.7.3
pwd
mpiexec -np 16 julia --project=. -e '
    include("solution.jl")
    for m in 1:3
       main_run(R=5,N=3200,method=m)
    end
'
julia --project=. -e '
    include("solution.jl")
    main_run(R=5,N=3200,method=0)
'
