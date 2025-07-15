#!/bin/bash
#FLUX: --job-name=stanky-peanut-9304
#FLUX: --priority=16

module load intel intelFPGA_pro/21.2.0 bittware_520n/20.4.0_max devel/CMake/3.15.3-GCCcore-8.3.0
srun ../../synthesis_artifacts/LINPACK_DP/520n-21.2.0-20.4.0-iec/Linpack_intel -f ../../synthesis_artifacts/LINPACK_DP/520n-21.2.0-20.4.0-iec/hpl_torus_intel.aocx -n 10 -m 96
