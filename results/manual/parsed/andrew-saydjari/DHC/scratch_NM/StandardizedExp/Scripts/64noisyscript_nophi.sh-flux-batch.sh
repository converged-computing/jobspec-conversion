#!/bin/bash
#FLUX: --job-name=64_noisy
#FLUX: -n=2
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia runexp_nophi.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/"
