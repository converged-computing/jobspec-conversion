#!/bin/bash
#FLUX: --job-name=muffled-pancake-5718
#FLUX: --queue=main
#FLUX: -t=43200
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export PATH='$HOME/apps/julia-1.8.1/bin:$PATH'
export LD_LIBRARY_PATH='$HOME/apps/julia-1.8.1/lib:$HOME/apps/julia-1.8.1/lib/julia:$LD_LIBRARY_PATH'

module purge
module use /projects/community/modulefiles
module load intel/17.0.4 python/3.8.5-gc563
ulimit -s unlimited
ulimit -s
export OMP_NUM_THREADS=1
export PATH=$HOME/apps/julia-1.8.1/bin:$PATH
export LD_LIBRARY_PATH=$HOME/apps/julia-1.8.1/lib:$HOME/apps/julia-1.8.1/lib/julia:$LD_LIBRARY_PATH
python3 mixing_test.py
