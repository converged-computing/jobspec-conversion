#!/bin/bash
#FLUX: --job-name=blank-signal-5628
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia runexp_triu_logcoeff.jl "reg" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_10_full_triu" "Full+Eps" 10
