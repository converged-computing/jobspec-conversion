#!/bin/bash
#FLUX: --job-name=com4521_run
#FLUX: -c=4
#FLUX: --queue=dcs-gpu-test
#FLUX: -t=600
#FLUX: --urgency=16

module load CUDAcore/11.1.1
module load gcccuda/2019b
./bin/release/assignment OPENMP SD 12 100
