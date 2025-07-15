#!/bin/bash
#FLUX: --job-name=purple-noodle-5621
#FLUX: -c=4
#FLUX: -t=9296
#FLUX: --priority=16

module purge
module load StdEnv/2023
module load cuda # Remove this line if not using a GPU
module load julia/1.9
module lead nvptx-tools
julia --project src/SkySurveillance.jl params-test.toml
