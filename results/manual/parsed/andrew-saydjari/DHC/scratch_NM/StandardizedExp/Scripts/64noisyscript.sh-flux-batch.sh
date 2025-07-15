#!/bin/bash
#FLUX: --job-name=grated-destiny-7175
#FLUX: --priority=16

module load Julia/1.5.3-linux-x86_64
julia runexp.jl "log" "apd" "iso" "../Nx64/noisy_stdtrue/"
