#!/bin/bash
#FLUX: --job-name=nuosc
#FLUX: -c=4
#FLUX: --queue=gtest
#FLUX: --urgency=16

module purge
module load nvhpc/21.7
NSYS=/work/opt/ohpc/pkg/qchem/nv/nsight-systems-2020.3.1/bin/nsys
OUT=nuosc
srun ${NSYS} profile -o ${OUT} -f true --trace openmp,nvtx,cuda ./nuosc
echo "--- Walltime: ${SECONDS} sec."
