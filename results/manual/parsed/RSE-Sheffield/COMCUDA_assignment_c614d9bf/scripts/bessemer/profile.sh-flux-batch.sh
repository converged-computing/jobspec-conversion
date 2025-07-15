#!/bin/bash
#FLUX: --job-name=com4521_profile
#FLUX: -c=4
#FLUX: --queue=dcs-gpu-test
#FLUX: -t=600
#FLUX: --urgency=16

module load CUDAcore/11.1.1
module load gcccuda/2019b
nvprof -o timeline.nvvp "./bin/release/assignment" CUDA SD 12 100
nvprof --analysis-metrics -o analysis.nvprof "./bin/release/assignment" CUDA SD 12 100
