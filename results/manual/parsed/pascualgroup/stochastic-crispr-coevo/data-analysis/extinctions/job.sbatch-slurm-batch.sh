#!/bin/bash
#FLUX: --job-name=crispr-test
#FLUX: --queue=broadwl
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load julia
julia /home/armun/crispr-sweep-6-9-2021/main.jl parameters.json &> script_output.txt
