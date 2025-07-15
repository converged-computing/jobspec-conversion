#!/bin/bash
#FLUX: --job-name=tax2D
#FLUX: -t=172800
#FLUX: --urgency=16

ml load CUTEst/linux-cutest
ml load julia/precompiled/0.5.0
ml load hdf5
cd ~/one-phase-2.0/Examples
julia tax2D.jl
