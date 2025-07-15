#!/bin/bash
#FLUX: --job-name=julia_cpu_example
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --urgency=16

module load julia/1.9 cuda/12.2 
julia julia_cpu.jl
