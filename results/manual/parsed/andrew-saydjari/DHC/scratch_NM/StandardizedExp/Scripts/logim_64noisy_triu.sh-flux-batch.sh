#!/bin/bash
#FLUX: --job-name=tart-truffle-8500
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia runexp_triu.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_triu"
