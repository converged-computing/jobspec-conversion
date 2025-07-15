#!/bin/bash
#FLUX: --job-name=placid-hope-5900
#FLUX: --priority=16

module purge
module load Julia/1.7.1-linux-x86_64
julia --threads 48 mapped.jl
