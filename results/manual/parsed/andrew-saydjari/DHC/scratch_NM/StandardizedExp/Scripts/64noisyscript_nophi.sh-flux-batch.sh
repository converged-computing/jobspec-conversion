#!/bin/bash
#FLUX: --job-name=delicious-noodle-0404
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia runexp_nophi.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/"
