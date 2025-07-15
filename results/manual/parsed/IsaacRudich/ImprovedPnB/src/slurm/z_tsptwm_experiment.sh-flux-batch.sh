#!/bin/bash
#FLUX: --job-name=evasive-dog-6906
#FLUX: -t=5400
#FLUX: --urgency=16

module load julia
julia z_tsptwm_experiment.jl $setnum $instance
