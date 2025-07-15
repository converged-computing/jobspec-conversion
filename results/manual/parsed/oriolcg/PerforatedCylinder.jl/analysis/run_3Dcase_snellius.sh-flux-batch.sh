#!/bin/bash
#FLUX: --job-name=perf_cylinder_3D
#FLUX: --queue=thin
#FLUX: -t=172800
#FLUX: --urgency=16

source ../compile/modules_snellius.sh
mpiexecjl --project=../ -n 4 julia -J ../PerforatedCylinder_parallel.so -O3 --check-bounds=no -e 'include("run_3Dcase.jl")'
