#!/bin/bash
#FLUX: --job-name=job-serial
#FLUX: -t=180
#FLUX: --urgency=16

ml purge  > /dev/null 2>&1
ml Julia/1.8.5-linux-x86_64
ml CUDA/11.4.1
julia script-gpu.jl
