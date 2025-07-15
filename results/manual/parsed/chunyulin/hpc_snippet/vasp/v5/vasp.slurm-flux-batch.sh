#!/bin/bash
#FLUX: --job-name=hanky-arm-0100
#FLUX: -t=88200
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/lib64/libpmi.so'

export I_MPI_PMI_LIBRARY=/lib64/libpmi.so
module purge
module load compiler/intel/2018
module load nvidia/cuda/10.0
VASP_EXE=/home/p00lcy01/VASP/icc_mkl/bin/vasp_std
OPTION="--cpu_bind=core"
srun ${OPTION} ${VASP_EXE}
echo "=== Wall time: $SECONDS secs."
