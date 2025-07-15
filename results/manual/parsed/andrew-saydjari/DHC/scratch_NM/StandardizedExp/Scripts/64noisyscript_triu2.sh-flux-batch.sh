#!/bin/bash
#FLUX: --job-name=tart-caramel-0695
#FLUX: --priority=16

module load Julia/1.5.3-linux-x86_64
julia runexp_triu.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_fullcov_triu" "Full+Eps"
