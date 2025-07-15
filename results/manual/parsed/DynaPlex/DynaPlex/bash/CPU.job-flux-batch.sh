#!/bin/bash
#FLUX: --job-name=cowy-lizard-1508
#FLUX: -c=128
#FLUX: --exclusive
#FLUX: --queue=genoa
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'

module load 2022
module load CMake/3.23.1-GCCcore-11.3.0
module load OpenMPI/4.1.4-GCC-11.3.0
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
cd ../out/LinRel/bin
srun ./lostsales_paper_results
