#!/bin/bash
#FLUX: --job-name=CUTEst_one_phase
#FLUX: --queue=jduchi
#FLUX: -t=172800
#FLUX: --urgency=16

ml load CUTEst/linux-cutest
ml load julia/precompiled/0.5.0
ml load hdf5
julia run_one_phase.jl
