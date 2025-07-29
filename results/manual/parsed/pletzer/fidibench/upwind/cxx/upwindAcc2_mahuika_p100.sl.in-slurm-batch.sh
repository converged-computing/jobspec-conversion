#!/bin/bash
#FLUX: --job-name=upwindAcc2_p100
#FLUX: -t=3600
#FLUX: --urgency=16

exe="@CMAKE_BINARY_DIR@/upwind/cxx/upwindAcc2Cxx"
time srun $exe -numCells 800 -numSteps 10
