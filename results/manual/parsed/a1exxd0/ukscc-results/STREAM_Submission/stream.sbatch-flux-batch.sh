#!/bin/bash
#FLUX: --job-name=stream4
#FLUX: -c=16
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'
export OMP_PROC_BIND='spread'

module load compilers/armclang/24.04
module load libraries/openmpi/5.0.3/armclang-24.04
export OMP_NUM_THREADS=16
export OMP_PROC_BIND=spread
srun -n 1 ./STREAM/stream
