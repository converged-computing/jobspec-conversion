#!/bin/bash
#FLUX: --job-name=run1
#FLUX: -n=36
#FLUX: --queue=skylake
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='18'

. /etc/profile.d/modules.sh
module load julia/1.4
module load R/3.6
module load intel-mpi-2017.4-gcc-5.4.0-rjernby
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=18
mpirun -ppn 2 -n 2 julia --project=../git/Simulation/examples \
  ../git/Simulation/examples/CirrusMPIRun.jl
