#!/bin/bash
#FLUX: --job-name=ipcc
#FLUX: --exclusive
#FLUX: --queue=amd_256
#FLUX: --urgency=16

export LD_LIBRARY_PATH='./lib:$LD_LIBRARY_PATH'

source /public1/soft/modules/module.sh
module load gcc/8.3.0
module load intel/20.4.3
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH
./setup-omp.sh
echo "build..."
make
echo ""
echo "running..."
./bin/stencil IPCC.png
