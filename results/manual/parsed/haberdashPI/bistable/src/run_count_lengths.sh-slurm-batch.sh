#!/bin/bash
#FLUX: --job-name=bistable
#FLUX: -c=8
#FLUX: --queue=shared
#FLUX: -t=7200
#FLUX: --urgency=16

julia  -e 'using Pkg; Pkg.activate("projects/bistable")' \
       -e 'include("projects/bistable/src/run_count_lengths.jl")' \
       -O3 --banner=no $@
