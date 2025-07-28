#!/bin/bash
#FLUX: --job-name=train
#FLUX: --queue=ampere
#FLUX: -t=21600
#FLUX: --urgency=16

julia --project=. initialise_env.jl
julia --project=. src/scripts/train_student.jl
