#!/bin/bash
#FLUX: --job-name=swampy-punk-8082
#FLUX: --urgency=16

module load julia/1.1.1-fasrc01
chmod u+x ./hello.jl
./hello.jl
