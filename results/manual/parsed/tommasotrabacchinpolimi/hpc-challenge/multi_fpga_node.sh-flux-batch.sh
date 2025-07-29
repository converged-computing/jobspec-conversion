#!/bin/bash
#FLUX --job-name=astute-lettuce-3223
#FLUX -N=3
#FLUX -n=3
#FLUX -c=8
#FLUX --queue=fpga
#FLUX -t=300
#FLUX --urgency=16

module load ifpgasdk && module load 520nmx && module load CMake && module load intel && module load deploy/EasyBuild
cd build
git pull
make main_node
srun main_node matrix_10000.bin rhs_10000.bin
