#!/bin/bash
#FLUX: --job-name=stream
#FLUX: -n=2
#FLUX: --queue=fpga
#FLUX: -t=7200
#FLUX: --urgency=16

module load intelFPGA_pro/21.2.0 bittware_520n/20.4.0_hpc intel devel/CMake/3.15.3-GCCcore-8.3.0 
srun ../../synthesis_artifacts/STREAM/520n-21.2.0-20.4.0/STREAM_FPGA_intel -f ../../synthesis_artifacts/STREAM/520n-21.2.0-20.4.0/stream_kernels_single.aocx -r 4 -s 1073741824
