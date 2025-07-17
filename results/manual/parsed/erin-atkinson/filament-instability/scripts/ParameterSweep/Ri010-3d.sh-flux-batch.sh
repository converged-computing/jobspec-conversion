#!/bin/bash
#FLUX: --job-name=filament-instability-Ri010-3d
#FLUX: -t=18000
#FLUX: --urgency=16

module load cuda/11.0.3
cd ~/filament-instability
./../julia-1.8.5/bin/julia -t 8 --project="env" -- src/simulation.jl 3d parameters/ParameterSweep/Ri010.txt 1 25 100 ../scratch/filament-instability/Ri010-3d
