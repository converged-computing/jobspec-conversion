#!/bin/bash
#FLUX: --job-name=rainbow-cinnamonbun-6395
#FLUX: -N=5
#FLUX: -n=9
#FLUX: --queue=fpga
#FLUX: --urgency=16

module load intelFPGA_pro/20.3.0
module load bittware_520n/19.4.0_max
module load intel
module load devel/CMake/3.15.3-GCCcore-8.3.0
BIN_FILE=/scratch/pc2-mitarbeiter/mariusme/devel/HPCC_FPGA_ptrans/build/520n/PTRANS/bin/Transpose_intel
AOCX_FILE=$PFS_SCRATCH/synth/520n/PTRANS/20.3.0-19.4.0_max-Nallatech_520N-noloop/bin/transpose_diagonal.aocx
srun ${BIN_FILE} -f ${AOCX_FILE} -n 10 -m 48 -r 4
