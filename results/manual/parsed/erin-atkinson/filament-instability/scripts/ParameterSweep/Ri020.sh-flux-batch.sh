#!/bin/bash
#FLUX: --job-name=filament-instability-Ri020
#FLUX: -t=86400
#FLUX: --priority=16

module load cuda/11.0.3
cd ~/filament-instability
./../julia-1.8.5/bin/julia -t 8 --project="env" -- src/simulation.jl secondarycirculation parameters/ParameterSweep/Ri020.txt 1 50 100 ../scratch/filament-instability/Ri020
