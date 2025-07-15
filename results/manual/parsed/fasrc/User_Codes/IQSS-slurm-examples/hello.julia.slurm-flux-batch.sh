#!/bin/bash
#FLUX: --job-name=fat-soup-9565
#FLUX: --priority=16

module load julia/1.1.1-fasrc01
chmod u+x ./hello.jl
./hello.jl
