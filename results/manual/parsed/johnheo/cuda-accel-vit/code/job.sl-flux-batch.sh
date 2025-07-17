#!/bin/bash
#FLUX: --job-name=blank-pancake-1833
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk
./go 50 384 6
./go 100 384 6
./go 200 384 6
./go 400 384 6
./go 800 384 6
./go 1000 384 6
