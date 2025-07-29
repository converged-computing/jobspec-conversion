#!/bin/bash
#FLUX: --job-name=upwindAcc_p100
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

exe="@CMAKE_BINARY_DIR@/upwind/cxx/upwindAccCxx"
time srun $exe -numCells 1024 -numSteps 10
