#!/bin/bash
#FLUX: --job-name=adorable-diablo-2331
#FLUX: -c=3
#FLUX: --priority=16

export OMP_NUM_THREADS='3'
export CRAY_ACC_DEBUG='2   # use 1 for less, or 3 for FULL'

export OMP_NUM_THREADS=3
ml LUMI/23.03
ml partition/G craype-accel-amd-gfx90a craype-x86-trento rocm
export CRAY_ACC_DEBUG=2   # use 1 for less, or 3 for FULL
                          #                 to see everything!
./a.out
