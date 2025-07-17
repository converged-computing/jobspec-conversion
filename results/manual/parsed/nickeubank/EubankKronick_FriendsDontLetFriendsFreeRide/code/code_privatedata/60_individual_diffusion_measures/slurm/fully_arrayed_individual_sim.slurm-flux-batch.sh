#!/bin/bash
#FLUX: --job-name=fully
#FLUX: -t=172800
#FLUX: --urgency=16

export CHUNK_SIZE='4'

export CHUNK_SIZE=4
julia fully_arrayed_individual_sim.jl
