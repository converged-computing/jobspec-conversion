#!/bin/bash
#FLUX: --job-name=blank-underoos-6042
#FLUX: -n=200
#FLUX: -t=28800
#FLUX: --urgency=16

module load StdEnv/2020
module load julia/1.8.5
srun julia SkX_MonoLayer_Run.jl inputParametersMonoLayer
