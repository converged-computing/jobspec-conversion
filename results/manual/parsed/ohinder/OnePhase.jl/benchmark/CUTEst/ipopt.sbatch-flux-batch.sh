#!/bin/bash
#FLUX: --job-name=CUTEst_IPOPT
#FLUX: -t=172800
#FLUX: --priority=16

ml load CUTEst/linux-cutest
ml load julia/precompiled/0.5.0
ml load hdf5
julia run_ipopt.jl
