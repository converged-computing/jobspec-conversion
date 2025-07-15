#!/bin/bash
#FLUX: --job-name=arid-nalgas-6352
#FLUX: -t=5400
#FLUX: --priority=16

module load julia
julia z_tsptwm_experiment.jl $setnum $instance
