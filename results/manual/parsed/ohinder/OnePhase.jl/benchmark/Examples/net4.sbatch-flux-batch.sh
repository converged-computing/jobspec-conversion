#!/bin/bash
#FLUX: --job-name=net4
#FLUX: --queue=hns,normal
#FLUX: -t=172800
#FLUX: --urgency=16

ml load CUTEst/linux-cutest
ml load julia/precompiled/0.5.0
ml load hdf5
cd ~/one-phase-2.0/Examples
julia net4.jl
