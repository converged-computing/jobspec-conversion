#!/bin/bash
#FLUX: --job-name="PerforatedCylinder"
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=259200
#FLUX: --priority=16

source ../compile/modules.sh
mpiexecjl --project=../ -n 48 $HOME/progs/install/julia/1.7.2/bin/julia -J ../PerforatedCylinder_serial.so -O3 --check-bounds=no -e 'include("run_PerforatedCylinder_distributed.jl")'
