#!/bin/bash
#FLUX: --job-name=PTRANS
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --queue=fpga
#FLUX: -t=7200
#FLUX: --urgency=16

module load intel intelFPGA_pro/21.2.0 bittware_520n/20.4.0_max devel/CMake/3.15.3-GCCcore-8.3.0
srun ../../synthesis_artifacts/PTRANS/520n-21.2.0-20.4.0-iec/Transpose_intel \
    -f ../../synthesis_artifacts/PTRANS/520n-21.2.0-20.4.0-iec/transpose_PQ_IEC.aocx \
    -n 10 -m 128 -b 512 -r 4
