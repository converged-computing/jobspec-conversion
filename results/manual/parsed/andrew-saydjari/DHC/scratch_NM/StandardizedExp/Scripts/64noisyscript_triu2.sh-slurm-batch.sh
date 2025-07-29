#!/bin/bash
#FLUX: --job-name=64_noisy
#FLUX: -n=4
#FLUX: --queue=shared
#FLUX: -t=1200
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia runexp_triu.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_fullcov_triu" "Full+Eps"
