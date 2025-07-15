#!/bin/bash
#FLUX: --job-name=arid-bike-3339
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia runexp_triu_logcoeff.jl "reg" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_1-0_full_triu" "Full+Eps" 1.0
