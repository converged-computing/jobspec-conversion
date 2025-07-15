#!/bin/bash
#FLUX: --job-name=evasive-leg-7712
#FLUX: --priority=16

module load mvapich2-2.3.7-gcc-11.2.0
MV2_USE_ALIGNED_ALLOC=1
time mpirun -n 1 julia --project --check-bounds=no -O3 /scratch/tpatel28/topo_mag/EW_sim/IGG_gpu/main_temporal.jl 
