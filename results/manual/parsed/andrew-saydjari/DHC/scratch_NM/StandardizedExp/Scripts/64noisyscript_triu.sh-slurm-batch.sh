#!/bin/bash
#FLUX: --job-name=64_noisy
#FLUX: -n=2
#FLUX: --queue=shared
#FLUX: -t=1200
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia lambda_runexp_triu.jl "reg" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_tunedlam_0-01_diag_triu" "Diagonal+Eps"
