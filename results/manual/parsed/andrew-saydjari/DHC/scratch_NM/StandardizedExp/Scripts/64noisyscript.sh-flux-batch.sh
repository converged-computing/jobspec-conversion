#!/bin/bash
#FLUX: --job-name=peachy-car-9872
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia runexp.jl "log" "apd" "iso" "../Nx64/noisy_stdtrue/"
