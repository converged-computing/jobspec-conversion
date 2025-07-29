#!/bin/bash
#FLUX: --job-name=DagTrain1
#FLUX: -n=2
#FLUX: -c=2
#FLUX: --queue=debug
#FLUX: -t=10800
#FLUX: --urgency=16

export PATH='$PATH:~/julia-1.8.5/bin'

export PATH="$PATH:~/julia-1.8.5/bin"
julia --project="/home/sr8685/distributed_systems/DaggerTraining" --threads=auto /home/sr8685/distributed_systems/DaggerTraining/train_1.jl
