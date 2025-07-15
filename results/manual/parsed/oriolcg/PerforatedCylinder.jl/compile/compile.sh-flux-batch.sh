#!/bin/bash
#FLUX: --job-name="cnn-NS"
#FLUX: --queue=compute
#FLUX: -t=14400
#FLUX: --priority=16

source modules.sh
mpiexecjl --project=../ -n 1 $HOME/progs/install/julia/1.7.2/bin/julia -O3 --check-bounds=no --color=yes compile.jl
