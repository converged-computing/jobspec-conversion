#!/bin/bash
#FLUX: --job-name=butterscotch-signal-2449
#FLUX: --queue=main
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load julia/1.10.2
julia script.jl
